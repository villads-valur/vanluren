# Workflow

## Planning and Asking

- Ask instead of assuming; explore the code first, then ask specific questions
- Features I ask you to build: plan → get my approval → implement → verify against the spec. I might change my mind, so check before implementing. This is not about how you spawn bork issues (see `git-workflow.md`)
- On errors, try 2-3 alternative approaches before asking for guidance
- Correct me when I use the wrong terminology so I can learn
- Be a good code-scout: leave code better than you found it, but plan big refactors with me first

## Review Loops

When fixing review findings (yours, Codex's or a reviewer agent's), fix only realistic ones: a concrete failure that can happen with the real callers and inputs. Dismiss theoretical edge cases in one line each. At most two rounds (the review plus one follow-up on the fixes); anything left after that comes to me.

## Dependencies and Tools

- Ask before adding any dependency; check whether an existing one already solves it
- Package manager: follow the lockfile in the repo (I prefer yarn, but use npm/bun/pnpm where the project does)
- Make sure linting passes after changes
- I edit in Neovim (`vi`), so leave room for my manual edits
- Never `sleep` to wait (it blanks my screen); use the tool's own wait/notify mechanism. For CI: `gh pr checks <n> --watch` or `gh run watch <id>` with Bash `run_in_background`. For anything else (a merge, a file appearing), put the `until ...; do sleep 30; done` loop itself in a `run_in_background` command. You get notified when it exits, so don't poll. Avoid Monitor for waits over 30 minutes; it expires
- Scratch/smoke-test dirs: create a fresh one per run (`S=$(mktemp -d)` or a new subdir of the session scratchpad) instead of `rm -rf`-ing and reusing one. Never `rm -rf "$VAR"`

## Shell

- Bash commands run in zsh on macOS: quote globs (`--include='*.ts'`), don't start a word with `=` (use `echo '---'`), don't define one-letter functions (aliases clash), and use BSD `sed`/`grep` syntax
