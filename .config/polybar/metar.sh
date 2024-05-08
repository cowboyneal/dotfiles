#!/usr/bin/env bash

temp_c=$(echo "$(curl -s https://w1.weather.gov/data/METAR/${1}.1.txt \
    | tr '\r\n' ' ')\n" | awk 'BEGIN { FS = "/" } ; { print $1 }' \
    | sed -r 's/^.*[[:space:]](M?[0-9]*)$/\1/' | sed 's/M/-/')
echo "($temp_c * 9.0 / 5.0) + 32.0" | bc -l \
    | sed -r 's/^([0-9]*\.[0-9])[0-9]*$/\1/'
