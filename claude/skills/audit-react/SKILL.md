---
name: audit-react
description: >-
  Audit a React or React Native component / feature / UI for quality and
  performance issues. Triggers on "audit this component", "check this UI",
  "audit react", "review react performance", or before shipping a complex
  component.
allowed-tools: Read, Grep, Glob
---

# Audit React

Structured performance and UI-quality audit for React 19 and React Native. Produces inline findings with `file:line` references, severity, and links to specific rule files.

## Companion skills

- `react-performance` — the reference library of perf rules this audit cross-references (see `~/.claude/skills/react-performance/rules/`)
- `react-composition-patterns` — component API and composition rules (see `~/.claude/skills/react-composition-patterns/rules/`)
- `no-use-effect` — authoritative for effect-related findings

## When to Use

- User asks to "audit this component", "check this UI", "audit react", "review the perf of X"
- Before shipping a non-trivial component or screen
- When investigating "this feels slow" reports
- During PR review, to go deeper than the general `code-reviewer` skill

## Workflow

### 1. Determine scope

Ask once if unclear:

- Single file? → read it
- Folder / feature? → `Glob` for `*.tsx`, `*.ts`, `*.jsx`, `*.js` and read the leaf components first
- Uncommitted / PR changes? → use `git diff --name-only` to get the set, then read each

Detect platform for each file:

- React Native: look for imports from `react-native`, `expo`, `react-native-*`, or a `.native.tsx` suffix
- Web: everything else
- If mixed or unclear, flag platform-specific findings as "[web]" or "[rn]" so the user can filter

### 2. Run the checklist

Go through every category below. For each file, produce zero or more findings. Do not skip categories silently; if nothing applies say "clean" in the summary.

#### A. Waterfalls (CRITICAL)

Look for:

- Sequential `await`s where operations are independent → `async-parallel`
- `await` before a conditional early return → `async-defer-await`
- `await getFlag()` combined with a cheap sync guard → `async-cheap-condition-before-await`
- Nested fetch chains that could be parallelized per-item → `async-dependencies`
- Data-dependent JSX blocking wrapper render, no `<Suspense>` boundary → `async-suspense-boundaries`

#### B. Effect usage

Look for:

- Any `useEffect` call not wrapped in `useMountEffect`
  - Classify using the five `no-use-effect` patterns (derive / fetch / event / mount-sync / reset-with-key)
- Effects that only `setState(deriveFromProps)` → `rerender-derived-state-no-effect`
- Effects that call fetch + setState → should use a data-fetching library → `no-use-effect` Rule 2
- Effects acting as an action relay (`setFlag` → effect runs → `setFlag(false)`) → `no-use-effect` Rule 3
- Effects with non-primitive deps that always change → `rerender-dependencies`
- Interaction logic in effect bodies → `rerender-move-effect-to-event`

#### C. Re-render hotspots

Look for:

- Component defined inside another component → `rerender-no-inline-components` (always applies, Compiler-independent)
- Derived value stored in state with an effect to update it → `rerender-derived-state-no-effect`
- Subscription to raw state when only a derived boolean is used → `rerender-derived-state`
- State read only inside event handlers → `rerender-defer-reads`
- Non-urgent updates (filters, search) not wrapped in `startTransition` → `rerender-transitions`
- Expensive derivations from rapidly changing input → `rerender-use-deferred-value`
- Large `useState` initial value without lazy initializer → `rerender-lazy-state-init`
- High-frequency transient values stored in state instead of refs → `rerender-use-ref-transient-values`

**If React Compiler is OFF** (check for `babel-plugin-react-compiler` in config, or `'use no memo'` directive), additionally look for:

- Expensive JSX not extracted to a `memo()`ed child → `rerender-memo`
- Memoized component with non-primitive default param → `rerender-memo-with-default-value`
- `useMemo` around a primitive expression → `rerender-simple-expression-in-memo`
- Combined `useMemo` with unrelated deps → `rerender-split-combined-hooks`
- Unstable setState callbacks without functional form → `rerender-functional-setstate`

If React Compiler is ON and these patterns appear, suggest removing manual memoization instead.

#### D. Rendering performance

Look for:

- Static JSX re-created every render inside a component → `rendering-hoist-jsx`
- `&&` with non-boolean left operand (`items.length && ...`) → `rendering-conditional-render`
- Manual `isLoading` state alongside a mutation when `useTransition` would work → `rendering-usetransition-loading`
- Show/hide patterns using `{flag && <Heavy/>}` where state should persist → `rendering-activity`

Web-only:

- Animated SVG element directly (CSS transform on `<svg>`) → `rendering-animate-svg-wrapper`
- Long lists without virtualization or `content-visibility` → `rendering-content-visibility`
- Critical resources without `<link rel=preload>` / `preload()` hint → `rendering-resource-hints`
- `<script>` without `defer`/`async` → `rendering-script-defer-async`

React Native-only:

- Long lists using `.map()` instead of `FlatList`/`FlashList`
- `FlatList` without `keyExtractor` or `getItemLayout` on fixed-height rows
- Heavy components not wrapped in `InteractionManager.runAfterInteractions` on mount when appropriate

#### E. Client-side patterns

