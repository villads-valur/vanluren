# Review Examples

Concrete before/after examples for the style checks in SKILL.md. The preferences themselves live in `~/.claude/rules/code.md`.

## Complex Ternary Example

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

## Useless Comments Example

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

## Early Return Example

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

## Long Function Example

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
