#!/bin/sh
# PreToolUse hook for Bash: block the zsh mistakes from rules/workflow.md before they run.
# Exit 2 blocks the command and shows the message to Claude.
cmd=$(jq -r '.tool_input.command // empty')
msg=""
printf '%s' "$cmd" | grep -Eq '(^|[;&|[:space:]])echo[[:space:]]+=' && msg="zsh expands words starting with =; use echo '---'"
printf '%s' "$cmd" | grep -Eq '(^|[;&|[:space:]])[A-Za-z][[:space:]]*\(\)' && msg="one-letter function names clash with zsh aliases; use a longer name"
printf '%s' "$cmd" | grep -Eq -- "--include=[^'\"[:space:]]*\*" && msg="quote globs in zsh, e.g. --include='*.ts'"
[ -n "$msg" ] && { echo "$msg" >&2; exit 2; }
exit 0
