# Lazy-load nvm: sourcing nvm.sh is the slowest part of shell startup.
# The newest installed node goes on PATH so node, npm and global tools work without loading nvm.
export NVM_DIR="$HOME/.nvm"

() {
  local node_versions=($NVM_DIR/versions/node/v*(N/nOn))
  if (( $#node_versions )); then
    export PATH="$node_versions[1]/bin:$PATH"
  fi
}

nvm() {
  unfunction nvm
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  nvm "$@"
}

# Switch node version when entering a directory with .nvmrc, revert when leaving
load-nvmrc() {
  if [[ -r .nvmrc ]]; then
    nvm use
  elif (( $+functions[nvm_version] )) && [[ $(nvm version) != $(nvm version default) ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd load-nvmrc
load-nvmrc
