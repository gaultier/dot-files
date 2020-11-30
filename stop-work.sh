#!/bin/sh

pgrep -i 'Mail|Calendar|k9s|skaffold|kubectl|viscosity|java|intellij|idea|docker|chat|openvpn' | xargs kill -9
BLUEUTIL_ALLOW_ROOT=1 blueutil -p off

