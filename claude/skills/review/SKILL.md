---
name: review
description: Review code for bugs, quality and security against my preferences, and draft review comments in my voice. Invoke when reviewing PRs, branches or changes, or when asked to "review this".
argument-hint: "[pr-number|file|branch]"
allowed-tools: Read, Grep, Glob, Bash(git:*), Bash(gh pr view:*), Bash(gh pr diff:*), Bash(gh issue view:*), Bash(bork issue show:*), Bash(yarn:*), Bash(npm run:*), Bash(pnpm:*), Bash(bun run:*)
---

# Review

## Context

- Current branch: !`git branch --show-current`
- Default branch: !`git symbolic-ref refs/remotes/origin/HEAD --short 2>/dev/null || echo "origin/main"`
- Uncommitted changes: !`git diff HEAD --stat`
- Branch changes: !`git diff "$(git merge-base HEAD "$(git symbolic-ref refs/remotes/origin/HEAD --short 2>/dev/null || echo origin/main)")" --stat 2>/dev/null | tail -1`

## 1. Scope

- `$ARGUMENTS` is a PR number/URL: `gh pr diff <pr>`, and `gh pr view <pr> --json headRefOid,baseRefName` for the head commit
- `$ARGUMENTS` is a file/path: that file
- `$ARGUMENTS` is a branch: `git diff <default-branch>...<branch>`
- Nothing on a feature branch: the whole branch against its merge-base with the default branch, plus uncommitted changes
- Nothing on the default branch: uncommitted changes

## 2. Gather context

The diff alone hides most real bugs, so before judging anything:

- Read every changed file in full at the reviewed version (for PRs: `git show <head-sha>:<path>`, since the working tree may be on another branch)
- For every function, type or endpoint whose signature or behaviour changed, grep its callers and check they still work
- Read the repo's standards: CLAUDE.md, AGENTS.md, CONTRIBUTING.md, `.claude/rules/`. My own preferences are in `~/.claude/rules/code.md` (and `react.md` for React)
- Read the PR title and description (`gh pr view <pr> --json title,body`) and use them to guide the review: what the author says changed and why, the test plan, and any risks or open questions they call out. Each claim is something to verify, and areas the author flags as risky get the closest look
- Find the spec, using the first that exists:
  1. Issues linked in the PR body or commit messages (`#123`, `Closes #45`, Linear IDs like `ENG-123`), including comments
  2. The bork issue (`bork issue show "$BORK_ISSUE_ID"`) and its linked Linear ticket
  3. The worktree's `.claude/planning.md`
  4. Ask me. If there's no spec, skip the Spec checks and say so
- Run the repo's lint and typecheck scripts if they finish quickly (check `package.json`); report real failures instead of guessing what tooling would catch

## 3. Check

Two axes, kept apart so passing one doesn't hide failing the other:

- **Standards**: is the code correct, safe and up to my standards?
- **Spec**: does it do what the issue asked for?

Read and apply each of these files (next to this SKILL.md) before judging the code; together they are the checklist:

- [checks.md](checks.md): correctness, security, data, code quality, tests
- [smells.md](smells.md): code smell baseline
- [spec.md](spec.md): spec checks and PR description quality
- [examples.md](examples.md): before/after examples for the code-quality checks

## 4. Verify each finding

Before reporting a finding:

- **State the failure**: for bugs, a concrete scenario (this input or state → this wrong result). If you can't state one, drop it or downgrade it to a `question`
- **Check the line number**: re-read the file at the reviewed version and confirm the line points at the code in question (new-file line numbers, not diff positions)
- **Drop anything tooling already enforces** (lint, formatter, typecheck)

## 5. Report

Write the report exactly as described in [report.md](report.md): High/Medium/Low groups, `file:line`, plain description, conventional-comment drafts in my voice, PR description notes, summary and verdict.
