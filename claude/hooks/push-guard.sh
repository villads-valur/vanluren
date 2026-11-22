#!/bin/sh
# PreToolUse hook for Bash: keep bork issue IDs off GitHub (rules/git-workflow.md).
# Blocks `git push` and `gh pr create` when the branch is a bork branch ({project}-{n}/{slug})
# or a pushed commit message mentions this session's bork issue ID.
# Exit 2 blocks the command and shows the message to Claude.
input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty' | tr '\n' ' ')
printf '%s' "$cmd" | grep -Eq '(^|[;&|[:space:]])(git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+push|gh[[:space:]]+pr[[:space:]]+create)([[:space:]]|$)' || exit 0
# Deleting a leaked branch is the fix, not the problem
printf '%s' "$cmd" | grep -Eq 'push[^;&|]*[[:space:]](--delete|-d)[[:space:]]' && exit 0

bork_branch='^[a-z][a-z0-9-]*-[0-9]+/'
fail() {
  echo "$1" >&2
  echo "Bork IDs must not reach GitHub. Rename first: git branch -m <TICKET-ID>/<slug> (or a descriptive slug), and keep bork IDs out of commit messages." >&2
  exit 2
}

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
  printf '%s' "$name" | grep -Eq "$bork_branch" && fail "'$name' looks like a bork branch."
done

branch=$(git -C "$dir" branch --show-current 2>/dev/null)
explicit_refspec=$(printf '%s' "$cmd" | grep -Eo 'push[^;&|]*' | grep -Eo '[[:space:]][^-[:space:]][^[:space:]]*:[^[:space:]]+' | head -1)
if [ -z "$explicit_refspec" ] && printf '%s' "$branch" | grep -Eq "$bork_branch"; then
  fail "Current branch '$branch' is a bork branch."
fi

# Commit messages about to be pushed must not mention this session's bork issue ID
if [ -n "$BORK_ISSUE_ID" ]; then
  base=$(git -C "$dir" rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null) ||
    base=$(git -C "$dir" rev-parse --abbrev-ref origin/HEAD 2>/dev/null)
  if [ -n "$base" ] && git -C "$dir" log --format=%B "$base..HEAD" 2>/dev/null | grep -Eq "(^|[^A-Za-z0-9-])$BORK_ISSUE_ID([^0-9]|\$)"; then
    fail "A commit in $base..HEAD mentions $BORK_ISSUE_ID. Reword it before pushing."
  fi
fi
exit 0
