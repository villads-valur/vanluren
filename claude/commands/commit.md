---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
argument-hint: [message]
description: Create a git commit
---

## Context

- Current git status: !`git status`
- Current git diff: !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task

Based on the above changes, create a single git commit. Use the conventional commit message format.
The commit message should be concise yet descriptive, summarizing the changes made.
If there are multiple types of changes, prioritize them in the following order: feat, fix, docs, style, refactor, test, chore.
