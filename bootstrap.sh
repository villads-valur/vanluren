#!/usr/bin/env bash
# Fresh-Mac setup. Safe to re-run: existing real files are moved to a backup dir before linking.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BORK="$HOME/code/personal/bork"
BORK_REPO="git@github.com:villads-valur/bork.git"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# Move a real (non-symlink) file out of the way; drop an old symlink
backup() {
  local dest="$1"
  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    mkdir -p "$BACKUP"
    mv "$dest" "$BACKUP/"
  fi
}

link() {
  local src="$1" dest="$2"
  backup "$dest"
  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest"
  echo "  $dest -> $src"
}

append_once() {
  local line="$1" file="$2"
  touch "$file"
  grep -qxF "$line" "$file" || echo "$line" >> "$file"
}

echo "==> Homebrew"
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file="$DOTFILES/Brewfile"

echo "==> GitHub + SSH"
gh auth status >/dev/null 2>&1 || gh auth login -h github.com -s admin:public_key
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
  mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
  ssh-keygen -t ed25519 -C "$(whoami)@$(scutil --get LocalHostName)" -f "$HOME/.ssh/id_ed25519" -N ""
fi
# Checked separately so a failed upload is retried on the next run
GITHUB_KEYS="$(gh ssh-key list 2>/dev/null || true)"
if ! grep -qF "$(awk '{print $2}' "$HOME/.ssh/id_ed25519.pub")" <<<"$GITHUB_KEYS"; then
  gh ssh-key add "$HOME/.ssh/id_ed25519.pub" --title "$(scutil --get ComputerName) $(date +%Y-%m-%d)"
fi
if ! grep -qx 'Host github.com' "$HOME/.ssh/config" 2>/dev/null; then
  printf '\nHost github.com\n  AddKeysToAgent yes\n  UseKeychain yes\n  IdentityFile ~/.ssh/id_ed25519\n' >> "$HOME/.ssh/config"
  chmod 600 "$HOME/.ssh/config"
fi
gh config set git_protocol ssh
git -C "$DOTFILES" remote set-url origin git@github.com:villads-valur/vanluren.git

echo "==> Runtimes"
export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"
. "$(brew --prefix nvm)/nvm.sh"
nvm install --lts
nvm alias default 'lts/*'
export PATH="$(brew --prefix rustup)/bin:$HOME/.cargo/bin:$PATH"
rustup default stable

echo "==> Shell"
append_once 'eval "$(/opt/homebrew/bin/brew shellenv)"' "$HOME/.zprofile"
append_once 'export PATH="$(brew --prefix rustup)/bin:$HOME/.cargo/bin:$PATH"' "$HOME/.zprofile"
ZSHRC_LINE="source $DOTFILES/zsh/config.zsh"
if [ "$(cat "$HOME/.zshrc" 2>/dev/null)" != "$ZSHRC_LINE" ]; then
  backup "$HOME/.zshrc"
  echo "$ZSHRC_LINE" > "$HOME/.zshrc"
fi

echo "==> Config links"
link "$DOTFILES/nvim" "$HOME/.config/nvim"
link "$DOTFILES/ghostty" "$HOME/.config/ghostty"
link "$DOTFILES/opencode" "$HOME/.config/opencode"
link "$DOTFILES/lazygit/config.yml" "$HOME/Library/Application Support/lazygit/config.yml"

echo "==> Claude"
for f in CLAUDE.md rules commands settings.json statusline-command.sh; do
  link "$DOTFILES/claude/$f" "$HOME/.claude/$f"
done
# Link skills one by one so Claude Code's own ~/.claude/skills/synced stays untouched.
# Older setups linked the whole folder; linking into it would clobber the repo's skills.
if [ -L "$HOME/.claude/skills" ]; then
  rm "$HOME/.claude/skills"
fi
mkdir -p "$HOME/.claude/skills"
for skill in "$DOTFILES"/claude/skills/*/; do
  link "${skill%/}" "$HOME/.claude/skills/$(basename "$skill")"
done

echo "==> bork"
if [ ! -d "$BORK/main" ]; then
  # `bork init` needs a bork binary, so build a throwaway copy first and reuse its build cache
  BORK_SEED="$(mktemp -d)"
  git clone --depth 1 "$BORK_REPO" "$BORK_SEED"
  cargo build --release --manifest-path "$BORK_SEED/Cargo.toml"
  (cd "$(dirname "$BORK")" && "$BORK_SEED/target/release/bork" init --agent claude "$BORK_REPO" "$(basename "$BORK")")
  mv "$BORK_SEED/target" "$BORK/main/target"
  rm -rf "$BORK_SEED"
fi
cargo build --release --manifest-path "$BORK/main/Cargo.toml"
ln -sf "$BORK/main/target/release/bork" /opt/homebrew/bin/bork

echo "==> Dock"
dockutil --find Ghostty >/dev/null || dockutil --add /Applications/Ghostty.app --no-restart
if dockutil --find Terminal >/dev/null; then
  dockutil --remove Terminal --no-restart
fi
killall Dock

echo "==> Neovim plugins"
nvim --headless "+Lazy! sync" +qa

echo
echo "Done. Open a new terminal. Launch OrbStack once to get the docker CLI."
if [ -d "$BACKUP" ]; then
  echo "Backed up replaced files to $BACKUP"
fi
