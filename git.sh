#!/bin/sh

set -ex

printf "\n========= %s =========\n" $PWD
git clean -f -d -x
MASTER_BRANCH="$(git remote show origin | awk '/HEAD/ {print $3}')"
git fetch origin "$MASTER_BRANCH" --auto-maintenance --auto-gc --prune --prune-tags --tags --recurse-submodules --quiet --update-head-ok --update-shallow --depth=10 --force --jobs=3
git checkout --quiet --force origin/"$MASTER_BRANCH"
