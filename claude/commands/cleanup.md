---
allowed-tools: Read, Grep, Glob, Edit, Bash(git:*)
argument-hint: [files|--staged|--recent]
description: Clean up code by removing noise and simplifying complexity
model: sonnet
---

## Context

- Recent changes: !`git diff HEAD~1 --stat`
- Staged changes: !`git diff --cached --stat`
- Current branch: !`git branch --show-current`

## Scope

Determine what to clean up based on argument:
- `--staged` or no argument: Clean staged changes
- `--recent`: Clean changes from last commit
- Specific files/paths: Clean those files

## Cleanup Actions

### 1. Useless Comments (Remove)

Comments that state WHAT the code does are noise. Good naming makes the WHAT obvious; comments should only explain WHY.

**Remove these:**
```ts
// Check if user is admin
if (user.isAdmin) { ... }

// Get all active users
const activeUsers = users.filter(u => u.isActive);

// Create new order
const order = new Order(items, customer);

// Loop through items
for (const item of items) { ... }

/**
 * Returns the sum of a and b
 */
function add(a: number, b: number) {
  return a + b;
}
```

**Keep these (explains WHY):**
```ts
// Legacy API returns 1-indexed, our system expects 0-indexed
const index = response.position - 1;

// Safari doesn't support this API, fallback required
const observer = window.IntersectionObserver ?? polyfill;
```

### 2. Deep Nesting / Arrow Anti-pattern (Refactor)

Flatten nested code with early returns and guard clauses.

**Before:**
```ts
function process(data) {
  if (data) {
    if (data.isValid) {
      if (data.items.length) {
        // actual logic buried here
      }
    }
  }
}
```

**After:**
```ts
function process(data) {
  if (!data) return;
  if (!data.isValid) return;
  if (!data.items.length) return;

  // actual logic at top level
}
```

### 3. Dead Code (Remove)

- Unused variables and imports
- Commented-out code blocks
- Unreachable code after returns

### 4. Debug Statements (Remove)

```ts
// Remove these
console.log('DEBUG:', data);
console.log('here!!!');
console.log('test');
debugger;
```

### 5. Stale TODOs (Flag for Review)

Present these to the user for decision:
```ts
// TODO: refactor this later
// FIXME: this is a hack
// HACK: temporary fix
```

Ask: "Found stale TODOs - should I remove them, convert to tickets, or keep?"

### 6. Empty Catch Blocks (Flag)

```ts
// Flag this
try {
  await riskyOperation();
} catch (e) {
  // swallowed silently
}
```

Suggest adding proper error handling or at minimum a comment explaining why it's intentionally swallowed.

## Process

1. **Scan** the files in scope for issues
2. **Fix automatically**: Useless comments, debug statements, dead code
3. **Present for approval**: Deep nesting refactors, stale TODOs, empty catches
4. **Summarise** changes made

## Output

After cleanup, provide a brief summary:
- Files modified
- Comments removed (count)
- Debug statements removed (count)
- Refactors applied
- Items flagged for manual review
