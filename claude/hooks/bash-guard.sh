#!/bin/sh
# PreToolUse hook for Bash: block shell habits that rules/ forbid before they run.
# Exit 2 blocks the command and shows the message to Claude.
# Test changes with test-guards.sh.
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

# Bork IDs must not reach GitHub (rules/git-workflow.md): check git push and gh pr create
# for bork branches ({project}-{n}/{slug}) and commit messages with this session's bork ID
check_push() {
  has "${sep}(git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+push|gh[[:space:]]+pr[[:space:]]+create)([[:space:]]|$)" || return
  # Deleting a leaked branch is the fix, not the problem
  has "push[^;&|]*[[:space:]](--delete|-d)[[:space:]]" && return

  bork_branch='^[a-z][a-z0-9-]*-[0-9]+/'
  rename="Bork IDs must not reach GitHub. Rename first: git branch -m <TICKET-ID>/<slug> (or a descriptive slug), and keep bork IDs out of commit messages."

  # Where the command runs: `git -C <dir>`, a leading `cd <dir> &&`, else the hook's cwd
  dir=$(printf '%s' "$cmd" | sed -nE 's/.*git[[:space:]]+-C[[:space:]]+([^[:space:]]+).*/\1/p')
  [ -z "$dir" ] && dir=$(printf '%s' "$cmd" | sed -nE 's/^[[:space:]]*cd[[:space:]]+([^[:space:];&]+)[[:space:]]*(&&|;).*/\1/p')
  [ -z "$dir" ] && dir=$(printf '%s' "$input" | jq -r '.cwd // empty')
  dir=$(printf '%s' "$dir" | sed -e "s|^~|$HOME|" -e "s/^[\"']//" -e "s/[\"']\$//")
  [ -d "$dir" ] || dir=.

  # Branch names given explicitly: push refspecs (dst of src:dst) and gh pr create --head
  set -f
  for word in $(printf '%s' "$cmd" | sed -nE 's/.*(git[^;&|]*push|gh[[:space:]]+pr[[:space:]]+create)([^;&|]*).*/\2/p'); do
    case "$word" in -*) continue ;; esac
    name=${word#*:}
    name=${name#refs/heads/}
    if printf '%s' "$name" | grep -Eq "$bork_branch"; then
      block "'$name' looks like a bork branch. $rename"
      return
    fi
  done
  set +f

  branch=$(git -C "$dir" branch --show-current 2>/dev/null)
  explicit_refspec=$(printf '%s' "$cmd" | grep -Eo 'push[^;&|]*' | grep -Eo '[[:space:]][^-[:space:]][^[:space:]]*:[^[:space:]]+' | head -1)
  if [ -z "$explicit_refspec" ] && printf '%s' "$branch" | grep -Eq "$bork_branch"; then
    block "Current branch '$branch' is a bork branch. $rename"
    return
  fi

  [ -n "$BORK_ISSUE_ID" ] || return
  base=$(git -C "$dir" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null) ||
    base=$(git -C "$dir" rev-parse --abbrev-ref origin/HEAD 2>/dev/null)
  if [ -n "$base" ] && git -C "$dir" log --format=%B "$base..HEAD" 2>/dev/null | grep -Eq "(^|[^A-Za-z0-9-])$BORK_ISSUE_ID([^0-9]|\$)"; then
    block "A commit in $base..HEAD mentions $BORK_ISSUE_ID. Reword it before pushing. $rename"
  fi
}
check_push

[ -n "$msg" ] && { echo "$msg" >&2; exit 2; }
exit 0
