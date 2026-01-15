# Global Claude Code Configuration

Personal configuration for all projects. Global rules are loaded from `~/.claude/rules/`.

## Project Structure (New Projects)

Every project should have a `.claude/` directory:

```
project/
├── .claude/
│   ├── CLAUDE.md                 # Project overview (minimal, auto-loaded)
│   ├── rules/                    # Modular rules (auto-loaded)
│   │   ├── workflow.md           # Git workflow, worktrees
│   │   ├── code-standards.md     # Code style, conventions
│   │   ├── infrastructure.md     # IaC, deployment
│   │   └── pr-guidelines.md      # PR descriptions
│   ├── architecture.md           # System design (via @import)
│   └── decisions-and-learnings.md # Lessons learned (via @import)
```

### Key Files

| File | Purpose | Auto-loaded? |
|------|---------|--------------|
| `CLAUDE.md` | Project overview, minimal context | Yes |
| `rules/*.md` | Modular project-specific rules | Yes |
| `architecture.md` | System design, technical architecture | Via @import |
| `decisions-and-learnings.md` | Technical decisions, gotchas | Via @import |
| `planning.md` | Current work (in worktrees) | Manual read |

### Memory Hierarchy

1. **Enterprise policy** (highest priority)
2. **Project memory** (`./CLAUDE.md`, `./.claude/CLAUDE.md`)
3. **Project rules** (`./.claude/rules/*.md`)
4. **User memory** (`~/.claude/CLAUDE.md`, `~/.claude/rules/*.md`)
5. **Project local** (`./CLAUDE.local.md` - gitignored)

## Templates

Located in `~/.claude/templates/`:

| Template | Use for |
|----------|---------|
| `project-claude.md` | New project `.claude/CLAUDE.md` |
| `architecture.md` | New project `.claude/architecture.md` |
| `decisions-and-learnings.md` | New project `.claude/decisions-and-learnings.md` |
| `planning.md` | New task `.claude/planning.md` |

## Common Commands

```bash
npm run lint        # Run linting
npm run typecheck   # Run type checking
npm run test        # Run tests
npm run build       # Build the project
```
