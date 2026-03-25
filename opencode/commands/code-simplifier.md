---
description: Simplify recently modified code
agent: code-simplifier
---

Simplify and refine the target code while preserving exact behavior.

## Scope

- If arguments are provided, limit work to those files/paths.
- Otherwise focus on recently modified code in this session or feature branch.
  - use `git log` to find what the changes are in the current session

## Instructions

1. Preserve all functionality and external behavior exactly.
2. Apply project standards from CLAUDE.md and project rules.
3. Improve clarity by reducing unnecessary complexity and nesting.
4. Remove redundancy, dead code, and obvious comments.
5. Avoid nested ternaries, prefer explicit if/else or switch for multi-condition logic.
6. Keep edits focused, minimal, and easy to review.

## Output

Briefly list significant simplifications and confirm behavior is unchanged.
