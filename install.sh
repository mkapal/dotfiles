#!/bin/bash

# Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

rm ~/.aliases
ln -s ~/configs/.aliases ~/

# Tmux configuration
rm ~/.tmux.conf
ln -s ~/configs/.tmux.conf ~/

# Install all tmux plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh

rm ~/.zshrc
ln -s ~/configs/.zshrc ~/
