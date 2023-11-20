#!/bin/sh

free -m | grep ^Mem | awk '{ printf "%sM used | %sM free", $3, $4; }'
echo
