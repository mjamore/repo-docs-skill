#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="${CODEX_HOME:-$HOME/.codex}/skills"

link_skill() {
  local name="$1"
  local source="$REPO_ROOT/$name"
  local target="$SKILLS_DIR/$name"

  if [[ ! -d "$source" ]]; then
    echo "Missing skill source: $source" >&2
    exit 1
  fi

  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"
    if [[ "$current" == "$source" ]]; then
      echo "$name already linked"
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
  echo "Linked $name"
}

mkdir -p "$SKILLS_DIR"
link_skill "repo-docs"
link_skill "repo-docs-audit"
