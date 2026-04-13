# repo-docs-skill

Agent skills for keeping repo documentation and source code in sync.

## Why use this

The goals are simple but powerful:

- Embrace progressive disclosure to make repo documentation fast to navigate and useful to both humans and agents
- Automatically keep the documentation and source code in sync
- Go from `source code -> docs` to `docs -> source code`. When source code is derived from the docs, English becomes the programming language.

## Install

`npx skills add mjamore/repo-docs-skill`

Or clone the repo and symlink the files to all common agent skill directories.

```bash
  git clone git@github.com:mjamore/repo-docs-skill.git
  cd repo-docs-skill
  ./install.sh
```

By default this symlinks the following directories:

```text
~/.agents/skills/
~/.claude/skills/
~/.codex/skills/
~/.copilot/skills/
~/.cursor/skills/
~/.gemini/skills/
~/.github/skills/
~/.opencode/skills/
~/.warp/skills/
```

Because the skills are installed as symlinks with `install.sh`, just run it once and any future edits you make to the repo skill files will be instantly available to all coding agents.

## Included skills

This repo contains two skills:

### `/repo-docs`

Use this when a repo should follow a doc-first workflow. Ideally add at the start of your projects, but you can add it any time.

It teaches the agent to:

1. Autonomously maintain `/docs/plans` and `docs/specs` when the user requests changes, keeping the docs and source code always in sync.
2. View the docs as the source of truth. Source code is derived from the docs, not the other way around.
3. Prompt the user when docs and source code are out of sync.

### `/repo-docs-audit`

Use this after code or doc changes when you need a read-only verification pass.

It checks:

- current work-in-progress links
- plan/spec alignment
- whether implementation changed without matching doc updates
- whether a plan is actually ready to archive

## Repo layout

```text
repo-docs/
  SKILL.md
  agents/openai.yaml

repo-docs-audit/
  SKILL.md
  agents/openai.yaml

install.sh
```

## Usage

Add "Always use the `/repo-docs` skill" to your `AGENTS.md` to have your agent automatically keep your docs and source code in sync and notify you of any discrepancies.

You can invoke `/repo-docs-audit` any time to perform an audit and surface any discrepancies between the docs and the source code so they can be resolved.
