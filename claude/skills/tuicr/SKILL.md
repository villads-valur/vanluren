---
name: tuicr
description: Review code in tuicr together with me. Either I review your changes in tuicr and you fix my comments, or you review a PR or diff and pre-fill my tuicr session with draft comments. Use on "tuicr", "let me review this", "open tuicr", "read my tuicr comments", "my comments are ready", "pre-fill my review of PR 123", "add your findings to tuicr"
argument-hint: "[pr-number|-w|-r <range>]"
allowed-tools: Read, Grep, Glob, Edit, Bash(tuicr:*), Bash(tmux:*), Bash(git:*), Bash(gh pr view:*), Bash(gh pr diff:*)
---

# tuicr

[tuicr](https://github.com/agavra/tuicr) is a terminal code review tool. I review in the TUI; you use the `tuicr review` CLI to find sessions, read my comments and add your own. My config is in `~/.config/tuicr/config.toml` (from my dotfiles).

## Pick the workflow

1. **I review your changes**: I want to read the diff and comment in tuicr. Open it, wait, then fix my comments. Don't review your own patch first and never write comments as me
2. **You review into tuicr**: I want your findings as draft comments in a tuicr session, usually a PR I'm reviewing, so I can edit or delete them before submitting

If it's unclear which one I mean, ask.

## Find the session

```bash
tuicr review list --repo <repo-root>   # local sessions + PR sessions for its origin
tuicr review list --all                # every repo
```

- Each row has a `slug`, `kind` (`local` or `pr`), `active`, `comment_count`, `reviewed_count` and `file_count`
- `[]` can also mean you passed a subdirectory. Retry with the repo root, then `--all`, before deciding nothing is open
- One active session that matches: use it. Several, or unsure: ask which slug. Adding to the wrong session still exits 0
- PR slugs (`gh:owner/repo/pr/<n>`) work without `--repo`. Local slugs need `--repo <repo-root>`

## Open tuicr in a tmux window

Only when no matching session is open. Always pass a scope, so I'm not left picking one in the TUI:

- Uncommitted changes: `tuicr -w`
- This branch's commits: `tuicr -r origin/<default-branch>..HEAD` (add `-w` to include uncommitted changes)
- A PR: `tuicr pr <n>`

Open it next to this session and signal when it closes. Use the same channel name in both commands:

```bash
tmux new-window -n tuicr -c <repo-root> "tuicr <scope>; tmux wait-for -S tuicr-$(tmux display -p '#S')"
```

Then run `tmux wait-for tuicr-<session>` with Bash `run_in_background: true`. You're notified when I quit tuicr; don't poll and never `sleep`. Tell me in one line that tuicr is open in the `tuicr` window.

- If a `tuicr` window already exists, ask before opening another
- Not in tmux (`$TMUX` unset): ask me to start tuicr myself, then find the session once I say it's open
- tuicr handles git and jj, so don't pre-check the repo with `git rev-parse`; let tuicr report it
- If I say my comments are ready before quitting, read them straight away

## 1. I review your changes

Read my comments once tuicr closes or I say they're ready:

```bash
tuicr review comments --session <slug> [--repo <repo-root>]
```

Each comment has `id`, `path`, `start_line`, `end_line`, `side`, `comment_type`, `author` and `content`. Handle them by type:

- `issue`: fix
- `suggestion`: fix, or tell me in one line why not
- `question`: answer in chat. Only change code if the answer clearly means a change
- `nit`: fix if it's quick
- `none` (untyped): read the content to decide

My comments are the review, so fix them unless one is wrong or would break something; then say so instead of fixing it. Comments from another author (an agent) are suggestions: check them against the code first.

No comments doesn't always mean nothing to fix:

- `reviewed_count` equals `file_count`: I reviewed everything and had nothing to flag. Done, don't ask
- `reviewed_count` is lower, or the session row is gone: I quit early or commented in another session. Ask

When done, report what you fixed (`file:line` + one line each), the questions you answered and anything you pushed back on. Commit on the branch and ask before pushing. Offer to clear the session's comments (`tuicr review clearc --session <slug>`) once they're handled, but don't clear without asking.

## 2. You review into tuicr

1. Find or open the session (above). For a PR I haven't opened yet, open `tuicr pr <n>` so the session exists
2. Run the `review` skill on the same diff. Its checks, finding verification and voice apply here. Rebuild the diff the session shows:
   - `…/pr/<n>`: `gh pr diff <n>`
   - `worktree/<head>` or `staged-and-unstaged/<head>`: `git diff HEAD`
   - `staged/<head>`: `git diff --cached`; `unstaged/<head>`: `git diff`
   - `commits/<base>..<head>`: `git diff <base>~1..<head>` (endpoints are inclusive)
   - `worktree-and-commits/<base>..<head>`: `git diff <base>~1`
   - Check the file count against `file_count`. If it differs, every line number will be off
3. Show me the findings and ask which to add. Then add each one:

   ```bash
   tuicr review add --session <slug> --username Claude --type <type> \
     --target-file <path> --line <n> [--end-line <m>] [--side new|old] \
     "[Clanker] <comment>"
   ```

   - `--type` is one of my four types: `question`, `nit`, `issue`, `suggestion`. tuicr adds the `type:` prefix when the review is submitted, so don't write it in the text. For a blocker, use `issue` and start the text with `(blocking)`. Other labels (`todo`, `praise`) go untyped (leave out `--type`) with the label written in the text
   - Line comments where you can, `--target-file` alone for a file comment, neither for a review-level summary
   - `--side new` for added or unchanged lines, `--side old` for removed ones
   - Write the text like a review comment from me: one line where possible, a question over an order, the reason for blockers. See the PR reviews section of `~/.claude/rules/writing-style.md`
4. Verify. A comment on a line outside the diff saves and exits 0 but never shows in the TUI. Re-read `tuicr review comments`, check each of your comments' `start_line` exists on the side you gave, and fix misplaced ones with `tuicr review delete --session <slug> --comment-id <id>` plus a new `add`
5. Tell me how many comments you added. I edit them in tuicr and submit with `:submit`, or ask for the `post-review` skill if I want them enriched first

## Don't

- Write comments under my name, or add comments in workflow 1
- Submit or post anything to GitHub yourself. That's `:submit` in tuicr or the `post-review` skill
- Put bork issue IDs or local paths in comments
