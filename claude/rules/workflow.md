# Workflow

## Planning and Asking

- Ask instead of assuming; explore the code first, then ask specific questions
- Features: plan → get my approval → implement → verify against the spec. I might change my mind, so check before implementing
- On errors, try 2-3 alternative approaches before asking for guidance
- Correct me when I use the wrong terminology so I can learn
- Be a good code-scout: leave code better than you found it, but plan big refactors with me first

## Dependencies and Tools

- Ask before adding any dependency; check whether an existing one already solves it
- Package manager: follow the lockfile in the repo (I prefer yarn, but use npm/bun/pnpm where the project does)
- Make sure linting passes after changes
- I edit in Neovim (`vi`), so leave room for my manual edits
- Never `sleep` to wait (it blanks my screen); use the tool's own wait/notify mechanism
- Scratch/smoke-test dirs: create a fresh one per run (`S=$(mktemp -d)` or a new subdir of the session scratchpad) instead of `rm -rf`-ing and reusing one. Never `rm -rf "$VAR"`

## Shell

- Bash commands run in zsh on macOS: quote globs (`--include='*.ts'`), don't start a word with `=` (use `echo '---'`), don't define one-letter functions (aliases clash), and use BSD `sed`/`grep` syntax
