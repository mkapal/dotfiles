#!/bin/bash

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

ln -sf ~/configs/.aliases ~
ln -sf ~/configs/.tmux.conf ~
ln -sf ~/configs/.zshrc ~
ln -sf ~/configs/.vimrc ~
rm -rf ~/.vim
ln -sf ~/configs/.vim ~

~/.tmux/plugins/tpm/scripts/install_plugins.sh

