---
name: review
description: Review code for quality, security, and best practices against my preferences. Invoke when reviewing PRs, checking code quality, analysing implementations, or when asked to "review this".
argument-hint: "[file-or-pr]"
allowed-tools: Read, Grep, Glob, Bash(git:*), Bash(gh pr view:*), Bash(gh pr diff:*), Bash(gh issue view:*), Bash(bork issue show:*)
model: sonnet
---

# Review

## Context

- Current branch: !`git branch --show-current`
- Uncommitted changes: !`git diff HEAD --stat`
- Recent commit: !`git diff HEAD~1 --stat`

## Scope

- `$ARGUMENTS` is a PR number/URL: review `gh pr diff <pr>`
- `$ARGUMENTS` is a file/path: review that
- Nothing: review uncommitted changes, else the last commit

## Two Axes

Review along two separate axes and report them separately, so passing one doesn't hide failing the other:

- **Standards**: does the code follow the repo's documented standards (CLAUDE.md, AGENTS.md, CONTRIBUTING.md, `.claude/rules/`), my preferences in the checklist below, and the smell baseline?
- **Spec**: does the code do what the originating issue asked for?

### Finding the spec

Check in order and use the first that exists:

1. Issues linked in the PR body or commit messages (`#123`, `Closes #45`, Linear IDs like `ENG-123`)
2. The bork issue (`bork issue show "$BORK_ISSUE_ID"`) and any Linear ticket attached to it
3. The worktree's `.claude/planning.md`
4. Ask me. If there's no spec, skip the Spec axis and say so.

Read Linear tickets including comments.

## Priorities

1. **Readability** - clear enough for co-workers to understand
2. **Security** - no vulnerabilities or exposed secrets
3. **Maintainability** - easy to modify and extend
4. **Performance** - efficient where it matters

For React code, also apply the `no-use-effect` rules; use `audit-react` for a deeper pass.

## Review Checklist

### Code Quality

- [ ] **Useless comments**: Flag comments that restate what code does, explain obvious names, or are commented-out code
- [ ] **Arrow anti-pattern**: Flag deeply nested code (3+ levels) that could be flattened with early returns
- [ ] **Missing guard clauses**: Flag nested if/else that could use early returns
- [ ] **Long functions**: Flag functions doing multiple things that should be split
- [ ] **Complex ternaries**: Flag nested or multi-line ternaries (use if/else instead)
- [ ] Follows project naming conventions
- [ ] No over-engineering, tech-debt files, or workaround code

#### Complex Ternary Example

Flag this:

```ts
const status = user.isActive
  ? user.hasSubscription
    ? 'premium'
    : 'free'
  : user.wasActive ? 'churned' : 'inactive';
```

Prefer:

```ts
function getStatus(user) {
  if (!user.isActive) {
    return user.wasActive ? 'churned' : 'inactive';
  }
  if (user.hasSubscription) {
    return 'premium';
  }
  return 'free';
}
```

#### Useless Comments Example

Flag these:

```ts
// increment counter
counter++;

// get user by id
const user = getUserById(id);

// TODO: remove this later
// const oldValue = calculateOld();

/**
 * Returns the sum of a and b
 */
function add(a: number, b: number) {
  return a + b;
}
```

#### Early Return Example

Flag this:

```ts
function process(data) {
  if (data) {
    if (data.isValid) {
      // 20 lines of logic
    }
  }
}
```

Prefer:

```ts
function process(data) {
  if (!data) return;
  if (!data.isValid) return;
  // 20 lines of logic
}
```

#### Long Function Example

Flag functions that do multiple unrelated things:

```ts
async function handleUserRegistration(data) {
  // validate input (10 lines)
  // create user in database (15 lines)
  // send welcome email (10 lines)
  // log analytics event (5 lines)
  // update admin dashboard cache (10 lines)
}
```

Prefer splitting into focused functions:

```ts
async function handleUserRegistration(data) {
  const validated = validateRegistrationData(data);
  const user = await createUser(validated);
  await sendWelcomeEmail(user);
  trackRegistration(user);
}
```

### Architecture

- [ ] Business logic centralised in API (not frontend)
- [ ] Pure functions and basic components preferred
- [ ] Feature-based folder structure maintained

### Security

- [ ] No hardcoded secrets or credentials
- [ ] Input validation at system boundaries
- [ ] No SQL injection, XSS, or command injection risks
- [ ] Sensitive data not logged

### TypeScript

- [ ] Proper typing (no `any` or typecasting)
- [ ] Consistent use of interfaces/types
- [ ] Null/undefined handled appropriately
- [ ]

### Testing

- [ ] Tests added for new functionality (if applicable)
- [ ] Edge cases considered
- [ ] No breaking changes without a migration plan
- [ ] Tests should be as high value as possible

### Smell Baseline

Fowler code smells (_Refactoring_, ch. 3) that apply even when a repo documents nothing. These are always judgement calls ("possible Feature Envy"), never hard violations, and a documented repo standard overrides them.

- **Mysterious Name**: name doesn't reveal what it does or holds → rename; if no honest name comes, the design is murky
- **Duplicated Code**: same logic shape in several hunks or files → extract the shared shape
- **Feature Envy**: function reaches into another object's data more than its own → move it to that data
- **Data Clumps**: the same fields/params keep travelling together → bundle them into one type
- **Primitive Obsession**: a string/number standing in for a domain concept → give it its own small type
- **Repeated Switches**: same `switch`/`if` cascade on the same type in several places → one shared map or polymorphism
- **Shotgun Surgery**: one logical change forces scattered edits → gather what changes together
- **Divergent Change**: one module edited for several unrelated reasons → split by reason to change
- **Speculative Generality**: abstraction, params or hooks the spec doesn't need → inline until a real need shows
- **Message Chains**: long `a.b().c().d()` navigation → hide the walk behind one function
- **Middle Man**: function/class that mostly delegates → call the real target directly

### Spec Checks

- [ ] Requirements that are missing or only partly done
- [ ] Behaviour nobody asked for (scope creep)
- [ ] Requirements that look implemented but the implementation looks wrong

Quote the spec line for each Spec finding.

## Output

Report under `## Standards` and `## Spec` headings. Don't merge or rerank findings across the two. End with one line: finding count per axis and the worst issue within each.

Label findings with conventional comments:

- `TODO:` - Required change
- `SUGGESTION:` - Optional improvement
- `QUESTION:` - Clarification needed
- `PRAISE:` - Good practice worth noting
- `NIT` - Nitpick

Focus on what matters: explain what and why, be constructive, and don't nitpick anything linting catches.
