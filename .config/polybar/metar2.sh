#!/usr/bin/env bash

me=$(basename $0)

GETOPT=$(getopt -o 'hmwps' --long 'help,no-humidity,no-wind' \
    --long 'no-pressure,no-sky-conditions' -n "$me" -- "$@")
eval set -- "$GETOPT"
unset GETOPT

while true; do
    case "$1" in
        '-m'|'--no-humidity')       NO_HUMIDITY=true;       shift; continue ;;
        '-w'|'--no-wind')           NO_WIND=true;           shift; continue ;;
        '-p'|'--no-pressure')       NO_PRESSURE=true;       shift; continue ;;
        '-s'|'--no-sky-conditions') NO_SKY_CONDITIONS=true; shift; continue ;;
        '-h'|'--help')
            cat << HELP_MESSAGE
Usage: $me [OPTIONS] <AIRPORT CODE>

  -h, --help                This message
  -m, --no-humidity         Don't print humidity information
  -w, --no-wind             Don't print wind speed/direction
  -p, --no-pressure         Don't print atmospheric pressure
  -s, --no-sky-conditions   Don't print sky conditions

An airport code for your local airport can be found at
https://www.iata.org/en/publications/directories/code-search/
HELP_MESSAGE
            exit                                                            ;;
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

time_hour=$(echo "$metar" | sed '1q;d' | sed -r 's/^.*[[:space:]](.*)$/\1/' \
    | awk 'BEGIN { FS = ":" } ; { print $1 }' | sed 's/^0//')
time_hour=$(( $time_hour + 20 ))
[ $time_hour -gt 24 ] && time_hour=$(( $time_hour - 24 ))
temp_f=$(echo "$metar" | grep Temperature | awk '{ print $5 }')
[ -z "$NO_HUMIDITY" ] && humidity=$(echo "$metar" | grep ^Rel \
    | awk '{ print $3 }')

if [ -z "$NO_WIND" ]; then
    windspeed=$(echo "$metar" | grep "^Wind speed" | awk '{ print $3 }' \
        | sed 's/None//')
    [ -n "$windspeed" ] && windspeed=$(echo "$windspeed * 2.23694" | bc -l \
        | sed -r 's/^([0-9]*\.[0-9])[0-9]*$/\1/')
    winddir=$(echo "$metar" | grep "^Wind dir" | awk '{ print $5 }' \
        | sed -r 's/\(|\)//g')
fi

if [ -z "$NO_PRESSURE" ]; then
    pressure=$(echo "$metar" | grep ^Pressure | awk '{ print $2 }' \
        | sed 's/none//')
    [ -n "$pressure" ] && pressure=$(echo "$pressure * 0.7500637554" | bc -l \
        | sed -r 's/^([0-9]*)\.[0-9]*$/\1/')
fi

[ -z "$NO_SKY_CONDITIONS" ] && sky=$(echo "$metar" | grep ^Sky \
    | sed -r 's/^Sky[[:space:]]Conditions:[[:space:]]//' \
    | tr '[[:upper:]]' '[[:lower:]]' | sed 's/none//')
weather=$(echo "$metar" | grep Weather: | sed -r 's/^Weather:[[:space:]]//' \
    | tr '[[:upper:]]' '[[:lower:]]' | sed 's/none//')

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

printf " %s°F" "$temp_f"
[ -n "$humidity" ] && printf "  %s" "$humidity"

if [ -n "$winddir$windspeed" ]; then
    printf " "
    [ -n "$winddir" ] && printf " %s" "$winddir"
    [ -n "$windspeed" ] && printf " %s mph" "$windspeed"
fi

[ -n "$pressure" ] && printf "  %s mmHg" "$pressure"

if [ -n "$sky" ] && [ -n "$weather" ]; then
    if [[ ! "$weather" =~ "$sky" ]]; then
        skyweather=" $sky, $weather"
    else
        skyweather=" $weather"
    fi
elif [ -n "$weather" ]; then
    skyweather=" $weather"
elif [ -n "$sky" ]; then
    skyweather=" $sky"
fi

case "$skyweather" in
    *tornado*)                          wicon='' ;;
    *thunder* | *lightning*)            wicon='' ;;
    *snow* | *flurries*)                wicon='' ;;
    *heavy\ rain* | *hail*)             wicon='' ;;
    *rain* | *drizzle*)                 wicon='' ;;
    *mist* | *fog* | *smog* | *haze*)   wicon='' ;;
    *broken\ clouds* | *few\ clouds* | *scattered\ clouds*)
        if [ $time_hour -ge 8 ] && [ $time_hour -lt 20 ]; then
                                        wicon=''
        else
                                        wicon=''
        fi
        ;;
    *cloud* | *overcast*)               wicon='' ;;
    *sun*)                              wicon='' ;;
    *moon*)                             wicon='' ;;
    *clear*)
        if [ $time_hour -ge 8 ] && [ $time_hour -lt 20 ]; then
                                        wicon=''
        else
                                        wicon=''
        fi
        ;;
esac

[ -n "$wicon" ] && printf " %s" "$wicon"
[ -n "$skyweather" ] && printf "%s" "$skyweather"

printf "\n"
