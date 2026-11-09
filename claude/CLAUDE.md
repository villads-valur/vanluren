# Global Claude Code Configuration

Personal configuration for all projects. Global rules in `~/.claude/rules/` are loaded automatically.

## Project Layout (bork)

Projects are managed with `bork` across git worktrees and tmux. Each project is a container directory (not a git repo) with a `main/` worktree and sibling issue worktrees:

```
{project}/
├── .bork/                 # Bork state (config.toml, state.json)
├── AGENTS.md              # Project-level agent instructions
├── main/                  # Main branch worktree (git repo)
└── {issue-id}-{slug}/     # Issue worktree, branch `{issue-id}/{slug}`
```

- Agents start in the container directory. For issue work, `cd` into the issue's worktree first and work only there
- `main/` is only for hotfixes and small fix branches (branch first). Don't leave uncommitted changes in it; if it's dirty, tell me instead of working around it
- Use `bork issue start` / `bork worktree` to create worktrees (see `rules/git-workflow.md`)
- Each worktree can keep its own `.claude/planning.md` for that task
- Finished issues go to `done` (`bork issue move <id> done`); never `bork issue archive`

