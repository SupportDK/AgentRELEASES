---
description: PO story refinement — review the Linear issues of a plugin version and improve them into clear, complete user stories before development
argument-hint: <plugin> <version>   (e.g. WPForms Notion 1.4.1)
---

# /stories $ARGUMENTS

Review all Linear issues associated with plugin version **$ARGUMENTS** and improve their descriptions into clear, detailed user stories. PO phase only — no implementation, no status changes, no branches.

## Phase 1 — Discovery

1. Resolve the plugin via the Repository Resolution Rules in the root `CLAUDE.md` (for naming consistency; no cloning needed).
2. Delegate to the **product-owner** agent: search Linear for the issues related to `<plugin> <version>` (plugin name in title/body/labels, version references, project/release association).
3. Present the list found. If nothing matches, ask the user which issues to review.

## Phase 2 — Quality triage (product-owner)

For each issue, classify:

- **Needs refinement** — vague, incomplete, missing acceptance criteria, one-liner descriptions.
- **Already well-written** — leave mostly unchanged; do not rewrite for the sake of it.

**Confirmation gate:** if more than 5 issues need updating, present the triage and ask the user for confirmation before bulk-updating.

## Phase 3 — Refinement (product-owner)

For each issue needing refinement, rewrite the description following this structure:

```markdown
## User Story

As a <user/admin/developer/site owner>,
I want <capability/change>,
so that <business/user value>.

## Context

<Explain the background and why this issue exists.>

## Scope

### In scope

- ...

### Out of scope

- ...

## Acceptance Criteria

- [ ] ...
- [ ] ...
- [ ] ...

## Technical Notes

- ...

## Testing Notes

- ...

## Dependencies / Open Questions

- ...
```

**Hard rules:**

- **Never invent requirements** not implied by the issue, the project, or the plugin context. Anything unclear goes under `## Dependencies / Open Questions` — never invented.
- **Preserve important original text** — improve structure, clarity and completeness; do not discard the author's intent or details.
- Add technical context only if available (codebase, plugin docs, related issues).
- Do not change status, priority, assignee, or project — description only.

## Phase 4 — Apply updates (main session)

For each refined issue: `mcp__linear__save_issue` with `id` + the new `description`. Verify each update by fetching the issue back.

## Phase 5 — PO stories log

Create/update `release-logs/<plugin-slug>/<version>/po-stories.md` in the workspace and commit it:

```markdown
# PO Stories — <Plugin Name> <Version>

## Issues Reviewed

- <issue key>: <title>

## Issues Updated

- <issue key>: <what changed>

## Issues Left Unchanged

- <issue key>: <reason>

## Open Questions Added

- <issue key>: <question>

## Summary

...
```

## Final output

- Table: issue key · title · action (updated / unchanged) · open questions added
- Path to `po-stories.md`
- Suggested next step: `/release <plugin> <version>` when the stories are ready

## Failure handling

- Linear update fails for an issue → report it per-issue; continue with the rest; list failures at the end.
- Never silently skip an issue from the triage list.
