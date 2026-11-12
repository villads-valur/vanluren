---
name: worktree
description: Create a bork-managed git worktree for a new workstream, with a relevant issue/ticket name and title
argument-hint: "[issue-id or title]"
allowed-tools: Bash(bork:*), Bash(git worktree list:*), Bash(git branch:*), Bash(mkdir:*), Read, Write
---

# Worktree (bork)

Create a worktree for a workstream via `bork`, then add a `.claude/` directory in it with `planning.md` and `decisions-and-learnings.md`.

## Layout

```
{project}/                 # bork container dir, agents start here
├── main/                  # main branch worktree
└── {issue-id}-{slug}/     # issue worktree, branch `{issue-id}/{slug}`
```

## Templates

Bundled with this skill:
- [planning-template.md](planning-template.md) - for `.claude/planning.md`
- [decisions-template.md](decisions-template.md) - for `.claude/decisions-and-learnings.md`

## Naming

- Slug is kebab-case and concise (2-4 words), e.g. `fix-recent-files-dnd`
- Issue IDs come from bork (`{project}-{n}`) or a Linear import (lowercase identifier, e.g. `eng-123`)

## Process

1. **Check existing state**

   ```bash
   bork issue list
   git -C main worktree list
   ```

   If a similar issue or worktree exists, ask for directions before proceeding.

2. **Create the worktree**

   - Issue already exists on the board: `bork worktree <issue-id> <slug>`
   - New workstream with its own agent: `bork issue start "Title" --project <name> --prompt "..."` (add `--linear ENG-123` to link a ticket, `--model` to pick a model). Leave `--mode` at the default (build) unless I ask for plan mode
   - Don't use raw `git worktree add`; bork won't track it

3. **Switch to the worktree directory**: all subsequent file operations happen in `{issue-id}-{slug}/`

4. **Create `.claude/planning.md`** from `${CLAUDE_SKILL_DIR}/planning-template.md`, filled in from the issue/ticket, dated today

5. **Create `.claude/decisions-and-learnings.md`** from `${CLAUDE_SKILL_DIR}/decisions-template.md`, dated today

6. **Read the issue/ticket** (Linear or GitHub, including comments) and use it to populate planning.md

7. **Confirm**: report the worktree path and branch, and ask if I want to start on the task
