---
name: repo-docs-audit
description: Read-only verification of repo documentation against the current work in progress. Use when code or repo docs changed and you need to check whether `/docs/WORK_IN_PROGRESS.md`, linked plan docs, linked spec docs, and implementation still align; when validating progressive disclosure links; when deciding whether a plan is ready to archive; or when the user explicitly asks for a docs/code audit.
---

# Repo Docs Audit

Audit current work in progress only unless asked for a full audit. Stay read-only. Report concrete findings.

## Scope Order

Audit in this order:

1. `/docs/WORK_IN_PROGRESS.md` progressive disclosure path
2. agent touched files for current task
3. git diff

Primary focus is active work, not whole repo.

Do not roam whole repo unless user explicitly asks for full audit.

## Inputs To Follow

Start at `/docs/WORK_IN_PROGRESS.md`.

Then:

- inspect linked active plan docs
- inspect linked active spec docs
- compare those docs against touched code/docs for current task
- use git diff only as lower-priority supporting signal

## What To Check

Check for:

- broken progressive disclosure path
- active work item missing link to plan or relevant spec docs
- plan exists but does not reflect actual work
- plan checklist incomplete while work appears closed out
- spec docs stale relative to implementation
- code behavior changed without matching doc updates
- spec/code conflict
- stale links caused by moved or renamed docs
- missing required doc updates after code change

## Read-Only Rule

Do not patch files.
Do not archive plans.
Do not silently fix docs.

If there is a true spec/code conflict, stop and prompt user.

## Findings Format

If docs and source code match:

- return short confirmation message only
- do not list audited files or scope

If not clean:

- return flat list of concrete findings
- mark each finding `blocking` or `non-blocking`
- for each finding, say:
  - what is conflicting
  - where the discrepancies are
  - ask the user how to proceed

Severity rules:

- `blocking`: spec/code conflict, missing required doc update, broken progressive disclosure link, archive not allowed because plan checklist incomplete
- `non-blocking`: stale wording, weak link structure, minor missing context

## Archive Gate

A plan is only archive-ready when both are true:

- audit is clean
- all plan checkboxes are completed

If both are true, tell calling agent it may ask user whether to archive plan.

If either is false, do not suggest archive.
