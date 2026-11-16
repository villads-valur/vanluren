---
name: pre-review
description: Self-review a PR before I or anyone else reviews it, by running the review skill and /simplify on the PR's changes. Use on "pre-review", "run /pre-review", "get this ready for review", "/pre-review and /review-session"
argument-hint: "[pr-number]"
allowed-tools: Read, Grep, Glob, Edit, Bash(git:*), Bash(gh pr view:*), Bash(gh pr diff:*), Bash(gh pr checkout:*)
---

# Pre-review

Get a PR into shape before a human looks at it: review it for issues, then simplify the changed code.

## Context

- Current branch: !`git branch --show-current 2>/dev/null || echo "not a git repo: cd into the issue worktree first"`
- PR for this branch: !`gh pr view --json number,title,baseRefName,headRefName -q '"#\(.number) \(.title) (\(.headRefName) -> \(.baseRefName))"' 2>/dev/null || echo "none"`
- Working tree: !`git status --short 2>/dev/null || echo "n/a"`

## Steps

1. **Resolve the PR**: use `$ARGUMENTS` if given, otherwise the PR for the current branch. If neither exists, ask.

2. **Make sure the PR branch is checked out locally**:
   - If the current branch isn't the PR's head branch, find its bork worktree (`git worktree list`) and work there. If there's no worktree, ask before running `gh pr checkout`.
   - If the working tree has uncommitted changes, stop and ask, so the fixes stay separate from unrelated edits.

3. **Review**: run the `review` skill on the PR (`/review <pr-number>`). Keep the findings.

4. **Simplify**: run `/simplify` on the PR's changes (`git diff <base>...HEAD`) and let it apply its fixes.

5. **Fix review findings**: apply the High and Medium findings from step 3 that are clear-cut and that `/simplify` didn't already cover. Leave Low findings, `question`s and anything that would change behaviour for me.

6. **Report**:
   - Changes made (files plus a one-line reason each)
   - Remaining review findings, using conventional-comment labels
   - Commit the fixes (`refactor:` or `fix:`), then ask before pushing

7. **Chain**: if I also asked for `review-session` ("/pre-review and /review-session", "and a short review-session"), run the `review-session` skill once the fixes are committed and pushed. "Short" means one round, no follow-up

## Rules

- Never post comments to GitHub or push without asking
- Don't change behaviour; flag anything that needs a behaviour change instead of fixing it
- Stay inside the PR's diff; don't refactor untouched code
