---
name: react-composition-patterns
description: >-
  Component composition patterns for React 19 and React Native. ACTIVATE when
  designing component APIs, refactoring components with many boolean props,
  building reusable component libraries, reviewing component architecture, or
  working with compound components and context providers. Includes React 19 API
  guidance.
allowed-tools: Read, Grep, Glob
---

# React Composition Patterns

Curated from Vercel's [agent-skills composition-patterns](https://github.com/vercel-labs/agent-skills/tree/main/skills/composition-patterns) (MIT, Vercel Engineering). All 8 rules included verbatim — they are framework-agnostic and apply to both React (web) and React Native. See `NOTICE`.

## Scope

- Component API design and composition (not performance — see `react-performance` for that)
- Universal: web and React Native
- `react19-no-forwardref` only applies if your project is on React 19+

## When to Apply

- Designing a new reusable component, especially one that has multiple modes
- Refactoring a component that is growing more boolean props every sprint
- Reviewing component architecture in PRs
- Building a feature where state needs to be shared across siblings
- Working with compound patterns: Tabs, Menu, Dialog, Form, Accordion, etc.

## Quick Reference

### 1. Component Architecture (HIGH)

| Rule | When |
|------|------|
| `architecture-avoid-boolean-props` | A component is gaining `isXyz` / `hasXyz` flags to switch behavior |
| `architecture-compound-components` | A component (Tabs, Menu, Dialog) has many props; expose subcomponents instead |

### 2. State Management (MEDIUM)

| Rule | When |
|------|------|
| `state-lift-state` | Siblings need shared state; prop-drilling is getting noisy |
| `state-decouple-implementation` | Provider exposes raw `useState`/`useReducer` shape to consumers |
| `state-context-interface` | Designing a context that should be swappable / testable |

### 3. Implementation Patterns (MEDIUM)

| Rule | When |
|------|------|
| `patterns-explicit-variants` | Boolean props create combinatorial states (e.g. `primary && large && disabled`) |
| `patterns-children-over-render-props` | API uses `renderHeader` / `renderItem` for layout slots |

### 4. React 19 APIs (MEDIUM, React 19+ only)

| Rule | When |
|------|------|
| `react19-no-forwardref` | Writing or migrating components in a React 19 codebase; drop `forwardRef`, use `use()` instead of `useContext()` |

## Companion skills

- `react-performance` — performance rules (waterfalls, re-renders, rendering, JS hot paths)
- `audit-react` — end-to-end component audit; cross-references both this skill and `react-performance`
- `no-use-effect` — authoritative on effects

## How to Use

1. Open `rules/<name>.md` for the full rule with code examples.
2. For full component audits, invoke `audit-react`.
3. For project-level state and data-flow conventions, see `~/.claude/rules/react.md`.
