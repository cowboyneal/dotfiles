#!/usr/bin/env bash

metar=$(pymetar "$1")
time_hour=$(echo "$metar" | sed '1q;d' | sed -r 's/^.*[[:space:]](.*)$/\1/' \
    | awk 'BEGIN { FS = ":" } ; { print $1 }' | sed 's/^0//')
time_hour=$(( $time_hour + 20 ))
[ $time_hour -gt 24 ] && time_hour=$(( $time_hour - 24 ))
temp_f=$(echo "$metar" | grep Temperature | awk '{ print $5 }')
humidity=$(echo "$metar" | grep ^Rel | awk '{ print $3 }')
windspeed=$(echo "$metar" | grep "^Wind speed" | awk '{ print $3 }' \
    | sed 's/None//')
[ -n "$windspeed" ] && windspeed=$(echo "$windspeed * 2.23694" | bc -l \
    | sed -r 's/^([0-9]*\.[0-9])[0-9]*$/\1/')
winddir=$(echo "$metar" | grep "^Wind dir" | awk '{ print $5 }' \
    | sed -r 's/\(|\)//g')
weather=$(echo "$metar" | grep Weather: | sed -r 's/^Weather:[[:space:]]//' \
    | tr '[[:upper:]]' '[[:lower:]]' | sed 's/none//')
sky=$(echo "$metar" | grep ^Sky \
    | sed -r 's/^Sky[[:space:]]Conditions:[[:space:]]//' \
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

printf " %s°F  %s" "$temp_f" "$humidity"

if [ -n "$winddir$windspeed" ]; then
    printf " "
    [ -n "$winddir" ] && printf " %s" "$winddir"
    [ -n "$windspeed" ] && printf " %s mph" "$windspeed"
fi

if [ -n "$sky" ] && [ -n "$weather" ]; then
    if [ "$sky" != "$weather" ]; then
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
    *snow* | *hail* | *flurries*)       wicon='' ;;
    "*heavy rain*")                     wicon='' ;;
    *rain* | *drizzle*)                 wicon='' ;;
    *mist* | *fog* | *smog* | *haze*)   wicon='' ;;
    *partly* | *broken*)
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
