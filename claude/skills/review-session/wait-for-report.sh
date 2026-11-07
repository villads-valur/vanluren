#!/usr/bin/env bash
# Blocks until a reviewer finishes, then prints one status line and exits.
# Run it in the background (Bash run_in_background) so the calling agent is notified on exit.
# Usage: wait-for-report.sh <tmux-session> <window-name> <report-file>
set -uo pipefail

session="$1"
window="$2"
report="$3"
exit_marker="$report.exit"

while true; do
  if [ -f "$report" ]; then
    echo "DONE: report ready at $report"
    exit 0
  fi
  if ! tmux list-windows -t "$session" -F '#W' 2>/dev/null | grep -qx "$window"; then
    echo "FAILED: window $window closed without writing $report"
    exit 1
  fi
  if [ -f "$exit_marker" ]; then
    echo "FAILED: reviewer in $window exited (code $(cat "$exit_marker")) without writing $report"
    exit 1
  fi
  sleep 5
done
