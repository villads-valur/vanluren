# Testing

Add tests for new features and bug fixes without asking, where they make sense. Follow the project's existing test setup and conventions.

## What to test

- Behaviour through the public interface: inputs in, outputs or side effects out
- Business rules, validation and error paths (the cases that would hurt in production)
- Edge cases: empty, null/undefined, boundaries, duplicates, permissions
- Bug fixes: a test that fails without the fix
- Prefer unit tests; add integration tests when behaviour crosses a boundary (DB, API, other services)
- Write the tests first when it helps pin down the behaviour (TDD)

## What not to test

- Implementation details: private functions, internal state, call order of internals
- Framework or library behaviour (that Prisma saves, that React renders)
- Trivial code with no logic (getters, re-exports, constants)
- Snapshots of large output that nobody reads when they change

## Good tests

- Fail for one clear reason, and the name says what behaviour broke
- Use realistic data and only mock at boundaries (network, time, external services)
- Assert on the expected value, not one recomputed with the code under test
- Independent: no shared mutable state or order dependence

## Examples

Test the behaviour, not the internals:

```ts
// Bad: breaks on any refactor, says nothing about the result
it("calls calculateDiscount", () => {
  const spy = jest.spyOn(pricing, "calculateDiscount");
  checkout(cart);
  expect(spy).toHaveBeenCalledTimes(1);
});

// Good: pins the business rule
it("applies 10% off orders over 1000", () => {
  expect(checkout(cartWithTotal(1200)).total).toBe(1080);
});
```

Assert a known answer, don't recompute it:

```ts
// Bad: passes even if the formula is wrong
expect(vat(200)).toBe(200 * VAT_RATE);

// Good
expect(vat(200)).toBe(50);
```

Cover the error path, not just the happy path:

```ts
// Bad: only checks it doesn't throw for valid input
it("creates a user", async () => {
  await expect(createUser({ email: "a@b.dk" })).resolves.toBeDefined();
});

// Good: the rule that matters
it("rejects a duplicate email", async () => {
  await createUser({ email: "a@b.dk" });
  await expect(createUser({ email: "a@b.dk" })).rejects.toThrow(ConflictException);
});
```

Mock at the boundary, not your own code:

```ts
// Bad: mocks the repository, so the test only checks the mock
repo.findOne.mockResolvedValue(user);
expect(await service.getUser(1)).toEqual(user);

// Good: real repository against a test DB, mock only the external email API
await service.inviteUser("a@b.dk");
expect(await repo.findOneBy({ email: "a@b.dk" })).toMatchObject({ status: "invited" });
expect(emailClient.send).toHaveBeenCalledWith(expect.objectContaining({ to: "a@b.dk" }));
```

Test UI like a user:

```tsx
// Bad: depends on internal state and class names
expect(wrapper.state("isOpen")).toBe(true);

// Good
await user.click(screen.getByRole("button", { name: "Open menu" }));
expect(screen.getByRole("menu")).toBeVisible();
```
