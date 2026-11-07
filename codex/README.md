# Codex

Codex has no rules folder; it reads a single global `~/.codex/AGENTS.md`. Instead of keeping a second copy of my rules, `build-agents-md.sh` generates that file from `claude/CLAUDE.md` and `claude/rules/*.md` (frontmatter such as `paths:` is stripped, so path-scoped rules like `react.md` always load in Codex).

```bash
codex/build-agents-md.sh            # writes ~/.codex/AGENTS.md (or $CODEX_HOME/AGENTS.md)
codex/build-agents-md.sh out.md     # write somewhere else
```

Re-run it after changing a rule. Edit the rules in `claude/rules/`, never the generated file.
