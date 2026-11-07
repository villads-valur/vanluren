DOTFILES_ZSH=${0:A:h}

# p10k instant prompt, keep near the top. Anything that needs console input goes above this.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval "$(/opt/homebrew/bin/brew shellenv zsh)"
export PATH="$HOME/.local/bin:$PATH"

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Rebuild the completion dump at most once a day, otherwise skip the security check
autoload -Uz compinit
() {
  local stale_dump=(${ZDOTDIR:-$HOME}/.zcompdump(N.mh+24))
  if [[ ! -f ${ZDOTDIR:-$HOME}/.zcompdump || -n $stale_dump ]]; then
    compinit
  else
    compinit -C
  fi
}

source $DOTFILES_ZSH/variables.zsh
source $DOTFILES_ZSH/plugins.zsh
source $DOTFILES_ZSH/alias.zsh
source $DOTFILES_ZSH/functions.zsh
source $DOTFILES_ZSH/nvm.zsh

# bun completions
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

source $HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit $DOTFILES_ZSH/.p10k.zsh
[[ -f $DOTFILES_ZSH/.p10k.zsh ]] && source $DOTFILES_ZSH/.p10k.zsh

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

# Machine-local, untracked config (work aliases etc.)
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# Must be sourced last, it wraps every widget defined before it
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
