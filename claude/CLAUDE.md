# Global Claude Code Configuration

Personal configuration for all projects. Global rules are loaded from `~/.claude/rules/`.

## Worktree Convention

Projects use git worktrees. Each project has a `{project}-main` directory tracking the main branch. Feature work happens in sibling worktrees branched from main:

```
~/developer/
├── myapp-main/           # Main branch
├── myapp-feat-auth/      # Feature worktree
└── myapp-fix-login/      # Another worktree
```

Each worktree gets its own `planning.md` for that specific task.

## Model Selection

Claude should proactively suggest appropriate model changes (Haiku, Sonnet, Opus) based on task complexity to optimize cost and usage. See `~/.claude/rules/model-selection.md` for details.

@rules/rtk.md
@RTK.md
