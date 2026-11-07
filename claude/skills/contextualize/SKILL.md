---
name: contextualize
description: Read project documentation and get up to speed. Invoke when user wants to understand a codebase, get context, or says "what is this project".
allowed-tools: Read, Glob, Bash(git:*), Bash(gh:*), Bash(bork issue show:*), Bash(bork issue list:*)
---

# Contextualize

Get up to speed on a project quickly. Summarise, don't dump files.

## Context

- Branch: !`git branch --show-current 2>/dev/null`
- Worktrees: !`git worktree list 2>/dev/null`
- Bork issue: !`[ -n "$BORK_ISSUE_ID" ] && bork issue show "$BORK_ISSUE_ID" 2>/dev/null || echo "not in a bork session"`

## What to Read

### Project Docs
- `AGENTS.md` in the bork container dir (project layout, bork conventions)
- `CLAUDE.md` and `.claude/` in the worktree: `architecture.md`, `decisions-and-learnings.md`, `planning.md`
- Skip files that don't exist

### Worktree Context
- Work out which worktree we're in (`{issue-id}-{slug}/` vs `main/`)
- If there's a linked Linear ticket or PR on the bork issue, read it (including comments)

### Git Status
- `git status` and `git log --oneline -10`

### GitHub Context
- `gh pr list --author @me` - my open PRs
- `gh pr list --search "review-requested:@me"` - PRs needing my review

## Output

Concise summary covering:
- What is this project?
- Current worktree, bork issue and task
- Current status/focus and recent work
- Important decisions or gotchas
- Open PRs / review requests worth knowing about
