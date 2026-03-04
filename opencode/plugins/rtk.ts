import type { Plugin } from "@opencode-ai/plugin"

// RTK OpenCode plugin — smart command rewriter for token savings.
// Mirrors RTK's registry.rs classification logic to only rewrite commands
// that RTK actually optimizes. Requires: rtk in PATH.

type Args = Record<string, unknown>

// Commands RTK supports, mapped to their rtk prefix.
// Order matters: more specific patterns first.
const SUPPORTED: [RegExp, string][] = [
  [/^(npx\s+|pnpm\s+)?tsc(\s|$)/, "rtk tsc"],
  [/^(npx\s+|pnpm\s+)?(eslint|biome|lint)(\s|$)/, "rtk lint"],
  [/^(npx\s+|pnpm\s+)?prettier/, "rtk prettier"],
  [/^(npx\s+|pnpm\s+)?next\s+build/, "rtk next build"],
  [/^(npx\s+|pnpm\s+)?(vitest|jest)(\s|$)/, "rtk vitest"],
  [/^(npx\s+|pnpm\s+)?playwright/, "rtk playwright"],
  [/^(npx\s+|pnpm\s+)?prisma/, "rtk prisma"],
  [/^(python3?\s+-m\s+)?mypy(\s|$)/, "rtk mypy"],
  [/^git\s+(status|log|diff|show|add|commit|push|pull|branch|fetch|stash|worktree)/, "rtk git"],
  [/^gh\s+(pr|issue|run|repo|api)/, "rtk gh"],
  [/^cargo\s+(build|test|clippy|check|fmt)/, "rtk cargo"],
  [/^pnpm\s+(list|ls|outdated|install)/, "rtk pnpm"],
  [/^npm\s+(run|exec)/, "rtk npm"],
  [/^npx\s+/, "rtk npx"],
  [/^(cat|head|tail)\s+/, "rtk read"],
  [/^(rg|grep)\s+/, "rtk grep"],
  [/^ls(\s|$)/, "rtk ls"],
  [/^find\s+/, "rtk find"],
  [/^docker\s+(ps|images|logs)/, "rtk docker"],
  [/^kubectl\s+(get|logs)/, "rtk kubectl"],
  [/^curl\s+/, "rtk curl"],
  [/^wget\s+/, "rtk wget"],
]

// Commands to skip entirely (shell builtins, trivial ops, already rtk).
const IGNORED_EXACT = new Set([
  "cd", "echo", "true", "false", "wait", "pwd", "bash", "sh", "fi", "done",
])

const IGNORED_PREFIXES = [
  "cd ", "cd\t", "echo ", "printf ", "export ", "source ", "mkdir ",
  "rm ", "mv ", "cp ", "chmod ", "chown ", "touch ", "which ", "type ",
  "command ", "test ", "sleep ", "kill ", "set ", "unset ", "wc ",
  "sort ", "uniq ", "tr ", "cut ", "awk ", "sed ", "python3 -c",
  "python -c", "node -e", "ruby -e", "rtk ", "bash ", "sh ",
  "then\n", "then ", "else\n", "else ", "do\n", "do ",
  "for ", "while ", "if ", "case ",
]

const ENV_PREFIX_RE = /^(?:sudo\s+|env\s+|[A-Z_][A-Z0-9_]*=[^\s]*\s+)+/

function isIgnored(cmd: string): boolean {
  if (IGNORED_EXACT.has(cmd)) return true
  for (const p of IGNORED_PREFIXES) {
    if (cmd.startsWith(p)) return true
  }
  return false
}

