#!/bin/sh

free | grep ^Mem | awk '{ printf "%s used | %s free ", $3, $4; }'
free | grep ^Swap | awk '{ printf "| %s swap", $3;}'
echo
