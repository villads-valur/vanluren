#!/usr/bin/env bash
# Tests for the PreToolUse Bash guards. Run: claude/hooks/test-guards.sh
set -u
here=$(cd "$(dirname "$0")" && pwd)
fails=0

# run <guard> <command> [run_in_background] [cwd] -> exit code of the guard
run() {
  jq -n --arg c "$2" --argjson bg "${3:-false}" --arg cwd "${4:-$PWD}" \
    '{tool_input: {command: $c, run_in_background: $bg}, cwd: $cwd}' |
    "$here/$1" 2>/dev/null
}
expect() { # expect <blocked|allowed> <description> <guard> <command> [bg] [cwd]
  local want=$1 desc=$2; shift 2
  local code got=allowed
  run "$@"; code=$?
  [ "$code" -eq 2 ] && got=blocked
  if [ "$got" = "$want" ]; then echo "ok    $desc"; else echo "FAIL  $desc (got $got)"; fails=$((fails + 1)); fi
}

echo "# bash-guard"
expect blocked "echo starting with =" bash-guard.sh "echo ==="
expect blocked "unquoted --include glob" bash-guard.sh "grep -r foo --include=*.ts ."
expect blocked "sed -i ''" bash-guard.sh "sed -i '' 's/a/b/' src/app.ts"
expect blocked "sed -E -i" bash-guard.sh "sed -E -i '' 's/a/b/' src/app.ts"
expect blocked "perl -0pi" bash-guard.sh "perl -0pi -e 's/a/b/s' src/app.ts"
expect blocked "perl -pi after cd" bash-guard.sh "cd app && perl -pi -e 's/a/b/' x.ts"
expect blocked "python heredoc writing a repo file" bash-guard.sh $'python3 - <<\'EOF\'\np = "src/app.ts"\nopen(p, "w").write("x")\nEOF'
expect blocked "python heredoc write_text" bash-guard.sh $'python3 <<EOF\nPath("a.ts").write_text(s)\nEOF'
expect blocked "foreground until/sleep loop" bash-guard.sh 'until gh pr view 1 --json state -q .state | grep -q MERGED; do sleep 15; done'
expect blocked "multi-line while/sleep loop" bash-guard.sh $'while true\ndo\n  gh pr checks 3 && break\n  sleep 30\ndone'
expect blocked "bork issue start | head" bash-guard.sh 'bork issue start "Fix x" --prompt "y" | head -1'
expect allowed "sed -n" bash-guard.sh "sed -n '1,20p' file.ts"
expect allowed "sed with i in the script" bash-guard.sh "sed 's/i/I/' file.ts"
expect allowed "perl -ne" bash-guard.sh "perl -ne 'print if /x/' file.ts"
expect allowed "perl -Mstrict -e" bash-guard.sh "perl -Mstrict -e 'print 1'"
expect allowed "python heredoc that only reads" bash-guard.sh $'python3 - <<EOF\nprint(open("a.json").read())\nEOF'
expect allowed "python writing to scratchpad" bash-guard.sh $'python3 - <<EOF\nopen("/private/tmp/x/scratchpad/out.json", "w").write(s)\nEOF'
expect allowed "background until/sleep loop" bash-guard.sh 'until [ -f done ]; do sleep 5; done' true
expect allowed "short single sleep" bash-guard.sh 'kill -TERM $p; sleep 1; echo done'
expect allowed "gh pr checks --watch" bash-guard.sh 'gh pr checks 12 --watch' true
expect allowed "bork issue start | tail" bash-guard.sh 'bork issue start "Fix x" --prompt "y" 2>&1 | tail -4'

echo "# push-guard"
repo=$(mktemp -d)
git -C "$repo" init -q -b main
git -C "$repo" -c user.email=t@t -c user.name=t commit -q --allow-empty -m "init"
git -C "$repo" switch -q -c arcane-life-12/live-join
expect blocked "git push on a bork branch" push-guard.sh "git push -u origin HEAD" false "$repo"
expect blocked "git -C push on a bork branch" push-guard.sh "git -C $repo push" false /
expect blocked "cd && push on a bork branch" push-guard.sh "cd $repo && git push" false /
expect blocked "gh pr create on a bork branch" push-guard.sh "gh pr create --fill" false "$repo"
expect blocked "refspec to a bork branch" push-guard.sh "git push origin HEAD:orb-tui-45/pin-images" false "$repo"
expect allowed "refspec renaming to a ticket branch" push-guard.sh "git push origin HEAD:ENG-12/live-join" false "$repo"
expect allowed "deleting a leaked bork branch" push-guard.sh "git push origin --delete arcane-life-12/live-join" false "$repo"
expect allowed "other git commands" push-guard.sh "git status" false "$repo"
git -C "$repo" branch -q -m ENG-12/live-join
expect allowed "git push on a renamed branch" push-guard.sh "git push -u origin HEAD" false "$repo"
expect blocked "gh pr create --head bork branch" push-guard.sh "gh pr create --head bork-3/x --fill" false "$repo"
git -C "$repo" update-ref refs/remotes/origin/HEAD HEAD
git -C "$repo" -c user.email=t@t -c user.name=t commit -q --allow-empty -m "fix: thing (arcane-life-12)"
BORK_ISSUE_ID=arcane-life-12 expect blocked "commit message with the bork ID" push-guard.sh "git push" false "$repo"
BORK_ISSUE_ID=arcane-life-1 expect allowed "a longer ID is not this ID" push-guard.sh "git push" false "$repo"
expect allowed "commit message check needs BORK_ISSUE_ID" push-guard.sh "git push" false "$repo"

echo
[ "$fails" -eq 0 ] && echo "all passed" || { echo "$fails failed"; exit 1; }
