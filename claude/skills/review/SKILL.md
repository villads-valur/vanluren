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

### Correctness (check first, most important)

- Logic does what it claims, including edge cases: empty, null/undefined, zero, duplicates, very large input
- Error paths are handled; failures aren't silently swallowed; async errors are awaited or caught
- Callers of changed code still work (step 2)
- Races and ordering: concurrent requests, double submits, stale state, missing `await`
- State and data stay consistent on partial failure
- Behaviour changes nobody asked for

### Security

- No hardcoded secrets or credentials; sensitive data isn't logged
- Input validated at system boundaries
- New endpoints and queries check authorization and are scoped to the right tenant/user
- No SQL injection, XSS or command injection

### Data

- No N+1 queries or unbounded queries/loops over user data
- New query patterns have the indexes they need
- Multi-step writes are in a transaction
- Migrations are backwards compatible (avoid breaking changes; work around them where possible)

### Code quality

- My preferences in `~/.claude/rules/code.md`: explicit `if/else` over complex ternaries, early returns, descriptive lambda names, comments only for a non-obvious WHY, naming conventions, business logic in the API, feature-based folders. Before/after examples are in [examples.md](examples.md)
- No over-engineering, tech-debt files or workaround code
- TypeScript: no `any` or typecasting, null/undefined handled, consistent types
- React: apply the `no-use-effect` rules; suggest `audit-react` for a deeper pass

### Tests

- New behaviour has tests, and they're high value: they test behaviour through the public interface, not implementation details
- Edge cases from the Correctness checks are covered
- Assertions can actually fail (not just recomputing the code's own answer)

### Smell baseline

Fowler code smells (_Refactoring_, ch. 3) that apply even when a repo documents nothing. Always judgement calls ("possible Feature Envy"); a documented repo standard overrides them.

- **Mysterious Name**: name doesn't reveal what it does or holds → rename; if no honest name comes, the design is murky
- **Duplicated Code**: same logic shape in several hunks or files → extract the shared shape
- **Feature Envy**: function reaches into another object's data more than its own → move it to that data
- **Data Clumps**: the same fields/params keep travelling together → bundle them into one type
- **Primitive Obsession**: a string/number standing in for a domain concept → give it its own small type
- **Repeated Switches**: same `switch`/`if` cascade on the same type in several places → one shared map or polymorphism
- **Shotgun Surgery**: one logical change forces scattered edits → gather what changes together
- **Divergent Change**: one module edited for several unrelated reasons → split by reason to change
- **Speculative Generality**: abstraction, params or hooks the spec doesn't need → inline until a real need shows
- **Message Chains**: long `a.b().c().d()` navigation → hide the walk behind one function
- **Middle Man**: function/class that mostly delegates → call the real target directly

### Spec

- Requirements that are missing or only partly done
- Behaviour nobody asked for (scope creep)
- Requirements that look implemented but the implementation looks wrong
- The PR description says something the code doesn't do, or the code does something significant the description doesn't mention
- The test plan doesn't cover the risky parts, or describes steps that can't work with this code

Quote the spec or description line for each Spec finding.

### PR description quality

Judge the description itself, separately from the code:

- **AI slop**: filler and generic phrasing ("This PR introduces a comprehensive solution..."), headings with nothing useful under them, a file-by-file retelling of the diff instead of the why, overclaiming ("robust", "seamless"), em-dash or emoji-heavy lists
- **Unclear**: a reviewer can't tell what changed, why, or how to test it; the important change is buried
- **Jargon**: unexplained acronyms, internal names or buzzwords someone outside the team wouldn't follow

These are observations for me, not comments to post. I decide whether to raise them.

## 4. Verify each finding

Before reporting a finding:

- **State the failure**: for bugs, a concrete scenario (this input or state → this wrong result). If you can't state one, drop it or downgrade it to a `question`
- **Check the line number**: re-read the file at the reviewed version and confirm the line points at the code in question (new-file line numbers, not diff positions)
- **Drop anything tooling already enforces** (lint, formatter, typecheck)

## 5. Report

Group findings by severity. Within each group, order by importance and tag each with its axis.

- **High**: bugs, security holes, data loss or corruption, missing required behaviour. Should block the merge
- **Medium**: likely future bugs, missing tests for risky paths, clear standards violations, maintainability problems
- **Low**: readability, naming, small simplifications, nitpicks

Each finding uses this shape:

````markdown
### `path/to/file.ts:42` · Standards

<One or two plain sentences: what's wrong and why it matters. No jargon; someone new to the codebase should get it.>

```text
issue (blocking): If `items` is empty this returns `undefined`, so the total on the checkout page shows "NaN". Could we default to `0` here?
```
````

Comment drafts are for me to pick from and maybe post on the PR as part of my own review, so write them as me, speaking to the PR author:

- Use [conventional comments](https://conventionalcomments.org): `issue`, `suggestion`, `question`, `nitpick`, `praise`, with `(blocking)` on High findings and `(non-blocking)` where it helps
- Write in my style (`~/.claude/rules/writing-style.md`): short, lead with the point, then a brief reason, friendly, a question when the author may know better, no em-dashes, no filler
- Ready to paste into GitHub as-is: one or two sentences, a small code suggestion only when it makes the point clearer

End with:

- **PR description**: either "Clear" or the slop/clarity/jargon problems you found, each with the quoted phrase and a short note on why it's a problem. Add an optional comment draft in my style (e.g. `suggestion (non-blocking): ...`) that I can use if I decide to raise it
- Up to three `praise` items worth mentioning, if any
- Summary: count per severity and per axis, the checks run (lint/typecheck) and their result
- Verdict: **Approve**, **Approve with nits** or **Changes needed**

Never post the drafts or anything else to GitHub yourself; I decide what goes on the PR.
