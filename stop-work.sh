#!/bin/sh

# Kill gracefully curses programs that leave a mess in the terminal if killed forcefully
pkill -HUP nvim k9s
# Kill forcefully the remaining processes
pgrep -i 'safari|chromium|emacs|Mail|Calendar|k9s|skaffold|kubectl|viscosity|java|intellij|idea|docker|chat|openvpn|redis|git|less|man|clangd|node|gopls|top|htop|find|mysql|mariadb|ruby|python|php|nginx|perl|vim|virtualbox|vbox|kafka|zookeeper|ssh|go' | xargs kill -9
BLUEUTIL_ALLOW_ROOT=1 blueutil -p off

brew services stop --all

