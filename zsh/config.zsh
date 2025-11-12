autoload -Uz compinit
compinit -u
PATH=$PATH:/opt/homebrew/bin

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $HOME/Developer/personal/vanluren/zsh/plugins.zsh
source $HOME/Developer/personal/vanluren/zsh/variables.zsh
source $HOME/Developer/personal/vanluren/zsh/alias.zsh
source $HOME/Developer/personal/vanluren/zsh/functions.zsh



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# place this after nvm initialization!
autoload -U add-zsh-hook

add-zsh-hook chpwd load-nvmrc

load-nvmrc

# powerlevel10k needs to be installed via Brew !!!
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/Developer/personal/vanluren/zsh/.p10k.zsh.
[[ ! -f ~/Developer/personal/vanluren/zsh/.p10k.zsh ]] || source ~/Developer/personal/vanluren/zsh/.p10k.zsh

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# bun completions
[ -s "/Users/villadsvalur/.bun/_bun" ] && source "/Users/villadsvalur/.bun/_bun"
