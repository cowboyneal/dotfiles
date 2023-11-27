#!/usr/bin/env bash

# Terminate already running bar instances
pkill -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar topbar &
polybar bottombar &

echo "Bars launched..."
