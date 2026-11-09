#!/usr/bin/env bash
# Install (or refresh) the daily dream launchd agent. Usage: install-launchd.sh [HH:MM], default 07:00.
# launchd runs a missed job when the Mac wakes, so a closed lid at 07:00 still gets a dream.
set -euo pipefail

TIME="${1:-07:00}"
LABEL="com.vanluren.claude-dream"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"
RUN="$HOME/.claude/skills/dream/run.sh"

mkdir -p "$HOME/Library/LaunchAgents" "$HOME/.claude/dreams"
cat > "$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>$LABEL</string>
  <key>ProgramArguments</key><array><string>$RUN</string></array>
  <key>StartCalendarInterval</key>
  <dict>
    <key>Hour</key><integer>$((10#${TIME%%:*}))</integer>
    <key>Minute</key><integer>$((10#${TIME##*:}))</integer>
  </dict>
  <key>StandardOutPath</key><string>$HOME/.claude/dreams/launchd.log</string>
  <key>StandardErrorPath</key><string>$HOME/.claude/dreams/launchd.log</string>
</dict>
</plist>
EOF

launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST"
echo "  $LABEL daily at $TIME -> $RUN"
