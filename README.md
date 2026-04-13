# repo-docs-skill

Agent skills for keeping repo documentation and source code in sync and deriving source code from documentation, not the other way around.

## Why should I use this?

If you've ever experienced the pain of any of the following when using AI agents for coding, you will find this skill helpful:

- Documentation and source code drift, causing confusion for both humans and agents about the intended behavior of the application.
- Constantly reminding the agent to update the documentation after every code change.
- Documentation is unorganized, bloated, and hard to navigate.
- Asking the agent to audit the docs and code to find discrepancies.
- Feeling unsure if your documentation accurately reflects the current state of the codebase.

The solutions are simple, but powerful:

- Embrace progressive disclosure to make repo documentation fast to navigate and useful to both humans and agents
- Automatically keep the documentation and source code in sync
- Go from `source code -> docs` to `docs -> source code`. This paradigm is clearly established by this skill. The agent understand how to write detailed enough documentation to effectively derive source code from it. When source code is derived from the docs, English becomes the programming language.

## Install

```bash
npx skills add mjamore/repo-docs-skill

OR

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
2. Use relative markdown links between repo docs to preserve progressive disclosure when files move or are reused.
3. Treat plans as durable records: extend same-scope plans, but do not overwrite completed plans with new scope. Ask before archiving.
4. View the docs as the source of truth. Source code is derived from the docs, not the other way around.
5. Prompt the user when docs and source code are out of sync.

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
