#!/usr/bin/env bash
# Daily dream: digest new transcripts, have Claude write a report, notify. Run by launchd.
set -euo pipefail

export PATH="$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DREAMS="$HOME/.claude/dreams"
DAY="$DREAMS/$(date +%F)"
mkdir -p "$DAY"

notify() {
  osascript -e "display notification \"$1\" with title \"Claude dream\"" >/dev/null 2>&1 || true
}

# Marked before extracting so sessions written during the run are picked up next time
touch "$DREAMS/.run-started"

DIGEST="$("$SKILL_DIR/extract.sh" --out "$DAY/digest.md")"
if ! grep -q '^## ' "$DIGEST"; then
  mv "$DREAMS/.run-started" "$DREAMS/.last-run"
  echo "No new sessions"
  exit 0
fi

cd "$DREAMS"
# Read-only: the report comes back on stdout, so the dream itself can't change anything
if claude -p "/dream run $DIGEST (headless)" \
  --permission-mode dontAsk \
  --allowedTools "Read" "Glob" "Grep" \
  --add-dir "$HOME/.claude" \
  --no-session-persistence \
  > "$DAY/report.md.tmp" 2> "$DAY/run.log" && grep -q '^# Dream' "$DAY/report.md.tmp"; then
  sed -n '/^# Dream/,$p' "$DAY/report.md.tmp" > "$DAY/report.md"
  rm "$DAY/report.md.tmp"
  mv "$DREAMS/.run-started" "$DREAMS/.last-run"
  notify "Report ready: run /dream apply"
else
  notify "Dream failed, see $DAY/run.log"
  exit 1
fi