function rewriteSegment(segment: string): string {
  const trimmed = segment.trim()
  if (!trimmed || isIgnored(trimmed)) return segment

  // Strip env prefixes (sudo, VAR=val) for matching, keep them in output
  const envMatch = trimmed.match(ENV_PREFIX_RE)
  const prefix = envMatch ? envMatch[0] : ""
  const clean = trimmed.slice(prefix.length).trim()
  if (!clean || isIgnored(clean)) return segment

  for (const [pattern, rtkCmd] of SUPPORTED) {
    if (!pattern.test(clean)) continue

    // Special rewrites: cat/head/tail -> rtk read, rg -> rtk grep
    if (rtkCmd === "rtk read") {
      const rest = clean.replace(/^(cat|head|tail)\s*/, "")
      return `${prefix}rtk read ${rest}`.trim()
    }
    if (rtkCmd === "rtk grep") {
      const rest = clean.replace(/^(rg|grep)\s*/, "")
      return `${prefix}rtk grep ${rest}`.trim()
    }
    // tsc/lint/prettier/next/vitest/playwright/prisma/mypy:
    // strip npx/pnpm wrapper, use rtk directly
    if (/^rtk (tsc|lint|prettier|next|vitest|playwright|prisma|mypy)/.test(rtkCmd)) {
      const stripped = clean.replace(/^(npx\s+|pnpm\s+)?(python3?\s+-m\s+)?/, "")
      return `${prefix}rtk ${stripped}`.trim()
    }
    // Default: prefix with rtk
    return `${prefix}rtk ${clean}`.trim()
  }

  return segment
}

interface ChainPart {
  segment: string
  operator: string // "&&", "||", ";", or "" for last segment
}

function splitChain(cmd: string): ChainPart[] | null {
  const trimmed = cmd.trim()
  if (!trimmed) return null

  // Heredoc or arithmetic: don't split
  if (trimmed.includes("<<") || trimmed.includes("$((")) return null

  const parts: ChainPart[] = []
  let start = 0
  let i = 0
  let inSingle = false
  let inDouble = false

  while (i < trimmed.length) {
    const ch = trimmed[i]
    if (ch === "'" && !inDouble) { inSingle = !inSingle; i++; continue }
    if (ch === '"' && !inSingle) { inDouble = !inDouble; i++; continue }

    if (!inSingle && !inDouble) {
      if (ch === "|" && trimmed[i + 1] === "|") {
        parts.push({ segment: trimmed.slice(start, i).trim(), operator: " || " })
        i += 2; start = i; continue
      }
      if (ch === "|") {
        // Pipe: only rewrite what's before it, pass the rest through
        parts.push({ segment: trimmed.slice(start, i).trim(), operator: " | " })
        parts.push({ segment: trimmed.slice(i + 1).trim(), operator: "" })
        return parts
      }
      if (ch === "&" && trimmed[i + 1] === "&") {
        parts.push({ segment: trimmed.slice(start, i).trim(), operator: " && " })
        i += 2; start = i; continue
      }
      if (ch === ";") {
        parts.push({ segment: trimmed.slice(start, i).trim(), operator: "; " })
        i += 1; start = i; continue
      }
    }
    i++
  }

  if (start < trimmed.length) {
    parts.push({ segment: trimmed.slice(start).trim(), operator: "" })
  }

  return parts.length > 0 ? parts : null
}

export const RtkPlugin: Plugin = async ({ $ }) => {
  try {
    await $`which rtk`.quiet()
  } catch {
    console.warn("[rtk] rtk binary not found in PATH - plugin disabled")
    return {}
  }

  return {
    "tool.execute.before": async (input, output) => {
      const tool = String(input?.tool ?? "").toLowerCase()
      if (tool !== "bash" && tool !== "shell") return

      const args = output?.args as Args | undefined
      if (!args || typeof args !== "object") return

      const command = args.command
      if (typeof command !== "string" || !command.trim()) return

      const chain = splitChain(command)
      if (!chain) return // heredoc or empty

      let changed = false
      const rewritten = chain.map((part, idx) => {
        // Don't rewrite the tail of a pipe (only the first command matters)
        const isPipeTail = idx > 0 && chain[idx - 1].operator === " | "
        if (isPipeTail || !part.segment) return part

        const result = rewriteSegment(part.segment)
        if (result !== part.segment) changed = true
        return { ...part, segment: result }
      })

      if (changed) {
        args.command = rewritten.map((p) => p.segment + p.operator).join("")
      }
    },
  }
}
