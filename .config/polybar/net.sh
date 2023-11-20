#!/bin/sh

ifstat -n -i "$1" 1 1 | sed '3q;d' | awk '{ printf " %sKB/s  %sKB/s", $1, $2; }'
echo
