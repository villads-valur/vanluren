---
name: pre-review
description: Self-review a PR before I or anyone else reviews it, by running the review skill and /simplify on the PR's changes. Use on "pre-review", "run /pre-review", "get this ready for review", "/pre-review and /review-session"
argument-hint: "[pr-number]"
allowed-tools: Read, Grep, Glob, Edit, Bash(git:*), Bash(gh pr view:*), Bash(gh pr diff:*), Bash(gh pr checkout:*), Bash(bork issue list:*), Bash(cd:*)
---

# Pre-review

Get a PR into shape before a human looks at it: review it for issues, then simplify the changed code.

## Context

- Worktree: !`git rev-parse --show-toplevel 2>/dev/null || { wt=$(bork issue list --json 2>/dev/null | jq -r --arg id "$BORK_ISSUE_ID" '.[] | select(.id==$id) | .worktree // empty'); [ -n "$wt" ] && [ -d "$wt" ] && (cd "$wt" && pwd); } || echo "none (in $(pwd), not a git repo)"`
- Current branch: !`git branch --show-current 2>/dev/null || echo "unknown: cd into the worktree first"`
- PR for this branch: !`gh pr view --json number,title,baseRefName,headRefName -q '"#\(.number) \(.title) (\(.headRefName) -> \(.baseRefName))"' 2>/dev/null || echo "unknown until you cd into the worktree"`
- Working tree: !`git status --short 2>/dev/null || echo "n/a"`

## Steps

0. **Go to the worktree**: this skill is often run from the bork container dir, which isn't a git repo. If the current directory isn't the Worktree above, `cd <worktree>` first and work there for every later step (the Context lines above are then stale, so re-run them). If Worktree is `none`, stop and say the issue has no worktree.

1. **Resolve the PR**: use `$ARGUMENTS` if given, otherwise the PR for the current branch. If neither exists, ask.

2. **Make sure the PR branch is checked out locally**:
   - If the current branch isn't the PR's head branch, find its bork worktree (`git worktree list`) and `cd` there. If there's no worktree, ask before running `gh pr checkout`.
   - If the working tree has uncommitted changes, stop and ask, so the fixes stay separate from unrelated edits.

3. **Review**: run the `review` skill on the PR (`/review <pr-number>`). Keep the findings.

4. **Simplify**: check the size with `git diff --shortstat origin/<base>...HEAD`.
   - Under 50 changed lines (added plus removed): don't run `/simplify`, since it starts several review agents. Read the diff yourself for reuse, duplication and needless complexity, and fix what you find
   - Otherwise run `/simplify` on the PR's changes (`git diff origin/<base>...HEAD`) and let it apply its fixes

5. **Fix review findings**: apply the High and Medium findings from step 3 that are clear-cut, realistic (see "Review Loops" in `~/.claude/rules/workflow.md`) and not already covered by step 4. Dismiss theoretical edge cases in one line each. Leave Low findings, `question`s and anything that would change behaviour for me.

6. **Report**:
   - Changes made (files plus a one-line reason each)
   - Remaining review findings, using conventional-comment labels
   - Commit the fixes (`refactor:` or `fix:`), then ask before pushing

7. **Chain**: if I also asked for `review-session` ("/pre-review and /review-session", "and a short review-session"), run the `review-session` skill once the fixes are committed and pushed. "Short" means one round, no follow-up

## Rules

- Never post comments to GitHub or push without asking
- Don't change behaviour; flag anything that needs a behaviour change instead of fixing it
- Stay inside the PR's diff; don't refactor untouched code
