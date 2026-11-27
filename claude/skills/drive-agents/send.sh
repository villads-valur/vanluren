#!/usr/bin/env bash
# Types a prompt into another agent's tmux pane and submits it.
# Usage: send.sh <bork-issue-id> <message>     (e.g. send.sh arcane-life-23 "Merge main and rerun the tests")
#        send.sh <tmux-target> <message>       (e.g. send.sh orb-tui-orb-tui-4:0 "...")
set -euo pipefail

target="$1"
message="$2"
if ! tmux has-session -t "${target%%:*}" 2>/dev/null; then
  # A bork issue ID: its session is <project>-<issue-id>, the agent runs in window 0
  session=$(tmux ls -F '#S' | grep -E -- "-${target}\$" | head -1)
  [ -n "$session" ] || { echo "no tmux session for $target" >&2; exit 1; }
  target="$session:0"
fi
[[ "$target" == *:* ]] || target="$target:0"

# -l sends the text literally; Enter goes separately, after the TUI has taken the paste
tmux send-keys -t "$target" -l "$message"
sleep 0.5
tmux send-keys -t "$target" Enter
echo "sent to $target"
