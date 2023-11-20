#!/bin/sh

sysctl -n vm.loadavg | awk '{ print $1, $2, $3; }'
#top -b | grep "CPU states" | awk '{ printf "%s user | %s sys", $3, $7; }'
