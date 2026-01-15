# Code Quality

- No tech_debt files or workaround files - fix issues directly
- Clean up after implementation: remove unneeded changes, files, or artifacts
- Don't over-optimise early - handle main errors/validations without going overboard
- Use existing logging/monitoring (like Sentry), add explicit logging only where errors are anticipated

## Readability Preferences

- **Avoid ternary operators** for complex logic - use explicit `if/else` instead
  - Simple assignment OK: `const x = condition ? a : b`
  - Nested/complex ternaries: always use `if/else` blocks
- **Use descriptive variable names in lambdas** when the body is complex
  - Short lambdas OK: `.map((f) => f.id)`
  - Complex lambdas: use `item`, `folder`, `doc`, etc. instead of single chars
