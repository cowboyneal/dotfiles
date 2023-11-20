#!/bin/sh

i=0

for a in $@; do
    df -h | grep $a$ | awk '{ printf "%s: %s", $6, $5}'
    i=$((i+1))

    if [[ $i -lt $# ]]; then
        printf " | "
    fi
done

echo
