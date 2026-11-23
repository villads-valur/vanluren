---
name: post-review
description: Post a tuicr code review to GitHub as a PR review, optionally enriching my comments with code context first. Use when asked to "post my review", "submit my tuicr review", "post review comments to GitHub", or "submit review to PR".
---

# Post Review

Post a tuicr review to a GitHub PR as a single review with inline comments. If I don't want any comments enriched, `:submit` in tuicr does the same thing, so say so.

See the `tuicr` skill for the CLI (finding sessions, reading comments).

## Step 1: Find the review

```bash
tuicr review list --all
```

- Pick the PR session (`kind: "pr"`, slug `gh:<owner>/<repo>/pr/<n>`) I mean. One active PR session: show its slug and comment count and ask me to confirm. Several: ask which
- Read the comments: `tuicr review comments --session <slug>`. Each has `path`, `start_line`, `end_line`, `side`, `comment_type`, `author` and `content`. No `path` means a review-level comment; a `path` with no line is a file comment
- No PR session (a local review): ask for the PR number, and use `--repo <repo-root>` to read it
- If the CLI can't find it, ask me to paste the export from `y` / `:clip` instead

## Step 2: Detect the PR

The PR slug has the owner, repo and number. Get the head commit:

```bash
gh pr view <n> --repo <owner>/<repo> --json headRefOid,url
```

## Step 3: Present comments for enrichment

Show a numbered summary of all comments:

```
Found 11 comments in the review of PR #123:

 1. [issue]      (review-level)                              We're duplicating a lot of...
 2. [nit]        settings-table.tsx:99-130                   I hate this thing here...
 3. [issue]      user-drawer.tsx (file)                      This file is doing a lot...
 4. [suggestion] user-drawer.tsx:52-65                       Maybe we should give feedback...
 ...
```

Ask:
> Which comments should I enrich with more context? (e.g. "2, 4, 7" or "all" or "none")

For comments to enrich:

- Read the relevant source code from the PR branch
- Flesh out the comment with concrete context and suggestions
- Preserve the user's intent and tone, just add substance
- Show the enriched version to the user for approval

For comments posted verbatim:

- Prefix with the comment type (see below)

## Step 4: Build and submit the review

### Comment type prefix

My tuicr types are `question`, `nit`, `issue` and `suggestion`; prefix each comment with `<type>:` (e.g. `nit: ...`). Older sessions may have other types such as `nitpick` or `note`: use `nit:` for `nitpick` and `<type>:` for the rest. Untyped comments (`none`) get no prefix, unless the text already starts with a label.

### GitHub API mapping

- **Review-level comments** -> `body` field of the review
- **File-level comments** -> `{ path, line: 1, side: "RIGHT" }`
- **Single-line comments (new side)** -> `{ path, line, side: "RIGHT" }`
- **Multi-line comments (new side)** -> `{ path, start_line, start_side: "RIGHT", line, side: "RIGHT" }`
- **Old-side comments (deleted lines)** -> use `side: "LEFT"` (and `start_side: "LEFT"` for ranges)

### Submit

Write the payload to a fresh temp file (`PAYLOAD=$(mktemp)`) and submit:

```bash
gh api repos/{owner}/{repo}/pulls/{number}/reviews \
  --method POST --input "$PAYLOAD" \
  --jq '{id: .id, state: .state, html_url: .html_url}'
```

Report the review URL back to the user. Clean up the temp file.

## Rules

- Always prefix comments with their type (`issue:`, `nit:`, etc.)
- Post as a single COMMENT review (not REQUEST_CHANGES or APPROVE)
- When enriching, keep the user's voice and tone - just add substance
- If a comment references code, read the actual code from the branch before enriching
- Never fabricate issues the user didn't raise
- Never mention bork issue IDs (`{project}-{n}`) or local worktree paths in comments
- Clean up temp files after submission
