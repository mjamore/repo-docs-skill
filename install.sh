#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIRS=(
  "$HOME/.agents/skills"
  "$HOME/.copilot/skills"
  "$HOME/.gemini/skills"
  "$HOME/.claude/skills"
  "$HOME/.codex/skills"
)

link_skill() {
  local name="$1"
  local skills_dir="$2"
  local source="$REPO_ROOT/$name"
  local target="$skills_dir/$name"

  if [[ ! -d "$source" ]]; then
    echo "Missing skill source: $source" >&2
    exit 1
  fi

  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"
    if [[ "$current" == "$source" ]]; then
      echo "$name already linked for $skills_dir"
      return
    fi
    echo "Refusing to replace existing symlink at $target -> $current" >&2
    exit 1
  fi

  if [[ -e "$target" ]]; then
    echo "Refusing to replace existing path at $target" >&2
    exit 1
  fi

  ln -s "$source" "$target"
  echo "Linked $name -> $skills_dir"
}

link_all_skills() {
  local skills_dir="$1"

  mkdir -p "$skills_dir"
  link_skill "repo-docs" "$skills_dir"
  link_skill "repo-docs-audit" "$skills_dir"
}

is_duplicate_dir() {
  local candidate="$1"
  local existing

  for existing in "${UNIQUE_SKILLS_DIRS[@]:-}"; do
    if [[ "$existing" == "$candidate" ]]; then
      return 0
    fi
  done

  return 1
}

UNIQUE_SKILLS_DIRS=()

for skills_dir in "${SKILLS_DIRS[@]}"; do
  if is_duplicate_dir "$skills_dir"; then
    continue
  fi

  UNIQUE_SKILLS_DIRS+=("$skills_dir")
  link_all_skills "$skills_dir"
done
