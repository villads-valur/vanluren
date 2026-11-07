---
name: land
description: Check whether this worktree's PR is ready to merge, or tidy up after I merged it. Use on "ready to merge?", "can we merge this?", "merged", "X is merged"
argument-hint: "[check|merged] [pr-number]"
---

# Land

Two modes. Pick from `$ARGUMENTS`, else from what I said: "ready to merge?" → `check`, "merged" → `merged`. Never merge yourself; I squash & merge in the GitHub UI.

Work in the issue's worktree (`git -C <worktree>` if you're in the bork container dir). The PR is the one given, else the one for the current branch (`gh pr view --json number`), else the bork issue's linked PR (`bork issue show $BORK_ISSUE_ID`).

## check

1. `git fetch origin`. If the branch is behind `origin/main`, merge it in (never rebase), resolve conflicts, and run the repo's lint/typecheck/tests for what changed. Ask before pushing
2. `gh pr checks <n>` and `gh pr view <n> --json mergeable,mergeStateStatus,reviewDecision,isDraft`, plus unresolved review threads
3. Reply in one line: **ready**, or **not ready** with only the blocking items (failing check, conflict, unresolved thread, still draft)

## merged

1. Confirm `gh pr view <n> --json state` is `MERGED`; if not, say so and stop
2. Update `main/`: `git -C <container>/main pull --ff-only`. If `main/` has uncommitted changes, list them and stop instead of stashing or resetting
3. `bork issue move <id> done` (never archive). If other bork issues are linked to this one, tell me which ones were waiting on it
4. Confirm in one line
