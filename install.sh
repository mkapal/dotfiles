#!/usr/bin/env bash

now=$(date +"%Y.%m.%d.%H.%M.%S")

cd ~/.dotfiles/files/

for file in .*; do
  if [[ $file == "." || $file == ".." ]]; then
    continue
  fi
  echo "Processing ~/$file"
  if [[ -e ~/$file ]] && [[ -f ~/$file ]]; then
    mkdir -p ~/.dotfiles_backup/$now
    mv ~/$file ~/.dotfiles_backup/$now/$file
    echo "backup saved as ~/.dotfiles_backup/$now/$file"
  fi
  unlink ~/$file > /dev/null 2>&1
  ln -s ~/.dotfiles/files/$file ~/$file
  echo "Link created: ~/$file"
done
