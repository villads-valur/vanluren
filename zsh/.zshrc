if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh
export PATH="/Users/villadsvalur/.nvm/versions/node/v18.14.0/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/villadsvalur/.cargo/bin:/Users/villadsvalur/.local/share/bob/nvim-bin"

ZSH_THEME=powerlevel10k/powerlevel10k

DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="mm/dd/yyyy"

plugins=(
  git 
  macos 
  tmux 
  zsh-completions 
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
export LANG=en_GB.UTF-8
export VISUAL=nvim
export EDITOR="nvim"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# General alias'
alias slack="open -a /Applications/Slack.app"
alias chrome=" open -a /Applications/Google\ Chrome.app"

# My alias'
alias v="nvim"
alias vim="nvim"
alias vi="nvim"
alias i="nvim" # Stupid alias for stupid people
alias oldvim="vim"
alias c="clear"
alias clean-slate="sudo rm -rf node_modules && yarn cache clean"

# Git
alias g="git"
alias gs="git status"
alias gc="cz"
alias gcob="gco -b"
alias gai="git add -i"
alias gcai="aicommits"

# tmux
alias t="tmux -f $HOME/.config/tmux/tmux.conf"
alias tk="tkss"


# Docker
alias dc="docker-compose"
alias k="kubectl"

# Utility
alias hg='history | grep'
alias sleep="pmset displaysleepnow"

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

# To customize prompt, run `p10k configure` or edit ~/Developer/personal/vanluren/zsh/.p10k.zsh.
[[ ! -f ~/Developer/personal/vanluren/zsh/.p10k.zsh ]] || source ~/Developer/personal/vanluren/zsh/.p10k.zsh
export PATH=/opt/homebrew/bin:/Users/villadsvalur/.nvm/versions/node/v18.14.0/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/villadsvalur/.cargo/bin:/Users/villadsvalur/.local/share/bob/nvim-bin
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
