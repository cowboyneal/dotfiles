#!/bin/sh

freecolor -m -o | grep ^Mem | awk '{ printf "Memory: %sM/%sM Used (%sM Free)", $3, $2, $4; }'
