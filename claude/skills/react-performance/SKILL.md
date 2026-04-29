---
name: react-performance
description: >-
  Reference guide for React 19 and React Native performance. ACTIVATE when
  writing or reviewing React components for waterfall elimination, re-render
  optimization, rendering performance, or JavaScript hot paths. Works alongside
  the no-use-effect skill. Web-only rules are noted inline.
allowed-tools: Read, Grep, Glob
---

# React Performance

Curated from Vercel's [agent-skills react-best-practices](https://github.com/vercel-labs/agent-skills/tree/main/skills/react-best-practices) (MIT, Vercel Engineering). Trimmed to rules that apply without Next.js/RSC. See `NOTICE`.

## Scope

- Framework: plain React 19 and React Native. Next.js-specific rules (RSC, Server Actions, `next/dynamic`, `after()`, hydration) are excluded.
- Bundle-size section is intentionally dropped; rely on Vite/Metro defaults and the barrel-import avoidance baked into most modern libraries.
- Web-only rules carry a `> **Platform:** Web only` callout.

## Authority vs existing rules

- `no-use-effect` skill overrides Vercel's "Effect Checklist". Never justify a new `useEffect`; use the five replacement patterns and `useMountEffect` escape hatch.
- Manual memoization rules (`rerender-memo`, `rerender-memo-with-default-value`, `rerender-simple-expression-in-memo`, `rerender-functional-setstate`, `rerender-split-combined-hooks`) only apply when [React Compiler](https://react.dev/learn/react-compiler) is disabled or the file has `'use no memo'`. Otherwise skip.

## When to Apply

- Writing new React components (web or native)
- Reviewing code for performance issues (data waterfalls, re-renders, long lists, hot-path JS)
- Investigating "this screen feels slow" reports
- The `audit-react` skill uses this as its reference library

## Quick Reference

Each row links to a file in `rules/`. Open the rule for full code examples.

### 1. Eliminating Waterfalls (CRITICAL)

| Rule | Impact |
|------|--------|
| `async-parallel` | Use `Promise.all()` for independent operations |
| `async-defer-await` | Move `await` into branches where actually used |
| `async-dependencies` | Use `better-all` (or promise composition) for partial deps |
| `async-cheap-condition-before-await` | Check cheap sync conditions before awaiting |
| `async-suspense-boundaries` | Stream wrapper UI, suspend only the data-dependent piece |

### 2. Client-side data (MEDIUM-HIGH)

| Rule | Impact | Platform |
|------|--------|----------|
| `client-swr-dedup` | Use SWR / React Query for deduplication | both |
| `client-event-listeners` | Share global listeners across instances | web |
| `client-passive-event-listeners` | Passive touch/wheel for scroll responsiveness | web |

### 3. Re-render Optimization (MEDIUM)

| Rule | Impact |
|------|--------|
| `rerender-derived-state-no-effect` | Derive in render, not effects |
| `rerender-derived-state` | Subscribe to derived booleans, not raw values |
| `rerender-defer-reads` | Don't subscribe for state only read in callbacks |
| `rerender-dependencies` | Use primitive effect dependencies |
| `rerender-move-effect-to-event` | Interaction logic belongs in handlers |
| `rerender-functional-setstate` | Functional setState for stable callbacks |
| `rerender-lazy-state-init` | Pass a fn to `useState` for expensive initials |
| `rerender-transitions` | `startTransition` for non-urgent updates |
| `rerender-use-deferred-value` | `useDeferredValue` for expensive derivations |
| `rerender-use-ref-transient-values` | `useRef` for transient high-frequency values |
| `rerender-no-inline-components` | Never define a component inside another (applies always) |
| `rerender-split-combined-hooks` | Split hooks with independent deps (memo-aware) |
| `rerender-memo` | Extract expensive work into memoized components (memo-aware) |
| `rerender-memo-with-default-value` | Hoist default non-primitive props to constants (memo-aware) |
| `rerender-simple-expression-in-memo` | Don't wrap primitive results in `useMemo` (memo-aware) |

"memo-aware" = only when React Compiler is off.

### 4. Rendering Performance (MEDIUM)

| Rule | Impact | Platform |
|------|--------|----------|
| `rendering-conditional-render` | Prefer ternaries over `&&` with non-boolean left side | both |
| `rendering-hoist-jsx` | Hoist static JSX outside components | both |
| `rendering-activity` | Use `<Activity>` for show/hide that preserves state | both |
| `rendering-usetransition-loading` | `useTransition` over manual loading state | both |
| `rendering-animate-svg-wrapper` | Animate the wrapper, not the SVG | web |
| `rendering-svg-precision` | Reduce SVG coordinate precision | both |
| `rendering-content-visibility` | `content-visibility: auto` for long lists | web |
| `rendering-resource-hints` | `preload` / `prefetchDNS` via React DOM | web |
| `rendering-script-defer-async` | `defer` / `async` on `<script>` tags | web |

For long lists in RN, use `FlatList` / `FlashList` with `getItemLayout` instead of `content-visibility`.

### 5. JavaScript Performance (LOW-MEDIUM)

Hot-path and loop-level optimizations, framework-agnostic.

| Rule |
|------|
| `js-early-exit` |
| `js-length-check-first` |
| `js-set-map-lookups` |
| `js-index-maps` |
| `js-cache-property-access` |
| `js-cache-function-results` |
| `js-cache-storage` (web only) |
| `js-combine-iterations` |
| `js-flatmap-filter` |
| `js-hoist-regexp` |
| `js-min-max-loop` |
| `js-tosorted-immutable` |
| `js-batch-dom-css` (web only) |
| `js-request-idle-callback` (web only) |

### 6. Advanced Patterns (LOW)

| Rule | Impact |
|------|--------|
| `advanced-effect-event-deps` | Don't put `useEffectEvent` results in effect deps |
| `advanced-event-handler-refs` | Store event handlers in refs for stable identity |
| `advanced-init-once` | App-level init runs once, not per mount |
| `advanced-use-latest` | `useLatest` for stable callback refs |

## How to Use

1. Open `rules/<name>.md` to read the full rule with code examples.
2. For an end-to-end audit of a component or feature, invoke the `audit-react` skill.
3. For effect-specific work, invoke the `no-use-effect` skill.
