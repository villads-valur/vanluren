---
name: review-session
description: Have a Codex or Claude reviewer review this bork issue's PRs in tmux windows next to this session, then wait for the result, fix the findings and clean up
argument-hint: "[codex|claude] [pr-number...|all] | done"
disable-model-invocation: true
allowed-tools: Read, Edit, Write, Bash(bork issue list:*), Bash(gh pr view:*), Bash(git fetch:*), Bash(git -C:*), Bash(tmux:*), Bash(mkdir:*), Bash(chmod:*), Bash(rm -f:*), Bash(${CLAUDE_SKILL_DIR}/wait-for-report.sh:*)
---

# Review Session

**You own the whole loop, not just the launch.** Opening the windows is step 4 of 8. The skill is only done once the review has come back, you've dealt with every finding, and the windows are closed:

launch reviewers → wait for their reports → triage → fix → report to me → clean up

The goal is to catch the problems that matter before merge, not to make the PR bulletproof against every edge case. Keep it to two rounds at most (the first review plus one follow-up that only checks the fixes); after that, anything left goes to me instead of into another round.

The reviewer runs in a separate tmux window of this session (one session per bork issue) in yolo mode, so it never stops for approvals. It can technically write, so its prompt is what keeps it read-only. It writes its findings to a report file, and that file is how you get the result back. Nothing is posted to GitHub.

## Context

- Bork issue: !`echo "${BORK_ISSUE_ID:-not in a bork session}"`
- Linked PRs: !`[ -n "$BORK_ISSUE_ID" ] && bork issue list --json | jq -r --arg id "$BORK_ISSUE_ID" '.[] | select(.id==$id) | .github_pr_links[].number' | tr '\n' ' ' || echo none`
- tmux session: !`tmux display-message -p '#S' 2>/dev/null || echo "not in tmux"`
- Windows: !`tmux list-windows -F '#I:#W' 2>/dev/null | tr '\n' ' ' || echo none`
- Worktree: !`git rev-parse --show-toplevel 2>/dev/null || { wt=$(bork issue list --json 2>/dev/null | jq -r --arg id "$BORK_ISSUE_ID" '.[] | select(.id==$id) | .worktree // empty'); [ -n "$wt" ] && [ -d "$wt" ] && (cd "$wt" && pwd); } || echo "none (in $(pwd), not a git repo)"`
- Branch: !`git branch --show-current 2>/dev/null || echo "unknown, use the worktree"`

`<worktree>` below is the Worktree path above. This skill is often run from the bork container dir, which isn't a git repo, so run git commands with `git -C <worktree>` and launch reviewers in `<worktree>`, never in the current directory. If Worktree is `none`, stop and say the issue has no worktree (`bork worktree <id> <slug>`).

## Files

Per PR, in `$TMPDIR/bork-review/` (`<id>` is the bork issue ID):

- `<id>-pr-<n>.md`: reviewer prompt
- `<id>-pr-<n>.sh`: launcher
- `<id>-pr-<n>-report.md`: the reviewer's findings (written by the reviewer, read by you)
- `<id>-pr-<n>-report.md.exit`: the reviewer's exit code (written by the launcher when the agent quits)

## Steps

