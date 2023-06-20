#!/bin/sh

percentage="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage:/ {print $2}')"
state="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/state:/ {print $2}')"
time_to_full="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/time to full:/ {print $4, $5}')"
now="$(date)"

printf "Battery: %s %s %s | %s" "$percentage" "$state" "$time_to_full" "$now"
