#!/bin/sh

pgrep -i 'Mail|Calendar|k9s|skaffold|kubectl|viscosity|java|intellij|idea|docker|chat|openvpn|redis|git|less|man|clangd|node|gopls|nvim' | xargs kill -9
BLUEUTIL_ALLOW_ROOT=1 blueutil -p off

