---
name: review-session
description: Start a Codex or Claude review of this bork issue's PRs in a new tmux window next to the current session
argument-hint: "[codex|claude] [pr-number...|all] | done"
disable-model-invocation: true
allowed-tools: Bash(bork issue list:*), Bash(gh pr view:*), Bash(git fetch:*), Bash(tmux:*), Bash(mkdir:*), Bash(chmod:*), Bash(rm -f:*), Write
---

# Review Session

Open one tmux window per PR in the current tmux session (one session per bork issue), each running a reviewer agent in yolo mode so it never stops for approvals. The agents can technically write, so the reviewer prompt is what keeps them read-only. Findings stay in those windows; nothing is posted to GitHub.

## Context

- Bork issue: !`echo "${BORK_ISSUE_ID:-not in a bork session}"`
- Linked PRs: !`[ -n "$BORK_ISSUE_ID" ] && bork issue list --json | jq -r --arg id "$BORK_ISSUE_ID" '.[] | select(.id==$id) | .github_pr_links[].number' | tr '\n' ' ' || echo none`
- tmux session: !`tmux display-message -p '#S' 2>/dev/null || echo "not in tmux"`
- Windows: !`tmux list-windows -F '#I:#W' 2>/dev/null | tr '\n' ' ' || echo none`
- Worktree: !`pwd`

## Steps

1. **Parse `$ARGUMENTS`**
   - `done`: skip to [Cleanup](#cleanup)
   - Agent: `codex` (default, gives a read independent of this session's model) or `claude`
   - PRs: explicit numbers, `all`, or nothing

2. **Pick the PRs**
   - Start from the linked PRs above. If there are none, stop and say the issue has no linked PRs (`bork integration attach-pr <n>`).
   - Look each one up: `gh pr view <n> --json number,title,state,headRefName,baseRefName,headRefOid`
   - One open PR and none requested: use it
   - Several open PRs and none requested: list them (number, title, branch → base) and ask which to review, offering "all"
   - Skip merged/closed PRs unless I named them

3. **Prepare** each PR so the reviewer can read it without network or writes:
   - `git fetch origin <headRefName> <baseRefName>`
   - Write the reviewer prompt below to `$TMPDIR/bork-review/<issue-id>-pr-<n>.md`, filling in the PR number, URL, base, head branch and `headRefOid`

4. **Launch** a window per PR, detached so focus stays here. If a window with the same name already exists, ask before replacing it.
   - Write a launcher `$TMPDIR/bork-review/<issue-id>-pr-<n>.sh` (avoids tmux quoting issues) and `chmod +x` it:
     - codex: `codex --dangerously-bypass-approvals-and-sandbox "$(cat <prompt-file>)"`
     - claude: `claude --dangerously-skip-permissions -n "review PR #<n>" "$(cat <prompt-file>)"`
     - End the script with `exec "$SHELL"` so the window stays open after the agent exits
   - `tmux new-window -d -n review-<agent>-<n> -c "$PWD" <launcher>`

5. **Report**: window names and how to switch (`prefix + <index>`). For codex, mention that a first run in a repo stops on a folder-trust prompt that I have to answer. Remind me to run `/review-session done` once the findings are handled.

## Cleanup

The review windows are temporary. Close them once they're no longer needed: when I run `/review-session done`, say the review is finished, or the findings have been fixed or dismissed in this session.

1. List this session's review windows: `tmux list-windows -F '#I:#W' | grep ':review-'`
2. If any agent in them is still working (check with `tmux capture-pane -p -t <window>`), ask before killing that one
3. Kill each one: `tmux kill-window -t <session>:<window-name>`. Only touch `review-*` windows that this skill created, never this session's own window or others
4. Remove the prompt and launcher files: `rm -f "$TMPDIR"/bork-review/<issue-id>-pr-*`
5. Confirm in one line which windows were closed

## Reviewer Prompt

```
Review PR #<n> (<url>): <head-branch> → <base-branch>, head commit <sha>.

Follow the review checklist and output format in ~/.claude/skills/review/SKILL.md (Standards and Spec axes, conventional-comment labels).

- Diff: `gh pr diff <n>` or `git diff origin/<base>...<sha>`
- Spec: `gh pr view <n>` (body and linked issues), plus the bork issue: `bork issue show <issue-id>`
- File context: read files at the PR head with `git show <sha>:<path>`; the working tree may be on a different branch

Read-only: don't edit files, check out branches, commit, push, or post to GitHub. Report findings ranked by severity, each with file:line, the problem and a suggested fix.
```
