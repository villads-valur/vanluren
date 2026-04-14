---
description: Fetch and merge main into current branch
---

## Task

Fetch `main` and merge it into the current branch.

## Context

- Current branch: !`git branch --show-current`
- Upstream branch: !`git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo "(none)"`
- Repo root: !`git rev-parse --show-toplevel 2>/dev/null || echo "not-a-git-repo"`

## Steps

1. Validate that the current directory is inside a git work tree (`git rev-parse --is-inside-work-tree`).
2. Determine merge source in this order:
   - `origin/main` if remote `origin` exists and has `main`
   - otherwise `<upstream-remote>/main` if current branch has an upstream remote
   - otherwise stop with a clear error message
3. Fetch the chosen remote main branch.
4. Merge that fetched `main` into the current branch using `git merge --no-ff <source-main>` so a merge commit is created (never rebase).
5. If conflicts occur, stop and list conflicted files with clear next steps.

## Rules

- Do not change directories or check out another branch.
- Keep execution in the current directory so it works in both git worktrees and non-worktree repos.
- Do not rebase, and do not push.
- Do not use fast-forward merge for this command (`--no-ff` is required).

## Output

Report the source branch used, merge result, and whether conflicts remain.
