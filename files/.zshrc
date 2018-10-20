export TERM="xterm-256color"

# Load tmux by default
#if [ "$TMUX" = "" ]; then tmux attach || tmux new; fi

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

source ~/antigen.zsh

antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen apply

export PATH="$HOME/shell-scripts/scripts:$HOME/.yarn/bin:$PATH"

