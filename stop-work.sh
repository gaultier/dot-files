#!/bin/sh

set -x

pgrep -i 'skaffold|kubectl|viscosity|java|intellij|idea|docker|chat' | tee /dev/stderr | xargs kill -9