- Manual `fetch` + `useState` + `useEffect` where a data-fetching lib exists → `client-swr-dedup` (or the project's SWR/TanStack Query equivalent)
- Multiple components registering the same global `window`/`document` listener → `client-event-listeners` [web]
- `touchstart`/`wheel` listeners without `{ passive: true }` → `client-passive-event-listeners` [web]

#### F. JavaScript hot paths

Scan render bodies, handlers, and `.map`-heavy sections for:

- Repeated linear `.find` / `.includes` on arrays where a `Set`/`Map` would fit → `js-set-map-lookups`, `js-index-maps`
- Separate `.filter().map()` chains on hot render paths → `js-combine-iterations`, `js-flatmap-filter`
- `RegExp` literal inside a loop body or per-render → `js-hoist-regexp`
- `[...arr].sort()` for pure min/max → `js-min-max-loop`
- `.sort()` that mutates shared arrays → `js-tosorted-immutable`
- Repeated property chains in loops (`obj.deeply.nested.value` per iteration) → `js-cache-property-access`
- Missing early exits in validation / guards → `js-early-exit`
- Long array comparison without length check → `js-length-check-first`
- Pure functions called repeatedly with the same args on hot path → `js-cache-function-results`
- Expensive non-critical work running during render/commit → `js-request-idle-callback` [web]
- Repeated `localStorage.getItem` in the same frame → `js-cache-storage` [web]
- Multiple sequential style mutations in an imperative handler → `js-batch-dom-css` [web]

#### G. Advanced patterns

- Event handlers passed to children that change every render, breaking memoization → `advanced-event-handler-refs`, `advanced-use-latest`
- `useEffectEvent` result placed in an effect's dep array → `advanced-effect-event-deps`
- App-level init (logger, analytics, store hydrate) re-running per component mount → `advanced-init-once`

#### H. Component API design

Cross-references `react-composition-patterns` skill.

- More than 2-3 boolean props on one component, especially combinatorial (`primary && large && disabled`) → `architecture-avoid-boolean-props`, `patterns-explicit-variants`
- Components using `renderHeader` / `renderFooter` / `renderItem` props for layout slots → `patterns-children-over-render-props`
- Complex components (Tabs, Menu, Dialog, Accordion) built as one monolithic component with many props → `architecture-compound-components`
- State managed by a parent and passed through 3+ levels of children → `state-lift-state`
- Context provider exposing raw `useState`/`useReducer` shape or specific implementation details → `state-decouple-implementation`, `state-context-interface`
- Codebase on React 19 still using `forwardRef` for new components, or `useContext()` instead of `use()` → `react19-no-forwardref`

#### I. UI quality (beyond Vercel rules)

Quick sanity checks:

- Controlled vs uncontrolled inputs consistent
- Loading, empty, and error states handled (not just happy path)
- `key` prop on lists uses a stable id, not index, for mutable lists
- Accessibility: interactive elements have accessible names; images have alt text (web) or `accessibilityLabel` (RN); focus order is sensible
- Large components split by responsibility (hooks, derived values, handlers, early returns, JSX in that order — see `no-use-effect` SKILL.md)

### 3. Output format

Produce findings grouped by severity. Each finding on one line where possible, with a reason on the next line. Always include a relative `file:line` ref and the rule slug.

```
[CRITICAL] src/chat/ChatList.tsx:42 — async-parallel
  Three independent awaits run sequentially. Wrap in Promise.all to cut latency.
  See: react-performance/rules/async-parallel.md

[HIGH] src/chat/ChatList.tsx:78 — rerender-no-inline-components
  `MessageRow` is defined inside `ChatList`; it remounts on every parent render
  and loses focus / local state.

[HIGH] src/chat/ChatList.tsx:112 — no-use-effect Rule 2
  useEffect(fetch + setState). Replace with useQuery or project data layer.

[MEDIUM] src/chat/ChatList.tsx:91 — rendering-hoist-jsx
  Static header JSX is recreated each render. Hoist the element above the
  component.

[LOW] src/chat/ChatList.tsx:203 — js-set-map-lookups
  `userIds.includes(id)` inside a loop over N messages; O(N*M). Build a Set once.

[SUGGESTION] src/chat/ChatList.tsx:54 — rerender-transitions
  Filter update is non-urgent. Consider startTransition to keep typing responsive.
```

Severity scale:

- `CRITICAL` — known perf killer (waterfalls, remounting components) or broken effect
- `HIGH` — likely user-visible impact (re-render storm, missing virtualization, effect-as-fetch)
- `MEDIUM` — measurable but situational (hoisting, memoization, list keys)
- `LOW` — micro-optimization, hot-path only
- `SUGGESTION` — stylistic / future-friendly, not a defect

### 4. End with a prioritized action list

After findings, output a short top-5 action list:

```
## Top 5 actions

1. [src/chat/ChatList.tsx:42] Parallelize the three awaits (async-parallel).
2. [src/chat/ChatList.tsx:78] Move `MessageRow` to module scope.
3. [src/chat/ChatList.tsx:112] Replace useEffect-fetch with the project data layer.
4. [src/chat/ChatList.tsx:91] Hoist the static header JSX.
5. [src/chat/ChatList.tsx:203] Use a Set for userId lookups.
```

## Rules

- Read-only. Do not edit files during an audit; propose changes, don't make them.
- If asked to fix, spin up a fresh turn or invoke the relevant rule + `no-use-effect` skill.
- Keep findings concrete: always a file, line, rule slug, and one-sentence reason.
- If a category is clean, say so in the summary. Don't invent findings.
- When Compiler status is unknown, flag memoization findings as "if Compiler off".
