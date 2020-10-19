#!/bin/sh

set -x

pgrep -i 'Mail|Calendar|k9s|skaffold|kubectl|viscosity|java|intellij|idea|docker|chat|openvpn' | tee /dev/stderr | xargs kill -9
