#!/usr/bin/env bash
# Marks a bork worktree's container dir as trusted in the Codex config, so Codex
# doesn't stop on its "Trust this folder?" prompt in each new worktree.
# Trusting the container covers every worktree inside it. Passing the trust level
# with `codex -c` doesn't skip the prompt, so it has to be in the config file.
# Usage: trust-codex.sh <worktree>
set -euo pipefail

worktree=$(cd "$1" && pwd)
container=$(dirname "$worktree")
config="${CODEX_HOME:-$HOME/.codex}/config.toml"

if [ ! -d "$container/.bork" ]; then
  echo "skipped: $container is not a bork container"
  exit 0
fi
if [ -f "$config" ] && grep -Fq "[projects.\"$container\"]" "$config"; then
  echo "already trusted: $container"
  exit 0
fi
printf '\n[projects."%s"]\ntrust_level = "trusted"\n' "$container" >> "$config"
echo "trusted: $container"
