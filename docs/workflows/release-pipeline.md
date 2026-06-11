# Release Pipeline

Human-readable narrative of what `/release WPC-123` does. The executable definition lives in [.claude/commands/release.md](../../.claude/commands/release.md) — this document explains the *why* and the roles.

---

## Overview

```
Linear Issue ($1)
    │
    ▼
[product-owner]  reads the issue, improves requirements,
    │            writes the Implementation Brief
    ▼
[main session]   creates branch release/$1
    │
    ▼
[developer]      implements the brief, self-reviews,
    │            commits locally (never pushes)
    ▼
[product-owner]  reviews every acceptance criterion
    │            PASS → continue · FAIL → back to developer (max 2 cycles)
    ▼
[main session]   version bump → ZIP → push → tag →
    │            GitHub Release on supportdk/AgentRELEASES
    ▼
[documentation]  CHANGELOG, release notes, docs, Notion page
    │
    ▼
[main session]   closes the Linear issue with the release link
```

## Design principles

- **The command orchestrates; agents work.** No agent knows the full pipeline — each receives its inputs and returns its outputs. The main session sequences phases and handles git/GitHub/Linear side effects.
- **The developer never pushes.** Push, tags, and releases are main-session actions. This keeps the developer agent safe to use standalone.
- **Invoking the command IS the approval.** `/release` and `/hotfix` are fully automatic by user decision. There are no intermediate confirmation gates — the safety net is the PO review (max 2 fix cycles, then abort before anything is pushed).
- **Abort before publish.** Any failure before Phase 5 leaves only local artifacts (branch + commits). Nothing is published unless the review passed.

## Roles per phase

| Phase | Actor | Input | Output |
|---|---|---|---|
| Brief | product-owner | Linear issue | Implementation Brief |
| Branch | main session | — | `release/$1` |
| Implement | developer | Brief | commits + Implementation Summary |
| Review | product-owner | Summary + diff | APPROVED / REJECTED |
| Publish | main session | approved work | version, ZIP, tag, GitHub Release |
| Document | documentation | Summary + version | CHANGELOG, release notes, Notion |
| Close | main session | release URL | Linear issue → Done |

## Variants

- **`/feature`** — stops after the review: push + PR, no version bump, no release. For work that merges via PR review.
- **`/hotfix`** — minimal brief, mandatory patch bump, only 1 fix cycle allowed. For urgent bugs.
- **`/issue`** — only the brief phase. For refining requirements before deciding.
