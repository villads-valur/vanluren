export LANG=en_GB.UTF-8
export VISUAL=nvim
export EDITOR=nvim
export FZF_DEFAULT_COMMAND='rg --files'

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt extended_history share_history hist_ignore_dups hist_ignore_space hist_reduce_blanks
