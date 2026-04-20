---
name: post-review
description: Post a tuicr code review to GitHub as a PR review. Use when asked to "post my review", "submit my tuicr review", "post review comments to GitHub", or "submit review to PR".
---

# Post Review

Post a tuicr code review to a GitHub PR as a single review with inline comments.

## Step 1: Find the review

Try these sources in order:

### 1a. Auto-detect tuicr session

Look for the latest session JSON in the tuicr data directory:
- **macOS:** `~/Library/Application Support/tuicr/reviews/`
- **Linux:** `~/.local/share/tuicr/reviews/`

List files sorted by modification time (newest first). Read the latest session
and show the user: branch name, number of files, number of comments.
Ask to confirm this is the right session.

### 1b. If no session found or wrong session

Ask the user:
> I couldn't find a matching tuicr session. You can either:
> 1. Paste your tuicr review export (the markdown from `:clip` or `y`)
> 2. Provide a path to a tuicr session JSON file

### Tuicr session JSON format

```json
{
  "branch_name": "feature-branch",
  "base_commit": "abc123",
  "review_comments": [
    { "content": "...", "comment_type": "issue", "side": null, "line_range": null }
  ],
  "files": {
    "path/to/file.tsx": {
      "file_comments": [
        { "content": "...", "comment_type": "suggestion", "side": null, "line_range": null }
      ],
      "line_comments": {
        "42": [
          { "content": "...", "comment_type": "nit", "side": "new", "line_range": { "start": 40, "end": 42 } }
        ]
      }
    }
  }
}
```

### Tuicr markdown export format

```
Comment types: QUESTION (...), NITPICK (...), SUGGESTION (...), ISSUE (...)

1. **[ISSUE]** `Review Comment (scope: ...)` - Review-level comment text
2. **[NITPICK]** `src/file.tsx:99-130` - Line comment text
3. **[SUGGESTION]** `src/file.tsx` - File-level comment text
4. **[QUESTION]** `src/file.tsx:42` - Single line comment text
```

When parsing the markdown export:
- `Review Comment (scope: ...)` -> review-level comment (goes in review body)
- `path` (no line) -> file-level comment
- `path:line` -> single-line comment
- `path:start-end` -> multi-line range comment
- `path:~line` or `path:~start-~end` -> old-side (deleted line) comment
- Comment type tag maps to prefix: `[ISSUE]` -> `issue:`, `[NITPICK]` -> `nit:`, etc.

## Step 2: Detect the PR

Use the branch name from the session (or ask the user) to find the PR:
```bash
gh pr list --head <branch-name> --json number,headRefName,url --limit 1
gh api repos/{owner}/{repo}/pulls/{number} --jq '.head.sha'
```

If no PR found, ask the user for the PR number or URL.

## Step 3: Present comments for enrichment

Show a numbered summary of all comments:

```
Found 11 comments in review for branch ent-279-members-page:

 1. [issue]      (review-level)                              We're duplicating a lot of...
 2. [nit]        permission-matrix.tsx:99-130                I hate this thing here...
 3. [issue]      active-member-detail-drawer.tsx (file)      This file is doing a lot...
 4. [suggestion] active-member-detail-drawer.tsx:52-65       Maybe we should give feedback...
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
- Prefix with the comment type: `issue:`, `nit:`, `suggestion:`, `question:`, `note:`, `praise:`

## Step 4: Build and submit the review

### Comment type prefix mapping

| tuicr type | Prefix |
|-----------|--------|
| `issue` | `issue:` |
| `nit` / `nitpick` | `nit:` |
| `suggestion` | `suggestion:` |
| `question` | `question:` |
| `note` | `note:` |
| `praise` | `praise:` |
| Custom type | `{type}:` |

### GitHub API mapping

- **Review-level comments** -> `body` field of the review
- **File-level comments** -> `{ path, line: 1, side: "RIGHT" }`
- **Single-line comments (new side)** -> `{ path, line, side: "RIGHT" }`
- **Multi-line comments (new side)** -> `{ path, start_line, start_side: "RIGHT", line, side: "RIGHT" }`
- **Old-side comments (deleted lines)** -> use `side: "LEFT"` (and `start_side: "LEFT"` for ranges)

### Submit

Write the payload to a temp JSON file and submit:
```bash
gh api repos/{owner}/{repo}/pulls/{number}/reviews \
  --method POST --input /tmp/pr-review-payload.json \
  --jq '{id: .id, state: .state, html_url: .html_url}'
```

Report the review URL back to the user. Clean up the temp file.

## Rules

- Always prefix comments with their type (`issue:`, `nit:`, etc.)
- Post as a single COMMENT review (not REQUEST_CHANGES or APPROVE)
- When enriching, keep the user's voice and tone - just add substance
- If a comment references code, read the actual code from the branch before enriching
- Never fabricate issues the user didn't raise
- Clean up temp files after submission
