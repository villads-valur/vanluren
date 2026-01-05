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



# p10k is sourced below after powerlevel10k theme is loaded

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
# source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
# source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

_wtp() {
        local -a opts # Declare a local array
        local current
        current=${words[-1]} # -1 means "the last element"
        if [[ "$current" == "-"* ]]; then
                # Current word starts with a hyphen, so complete flags/options
                opts=("${(@f)$(env WTP_SHELL_COMPLETION=1 ${words[@]:0:#words[@]-1} ${current} --generate-shell-completion)}")
        else
                # Current word does not start with a hyphen, so complete subcommands
                opts=("${(@f)$(env WTP_SHELL_COMPLETION=1 ${words[@]:0:#words[@]-1} --generate-shell-completion)}")
        fi

        if [[ "${opts[1]}" != "" ]]; then
                _describe 'values' opts
        else
                _files
        fi
}

# Don't run the completion function when being source-ed or eval-ed.
# See https://github.com/urfave/cli/issues/1874 for discussion.
if [ "$funcstack[1]" = "_wtp" ]; then
        _wtp
fi

# wtp cd command hook for zsh
wtp() {
    for arg in "$@"; do
        if [[ "$arg" == "--generate-shell-completion" ]]; then
            command wtp "$@"
            return $?
        fi
    done
    if [[ "$1" == "cd" ]]; then
        if [[ -z "$2" ]]; then
            echo "Usage: wtp cd <worktree>" >&2
            return 1
        fi
        local target_dir
        target_dir=$(command wtp cd "$2" 2>/dev/null)
        if [[ $? -eq 0 && -n "$target_dir" ]]; then
            cd "$target_dir"
        else
            command wtp cd "$2"
        fi
    else
        command wtp "$@"
    fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.local/bin:$PATH"
