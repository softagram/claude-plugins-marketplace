#!/usr/bin/env bash
# SessionStart hook: tell the session which knowledge holarchies this user works with.
#
# Sources, merged in order (duplicates by repo or path are shown once):
#   1. $CLAUDE_PROJECT_DIR/.claude/holarchies   — per project; committed with a code repo
#   2. ~/.claude/holarchies                      — per user
#   3. every directory under $HOLARCHY_HOME (default ~/holarchies) with a root .holon-* marker
#
# Registry line format:  <owner/repo> [local path]   ('#' starts a comment)
#
# Prints nothing when no holarchy is known, so the plugin costs nothing for other projects.

set -u
home_dir="${HOLARCHY_HOME:-$HOME/holarchies}"
seen=" "
out=""

# Name from the root marker, scope from the line after "## What is this?" in CLAUDE.md.
describe() {
  local dir="$1" marker name scope
  marker=$(ls -A "$dir" 2>/dev/null | grep -m1 '^\.holon-') || return 0
  name=$(sed -n 's/^name:[[:space:]]*//p' "$dir/$marker" | head -1)
  scope=$(awk '/^## What is this\?/{f=1;next} f&&NF{print;exit}' "$dir/CLAUDE.md" 2>/dev/null)
  printf '%s%s' "${name:-}" "${scope:+ — $scope}"
}

add() {
  local repo="$1" path="$2" key desc state
  path="${path/#\~/$HOME}"
  key="${repo:-$path}"
  case "$seen" in *" $key "*) return ;; esac
  [ -n "$repo" ] && [ -n "$path" ] && case "$seen" in *" $path "*) return ;; esac
  seen="$seen$key $path "
  if [ -n "$path" ] && [ -d "$path" ]; then
    desc=$(describe "$path"); state="local: $path"
  else
    desc=""; state="not cloned here"
  fi
  out="$out- ${repo:-$(basename "$path")}${desc:+ — $desc} ($state)"$'\n'
}

read_registry() {
  local file="$1" repo path
  [ -f "$file" ] || return 0
  while read -r repo path _; do
    case "$repo" in ''|'#'*) continue ;; esac
    if [ -z "${path:-}" ] && [ -d "$home_dir/${repo##*/}" ]; then path="$home_dir/${repo##*/}"; fi
    add "$repo" "${path:-}"
  done < "$file"
}

[ -n "${CLAUDE_PROJECT_DIR:-}" ] && read_registry "$CLAUDE_PROJECT_DIR/.claude/holarchies"
read_registry "$HOME/.claude/holarchies"

if [ -d "$home_dir" ]; then
  for d in "$home_dir"/*/; do
    d="${d%/}"
    ls -A "$d" 2>/dev/null | grep -q '^\.holon-' || continue
    repo=$(git -C "$d" remote get-url origin 2>/dev/null | sed -E 's#^(https://[^/]+/|git@[^:]+:)##; s#\.git$##')
    case "$seen" in *" $d "*) continue ;; esac
    add "$repo" "$d"
  done
fi

[ -z "$out" ] && exit 0
printf 'Knowledge holarchies available to this user (use the holarchy skill when a task touches their scope):\n%s' "$out"
