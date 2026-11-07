# Git Workflow

## Commits

- Conventional commits
- Never add yourself as co-author or mention the code was AI-generated
- Commit early and often, but check with me before committing

## Branches and PRs

- Update feature branches by merging main (`git merge main` or GitHub's "Update branch"); never rebase pushed branches or force push
- I sometimes use "Update branch" on GitHub, so fetch before working on a pushed branch
- I squash & merge PRs in the GitHub UI so the merge queue runs; never merge to main from the CLI

## Worktrees (bork)

A project is a container dir with `main/` plus sibling `{issue-id}-{slug}/` worktrees on branch `{issue-id}/{slug}`. Agents start in the container dir.

1. **Find or create the worktree**
   - Existing issue: `bork issue show <issue-id>` and `git -C main worktree list`
   - Issue without a worktree: `bork worktree <issue-id> <slug>`
   - New sub-task: `bork issue start "Title" --project <name> --prompt "..."` (creates issue, worktree and agent)
   - Use bork rather than raw `git worktree add`, so bork tracks it
2. **Work inside the worktree**: all file changes happen in `{issue-id}-{slug}/`, never in `main/` or the container
3. **Context**: read `.claude/planning.md` in the worktree if it exists, and the linked Linear/GitHub issue including comments
4. **After opening a PR**: `bork integration attach-pr <pr-number>` (inside an agent session the issue ID comes from `BORK_ISSUE_ID`)
