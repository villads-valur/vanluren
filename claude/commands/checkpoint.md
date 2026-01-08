---
allowed-tools: Read, Edit, Write, Bash(git:*)
description: Save progress to planning.md before compacting
---

## Task

Create a checkpoint by updating `./.claude/planning.md` with the current session's progress, preparing for a `/compact`.

## Steps

1. **Read current planning.md** - Read `./.claude/planning.md` to understand the current state

2. **Check git status** - Run `git status` to see what's changed

3. **Summarise session progress** - Think about what was accomplished this session:
   - What tasks were completed?
   - What's currently in progress?
   - What's the next logical step?
   - Any blockers or decisions needed?

4. **Update planning.md** - Edit `./.claude/planning.md` to reflect:
   - Mark completed items as done
   - Add any new tasks discovered
   - Update the "Current Focus" or equivalent section
   - Add any important notes or context for the next session

5. **Confirm ready** - Tell the user the checkpoint is saved and they can now run `/compact`

## Output

Briefly confirm what was updated in planning.md. Keep it short - the user will run `/compact` next.
