# General alias'
alias slack="open -a /Applications/Slack.app"
alias @="~"
alias zshrc="source $HOME/.zshrc" 

# My alias'
alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias i="nvim" # Stupid alias for stupid people
alias oldvim="vim"
alias c="clear"
alias clean-slate="sudo rm -rf node_modules && yarn cache clean"
alias y="yarn"

# Git
alias g="git"
alias gs="git status"
alias gc="cz"
alias gcob="gco -b"
alias gai="git add -i"
alias gcai="aicommits"
alias gsc="git stash clear" # Clear all stashes, over

# tmux
alias t="tmux -f $HOME/.config/tmux/tmux.conf"
alias tk="tkss"

# Kitty
alias dark="kitty +kitten themes --reload-in=all One Half Dark"
alias light="kitty +kitten themes --reload-in=all Ayu Light"

# Docker
alias dc="docker-compose"
alias k="kubectl"

# Utility
alias hg='history | grep'

# lazygit
alias lg="lazygit"
alias lazy="lazygit"
alias lga="lazygit add"

# Claude
alias claude-code="claude"

# Kvalifik
alias ev="cd ~/Developer/ev-remarketing/"
alias banijay="cd ~/Developer/banijay/"
