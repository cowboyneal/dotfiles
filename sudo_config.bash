#!/usr/bin/env bash

name="$1"

if [ -z "$name" ]; then
    echo "need a user ID"
    exit 1
fi

dir_locs=( '/usr/local/etc/sudoers.d' '/etc/sudoers.d' )

for a in ${dir_locs[@]}; do
    if [ -d "$a" ]; then
        echo "$name ALL=(ALL:ALL) NOPASSWD: ALL" > $a/sudo-$name
        break
    fi
done
