# Claude Code Setup

## The Basic Idea

I keep my Claude Code configuration in this git repository and symlink it to `~/.claude/`. This lets me version control my setup and share it across machines.

```
~/.claude/
├── CLAUDE.md     -> <this-repo>/CLAUDE.md
├── rules/        -> <this-repo>/rules/
├── commands/     -> <this-repo>/commands/
├── skills/       -> <this-repo>/skills/
├── templates/    -> <this-repo>/templates/
└── settings.json -> <this-repo>/settings.json
```

## Directory Structure

```
claude/
├── CLAUDE.md              # Global instructions (auto-loaded)
├── rules/                 # Modular rule files (auto-loaded)
│   ├── core-principles.md # Communication, workflow
│   ├── git-workflow.md    # Branching, commits, worktrees
│   ├── code-quality.md    # Readability preferences
│   ├── architecture.md    # Code organisation preferences
│   ├── dependencies.md    # Package management
│   ├── testing.md         # Test philosophy
│   ├── tech-stack.md      # Languages and frameworks I use
│   ├── naming-conventions.md
│   ├── model-selection.md # When to suggest different models
│   └── project-management.md # Ticket formatting
├── commands/              # Slash commands
│   ├── commit.md          # /commit
│   ├── pr.md              # /pr
│   ├── review.md          # /review
│   ├── checkpoint.md      # /checkpoint
│   ├── contextualize.md   # /contextualize
│   └── cleanup.md         # /cleanup
├── skills/                # Auto-invoked workflows
│   ├── code-reviewer/     # Code review skill
│   ├── cleanup/           # Code cleanup skill
│   ├── commit/            # Git commit skill
│   ├── pr/                # Pull request skill
│   └── contextualize/     # Project context skill
├── templates/             # Templates for new projects
│   ├── project-claude.md
│   ├── architecture.md
│   ├── decisions-and-learnings.md
│   └── planning.md
├── settings.json          # Permissions, statusline, plugins
└── statusline-command.sh  # Custom status bar script
```

## Disclaimer

This is my personal Claude Code configuration. It's a work in progress that changes frequently as I learn more about what works and what doesn't. Take everything here with a grain of salt, this is just my approach.

This setup evolves constantly. What's here today might be completely different next week. I'm still learning what makes Claude Code most effective, and this is just one person's attempt at finding a good workflow.

Feel free to take inspiration, but don't treat this as a template to follow blindly.

## How It Works

### Rules (`rules/`)

These are automatically loaded by Claude Code. I split them into separate files to keep things organised. Some examples:

- **core-principles.md** - How I want Claude to communicate (ask questions, provide updates, correct my terminology)
- **git-workflow.md** - My branching strategy, commit conventions, worktree workflow
- **model-selection.md** - Prompts Claude to suggest cheaper models for simple tasks(Very much WIP)

### Commands (`commands/`)

Slash commands I use regularly:

- `/commit` - Create a conventional commit
- `/pr` - Create a pull request
- `/review` - Review code against my preferences
- `/cleanup` - Clean up code (remove useless comments, simplify nesting, remove dead code)
- `/checkpoint` - Save progress to planning.md
- `/contextualize` - Read project docs, worktree context, and GitHub status

### Skills (`skills/`)

Skills are auto-invoked based on context. They trigger when you say things like:

| Skill           | Triggers on                            |
| --------------- | -------------------------------------- |
| `commit`        | "commit this", "save my changes"       |
| `pr`            | "create a PR", "open a pull request"   |
| `cleanup`       | "clean up the code", "remove noise"    |
| `contextualize` | "get context", "what is this project"  |
| `code-reviewer` | "review this code", "check for issues" |

Skills contain the same logic as their corresponding commands but are invoked automatically when Claude detects the intent.

### Templates (`templates/`)

When starting a new project, I copy these to set up the project's `.claude/` directory. They provide a consistent structure across projects.

### Settings (`settings.json`)

Contains:

- **Permissions** - Pre-approved commands (git, npm, docker, etc.)
- **Denied commands** - Things I never want Claude to run (force push)
- **Ask permissions** - Commands requiring confirmation (reading .env files)
- **Statusline** - Custom script showing directory, branch, and context usage
- **Plugins** - TypeScript LSP enabled

## Project Structure Convention

For each project, I aim to have:

project/.claude/
├── CLAUDE.md # Project overview
├── rules/ # Project-specific rules
├── architecture.md # System design
├── decisions-and-learnings.md # Gotchas, past decisions
└── planning.md # Current task (in worktrees)

### Worktree Convention

I use git worktrees for parallel work. Each project lives in a `{project-name}-main` directory which tracks the main branch. Feature work happens in sibling worktrees:

```
~/developer/
├── myapp-main/           # Main branch (always clean)
├── myapp-feat-auth/      # Feature worktree
└── myapp-fix-login/      # Another worktree
```

New worktrees branch off from `{project}-main`. Each worktree gets its own `planning.md` to track that specific task.

### Key Files Explained

**`CLAUDE.md`** - The project overview. Uses `@import` to pull in other files:

```markdown
@.claude/architecture.md
@.claude/decisions-and-learnings.md
```

This ensures Claude gets context automatically without having to remember to read these files itself.

**`architecture.md`** - System design, how things fit together. I maintain this actively, not just "write once and forget". During weekly worktree cleaning, I read through it and remove any misunderstandings or outdated information.

**`decisions-and-learnings.md`** - Gotchas, past decisions, things that tripped me up. Same maintenance approach - reviewed weekly and kept accurate.

**`planning.md`** - One per worktree. Holds the current task status, what needs to be done, progress tracking. When I create a new worktree for a task, I create a fresh `planning.md` for that work.

**`rules/`** - Project-specific guidelines. Think of these as team-specific rules for that codebase. When I find myself adding the same rule to multiple projects, I promote it to the global rules instead.
