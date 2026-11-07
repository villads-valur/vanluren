# Code

Usual stack: TypeScript, NestJS/Express, React/React Native, TypeORM/Prisma/Drizzle, PostgreSQL.

## Quality

- Edit files with the Edit/Write tools, not `python3`/`sed -i`/heredoc scripts (they may be missing and they trigger permission prompts)
- Fix issues directly; no tech-debt or workaround files
- Clean up after implementing: remove unneeded changes, files and artifacts
- Handle the main errors and validations without over-optimising early
- Use the existing logging/monitoring (e.g. Sentry); add explicit logging only where errors are anticipated
- Comment sparingly, only to explain a non-obvious WHY
- Avoid breaking changes; work around issues rather than adding migrations

## Readability

- Explicit `if/else` over complex or nested ternaries; simple assignments like `const x = cond ? a : b` are fine
- Descriptive names in non-trivial lambdas (`item`, `folder`, `doc`); `.map((f) => f.id)` is fine
- Early returns over deep nesting

## Architecture

- Centralise business logic in the API; keep the frontend simple
- Prefer pure functions and basic components
- Default to React's built-in state and custom hooks over state libraries
- Feature-based folders with colocated files

## Naming

Project conventions first, then:

| Type                | Convention       |
| ------------------- | ---------------- |
| File names          | kebab-case       |
| Components          | PascalCase       |
| Functions/variables | camelCase        |
| Constants           | UPPER_SNAKE_CASE |

Imports: follow the project; prefer path aliases.
