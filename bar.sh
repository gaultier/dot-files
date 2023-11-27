#!/bin/sh

battery_info="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)"
percentage="$(echo "$battery_info" | awk '/percentage:/ {print $2}')"
state="$(echo "$battery_info" | awk '/state:/ {print $2}')"
time_to_full="$(echo "$battery_info" | awk '/time to full:/ {for (i=4; i<NF; i++) printf $i " "; print $NF}')"
now="$(date)"

wifi="$(nmcli --terse --fields in-use,ssid,bars device wifi list | awk -F ':' '$1=="*" {print $2, $3}')"

bluetooth="$(bluetoothctl devices)"

ethernet="$(nmcli -t -g general.state device show enx00e04c709655)"

printf "Ethernet: %s | Bluetooth: %s | Wifi: %s | Battery: %s %s %s | %s" "$ethernet" "$bluetooth" "$wifi" "$percentage" "$state" "$time_to_full" "$now"
