# OpenCode Workspace

This directory contains local OpenCode configuration used by this repo.

## What is in here

- `opencode.jsonc`
  - OpenCode config (schema, instruction file paths, model/agent routing, MCP config).
  - Skills are loaded from local `./skills` first, then `~/.claude/skills` as fallback.
  - Note: the `instructions` entry is machine-specific (points at `~/.claude/...`).
  - Why `~/.claude/*`: this reuses a single, shared set of personal instructions/rules across projects, so OpenCode behaves consistently no matter which repo you run it in.
  - OpenCode docs: `instructions` config option, https://opencode.ai/docs/config/#instructions
