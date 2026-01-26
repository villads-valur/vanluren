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

- [ ] **Useless comments**: Flag comments that restate what code does, explain obvious names, or are commented-out code
- [ ] **Arrow anti-pattern**: Flag deeply nested code (3+ levels) that could be flattened with early returns
- [ ] **Missing guard clauses**: Flag nested if/else that could use early returns
- [ ] **Long functions**: Flag functions doing multiple things that should be split
- [ ] **Complex ternaries**: Flag nested or multi-line ternaries (use if/else instead)
- [ ] Follows project naming conventions

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
