#!/usr/bin/env bash

me=$(basename $0)
DELIMITER='|'

GETOPT=$(getopt -o 'h?cmwpsnd:' --long 'help,no-humidity,no-wind,no-glyphs' \
    --long 'no-pressure,no-sky-conditions,use-metric,si,delimiter:' \
    -n "$me" -- "$@")
eval set -- "$GETOPT"
unset GETOPT

while true; do
    case "$1" in
        '-h'|'-?'|'--help')
            cat << HELP_MESSAGE
Usage: $me [OPTIONS] [--] <AIRPORT CODE>

  -h, -?,   --help              This message
  -c,       --use-metric, --si  Use metric units
  -m,       --no-humidity       Don't print humidity information
  -w,       --no-wind           Don't print wind speed/direction
  -p,       --no-pressure       Don't print atmospheric pressure
  -s,       --no-sky-conditions Don't print sky conditions
  -n,       --no-glyphs         Don't print FontAwesome glyphs
  -d<char>, --delimiter=<char>  Use <char> as a delimiter instead of "|",
                                only works with glyphs turned off.

An airport code for your local airport can be found at
https://www.iata.org/en/publications/directories/code-search/

If the glyphs are not showing up, make sure that you have Font Awesome 6
Free installed. Some fonts may also override the Font Awesome glyphs.
HELP_MESSAGE
            exit                                                            ;;
        '-c'|'--use-metric'|'--si') USE_METRIC=true;        shift; continue ;;
        '-m'|'--no-humidity')       NO_HUMIDITY=true;       shift; continue ;;
        '-w'|'--no-wind')           NO_WIND=true;           shift; continue ;;
        '-p'|'--no-pressure')       NO_PRESSURE=true;       shift; continue ;;
        '-s'|'--no-sky-conditions') NO_SKY_CONDITIONS=true; shift; continue ;;
        '-n'|'--no-glyphs')         NO_GLYPHS=true;         shift; continue ;;
        '-d'|'--delimiter') d="$2"; DELIMITER=${d:0:1};   shift 2; continue ;;
        '--')                                               shift; break    ;;
    esac
done

if [ -n "$1" ]; then
    if [ -x "$(which pymetar)" ]; then
        metar=$(pymetar "$1")
    else
        echo "Missing pymetar! Please install the python3-pymetar package."
        exit
    fi
else
    exec "$0" -h
fi

time_hour=$(date +%H | sed 's/^0//')
temp_f=$(echo "$metar" | grep Temperature | awk '{ print $5 }')
[ -n "$USE_METRIC" ] && temp_c=$(echo "$metar" | grep Temperature \
    | awk '{ print $2 }')
[ -z "$NO_HUMIDITY" ] && humidity=$(echo "$metar" | grep ^Rel \
    | awk '{ print $3 }')

if [ -z "$NO_WIND" ]; then
    windspeed=$(echo "$metar" | grep "^Wind speed" | awk '{ print $3 }' \
        | sed 's/0\.00//')
    if [ -n "$USE_METRIC" ]; then
        [ -n "$windspeed" ] && windspeed=$(echo "$windspeed * 3.6" \
            | bc -l | sed -r 's/^([0-9]*\.[0-9])[0-9]*$/\1/')
    else
        [ -n "$windspeed" ] && windspeed=$(echo "$windspeed * 2.23694" \
            | bc -l | sed -r 's/^([0-9]*\.[0-9])[0-9]*$/\1/')
    fi

    winddir=$(echo "$metar" | grep "^Wind dir" | awk '{ print $5 }' \
        | sed -r 's/\(|\)//g' | sed 's/None//')
fi

if [ -z "$NO_PRESSURE" ]; then
    pressure=$(echo "$metar" | grep ^Pressure | awk '{ print $2 }' \
        | sed 's/none//')

    if [ -n "$USE_METRIC" ]; then
        [ -n "$pressure" ] && pressure=$(echo "$pressure / 10" | bc -l \
            | sed -r 's/^([0-9]*\.[0-9])[0-9]*$/\1/')
    else
        [ -n "$pressure" ] && \
            pressure=$(echo "$pressure * 0.02952998057228486" \
            | bc -l | sed -r 's/^([0-9]*\.[0-9][0-9])[0-9]*$/\1/')
    fi
