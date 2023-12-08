#!/bin/sh

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
#polybar-msg cmd quit || true
# Otherwise you can use the nuclear option:
killall -q polybar

for m in $(xrandr --query | grep -w connected | cut -d" " -f1); do
  MONITOR=$m polybar --reload &
done

echo "Bars launched..."
