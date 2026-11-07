---
name: dream
description: Review my recent Claude Code transcripts and propose improvements to my rules, skills, settings and memory. `run` writes a report (daily via launchd), `apply` walks me through it
argument-hint: "run [digest-file] | apply [report-date]"
disable-model-invocation: true
---

# Dream

Learn from how I actually used Claude since the last dream, and turn that into concrete, small improvements to my setup. You only ever propose in `run`; changes happen in `apply`, with me.

- Dreams dir: `~/.claude/dreams/` (`<date>/digest.md`, `<date>/report.md`). Not in any repo, keep it that way
- Latest report: !`find ~/.claude/dreams -name 'report*.md' 2>/dev/null | sort | tail -1 | grep . || echo none`

Parse `$ARGUMENTS`: `run` or `apply`. With neither, `apply` if the latest report still has `Status: open` findings, else `run`.

Never overwrite a report: if `<date>/report.md` exists, write `report-2.md`, `report-3.md`, ….

## The public-repo rule

My rules, skills, `CLAUDE.md` and `settings.json` are symlinks into a **public** dotfiles repo (`~/.claude/rules/`, `~/.claude/CLAUDE.md`, `~/.claude/settings.json`, `~/.claude/skills/<name>/`). Every finding gets one target:

- `dotfiles`: a generic change to those files. It must make sense without the session it came from: no employer, client, colleague or customer names, no internal URLs, repo/service names, ticket IDs, hostnames, paths under work projects, and no quotes from work sessions. If it can't be phrased generically, it isn't `dotfiles`
- `local`: anything specific to one project. Goes to that project's `CLAUDE.local.md` (in the project root, untracked) or its memory folder `~/.claude/projects/<project-dir>/memory/`. Never to the symlinked paths above
- `memory`: tidying an existing memory folder (merge, fix, delete). Local by nature

A finding seen **only** in `work` sessions is `local` or `memory`, never `dotfiles`, unless the same pattern also shows up in a `personal` session. Work sessions can contain customer data: never copy their content into the report beyond what a finding needs, and never more than a short paraphrase.

## run

1. **Digest**: use the file given in `$ARGUMENTS`, else run `${CLAUDE_SKILL_DIR}/extract.sh` and use the path it prints. Each `##` section is one session: `personal`/`work`, cwd, title, then my prompts (`you:`), slash commands (`cmd:`), `INTERRUPT`, `REJECTED` tool calls, `PERMISSION PROMPT`s, tool `ERROR`s and tool counts
2. **Current setup**: read `~/.claude/CLAUDE.md`, `~/.claude/rules/*.md`, the `description` of each `~/.claude/skills/*/SKILL.md`, `~/.claude/settings.json` (permissions), every `~/.claude/projects/*/memory/MEMORY.md`, and the last 3 reports (don't re-propose something I rejected unless the evidence is new)
3. **Look for** (signal over volume; one occurrence is an anecdote, two or more is a pattern):
   - **Corrections**: I said no, redirected, repeated myself, or interrupted. What rule would have prevented it?
   - **Broken rules**: a rule exists but Claude didn't follow it. Propose a sharper wording, moving it to a skill, or enforcing it in settings/hooks
   - **Dead weight**: rules that never mattered, skills never used, duplicated instructions between files
   - **Skill candidates**: prompts I typed more than once that a skill or argument would replace
   - **Friction**: repeated tool errors with the same cause (missing tool, wrong path, a skill that breaks in the bork container dir), permission prompts worth allowlisting, approvals that were always "yes"
   - **Memory**: duplicates, contradictions, stale facts, relative dates, memories that belong in rules instead
4. **Output the report** in the format below. At most 10 findings, ranked by how much friction they'd remove. Write `nothing worth changing` rather than padding. Don't change any file in `run`
   - Headless (the daily `run.sh`, which has no write access): your final message is the report and nothing else. `run.sh` saves it to `<date>/report.md` next to the digest
   - Interactive: write it to `<date>/report.md` next to the digest and print the path and finding count

### Report format

```markdown
# Dream <date>

<sessions> sessions (<personal> personal, <work> work). <one line on the overall pattern>

## 1. <short title>

- Target: dotfiles | local (<project>) | memory (<project>)
- Kind: correction | broken-rule | dead-weight | skill | friction | memory
- Evidence: <count> × in <sessions or projects>; <short paraphrase or, for personal sessions only, a short quote>
- Change: <file> — <what and why, one or two lines>

  ```diff
  <proposed diff>
  ```

- Status: open
```

## apply

1. Open the report for the given date, else the latest. Only `Status: open` findings
2. Go through them one at a time: show title, evidence and diff, then ask accept / edit / reject / skip (AskUserQuestion, batch up to 4 small ones). Write the answer back to `Status:` (`accepted`, `rejected: <reason>`, `skipped`)
3. Apply accepted ones:
   - `memory` and `local`: edit the files directly
   - `dotfiles`: re-check the diff against the public-repo rule first; if anything work-related slipped in, rewrite it generically or drop it and tell me. Then, in the dotfiles bork project (`~/code/personal/vanluren`), create an issue (`bork issue create "Dream <date>"`) and its worktree (`bork worktree <id> dream-<date>`), make all accepted `dotfiles` changes there (never in `main/`), commit, and ask before pushing or opening the PR
4. Summarise: applied, rejected, left open
