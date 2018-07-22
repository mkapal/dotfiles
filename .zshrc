export TERM="xterm-256color"

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

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

# disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# disable colors in ls
# export DISABLE_LS_COLORS="true"

# disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Automatically load nvm when in a directory with .nvmrc file
export NVM_AUTO_USE=true

# Which plugins would you like to load? (plugins can be found in ~/.dotfiles/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(colorize compleat dirpersist autojump git gulp history cp zsh-nvm)

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# source /home/martin/.nvm/nvm.sh

# autoload -U add-zsh-hook
# load-nvmrc() {
#  if [[ -f .nvmrc && -r .nvmrc ]]; then
#    nvm use &> /dev/null
#  elif [[ $(nvm version) != $(nvm version default)  ]]; then
#    nvm use default &> /dev/null
#  fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# Customize to your needs...
unsetopt correct

source $HOME/.aliases

eval $(thefuck --alias)

# This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# added by travis gem
[ -f /home/martin/.travis/travis.sh ] && source /home/martin/.travis/travis.sh

# tabtab source for yarn package
# uninstall by removing these lines or running `tabtab uninstall yarn`
[[ -f /home/martin/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh ]] && . /home/martin/.config/yarn/global/node_modules/tabtab/.completions/yarn.zsh

# Load the latest tmux session
tmux attach
