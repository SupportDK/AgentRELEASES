---
description: Fast-track automated release for a bug — minimal brief, fix, patch bump, publish
argument-hint: WPC-123
---

# /hotfix $ARGUMENTS

Fast-track release pipeline for bug issue **$1**. Fully automatic — invoking this command is the user's approval for push and publication.

Same structure as `/release` with these differences:

## Phase 1 — Product Owner: minimal brief

Delegate to the **product-owner** agent:
- Read issue $1 from Linear. Confirm it describes a **bug** (reproduction, expected vs actual). If it is not a bug, stop and suggest `/release $1` instead.
- Extract minimal acceptance criteria: the bug no longer reproduces + no regression in directly related behavior. No full User Story required.

## Phase 2 — Branch

```bash
git checkout -b hotfix/$1
```

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
4. GitHub Release on `supportdk` with the ZIP attached.

## Phase 6 — Documentation

Delegate to the **documentation** agent: changelog entry (`fix: …`), short release notes. Skip README updates unless the fix changes documented behavior.

## Phase 7 — Close the loop

Comment + status "Done" on Linear issue $1.

## Final report

Same table as `/release`.

## Failure handling

Same as `/release`, with the stricter limit: 1 failed review cycle → ABORT and recommend `/release $1`.