fi

[ -z "$NO_SKY_CONDITIONS" ] && sky=$(echo "$metar" | grep ^Sky \
    | sed -r 's/^Sky[[:space:]]Conditions:[[:space:]]//' \
    | tr '[[:upper:]]' '[[:lower:]]' | sed 's/none//')
weather=$(echo "$metar" | grep Weather: | sed -r 's/^Weather:[[:space:]]//' \
    | tr '[[:upper:]]' '[[:lower:]]' | sed 's/none//')

if [ -z "$NO_GLYPHS" ]; then
    if (( $(echo "$temp_f >= 90" | bc -l) )); then
        printf ""
    elif (( $(echo "$temp_f >= 70" | bc -l) )); then
        printf ""
    elif (( $(echo "$temp_f >= 50" | bc -l) )); then
        printf ""
    elif (( $(echo "$temp_f >= 30" | bc -l) )); then
        printf ""
    else
        printf ""
    fi

    printf " "
fi

if [ -n "$USE_METRIC" ]; then
    printf "%s°C" "$temp_c"
else
    printf "%s°F" "$temp_f"
fi

if [ -n "$humidity" ]; then
    if [ -z "$NO_GLYPHS" ]; then
        printf "  "
    else
        printf " $DELIMITER "
    fi

    printf "%s" "$humidity"
fi

if [ -n "$winddir$windspeed" ]; then
    if [ -z "$NO_GLYPHS" ]; then
        printf " "
    else
        printf " $DELIMITER"
    fi

    [ -n "$winddir" ] && printf " %s" "$winddir"

    if [ -n "$USE_METRIC" ]; then
        [ -n "$windspeed" ] && printf " %s kph" "$windspeed"
    else
        [ -n "$windspeed" ] && printf " %s mph" "$windspeed"
    fi
fi

if [ -n "$pressure" ]; then
    if [ -z "$NO_GLYPHS" ]; then
        printf " "
    else
        printf " $DELIMITER"
    fi
fi

if [ -n "$USE_METRIC" ]; then
    [ -n "$pressure" ] && printf " %s kPa" "$pressure"
else
    [ -n "$pressure" ] && printf " %s inHg" "$pressure"
fi

if [ -n "$sky" ] && [ -n "$weather" ]; then
    if [[ "$weather" =~ "$sky" ]]; then
        skyweather=" $weather"
    else
        skyweather=" $sky, $weather"
    fi
elif [ -n "$weather" ]; then
    skyweather=" $weather"
elif [ -n "$sky" ]; then
    skyweather=" $sky"
fi

case "$skyweather" in
    *tornado*)                                  wicon='' ;;
    *thunder* | *lightning*)                    wicon='' ;;
    *snow* | *flurries*)                        wicon='' ;;
    *heavy\ rain* | *hail*)                     wicon='' ;;
    *rain* | *drizzle*)                         wicon='' ;;
    *mist* | *fog* | *smog* | *haze* | *smoke*) wicon='' ;;
    *broken\ clouds* | *few\ clouds* | *scattered\ clouds*)
        if [ $time_hour -ge 8 ] && [ $time_hour -lt 20 ]; then
                                                wicon=''
        else
                                                wicon=''
        fi
        ;;
    *cloud* | *overcast*)                       wicon='' ;;
    *clear*)
        if [ $time_hour -ge 8 ] && [ $time_hour -lt 20 ]; then
                                                wicon=''
        else
                                                wicon=''
        fi
        ;;
    *sun*)                                      wicon='' ;;
    *moon*)                                     wicon='' ;;
esac

if [ -n "$wicon" ] && [ -z "$NO_GLYPHS" ]; then
    printf " %s" "$wicon"
else
    [ -n "$skyweather" ] && printf " $DELIMITER"
fi

[ -n "$skyweather" ] && printf "%s" "$skyweather"

printf "\n"
