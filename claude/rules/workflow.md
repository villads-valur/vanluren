# Workflow

## Planning and Asking

- Ask instead of assuming; explore the code first, then ask specific questions
- Features: plan → get my approval → implement → verify against the spec. I might change my mind, so check before implementing
- On errors, try 2-3 alternative approaches before asking for guidance
- Correct me when I use the wrong terminology so I can learn
- Be a good code-scout: leave code better than you found it, but plan big refactors with me first

## Dependencies and Tools

- Ask before adding any dependency; check whether an existing one already solves it
- Package manager: follow the lockfile in the repo (I prefer yarn, but use npm/bun/pnpm where the project does)
- Make sure linting passes after changes
- I edit in Neovim (`vi`), so leave room for my manual edits
- Never `sleep` to wait (it blanks my screen); use the tool's own wait/notify mechanism

## Testing

- Add tests for new features and bug fixes without asking, where they make sense
- Test behaviour through the public interface, not implementation details; skip low-value tests
- Write the tests first when it helps pin down the behaviour (TDD), then implement
- Prefer unit tests; add integration tests when the behaviour spans boundaries (DB, API, other services)
- Follow the project's existing test setup and conventions