1. **Parse `$ARGUMENTS`**
   - `done`: jump to step 8
   - Agent: `codex` (default, gives a read independent of this session's model) or `claude`
   - PRs: explicit numbers, `all`, or nothing

2. **Pick the PRs**
   - Start from the linked PRs above. If there are none, stop and say the issue has no linked PRs (`bork integration attach-pr <n>`)
   - Look each one up: `gh pr view <n> --json number,title,state,url,headRefName,baseRefName,headRefOid`
   - One open PR and none requested: use it
   - Several open PRs and none requested: list them (number, title, branch → base) and ask which to review, offering "all"
   - Skip merged/closed PRs unless I named them
   - Everything must be pushed first: if `<worktree>` has unpushed commits or uncommitted changes (`git -C <worktree> status -sb`), say so and ask, since the reviewer only sees what's on the PR

3. **Prepare** each PR:
   - `git -C <worktree> fetch origin <headRefName> <baseRefName>`
   - `mkdir -p "$TMPDIR/bork-review"` and delete any old report for this PR
   - Write the reviewer prompt (below) to the prompt file, filling in every `<placeholder>`

4. **Launch** a detached window per PR. If a window with the same name already exists, ask before replacing it.
   - Write the launcher and `chmod +x` it:
     - codex: `codex --dangerously-bypass-approvals-and-sandbox "$(cat <prompt-file>)"`
     - claude: `claude --dangerously-skip-permissions -n "review PR #<n>" "$(cat <prompt-file>)"`
     - After the agent command, write its exit code to `<report-file>.exit` (`echo "$?" > ...`), so the wait step can tell a crash from a slow review
     - End it with `exec "$SHELL"` so the window stays open for me to read after the agent exits
   - `tmux new-window -d -n review-<agent>-<n> -c <worktree> <launcher>`
   - Check the pane once (`tmux capture-pane -p -t <session>:review-<agent>-<n>`). If Codex is waiting on a folder-trust prompt, tell me: it needs my answer before the review can start

5. **Wait for the report.** For each window, run with Bash `run_in_background: true`:

   ```bash
   ${CLAUDE_SKILL_DIR}/wait-for-report.sh <session> review-<agent>-<n> "$TMPDIR/bork-review/<id>-pr-<n>-report.md"
   ```

   It exits with `DONE: ...` once the report exists, or `FAILED: ...` if the reviewer exits or its window closes without one. Tell me in one line that the review is running and which window to watch, then keep working or end the turn. You'll be notified when it exits; don't poll it, and never `sleep` in the foreground.
   - On `FAILED`: capture the pane, tell me what happened, and ask whether to relaunch

6. **Triage** each report as soon as it's ready. The reviewer can be wrong, so check every finding against the code yourself before acting:
   - **Agree**: the problem is real and the fix is clear
   - **Disagree**: it's wrong, doesn't apply here, or the scenario can't realistically happen with the real callers and inputs (say why in one line)
   - **Unsure / my call**: it needs a product decision, changes behaviour, or the fix has trade-offs

7. **Fix and report**
   - Fix the **agreed High and Medium** findings on the PR's branch, in `<worktree>`. If the PR's branch isn't checked out there, ask before switching
   - Fix agreed Low findings only if they're trivial and in code this PR already touches
   - Run the repo's lint/typecheck/tests for what you changed
   - Then report to me, grouped as: fixed (`file:line` + one line each), disagreed (with reason), needs my decision, Low findings left alone, and the reviewer's notes on the PR description
   - Commit the fixes on the PR's branch, then ask before pushing
   - **Follow-up round**: only offer one if this was the first round and you fixed High findings or made non-trivial changes. It reviews only the fix commits (`<previous-sha>..<new-sha>`, see the follow-up prompt below), not the whole PR again. After the follow-up round, don't offer another: fix what's agreed, hand the rest to me and clean up

8. **Clean up** once the findings are handled (fixed, dismissed, or handed to me), or when I run `/review-session done`:
   - List this session's review windows: `tmux list-windows -F '#I:#W' | grep ':review-'`
   - If an agent in one is still working, ask before killing it
   - `tmux kill-window -t <session>:<window-name>` for each `review-*` window this skill created; never touch this session's own window or any others
   - `rm -f "$TMPDIR"/bork-review/<id>-pr-*`
   - Confirm in one line which windows were closed

## Reviewer Prompt

```
Review PR #<n> (<url>): <head-branch> → <base-branch>, head commit <sha>.

Follow ~/.claude/skills/review/SKILL.md and the files it links (checks.md, smells.md, spec.md, report.md in the same folder): its checks, finding verification and report format (High/Medium/Low, file:line, plain description, conventional-comment draft, PR description notes, verdict).

- Diff: `gh pr diff <n>` or `git diff origin/<base>...<sha>`
- PR description and linked issues: `gh pr view <n>`; bork issue: `bork issue show <id>`
- File context: read files at the PR head with `git show <sha>:<path>`; the working tree may be on a different branch

Focus on what matters: bugs that can realistically happen, security, data loss, and missing required behaviour. Every finding needs a concrete failure scenario that's reachable with the real callers and inputs; drop unrealistic edge cases and theoretical what-ifs rather than listing them. A short report is fine, and "nothing High or Medium" is a valid result.

Read-only: don't edit files in the repo, check out branches, commit, push or post to GitHub.

When the review is complete, write the full report to <report-file>.tmp and then rename it to <report-file> (`mv`), so it appears in one go. Another agent is waiting for that file to fix the findings. Also print a short summary here.
```

### Follow-up prompt

For the follow-up round, add this right after the first line of the prompt above:

```
This is a follow-up review. The previous round's findings were fixed in <previous-sha>..<sha>. Review only that range (`git diff <previous-sha> <sha>`): check the fixes are correct and didn't break anything. Don't re-review the rest of the PR or raise new Low findings on code outside that range.
```
