---
allowed-tools: Read, Grep, Glob, Bash(git:*)
argument-hint: [file-or-pr]
description: Review code for quality and best practices
model: sonnet
---

## Context

- Recent changes: !`git diff HEAD~1 --stat`
- Current branch: !`git branch --show-current`

## Review Checklist

### Code Quality

- [ ] Readable and clear to co-workers
- [ ] No over-engineering or unnecessary complexity
- [ ] Comments only where logic isn't self-evident
- [ ] Follows project naming conventions
- [ ] No useless comments added, naming supports undertanding

### Architecture

- [ ] Business logic centralised in API (not frontend)
- [ ] Pure functions and basic components preferred
- [ ] Feature-based folder structure maintained

### Security

- [ ] No hardcoded secrets or credentials
- [ ] Input validation at system boundaries
- [ ] No SQL injection, XSS, or command injection risks

### TypeScript

- [ ] Proper typing (no unnecessary `any`)
- [ ] Consistent use of interfaces/types
- [ ] Null/undefined handled appropriately

### Testing

- [ ] Tests added for new functionality (if applicable)
- [ ] Edge cases considered

## Output

Provide feedback using conventional comments:

- `TODO:` - Required change
- `SUGGESTION:` - Optional improvement
- `QUESTION:` - Clarification needed
- `PRAISE:` - Good practice worth noting

Focus on what matters. Don't nitpick formatting if linting handles it.
