export TERM="xterm-256color"

# Load tmux by default
if [ "$TMUX" = "" ]; then tmux attach || tmux new; fi

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# if you want to use this, change your non-ascii font to Droid Sans Mono for Awesome
# POWERLEVEL9K_MODE='awesome-patched'
export ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

# https://github.com/bhilburn/powerlevel9k#customizing-prompt-segments
# https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir nvm vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)

# colorcode test
# for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
POWERLEVEL9K_NVM_FOREGROUND='000'
POWERLEVEL9K_NVM_BACKGROUND='072'
POWERLEVEL9K_SHOW_CHANGESET=true

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Automatically load nvm when in a directory with .nvmrc file
export NVM_AUTO_USE=true

# Which plugins would you like to load? (plugins can be found in ~/.dotfiles/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(colorize compleat dirpersist autojump git gulp history cp zsh-nvm)

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

unsetopt correct

# Custom aliases
alias dcu='docker-compose up -d'
alias dcub='docker-compose up -d --build'
alias dcd='docker-compose down'
alias dca='docker ps -a'
alias drmex='docker rm $(docker ps -q -f status=exited)'
alias drmid='docker rmi $(docker images -f "dangling=true" -q)'
alias dsex="docker start $(docker ps -a --filter 'status=exited' -q)"

eval $(thefuck --alias)

# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# added by travis gem
[ -f /home/martin/.travis/travis.sh ] && source /home/martin/.travis/travis.sh

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[[ -f /home/martin/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh ]] && . /home/martin/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh
