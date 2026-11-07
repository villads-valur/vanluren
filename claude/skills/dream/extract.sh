#!/usr/bin/env bash
# Condense Claude Code transcripts changed since the last dream into one digest.
# Usage: extract.sh [--days N] [--out FILE]
# Without --days, reads sessions newer than $DREAMS/.last-run (fallback: 1 day).
set -euo pipefail

DREAMS="${DREAMS_DIR:-$HOME/.claude/dreams}"
PROJECTS="$HOME/.claude/projects"
DAYS=""
OUT=""

while [ $# -gt 0 ]; do
  case "$1" in
    --days) DAYS="$2"; shift 2 ;;
    --out) OUT="$2"; shift 2 ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

mkdir -p "$DREAMS"
OUT="${OUT:-$DREAMS/$(date +%F)/digest.md}"
mkdir -p "$(dirname "$OUT")"

# Paths counted as personal; everything else is work. One absolute path prefix per line.
PERSONAL_ROOTS="$HOME/code/personal"
[ -f "$DREAMS/personal-roots" ] && PERSONAL_ROOTS="$(grep -v '^#' "$DREAMS/personal-roots" | sed '/^$/d')"

if [ -n "$DAYS" ]; then
  FIND_AGE=(-mtime "-$DAYS")
elif [ -f "$DREAMS/.last-run" ]; then
  FIND_AGE=(-newer "$DREAMS/.last-run")
else
  FIND_AGE=(-mtime -1)
fi

# ./ prefix because project dirs start with "-"
cd "$PROJECTS"
# Skips the dream's own sessions (run from ~/.claude/dreams)
SESSIONS=$(find ./* -maxdepth 1 -name '*.jsonl' -not -path './*-claude-dreams/*' "${FIND_AGE[@]}" -print 2>/dev/null | sort)

# One jq pass per session: prompts, slash commands, interrupts, rejections,
# permission prompts, tool errors and tool counts. Skips subagent (sidechain) records.
read -r -d '' JQ <<'EOF' || true
def oneline($n): gsub("\\s+"; " ") | if length > $n then .[:$n] + "…" else . end;
def input_summary: if .plan then (.plan | split("\n")[0]) elif .command then .command elif .file_path then .file_path elif .skill then .skill else (tostring) end | oneline(160);

map(select(.isSidechain != true)) as $recs
| ($recs | map(select(.type == "assistant") | .message.content[]? | select(.type == "tool_use") | {(.id): {name, input}}) | add // {}) as $tools
| ($recs | map(.cwd // empty) | first // "?") as $cwd
| ($recs | map(select(.type == "custom-title") | .customTitle) | last // "") as $title
| ($recs | map(.gitBranch // empty) | map(select(. != "" and . != "HEAD")) | last // "-") as $branch
| ($recs | map(.timestamp // empty) | first // "?") as $start
| ($personal | split("\n") | map(select(. != "")) | any(. as $root | $cwd | startswith($root))) as $isPersonal
| [
    "## \(if $isPersonal then "personal" else "work" end) · \($cwd | sub("^" + $home; "~")) · \($title | oneline(80))",
    "session `\($session)` · branch `\($branch)` · started \($start[:16])",
    "",
    ( $recs[]
      | select(.type == "user")
      | . as $rec
      | if (.message.content | type) == "string" then
          if (.promptSource == "typed" or .promptSource == "suggestion_accepted") then
            if (.message.content | test("^<command-name>")) then
              "- cmd: \(.message.content | capture("<command-name>(?<c>[^<]*)</command-name>").c) \(.message.content | capture("<command-args>(?<a>[^<]*)</command-args>").a? // "" | oneline(200))"
            elif (.message.content | test("^<local-command-stdout>")) then empty
            else "- you: \(.message.content | oneline(600))"
            end
          else empty end
        else
          .message.content[]
          | if .type == "text" and (.text | test("^\\[Request interrupted")) then "- INTERRUPT"
            elif .type == "text" and ($rec.promptSource == "typed") then "- you: \(.text | oneline(600))"
            elif .type == "tool_result" then
              ($tools[.tool_use_id] // {name: "?", input: {}}) as $t
              | (.content | if type == "array" then map(.text? // "") | join(" ") else tostring end) as $body
              | if ($body | test("doesn't want to proceed")) then
                  "- REJECTED \($t.name): \($t.input | input_summary)\($body | capture("the user said:\\s*(?<r>.*)"; "s").r? // "" | if . != "" then " → you: " + oneline(300) else "" end)"
                elif $rec.permissionDecision.source? == "user_temporary" or $rec.permissionDecision.source? == "user_permanent" then
                  "- PERMISSION PROMPT \($t.name): \($t.input | input_summary)"
                elif .is_error == true then
                  "- ERROR \($t.name): \($t.input | input_summary) ⇒ \($body | oneline(200))"
                else empty end
            else empty end
        end
    ),
    "",
    "tools: \($tools | [.[].name] | group_by(.) | map("\(.[0])×\(length)") | join(", "))",
    ""
  ]
| join("\n")
EOF

{
  echo "# Dream digest $(date +%F)"
  echo
  echo "Window: ${DAYS:+last $DAYS days}${DAYS:-since last run}. Sessions: $(printf '%s\n' "$SESSIONS" | sed '/^$/d' | wc -l | tr -d ' ')"
  echo
  for f in $SESSIONS; do
    jq -rs --arg session "$(basename "$f" .jsonl)" --arg home "$HOME" --arg personal "$PERSONAL_ROOTS" "$JQ" "$f" 2>/dev/null \
      || echo "## ? · $f (could not parse)"
  done
} > "$OUT"

echo "$OUT"
