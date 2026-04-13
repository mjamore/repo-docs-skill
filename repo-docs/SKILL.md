---
name: repo-docs
description: Docs -> source code. Keep documentation and source code in sync at all times. Centered on `/docs` directory. Use when a repo should follow the doc-first system with `AGENTS.md`, `/docs/WORK_IN_PROGRESS.md`, plan docs, and spec docs; when docs structure is missing; when code changes require matching doc updates; when spec ownership or progressive disclosure links need upkeep; or when a task may need a plan.
---

# Repo Docs

Keep repo docs aligned with code. Follow doc-first workflow. Keep docs concise. Prefer progressive disclosure.

## Core Path

Read in this order:

1. `AGENTS.md`
2. This skill
3. `/docs/WORK_IN_PROGRESS.md`
4. Linked plan doc if one exists for active item relevant to current task
5. Otherwise scan `/docs/specs/` for relevant context to current task
6. Code only after docs path is clear

Read only next relevant doc.

If `/docs/WORK_IN_PROGRESS.md` has no active item relevant to the current task, scan `/docs/specs/` for the closest owning spec docs before reading code.

## Bootstrap

If repo is missing doc scaffold, create it.

If practical, ask user first. If not practical, create it anyway.

Bootstrap scaffold:

- `AGENTS.md`
- `/docs/README.md`
- `/docs/WORK_IN_PROGRESS.md`
- `/docs/TODO.md`
- `/docs/FEATURE_IDEAS.md`
- `/docs/plans/`
- `/docs/plans/archived/`
- `/docs/specs/`

Bootstrap rules:

- If `AGENTS.md` exists but does not mention `/repo-docs`, add only: `Always use the \`/repo-docs\` skill.`
- If `AGENTS.md` does not exist, create minimal file with only that instruction.
- Create `/docs/README.md` to explain the /docs directory for humans. Keep it short, under 50 lines.
- Leave `/docs/plans/` and `/docs/specs/` empty until real docs are needed.
- Create `/docs/TODO.md` and `/docs/FEATURE_IDEAS.md` during bootstrap only with placeholder checklist items
- After bootstrap, treat `/docs/TODO.md` and `/docs/FEATURE_IDEAS.md` as read-only and maintained by humans.

## Work In Progress

`/docs/WORK_IN_PROGRESS.md` is source of truth for current active work.

Required structure:

- file title
- `## Active Items`
- each item has following bullet points:
  - short task line
  - `Created` and `Last Updated` timestamps in Los Angeles time
  - links to plan doc and/or relevant spec docs

Rules:

- No status tags.
- Timestamps belong to each item, not file header.
- No direct code references.
- Keep progressive disclosure intact by linking onward to plan/spec docs.
- Use relative markdown links to plan/spec docs from the current file. Never use `/docs/...` or filesystem absolute paths for doc-to-doc links.
- If no active item in `/docs/WORK_IN_PROGRESS.md` matches the current task, fall back to scanning `/docs/specs/` for relevant context.

## Link Rules

For links between markdown docs in repo docs:

- use relative paths from current file
- never use repo-root absolute paths like `/docs/specs/foo-spec.md`
- never use filesystem absolute paths
- update affected relative links in same change when files move or rename

## Plans

Do not require plan for every change.

Skip plan when change is small, localized, or already fully explained by existing spec docs.

Create or offer a plan when change is:

- multi-step
- cross-cutting
- user-facing behavior change
- unclear
- risky
- tradeoff-heavy

If task seems significant enough to warrant plan, prompt user and offer to create one.

Plan rules:

- path: `/docs/plans/`
- archive path: `/docs/plans/archived/`
- filename: `[relevant-part-of-code]-[brief-description]-plan.md`
- first line is title
- next lines are markdown bullets for `Created` and `Last Updated` in Los Angeles time
- sections in order:
  - `## TLDR`
  - `## Current State`
  - `## Desired State`
  - `## Goals`
  - `## Options Considered`
  - `## Unknowns / Risks / Questions`
  - `## Changes To Be Made`

Plan content rules:

- Explain what and why.
- Keep direct code references minimal or none.
- Link to relevant spec docs from `Current State` using relative markdown links.
- Keep `Created` and `Last Updated` as separate markdown bullets at the top of the plan.
- Add `Archived` bullet only when the plan is archived.
- Use checklist items in `Changes To Be Made` to track progress towards completion.
- Treat each plan file as durable record for one scope of work.
- If newly discovered work is still same scope, extend the existing active plan instead of replacing it.
- If newly discovered work is different scope or materially expands scope, create a new plan instead of overwriting the existing one.

Archive rule:

- When planned code/docs work is complete and `/docs/specs/` reflects final behavior, ask user whether to archive plan.
- Never ask user to archive unless all plan checklist items are completed.
- Never ask user to archive unless finished work is fully covered by the current `/docs/specs/` state. Update specs first, whether that means creating, editing, moving, merging, splitting, or deleting docs.
- When archiving a plan, add an `- Archived: ...` timestamp in Los Angeles time directly under `- Last Updated: ...` at the top of the document before moving it to `/docs/plans/archived/`.
- Once plan is complete, do not overwrite or repurpose that file with new scope.
- If user does not archive because more same-scope work is needed, add new checklist items to that plan and keep it active.
- If user does not archive because follow-on work is new scope, keep completed plan intact and create a new plan.

## Specs

Specs are source of truth for intended application behavior.

Rules:

- path: `/docs/specs/`
- filename: `*-spec.md`
- first line is title
- next two lines are bullet points: `- Created: ...` and `- Last Updated: ...` in Los Angeles time
- required early sections:
  - `## TLDR`
  - `## Contents`
- required last section:
  - `## Other Relevant Spec Documents`

Spec structure rules:

- Keep most important information near top.
- Use headings, bold text, and links to add meaning to text (importance/hierarchy/relationships).
- Link to relevant code files. Do not paste code into specs.
- Keep enough detail to derive intended behavior, not 1:1 source mapping.
- Do not leave `Created` and `Last Updated` as plain lines. They must each be their own markdown bullet.

Spec ownership rules:

- Default: update existing relevant spec docs.
- Create new spec doc when no current spec cleanly owns feature or area.
- Split, merge, move, or delete spec docs only when current structure hurts progressive disclosure enough to justify it.
- When restructuring specs, update all affected links in same change.
- Before any plan is archive-ready, ensure finished work is covered by the resulting `/docs/specs/` structure, even if that requires spec reorganization.

## Conflict Rule

If specs and code conflict, stop and ask user every time before changing either.

No exceptions.

## Doc Style

Use caveman style.

Rules:

- concise
- no bloated background
- answer what
- answer why when needed
- optimize for humans and agents
- use markdown structure to add meaning to text and for progressive disclosure and discoverability

## Closeout

When task changes code or repo docs:

1. update repo docs to final state, including any `/docs/specs/` create, edit, move, merge, split, or delete work needed so finished behavior is documented
2. run `/repo-docs-audit`
3. if audit passes and relevant plan exists with all checkboxes complete, output the relative repo paths of every spec doc updated for this task. If none were updated, explicitly say so
4. after outputting those spec doc paths, ask user whether to archive the plan
5. if user wants to keep working and scope is same, reopen that plan by adding explicit new checklist items
6. if user wants to keep working and scope is new, create a new plan and keep completed one intact
7. if audit passes and no plan is archive-ready, inform the user that the docs and code are in sync - "Validated that /docs and source code are in sync."
8. if audit fails, notify user of discrepancies so they can provide the correct direction going forward

Skip audit for read-only research or question-only work.
