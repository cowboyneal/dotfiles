#!/bin/sh

sysctl vm.loadavg | awk '{ print "Load:", $3, $4, $5; }'
