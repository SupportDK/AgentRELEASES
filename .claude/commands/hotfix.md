---
description: Fast-track Phase 1 for a bug — minimal brief, fix, patch bump, test ZIP. STOPS for human QA; finalize with /tested.
argument-hint: WPC-123 | <plugin name>
---

# /hotfix $ARGUMENTS

Fast-track Phase 1 pipeline for a bug. Like `/release`, it **STOPS after preparing the test package** — the release is finalized manually with `/tested <plugin> <version>` after human QA.

Same structure as `/release` with these differences:

## Phase 0 — Target repository resolution

Same as `/release`: parse `$ARGUMENTS` (Linear issue ID or plugin display name) and apply the **Repository Resolution Rules** and **Repository Acquisition Workflow** from the root `CLAUDE.md`. Clone/update into `repos/<repository>/`, checkout the default branch. All git work happens inside that directory.

## Phase 1 — Product Owner: minimal brief

Delegate to the **product-owner** agent:
- Read the resolved Linear issue. Confirm it describes a **bug** (reproduction, expected vs actual). If it is not a bug, stop and suggest `/release` instead.
- Extract minimal acceptance criteria: the bug no longer reproduces + no regression in directly related behavior. No full User Story required.

## Phase 2 — Branch

```bash
git checkout -b release/<version>
```

`<version>` = current header version + mandatory patch bump (e.g. `release/2.5.2`). Pushes only ever go to `release/<version>` — never to `main`.

## Phase 3 — Developer: fix

Delegate to the **developer** agent:
- Smallest possible fix. No refactors, no cleanup, no improvements beyond the fix.
- Commit prefix `fix:`.

## Phase 4 — Product Owner: regression-focused review

- Verify the fix addresses the reported bug.
- Verify nothing outside the fix's scope was touched (diff should be minimal).
- Maximum **1 fix cycle** — hotfixes that need more rework should go through `/release`.

## Phase 5 — Test package (main session)

Only after APPROVED:

1. Version bump: **patch is mandatory** (X.Y.Z → X.Y.Z+1), updated in the plugin header.
2. Package ZIP per the `/release` Phase 5 procedure (`wp dist-archive` preferred) and rename to `<main-plugin-file-without-.php>.<version>.zip`.
3. Push the branch `release/<version>`. **No tag, no GitHub Release** — those belong to `/tested`.

## Phase 6 — Linear updates (main session)

Same as `/release` Phases 7–8:

- Move the bug issue to **For Test**.
- Create the QA issue `Update <Plugin Name> <Version>` → **For Test**, with the ZIP attached or referenced.
- README issue handling if the fix changed readme content (rare for hotfixes).

## STOP — restrictions

Same as `/release`: no tag, no GitHub Release, no merges, no deploys, no closing issues. Output the same "Status: Waiting for human QA" summary, ending with:

```text
Next step after human testing:
/tested <plugin> <version>
```

## Failure handling

Same as `/release`, with the stricter limit: 1 failed review cycle → ABORT and recommend `/release`.
