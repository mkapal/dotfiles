alias ~='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias l='ls -A1'
alias la='ls -lAh'
ls --color=auto &> /dev/null && alias ls='ls --color=auto'
alias path='echo "$PATH" | tr ":" "\n"'

# Git
alias ga='git add'
alias gaa='git add -a'
alias gc='git commit'
alias gb='git checkout -b'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gl='git pull'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gs='tig status'
alias grh='git reset HEAD~'

gitFetchRebase() {
  git fetch origin $1:$1 --progress --prune
  git rebase $1
}

# Docker
alias dcu='docker compose up -d'
alias dcub='docker compose up -d --build'
alias dcd='docker compose down'
alias dca='docker ps -a'
# alias drmex='docker rm $(docker ps -q -f status=exited)'
# alias drmid='docker rmi $(docker images -f "dangling=true" -q)'
# alias dsex="docker start $(docker ps -a --filter 'status=exited' -q)"

# Yarn
alias ya='yarn add'
alias yad='yarn add -D'
alias yr='yarn remove'
alias yga='yarn global add'
alias yarr=yarn
alias y=yarn
alias yf='yarn --force'
alias yu='yarn upgrade-interactive --latest'

# Yalc
alias ylcp='yalc publish && yalc push'

# pnpm
alias pi='pnpm i'

alias zshrc='vim ~/.zshrc'

update() {
    brew update
    brew upgrade
    vim +PlugUpgrade +PlugUpdate +PlugClean +qall
    antigen update
}

mkcd () {
  mkdir "$1"
  cd "$1"
}
