# Lazy-load nvm: sourcing nvm.sh is the slowest part of shell startup.
# The default node goes on PATH so node, npm and global tools work without loading nvm.
export NVM_DIR="$HOME/.nvm"

# Resolve the nvm default alias (e.g. default -> lts/* -> lts/lithium -> v26.13.0) by reading alias files
() {
  local version=default
  local hops=0
  while [[ -f $NVM_DIR/alias/$version ]] && (( hops++ < 10 )); do
    version=$(<$NVM_DIR/alias/$version)
  done

  local node_dir=$NVM_DIR/versions/node
  local matches
  if [[ $version == (node|stable) ]]; then
    matches=($node_dir/v*(N/nOn))
  else
    matches=($node_dir/v${version#v}(N/) $node_dir/v${version#v}.*(N/nOn))
  fi

  if (( $#matches )); then
    export PATH="$matches[1]/bin:$PATH"
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
