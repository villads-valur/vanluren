# Standards Checks

What to look for on the Standards axis. Correctness comes first.

This is a list of places to look, not a list of things to report. Only report what can realistically happen with this code and its real callers (see Verify in SKILL.md).

## Correctness (check first, most important)

- Logic does what it claims, including the edge cases real inputs can hit (empty, null/undefined, zero, duplicates). Skip cases the types, validation or callers already rule out
- Error paths are handled; failures aren't silently swallowed; async errors are awaited or caught
- Callers of changed code still work (step 2)
- Races and ordering that can happen in normal use: concurrent requests, double submits, stale state, missing `await`
- State and data stay consistent on partial failure
- Behaviour changes nobody asked for

## Security

- No hardcoded secrets or credentials; sensitive data isn't logged
- Input validated at system boundaries
- New endpoints and queries check authorization and are scoped to the right tenant/user
- No SQL injection, XSS or command injection

## Data

- No N+1 queries or unbounded queries/loops over user data
- New query patterns have the indexes they need
- Multi-step writes are in a transaction
- Migrations are backwards compatible (avoid breaking changes; work around them where possible)

## Code quality

- My preferences in `~/.claude/rules/code.md`: explicit `if/else` over complex ternaries, early returns, descriptive lambda names, comments only for a non-obvious WHY, naming conventions, business logic in the API, feature-based folders. Before/after examples are in [examples.md](examples.md)
- No over-engineering, tech-debt files or workaround code
- TypeScript: no `any` or typecasting, null/undefined handled, consistent types
- React: apply the `no-use-effect` rules; suggest `audit-react` for a deeper pass

## Tests

- New behaviour has tests, and they're high value: they test behaviour through the public interface, not implementation details
- The risky paths are covered; don't ask for tests of edge cases that can't happen
- Assertions can actually fail (not just recomputing the code's own answer)
