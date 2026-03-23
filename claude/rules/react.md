# React Rules

Use `useEffect` only to synchronize with external systems (network, browser APIs, subscriptions, timers, third-party widgets).

## You Might Not Need an Effect

- Derive values during render instead of storing derived state
- Put user-triggered logic in event handlers, not in effects
- Avoid effects that only transform props/state into other props/state
- Reset state with keys or by changing component boundaries, not with cleanup hacks
- Update related state together in one handler when possible
- Use `useMemo` only for expensive calculations, not for correctness

## State and Data Flow

- Keep the minimal source of truth, derive everything else
- Lift state up when multiple components need to stay in sync
- Prefer controlled components for form behavior that affects app state
- Keep reducers and state updates pure and predictable
- Prefer `useState` for local UI state before reaching for Context or global state
- Use Context for shared feature-level state when prop drilling becomes noisy
- Treat server state separately from UI state, and use dedicated data-fetching tools for it
- Use global state only when state must be shared across unrelated parts of the app

## React Compiler Memoization

- If React Compiler is enabled, do not add `useMemo`, `useCallback`, or `React.memo` by default
- Remove manual memoization when refactoring unless there is a documented reason to keep it
- If a component uses `'use no memo'`, manual memoization is allowed where it clearly improves correctness or performance

## Conditional Rendering

- Prefer early returns when conditional logic is non-trivial or controls large sections of UI
- Use ternaries only for short, readable inline branches
- Extract condition-heavy UI into small components instead of stacking nested conditions in one render path

## Cleanup Order

- When React content is mounted into an external DOM host (for example a portal, popup, tooltip, or custom renderer), destroy the React component before destroying the host
- Unmounting React after the host is removed can cause DOM cleanup errors and flaky UI behavior

## Effect Checklist

Before adding an effect, verify all of these:

- This code syncs with something outside React
- The logic cannot live in render or an event handler
- Dependencies are complete and intentional
- Cleanup is required and mirrors setup

If any item fails, refactor away from the effect.
