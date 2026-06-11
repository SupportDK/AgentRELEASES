---
description: Fast-track automated release for a bug — minimal brief, fix, patch bump, publish
argument-hint: WPC-123 | <plugin name>
---

# /hotfix $ARGUMENTS

Fast-track release pipeline for a bug. Fully automatic — invoking this command is the user's approval for push and publication.

Same structure as `/release` with these differences:

## Phase 0 — Target repository resolution

Same as `/release`: parse `$ARGUMENTS` (Linear issue ID or plugin display name) and apply the **Repository Resolution Rules** and **Repository Acquisition Workflow** from the root `CLAUDE.md`. Clone/update into `repos/<repository>/`, checkout the default branch. All git work happens inside that directory.

## Phase 1 — Product Owner: minimal brief

Delegate to the **product-owner** agent:
- Read the resolved Linear issue. Confirm it describes a **bug** (reproduction, expected vs actual). If it is not a bug, stop and suggest `/release` instead.
- Extract minimal acceptance criteria: the bug no longer reproduces + no regression in directly related behavior. No full User Story required.

## Phase 2 — Branch

> ⚠️ Temporary testing convention (same as `/release`): all pushes go to `test/<version>` — never to `main` or `hotfix/*`.

```bash
git checkout -b test/<version>
```

`<version>` = current header version + mandatory patch bump (e.g. `test/2.5.2`).

## Phase 3 — Developer: fix

Delegate to the **developer** agent:
- Smallest possible fix. No refactors, no cleanup, no improvements beyond the fix.
- Commit prefix `fix:`.

## Phase 4 — Product Owner: regression-focused review

- Verify the fix addresses the reported bug.
- Verify nothing outside the fix's scope was touched (diff should be minimal).
- Maximum **1 fix cycle** — hotfixes that need more rework should go through `/release`.

## Phase 5 — Patch release (main session)

Only after APPROVED:

1. Version bump: **patch is mandatory** (X.Y.Z → X.Y.Z+1).
2. Package ZIP (per `/package` procedure).
3. Push branch + tag `vX.Y.Z+1`.
4. GitHub Release on the target plugin repository (`wpconnect-co/<repository>`) with the ZIP attached.

## Phase 6 — Documentation

Delegate to the **documentation** agent: changelog entry (`fix: …`), short release notes. Skip README updates unless the fix changes documented behavior.

## Phase 7 — Close the loop

Comment + status "Done" on the Linear issue.

## Final report

Same table as `/release` (includes repository, branch, commit hash, ZIP location).

## Failure handling

Same as `/release`, with the stricter limit: 1 failed review cycle → ABORT and recommend `/release`.
