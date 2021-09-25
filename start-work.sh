#!/bin/sh
set -x

nvim -R -c ':PlugUpdate' -c ':PlugClean' -c ':qa'

if which brew >/dev/null 2>&1; then
 brew update
 brew upgrade
 brew cleanup
fi

if which pkgin >/dev/null 2>/dev/null; then
  sudo pkgin update
  sudo pkgin -y upgrade
fi

if which pacman >/dev/null 2>/dev/null; then
  sudo pacman -Syu
fi
