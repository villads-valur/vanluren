# RTK Usage

- RTK (`rtk-ai/rtk`) is installed and should be used for CLI commands when available.
- Prefer the RTK hook flow for Claude Code: commands are transparently rewritten (for example, `git status` -> `rtk git status`).
- Even if hooks are active, writing commands with an explicit `rtk` prefix is always safe and preferred in docs/examples.

## Core Rule

- Always prefix commands with `rtk` in explicit command examples and command chains.
- In chained commands, keep `rtk` on each command:
  - `rtk git add . && rtk git commit -m "msg" && rtk git push`

## High-Value Commands

- Git: `rtk git status`, `rtk git diff`, `rtk git log`, `rtk git show`
- Tests: `rtk test <cmd>`, `rtk vitest run`, `rtk cargo test`, `rtk pytest`, `rtk playwright test`
- Build/lint/typecheck: `rtk tsc`, `rtk lint`, `rtk cargo check`, `rtk next build`, `rtk prettier --check`
- Search/read: `rtk ls`, `rtk find <pattern>`, `rtk grep <pattern>`, `rtk read <file>`

## Meta Commands (always direct)

- `rtk gain` and `rtk gain --history` for savings analytics
- `rtk discover` to detect missed RTK opportunities
- `rtk proxy <cmd>` to bypass filtering for debugging
- `rtk hook-audit` for rewrite metrics when `RTK_HOOK_AUDIT=1`

## Verification

- `rtk --version` should return a valid RTK version.
- `rtk gain` should work (confirms this is Rust Token Killer, not Rust Type Kit).
- `rtk init --show` should report hook + `settings.json` integration.
