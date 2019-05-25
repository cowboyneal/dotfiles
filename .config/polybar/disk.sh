#!/bin/sh

df -h | grep $1$ | awk '{ printf "%s: %s/%s (%s)", $6, $3, $2, $5}'
