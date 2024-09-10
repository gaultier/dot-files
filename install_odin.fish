#!/usr/bin/env fish
set -x fish_trace

if ! command -q dnf 
  echo "Not on Fedora"
  exit 1
end

sudo dnf install -y git clang llvm-devel
mkdir ~/not-my-code
cd ~/not-my-code
git clone --recurse https://github.com/odin-lang/Odin.git
git clone --recurse https://github.com/DanielGavin/ols.git

if ! command -q odin
  cd ~/not-my-code/Odin
  ./build_odin.sh release
  sudo ln -s $PWD/odin /usr/local/bin/odin
end

if ! command -q odin
  echo "odin command not available, something went wrong"
  exit 1
end

if ! command -q ols
  cd ~/not-my-code/ols
  ./build.sh
  sudo ln -s $PWD/ols /usr/local/bin/ols
end

if ! command -q ols
  echo "ols command not available, something went wrong"
  exit 1
end

echo "All done."
