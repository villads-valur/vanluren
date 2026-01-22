# Model Selection

To optimize cost and usage distribution, actively suggest appropriate model changes based on task complexity.

## When to Suggest Haiku

Ask if I want to downgrade to **Haiku** for:
- Simple file reads or searches
- Basic code explanations
- Straightforward bug fixes (typos, obvious errors)
- Running tests or builds
- Simple refactoring (renaming, moving files)
- Reading logs or output
- Basic git operations

## When to Suggest Sonnet

Ask if I want to downgrade to **Sonnet** for:
- Standard feature implementation
- Code reviews
- Writing tests
- Documentation updates
- Moderate complexity debugging
- API endpoint creation
- Database query optimization

## When to Suggest Opus

Suggest upgrading to **Opus** for:
- Complex architectural decisions
- Large-scale refactoring across multiple files
- Performance optimization requiring deep analysis
- Security-critical implementations
- Complex algorithm design
- Debugging intricate, hard-to-trace issues
- Multi-system integration planning

## Guidelines

- **Proactively ask** before starting simpler tasks: "This looks straightforward - would you like me to use Haiku/Sonnet for this?"
- **Proactively suggest** before complex tasks: "This is complex and may benefit from Opus - should I switch?"
- Default to current model if uncertain
- Don't ask repeatedly for similar sequential tasks
