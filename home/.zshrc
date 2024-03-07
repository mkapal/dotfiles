export PATH="/opt/homebrew/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    wd
    history-substring-search
)

# Skip Oh My ZSH default aliases
zstyle ':omz:*' aliases no

source $ZSH/oh-my-zsh.sh

# Language environment
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Preferred editor
export EDITOR='vim'

# History search based on prompt input
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Fast Node Manager https://github.com/Schniz/fnm
eval "$(fnm env --use-on-cd)"

# Pure Prompt
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit; promptinit
prompt pure
