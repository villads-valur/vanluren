# vanluren

My personal dotfiles. I'm the sole maintainer.

## Never leak work

This repo is public. Nothing from my day job goes in here:

- No employer, client or colleague names
- No internal URLs, repo names, ticket IDs or Slack/Linear content
- No tokens, keys, hostnames or machine-specific work paths
- No work-only config. Keep that in untracked local files

If a change might include any of this, stop and ask.

## Layout

Each top-level folder (`zsh/`, `nvim/`, `ghostty/`, `lazygit/`, `claude/`, `opencode/`) is symlinked into `~/.config` or `~/.claude`. See `README.md`.

## Build & test

None. Changes are config only, so check them by reloading the tool they affect.
