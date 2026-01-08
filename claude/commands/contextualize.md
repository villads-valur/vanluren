---
allowed-tools: Read, Glob, Bash(git:*)
description: Read project documentation and get up to speed
---

## Task

Read and summarise the project documentation to understand the current context.

## Steps

1. **Check for project docs** - Look for these files in `./.claude/`:
   - `CLAUDE.md` - Project-specific context and working agreements
   - `architecture.md` - System design and technical architecture
   - `decisions-and-learnings.md` - Technical decisions and gotchas
   - `planning.md` - Current work and task tracking

2. **Read what exists** - Read each file that exists in `./.claude/`

3. **Check git status** - Run `git status` and `git log --oneline -10` to understand recent work

4. **Summarise** - Provide a brief summary:
   - What is this project?
   - What's the current status/focus?
   - Any important decisions or gotchas to be aware of?
   - What was recently worked on?

## Output

Provide a concise summary (not a dump of the files). Focus on what's actionable and relevant for the current session.
