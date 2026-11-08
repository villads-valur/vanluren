# Report Format

Group findings by severity. Within each group, order by importance and tag each with its axis.

- **High**: bugs, security holes, data loss or corruption, missing required behaviour. Should block the merge
- **Medium**: likely future bugs, missing tests for risky paths, clear standards violations, maintainability problems
- **Low**: readability, naming, small simplifications, nitpicks

Severity is about impact on real users and data, so an unlikely scenario is never High. Keep the report short:

- Report at most 5 Low findings, the ones most worth my time; drop the rest
- One finding per root cause; don't repeat the same issue for every place it shows up, list the extra `file:line`s in the one finding
- If there's nothing High or Medium, say so plainly; don't promote Lows to fill the report

Each finding uses this shape:

````markdown
### `path/to/file.ts:42` · Standards

<One or two plain sentences: what's wrong and why it matters. No jargon; someone new to the codebase should get it.>

```text
issue (blocking): If `items` is empty this returns `undefined`, so the total on the checkout page shows "NaN". Could we default to `0` here?
```
````

Comment drafts are for me to pick from and maybe post on the PR as part of my own review, so write them as me, speaking to the PR author:

- Use [conventional comments](https://conventionalcomments.org): `issue`, `suggestion`, `question`, `nitpick`, `praise`, with `(blocking)` on High findings and `(non-blocking)` where it helps
- Write in my style (`~/.claude/rules/writing-style.md`): short, lead with the point, then a brief reason, friendly, a question when the author may know better, no em-dashes, no filler
- Ready to paste into GitHub as-is: one or two sentences, a small code suggestion only when it makes the point clearer

End with:

- **PR description**: either "Clear" or the slop/clarity/jargon problems you found, each with the quoted phrase and a short note on why it's a problem. Add an optional comment draft in my style (e.g. `suggestion (non-blocking): ...`) that I can use if I decide to raise it
- Up to three `praise` items worth mentioning, if any
- Summary: count per severity and per axis, the checks run (lint/typecheck) and their result
- Verdict: **Approve**, **Approve with nits** or **Changes needed**

Never post the drafts or anything else to GitHub yourself; I decide what goes on the PR.
