# Claude Code Setup

## The Basic Idea

I keep my Claude Code configuration in this git repository and symlink it to `~/.claude/`. This lets me version control my setup and share it across machines.

```
~/.claude/
├── CLAUDE.md -> ~/developer/personal/vanluren/claude/CLAUDE.md
├── rules/    -> ~/developer/personal/vanluren/claude/rules/
├── commands/ -> ~/developer/personal/vanluren/claude/commands/
├── skills/   -> ~/developer/personal/vanluren/claude/skills/
├── templates/-> ~/developer/personal/vanluren/claude/templates/
└── settings.json -> ~/developer/personal/vanluren/claude/settings.json
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
│   └── contextualize.md   # /contextualize
├── skills/                # More complex workflows
│   └── code-reviewer/     # Code review skill
├── templates/             # Templates for new projects
│   ├── project-claude.md
│   ├── architecture.md
│   ├── decisions-and-learnings.md
│   └── planning.md
├── settings.json          # Permissions, statusline, plugins
└── statusline-command.sh  # Custom status bar script

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

- `/checkpoint` - Saves progress to planning.md
- `/review` - Reviews code against my preferences
- `/contextualize` - Reads project docs to get up to speed

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

```

project/
└── .claude/
├── CLAUDE.md # Project overview
├── rules/ # Project-specific rules
├── architecture.md # System design
├── decisions-and-learnings.md # Gotchas, past decisions
└── planning.md # Current task (in worktrees)

````

I don't set this up beforehand. I open Claude Code on a project and populate the `.claude/` directory as I go.

### Key Files Explained

**`CLAUDE.md`** - The project overview. Uses `@import` to pull in other files:

```markdown
@.claude/architecture.md
@.claude/decisions-and-learnings.md
````

This ensures Claude gets context automatically without having to remember to read these files itself.

**`architecture.md`** - System design, how things fit together. I maintain this actively, not just "write once and forget". During weekly worktree cleaning, I read through it and remove any misunderstandings or outdated information.

**`decisions-and-learnings.md`** - Gotchas, past decisions, things that tripped me up. Same maintenance approach - reviewed weekly and kept accurate.

**`planning.md`** - One per worktree. Holds the current task status, what needs to be done, progress tracking. When I create a new worktree for a task, I create a fresh `planning.md` for that work.

**`rules/`** - Project-specific guidelines. Think of these as team-specific rules for that codebase. When I find myself adding the same rule to multiple projects, I promote it to the global rules instead.
