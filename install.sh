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
    unlink ~/$file > /dev/null 2>&1
    ln -s ~/.dotfiles/files/$file ~/$file
    echo "Link created: ~/$file"
  fi
done

# Special case for termite config

termite_config=.config/termite/config

if [[ -e ~/$termite_config ]] && [[ -f ~/$termite_config ]]; then
  mkdir -p ~/.dotfiles_backup/$now/.config/termite
  mv ~/$termite_config ~/.dotfiles_backup/$now/$termite_config
  echo "backup saved as ~/.dotfiles_backup/$now/$termite_config"
  unlink ~/$termite_config > /dev/null 2>&1
  ln -s ~/.dotfiles/files/$termite_config ~/$termite_config
  echo "Link created: ~/$termite_config"
fi
