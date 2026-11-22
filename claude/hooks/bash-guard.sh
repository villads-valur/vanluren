#!/bin/sh
# PreToolUse hook for Bash: block shell habits that rules/ forbid before they run.
# Exit 2 blocks the command and shows the message to Claude.
input=$(cat)
# Flatten newlines so multi-line commands (heredocs, loops) match as one string
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty' | tr '\n' ' ')
background=$(printf '%s' "$input" | jq -r '.tool_input.run_in_background // false')
msg=""
block() { msg="${msg}${msg:+
}$1"; }
has() { printf '%s' "$cmd" | grep -Eq -- "$1"; }
sep='(^|[;&|(`[:space:]])'

# zsh pitfalls (rules/workflow.md)
has "${sep}echo[[:space:]]+=" && block "zsh expands words starting with =; use echo '---'"
has "${sep}[A-Za-z][[:space:]]*\(\)" && block "one-letter function names clash with zsh aliases; use a longer name"
has "--include=[^'\"[:space:]]*\*" && block "quote globs in zsh, e.g. --include='*.ts'"

# In-place file edits (rules/code.md): they break line numbers and the Edit tool's read state
edit_msg="edit files with the Edit tool (replace_all for repeated replacements) or Write, not"
has "${sep}sed[[:space:]]+(-[A-Za-z]+[[:space:]]+)*-[A-Za-z]*i" && block "$edit_msg sed -i"
has "${sep}perl[[:space:]]+(-[0-9A-LN-Za-z]+[[:space:]]+)*-[0-9A-LN-Za-z]*i" && block "$edit_msg perl -i/-pi"
# python that writes files, unless it only writes to a temp/scratch dir
if has "${sep}python3?[[:space:]]+(-[[:space:]]*<<|<<|-c)" &&
  has "write_text|write_bytes|\.write\(|open\([^)]*,[[:space:]]*(mode=)?['\"][wa]" &&
  ! has "/tmp/|TMPDIR|scratchpad|mktemp"; then
  block "$edit_msg python scripts that write files"
fi

# Waiting (rules/workflow.md): no foreground polling loops
if [ "$background" != "true" ] && has "${sep}(until|while)[[:space:]].*[[:space:]]do[[:space:]].*sleep[[:space:]]+[0-9]"; then
  block "don't poll with sleep in the foreground; use 'gh pr checks <n> --watch' or 'gh run watch' with run_in_background, or run the loop with run_in_background"
fi

# bork issue start must finish; head closes the pipe and leaves a half-created issue
has "bork[[:space:]]+issue[[:space:]]+start[^|]*\|[[:space:]]*head" && block "don't pipe bork issue start into head; run it without a pipe (or redirect to a file)"

[ -n "$msg" ] && { echo "$msg" >&2; exit 2; }
exit 0
