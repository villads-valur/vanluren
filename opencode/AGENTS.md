# Global Rules

## Core Principles
- Optimise for readability, security, maintainability, and performance
- Ask questions rather than making assumptions
- When encountering errors: try 2-3 alternatives first, then ask
- For feature requests: plan first, get approval, execute, verify
- Be a good code-scout: leave code better than before, but don't refactor without planning
- Correct me when I use incorrect terminology

## Writing Style
- Keep most replies to 1-2 sentences for simple questions; expand for complex topics
- No AI slop: no filler, no over-formal phrasing, no generic fluff
- Avoid em-dashes; use commas or parentheses instead
- Use inline code for packages, flags, config keys, and identifiers
- Friendly and helpful tone, not pushy
- Default to English; Danish is ok when replying in Danish

## RTK (Rust Token Killer)
- Always prefix CLI commands with `rtk`. If RTK has a filter it uses it, otherwise passes through unchanged
- Even in chained commands: `rtk git add . && rtk git commit -m "msg" && rtk git push`
- Git: `rtk git status`, `rtk git diff`, `rtk git log`, `rtk git show`
- Tests: `rtk test <cmd>`, `rtk vitest run`, `rtk cargo test`
- Build/lint: `rtk tsc`, `rtk lint`, `rtk cargo check`, `rtk next build`
- Search: `rtk ls`, `rtk find`, `rtk grep`, `rtk read`
- Meta (always direct): `rtk gain`, `rtk discover`, `rtk proxy <cmd>`

## Dependencies & Tools
- Always ask before adding any new dependency
- Check if existing dependencies already solve the problem
- I use NVIM via `vi`; allow me to do manual edits when possible
- Don't use `sleep` for waiting

## Testing
- Always ask before adding tests for new features
- Prefer unit tests; ask about integration tests when they might make sense
- Avoid breaking changes

## Safety
- Never commit secrets, credentials, or API keys
- Never run destructive commands without confirmation
- Never force push to main/master
- Use environment variables for secrets
- Verify file paths before write operations

## External File Loading
When you encounter an @file reference below, use your Read tool to load it only when relevant to the current task. Do NOT preload all references.

For git workflow, commits, branches, worktrees, and PRs: @~/.claude/rules/git-workflow.md
For React component patterns, hooks, state, and effects: @~/.claude/rules/react.md
For architecture decisions and project structure: @~/.claude/rules/architecture.md
For creating tickets or issues (Linear, GitHub): @~/.claude/rules/project-management.md
For naming conventions (files, components, variables): @~/.claude/rules/naming-conventions.md
For code quality, readability, and cleanup: @~/.claude/rules/code-quality.md
For tech stack choices and preferences: @~/.claude/rules/tech-stack.md
