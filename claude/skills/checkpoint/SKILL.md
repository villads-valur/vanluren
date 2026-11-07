---
name: checkpoint
description: Save progress to planning.md before compacting
disable-model-invocation: true
allowed-tools: Read, Edit, Write, Bash(git:*)
---

# Checkpoint

Update the worktree's `.claude/planning.md` with this session's progress, ready for `/compact`.

## Context

- Status: !`git status --short`
- Branch: !`git branch --show-current`

## Steps

1. **Read** `.claude/planning.md` in the current worktree (create it from the `worktree` skill's `planning-template.md` if missing)
2. **Summarise the session**: what was completed, what's in progress, the next step, any blockers or open decisions
3. **Update planning.md**: tick off completed items, add newly discovered tasks, update the active task status, add notes needed for the next session
4. **Confirm** in one or two lines that the checkpoint is saved and `/compact` can run
