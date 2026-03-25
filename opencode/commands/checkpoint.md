---
description: Checkpoint OpenCode plan and summarize in .claude/planning.md
model: openai/gpt-5.3-codex
---

## Task

Create a checkpoint from the active OpenCode plan in `.opencode/plans/`, then summarize the current state in `./.claude/planning.md` so the next session can resume quickly after `/compact`.

## Steps

1. **Find active plan**
   - Locate files in `.opencode/plans/*.md`
   - Select the most recently modified file
   - If none exists, stop and report that no OpenCode plan was found

2. **Read active plan**
   - Read the selected plan file fully
   - Preserve structure and decisions

3. **Capture current state**
   - Run `rtk git status --short`
   - Identify completed, in-progress, and next work

4. **Update active plan**
   - Refresh progress sections in the selected `.opencode/plans/*.md` file
   - Add newly discovered tasks, blockers, and key decisions
   - Keep it concise and execution-ready

5. **Write immutable checkpoint snapshot**
   - Ensure `.opencode/checkpoints/` exists
   - Write `.opencode/checkpoints/<timestamp>-<plan-filename>.md`
   - Include: plan path, timestamp, git status summary, and full updated plan content

6. **Summarize in .claude planning**
   - Update `./.claude/planning.md` with a short handoff summary
   - Include: active plan path, what changed this session, what is next, and blockers/decisions

7. **Confirm ready**
   - Confirm checkpoint is saved
   - Include both file paths: updated plan, snapshot, and `./.claude/planning.md`
   - Tell the user they can run `/compact`

## Output

Brief confirmation with:
- active plan path
- checkpoint snapshot path
- `.claude/planning.md` update note
- one-line next step
