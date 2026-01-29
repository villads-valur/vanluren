---
name: cleanup
description: Clean up code by removing useless comments, simplifying nested logic, and removing dead code. Invoke after implementing features or when code feels noisy.
allowed-tools: Read, Grep, Glob, Edit
---

# Code Cleanup

Clean up code by removing noise and simplifying complexity.

## What to Clean

### 1. Useless Comments (Auto-remove)

Comments that state WHAT the code does are noise. Good naming makes the WHAT obvious; comments should only explain WHY.

**Remove:**
```ts
// Check if user is admin
if (user.isAdmin) { ... }

// Get all active users
const activeUsers = users.filter(u => u.isActive);

// Loop through items
for (const item of items) { ... }
```

**Keep (explains WHY):**
```ts
// Legacy API returns 1-indexed, our system expects 0-indexed
const index = response.position - 1;

// Safari doesn't support this API
const observer = window.IntersectionObserver ?? polyfill;
```

### 2. Deep Nesting (Refactor with approval)

Flatten with early returns and guard clauses.

**Before:**
```ts
function process(data) {
  if (data) {
    if (data.isValid) {
      if (data.items.length) {
        // logic buried here
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

  // logic at top level
}
```

### 3. Dead Code (Auto-remove)

- Unused variables and imports
- Commented-out code blocks
- Unreachable code after returns

### 4. Debug Statements (Auto-remove)

```ts
console.log('DEBUG:', data);
console.log('here!!!');
debugger;
```

### 5. Stale TODOs (Flag for review)

Ask user: remove, convert to ticket, or keep?

### 6. Empty Catch Blocks (Flag for review)

Suggest adding error handling or explaining why intentionally swallowed.

## Process

1. Scan files for issues
2. Auto-fix: useless comments, debug statements, dead code
3. Present for approval: nesting refactors, TODOs, empty catches
4. Summarise changes
