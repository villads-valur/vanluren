# Claude Code Setup

## The Basic Idea

I keep my Claude Code configuration in this git repository and symlink it into `~/.claude/`. This lets me version control my setup and share it across machines.

```
~/.claude/
├── CLAUDE.md               -> <this-repo>/claude/CLAUDE.md
├── rules/                  -> <this-repo>/claude/rules/
├── settings.json           -> <this-repo>/claude/settings.json
└── skills/
    ├── commit/             -> <this-repo>/claude/skills/commit/
    ├── pr/                 -> <this-repo>/claude/skills/pr/
    └── ...                 # one symlink per skill
```

Skills are symlinked one by one so `~/.claude/skills/` can also hold skills synced from elsewhere. To link them all:

```bash
for skill in <this-repo>/claude/skills/*/; do ln -sfn "${skill%/}" ~/.claude/skills/; done
```

## Directory Structure

```
claude/
├── CLAUDE.md                  # Global instructions (auto-loaded)
├── rules/                     # Always-loaded preferences (keep these short)
│   ├── workflow.md            # Planning, asking, dependencies
│   ├── code.md                # Stack, quality, readability, architecture, naming
│   ├── testing.md             # What to test, with good/bad examples
│   ├── git-workflow.md        # Commits, branches/PRs, bork worktrees
│   ├── react.md               # React rules (scoped to React files via `paths:`)
│   └── writing-style.md       # How I write
├── skills/                    # Skills, each also available as /<name>
│   ├── commit/
│   ├── pr/
│   ├── review/
│   ├── pre-review/
│   ├── review-session/
│   ├── cleanup/
│   ├── code-simplifier/
│   ├── handoff/
│   ├── worktree/              # Includes planning + decisions templates
│   ├── ticket/
│   ├── stacking-pr/
│   ├── post-review/
│   ├── audit-react/
│   ├── no-use-effect/
│   ├── react-performance/
│   └── react-composition-patterns/
├── plugins/config.json
├── settings.json              # Permissions, hooks, statusline, plugins
└── statusline-command.sh      # Custom status bar script
```

## Disclaimer

This is my personal Claude Code configuration. It's a work in progress that changes frequently as I learn more about what works and what doesn't. Take everything here with a grain of salt, this is just my approach.

Feel free to take inspiration, but don't treat this as a template to follow blindly.

## How It Works

### Rules (`rules/`)

Loaded automatically by Claude Code from `~/.claude/rules/`. Split into separate files to keep things organised. Rules can be scoped to file globs with `paths:` frontmatter (see `react.md`). Some examples:

- **workflow.md** - How I want Claude to work with me (plan first, ask instead of assuming)
- **code.md** - Code quality, readability, architecture and naming preferences
- **testing.md** - What to test (and not), with good and bad examples
- **git-workflow.md** - Commit conventions, branch/PR strategy, bork worktree workflow

What belongs where:

- **Rules**: short preferences that apply in every session
- **Skills**: procedures or reference only needed for some tasks (e.g. `ticket`), loaded on demand
- **Settings/hooks/linters**: anything that can be enforced mechanically (e.g. force push is in the deny list)

### Skills (`skills/`)

Claude Code merged custom commands into skills, so every skill here is both a `/name` slash command and (unless disabled) auto-invoked when Claude detects the intent.

| Skill                        | Use                                                        |
| ---------------------------- | ---------------------------------------------------------- |
| `commit`                     | Conventional commit from the current changes               |
| `pr`                         | Open a PR and link it to the bork issue                    |
| `review`                     | Review a diff, file or PR on two axes: standards and spec  |
| `pre-review`                 | Run `review` + `/simplify` on a PR before others review it (manual only) |
| `review-session`             | Open yolo-mode Codex/Claude reviews of the bork issue's PRs in tmux windows; `done` closes them (manual only) |
| `cleanup`                    | Remove noise: useless comments, debug code, dead code      |
| `code-simplifier`            | Simplify recently changed code without changing behaviour  |
| `handoff`                    | Save the session to `planning.md` for `/compact`, a new session or a bork sub-issue (manual only) |
| `ticket`                     | Write a ticket in my Goal / Context / Acceptance criteria format |
| `worktree`                   | Create a bork worktree with `planning.md` + decisions file |
| `stacking-pr`                | Stacked PRs with the `gh stack` extension                  |
| `post-review`                | Post a tuicr review to a GitHub PR                         |
| `audit-react`                | Structured React / React Native audit                      |
| `no-use-effect`              | Replacement patterns for `useEffect`                       |
| `react-performance`          | React performance rule library                             |
| `react-composition-patterns` | Component API and composition rules                        |

### Settings (`settings.json`)

Contains:

- **Permissions** - Pre-approved commands (git, npm, docker, etc.)
- **Denied commands** - Things I never want Claude to run (force push)
- **Ask permissions** - Commands requiring confirmation (reading .env files)
- **Attribution** - Disabled for commits and PRs
- **Statusline** - Custom script showing directory, branch, and context usage
- **Plugins** - TypeScript LSP enabled

## Project Structure Convention

Projects are managed with `bork`: a container directory (not a git repo) with a `main/` worktree and sibling issue worktrees. Agents start in the container dir.

```
myapp/
├── .bork/                     # Bork state
├── AGENTS.md                  # Project layout + bork conventions for agents
├── main/                      # Main branch worktree
│   ├── CLAUDE.md              # Project overview
│   └── .claude/
│       ├── rules/             # Project-specific rules
│       ├── architecture.md    # System design
│       └── decisions-and-learnings.md
└── myapp-12-fix-login/        # Issue worktree, branch `myapp-12/fix-login`
    └── .claude/planning.md    # Current task
```

New worktrees are created with `bork issue start` or `bork worktree`, branching from `main`.

### Key Files Explained

**`CLAUDE.md`** - The project overview. Uses `@import` to pull in other files:

```markdown
@.claude/architecture.md
@.claude/decisions-and-learnings.md
```

This ensures Claude gets context automatically without having to remember to read these files itself.

**`architecture.md`** - System design, how things fit together. I maintain this actively, not just "write once and forget". During weekly worktree cleaning, I read through it and remove any misunderstandings or outdated information.

**`decisions-and-learnings.md`** - Gotchas, past decisions, things that tripped me up. Same maintenance approach, reviewed weekly and kept accurate.

**`planning.md`** - One per worktree. Holds the current task status, what needs to be done, progress tracking. The `worktree` skill creates it from a template and `handoff` keeps it current.

**`rules/`** - Project-specific guidelines. When I find myself adding the same rule to multiple projects, I promote it to the global rules instead.
