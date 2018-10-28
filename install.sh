#!/usr/bin/env bash

now=$(date +"%Y.%m.%d.%H.%M.%S")

for file in files/.*; do
  if [[ $file == "." || $file == ".." ]]; then
    continue
  fi
  echog "Processing ~/$file"
  # if the file exists:
  if [[ -e ~/$file ]]; then
      mkdir -p ~/.dotfiles_backup/$now
      mv ~/$file ~/.dotfiles_backup/$now/$file
      echo "backup saved as ~/.dotfiles_backup/$now/$file"
  fi
  # symlink might still exist
  unlink ~/$file > /dev/null 2>&1
  # create the link
  ln -s ~/.dotfiles/homedir/$file ~/$file
  echo "Link created: ~/$file"
done
