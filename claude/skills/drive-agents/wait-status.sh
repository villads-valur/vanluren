#!/usr/bin/env bash
# Blocks until another bork agent stops working, then prints its status and exits.
# Run it with Bash run_in_background so you're notified on exit; never in the foreground.
# Usage: wait-status.sh <bork-container-dir> <bork-issue-id>
# Reads <container>/.bork/agent-status/<project>-<issue-id>.json, written by bork's agent hooks.
set -uo pipefail

container="$1"
issue="$2"
project=$(basename "$container")
file="$container/.bork/agent-status/$project-$issue.json"
[ -f "$file" ] || { echo "FAILED: no status file at $file" >&2; exit 1; }

# Give a just-sent prompt time to flip the status to Busy
sleep 10
while true; do
  status=$(jq -r '.status // empty' "$file" 2>/dev/null)
  case "$status" in
    Busy | "") sleep 15 ;;
    *) echo "$issue: $status"; exit 0 ;;
  esac
done
