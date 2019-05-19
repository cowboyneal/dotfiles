#!/bin/sh

sysctl vm.loadavg | awk '{ print $3, $4, $5; }'
