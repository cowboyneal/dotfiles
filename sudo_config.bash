#!/bin/env bash

dir_locs=( '/usr/local/etc/sudoers.d' '/etc/sudoers.d' )

for a in ${dir_locs[@]}; do
    if [ -d "$a" ]; then
        echo "pater ALL=(ALL:ALL) NOPASSWD" > $a/pater
        break
    fi
done
