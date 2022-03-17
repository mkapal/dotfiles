# [[ $TMUX = "" ]] && export TERM="xterm-256color"

if [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ] && [ "$TERMINAL_EMULATOR" != "VSCode" ]
then 
   # ZSH_TMUX_AUTOSTART=true
fi

# Load tmux by default
if [ "$TMUX" = "" ] && [ "$ZSH_TMUX_AUTOSTART" = true ]; then
    tmux attach || tmux new;
fi

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

# Antigen plugins
source ~/.dotfiles/files/antigen/antigen.zsh
export NVM_AUTO_USE=true
antigen bundle lukechilds/zsh-nvm
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-history-substring-search
antigen apply

# Pure prompt
autoload -U promptinit; promptinit
prompt pure

# History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

# History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# Vi mode
bindkey -v

# History search based on prompt input
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

export PATH="$(yarn global bin):${ANDROID_SDK_ROOT}/emulator:$PATH"

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
