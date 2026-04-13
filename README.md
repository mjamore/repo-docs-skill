# repo-docs-skill

Shared Codex skills for doc-first repo workflows.

This repo contains two skills:

- `repo-docs`: bootstrap and maintain a `/docs` workflow centered on `AGENTS.md`, `WORK_IN_PROGRESS.md`, plan docs, and spec docs
- `repo-docs-audit`: read-only audit that checks whether current docs and implementation still match

## Why use this

The goals are simple but powerful:

- Embrace progressive disclosure to make repo documentation fast to navigate and useful to both humans and agents
- Automatically keep the documentation and source code in sync
- Go from `source code -> docs` to `docs -> source code`

## Install

This repo ships an installer that symlinks the skills into common agent skill directories.

```bash
  git clone git@github.com:mjamore/repo-docs-skill.git
  cd repo-docs-skill
  ./install.sh
```

By default this links into:

```text
~/.agents/skills/
~/.copilot/skills/
~/.gemini/skills/
~/.claude/skills/
~/.codex/skills/
```

You can override the Codex target with `CODEX_HOME`.

```bash
CODEX_HOME=/path/to/codex-home ./install.sh
```

Because the skills are installed as symlinks, edits in this repo are reflected immediately in each linked tool. There is no separate copy to refresh.

## Included skills

### `repo-docs`

Use this when a repo should follow a doc-first workflow.

It teaches the agent to:

1. read `AGENTS.md`
2. read active docs before code
3. maintain `/docs/WORK_IN_PROGRESS.md`
4. create plans only when they add value
5. treat spec docs as the source of truth
6. stop and ask the user if specs and code conflict

### `repo-docs-audit`

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

Reference the skill from a repo's `AGENTS.md`.

```md
Always use the `/repo-docs` skill.
```

Then call `repo-docs-audit` as part of closeout whenever code or repo docs changed.

## Contributing

Keep changes small and concrete. Favor clarity over completeness. If you change the workflow rules, update the skill docs directly instead of adding explanation drift elsewhere.
