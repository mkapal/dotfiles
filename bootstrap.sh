#!/usr/bin/env bash

if [[ ! -e ~/.dotfiles ]]; then
  echo Cloning dotfiles...
  git clone --recurse-submodules https://github.com/flamecze/dotfiles ~/.dotfiles > /dev/null 2>&1
fi

cd ~/.dotfiles/
echo Installing dotfiles...
./install.sh
