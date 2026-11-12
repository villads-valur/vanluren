# Git Workflow

## Commits

- Conventional commits
- Never add yourself as co-author or mention the code was AI-generated
- In a bork issue worktree, commit early and often on the issue branch without asking
- Ask before pushing or opening a PR, unless the task already asks for it
- Write or edit PR titles and descriptions with the `tidy-pr` skill
- Never commit on `main`/`master`

## Branches and PRs

- Update feature branches by merging main (`git merge main` or GitHub's "Update branch"); never rebase pushed branches or force push
- If I say "rebase" on a pushed branch, merge main instead and say so in one line (I usually mean "update the branch")
- I sometimes use "Update branch" on GitHub, so fetch before working on a pushed branch
- I squash & merge PRs in the GitHub UI so the merge queue runs; never merge to main from the CLI

## Worktrees (bork)

A project is a container dir with `main/` plus sibling `{issue-id}-{slug}/` worktrees on branch `{issue-id}/{slug}`. Agents start in the container dir.

1. **Find or create the worktree**
   - Existing issue: `bork issue show <issue-id>` and `git -C main worktree list`
   - Issue without a worktree: `bork worktree <issue-id> <slug>`
   - New sub-task: `bork issue start "Title" --project <name> --prompt "..."` (creates issue, worktree and agent)
   - Use bork rather than raw `git worktree add`, so bork tracks it
2. **Work inside the worktree**: all issue changes happen in `{issue-id}-{slug}/`, never in the container. `main/` is only for hotfixes and small fix branches
3. **Context**: read `.claude/planning.md` in the worktree if it exists, and the linked Linear/GitHub issue including comments
4. **After opening a PR**: `bork integration attach-pr <pr-number>` (inside an agent session the issue ID comes from `BORK_ISSUE_ID`)

## Bork IDs are internal

Bork issue IDs (`{project}-{n}`, e.g. `vanluren-16`) only exist on my machine, so nobody else can look them up. Use them in bork commands, worktree paths and `.claude/planning.md`, and nowhere else:

- Never put a bork ID in commit messages, PR titles or descriptions, review comments, Linear or GitHub issues, Slack messages, code or code comments
- Branches: leave the worktree branch bork created (`{issue-id}/{slug}`) as it is, since bork tracks it by name. Any branch you create yourself (stack layers, follow-up branches) gets a descriptive name without the bork ID
- Refer to the work by what it does, or link the real Linear/GitHub issue. A bork issue imported from Linear (lowercase, e.g. `eng-123`) maps to a real ticket, so reference it as `ENG-123` or its Linear URL
