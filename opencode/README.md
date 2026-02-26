# OpenCode Workspace

This directory contains local OpenCode configuration, plugins, and plugin config/state used by this repo.

## What is in here

- `opencode/opencode.jsonc`
  - OpenCode config (schema, instruction file paths, model/agent routing, MCP config).
  - Note: the `instructions` and `skills.paths` entries are machine-specific (point at `~/.claude/...`).
  - Why `~/.claude/*`: this reuses a single, shared set of personal instructions/rules across projects, so OpenCode behaves consistently no matter which repo you run it in.
  - OpenCode docs: `instructions` config option, https://opencode.ai/docs/config/#instructions

- `opencode/plugins/`
  - OpenCode plugins written in TypeScript.
  - `opencode/plugins/peon-ping.ts`: plays sound effects for OpenCode events (and can send desktop notifications).
  - Plugin page: https://github.com/tonyyont/peon-ping

- `opencode/peon-ping/`
  - Runtime/config files for the `peon-ping` plugin.
  - `opencode/peon-ping/config.json`: plugin settings (pack name, volume, category toggles, spam detection, debounce, notifications).
  - `opencode/peon-ping/peon-icon.png`: icon used for notifications (when supported).
  - `opencode/peon-ping/.state.json`: last-played tracking (ignored by git).

## Notes

- The `peon-ping` plugin defaults to reading packs from `~/.openpeon/packs` (unless `packs_dir` is set in config).
- The plugin code expects its runtime config under `~/.config/opencode/peon-ping/` and plugins under `~/.config/opencode/plugins/`. This repo keeps a copy of those files for versioning/reference.
