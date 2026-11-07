---
name: handoff
description: Write the current session into the worktree's planning.md so a fresh agent (or this one after /compact) can pick up the work
argument-hint: "[what the next session is for]"
disable-model-invocation: true
allowed-tools: Read, Edit, Write, Bash(git:*), Bash(bork issue show:*)
---

# Handoff

Capture this session in the worktree's `.claude/planning.md` so the next context can continue without this conversation: after `/compact`, in a new session, or in a bork sub-issue.

## Context

- Status: !`git status --short`
- Branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -5`

## Steps

1. **Read** `.claude/planning.md` in the current worktree. If it's missing, create it from the `worktree` skill's `planning-template.md`.

2. **Update it** so a fresh agent with no memory of this session can continue:
   - Active task and status
   - Done this session (tick off completed items)
   - In progress and the exact next step
   - Decisions made and why, plus dead ends already ruled out
   - Blockers or open questions for me
   - Suggested skills for the next session (e.g. `/pre-review`, `/pr`)

3. **Tailor it** to `$ARGUMENTS` if given (what the next session will focus on).

4. **Reference, don't copy**: point to existing artifacts (PRs, Linear tickets, bork issue, commits, files) by URL or path instead of repeating their content.

5. **Redact** secrets, tokens and personal data.

6. **Confirm** in one or two lines what was saved and the next step: `/compact`, a new session, or `bork issue start "..." --prompt "Continue from <worktree>/.claude/planning.md"` if the work should move to a sub-issue (ask before starting one).
