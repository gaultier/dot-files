exec xrandr --output DP-2 --above eDP-1

# Disable DPMS turning off the screen
xset -dpms
xset s off

# Disable bell
xset -b

# Enable core dumps in case something goes wrong
ulimit -c unlimited

echo "Starting at $(date)" >> ~/.i3/logfile
exec /usr/bin/i3 -V -d all >> ~/.i3/logfile
