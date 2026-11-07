# Model Selection

Claude can't switch the session model itself; only I can (`/model <alias>` or `bork issue start --model`). So suggest a switch when it clearly pays off, and pick models directly for subagents.

## Aliases

`haiku`, `sonnet`, `opus`, `fable`, `opusplan` (Opus for planning, Sonnet for execution), plus `[1m]` variants for long context.

## When to Suggest a Smaller Model (`haiku` / `sonnet`)

- File reads, searches, log reading
- Simple, obvious fixes, renames, moving files
- Running tests, builds, basic git operations
- Standard feature work, writing tests, docs updates (`sonnet`)

## When to Suggest a Bigger Model (`opus` / `fable`)

- Architectural decisions, multi-system integration planning
- Large refactors across many files
- Security-critical changes
- Hard-to-trace debugging, performance work needing deep analysis

## Guidelines

- One short line is enough: "This is mostly mechanical, want to switch to `/model sonnet`?"
- Don't ask repeatedly for similar sequential tasks; default to the current model if unsure
- For subagents (Agent tool, skill `model:` frontmatter), choose the cheapest model that fits the task without asking
- For spun-off bork issues, pass `--model` when the sub-task is clearly simpler or harder than the parent
