# vanluren dotfiles

Personal dotfiles focused on a fast terminal + Neovim workflow.

## What is in here

- `zsh/` - Zsh config (aliases, functions, variables, plugins, `p10k`)
- `nvim/` - Neovim config (LazyVim-based). See `nvim/README.md`
- `ghostty/` - Ghostty terminal config
- `lazygit/` - Lazygit config
- `claude/` - Claude Code rules, skills and settings. See `claude/README.md`
- `opencode/` - OpenCode config/plugins. See `opencode/README.md`
- `codex/` - Generates Codex's global `AGENTS.md` from the Claude rules. See `codex/README.md`

## How I use it

I keep this repo checked out and symlink the bits I want into place (mostly under `~/.config` and `~/.claude`).

## Notes

- This is intentionally personal and opinionated; expect machine-specific paths and preferences.
- `zsh/config.zsh` currently assumes the repo lives at `~/Developer/personal/vanluren/`.
- Each folder is usable on its own.
