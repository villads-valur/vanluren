if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME=powerlevel10k/powerlevel10k

DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git macos tmux)

source $ZSH/oh-my-zsh.sh
export LANG=da_DK.UTF-8
export VISUAL=nvim
export EDITOR="$VISUAL"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# General alias'
alias slack="open -a /Applications/Slack.app"
alias chrome=" open -a /Applications/Google\ Chrome.app"

# My alias'
alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias oldvim="vim"
alias gcob="gco -b"
alias c="clear"
alias clean-slate="sudo rm -rf node_modules && yarn cache clean"

# Git
alias g="git"
alias gs="git status"
alias gc="cz"

# tmux
alias t="tmux -f $HOME/.config/tmux/tmux.conf"
alias tk="tkss"


# Docker
alias dc="docker-compose"
alias k="kubectl"

# Utility
alias hg='history | grep'

kill_port() {
  if [ -n "$1" ]
  then
    lsof -ti :"$1" | xargs kill -9
  else
    echo "Pass in port number."
  fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  elif [[ $(nvm version) != $(nvm version default)  ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

export FZF_DEFAULT_COMMAND='rg --files'
