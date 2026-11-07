# General alias'
alias slack="open -a /Applications/Slack.app"
alias @="cd ~"
alias zshrc="source $HOME/.zshrc"

# My alias'
alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias i="nvim" # Stupid alias for stupid people
alias oldvim="command vim"
alias c="clear"
alias clean-slate="rm -rf node_modules && yarn cache clean"
alias y="yarn"
alias p="pnpm"

# Git
alias g="git"
alias gs="git status"
alias gc="oco"
alias gcob="gco -b"
alias gai="oco"
alias gcai='oco'
alias gsc="git stash clear" # Clear all stashes

# Docker
alias dc="docker compose"
alias dcu="docker compose up -d" # start all containers in detached mode
dsa() { docker stop $(docker ps -q); } # stop all running containers
alias dxc="docker container exec"
alias dxci="docker container exec -it" # execute in interactive terminal
alias docker-stop-all="dsa"
alias docker-start-all="dcu"
docker-restart-all() { docker container restart $(docker ps -q); }
alias docker-clean-up="docker volume prune"

# Kube
alias k="kubectl"

# Utility
alias hg='history | grep'

# lazygit
alias lg="lazygit"
alias lazy="lazygit"
alias lga="lazygit add"

# AI
alias cursor="cursor-agent"
alias oc="opencode"
