---
name: drive-agents
description: Drive other bork agents from an orchestrator session - find their tmux window, read what they're doing, send them a prompt, wait until they're done, and write lean /loop prompts. Use when orchestrating sub-issues, "tell 23 to ...", "check on the agents", "pass this to the running agents", or before setting up a /loop that checks on agents
argument-hint: "[issue-id...]"
allowed-tools: Read, Bash(bork issue list:*), Bash(bork issue show:*), Bash(tmux:*), Bash(${CLAUDE_SKILL_DIR}/send.sh:*), Bash(${CLAUDE_SKILL_DIR}/wait-status.sh:*)
---

# Drive agents

Each bork issue runs its agent in its own tmux session, named `<project>-<issue-id>` (e.g. `arcane-life-arcane-life-23`). The agent is in window `0`, and window `1` is a plain terminal. Don't rediscover this each time; use the commands below.

## Context

- This session: !`echo "${BORK_SESSION:-not a bork session}"`
- Status dir: !`echo "${BORK_STATUS_DIR:-unknown}"`
- Agent sessions: !`tmux ls -F '#S' 2>/dev/null | tr '\n' ' ' || echo "not in tmux"`

## Find and read

- Issues, worktrees and agents: `bork issue list --json` (or `bork issue show <id>`)
- What an agent is doing: `tmux capture-pane -p -J -t <session>:0 -S -80`. Don't pipe pane output through `cut`; escape codes break it
- Status without reading the pane: `jq -r .status "$BORK_STATUS_DIR/<project>-<issue-id>.json"`. `Busy` is working; `Idle`, `WaitingInput`, `WaitingPermission` and `WaitingApproval` mean it's waiting for someone

## Send a prompt

- Claude sessions: prefer `SendMessage` (find the name with `ListAgents`). It arrives as a message, with no typing into the TUI
- Codex, other agents, or when `SendMessage` isn't available: `${CLAUDE_SKILL_DIR}/send.sh <issue-id> "<message>"`. It types the text literally and presses Enter separately, so the TUI doesn't swallow the Enter into the paste
- Keep messages self-contained: the other agent doesn't see your conversation. Say what to do, why, and when to report back
- Answering a numbered prompt (e.g. "1. Yes / 2. No"): `tmux send-keys -t <session>:0 <number>`, then read the pane again to check it took

## Wait

- `${CLAUDE_SKILL_DIR}/wait-status.sh <container-dir> <issue-id>` with Bash `run_in_background: true`. It exits once the agent stops being `Busy` and prints its status; you're notified then. Start one per agent you're waiting on
- Never poll with `sleep` in the foreground (the bash guard blocks it), and don't use Monitor for waits over 30 minutes

## /loop prompts

`/loop` re-sends its prompt on every wake-up, so keep that prompt to one or two lines and put the instructions in a file:

- Write the plan and per-agent state to the orchestrator's `.claude/planning.md` (who's doing what, what's done, what's next)
- Loop prompt: `Check the agents in .claude/planning.md with /drive-agents, act on anything that's waiting, update the file`
- Update the file each wake-up so the next one starts from it, not from the conversation
