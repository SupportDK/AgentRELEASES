# Release Pipeline

Human-readable narrative of the two-phase release lifecycle. The executable definitions live in [.claude/commands/release.md](../../.claude/commands/release.md) and [.claude/commands/tested.md](../../.claude/commands/tested.md) — this document explains the *why* and the roles.

---

## Lifecycle

```
/release <plugin> <version>
    ↓
Development
    ↓
Branch pushed to test/<version>
    ↓
ZIP generated
    ↓
Issues moved to For Test
    ↓
QA issue created
    ↓
Human tests ZIP              ← QA APPROVAL GATE
    ↓
/tested <plugin> <version>   ← manual trigger only
    ↓
Tag created
    ↓
Tag pushed
    ↓
Issues moved to Closed
    ↓
Release completed
```

## Phase 1 — `/release <plugin> <version>`

Prepares a version for testing. Example: `/release wpforms-notion 1.4.1`

| Step | Actor | What happens |
|---|---|---|
| Resolve | main session | Plugin → `wpconnect-co/<repo>` (CLAUDE.md mapping), clone into `repos/` |
| Discover | product-owner | Finds the Linear issues for this plugin+version, improves them, writes the brief |
| Start | main session | Issues in scope → **In Progress** (work has visibly started) |
| Branch | main session | `test/<version>` (e.g. `test/1.4.1`) |
| Implement | developer | Changes + plugin readme/changelog + version bump in header, local commits |
| Review | product-owner | Acceptance criteria PASS/FAIL (max 2 fix cycles, then abort) |
| Package | main session | `wp dist-archive` → renamed `<main-file>.<version>.zip` (e.g. `wpconnect-wpf-notion.1.4.1.zip`) → `dist/` |
| Push | main session | `test/<version>` to the plugin repo |
| Linear | main session | Original issues → **For Test** · creates QA issue `Update <Plugin Name> <Version>` (creation **verified** — identifier fetched back, never silently skipped) → **For Test**, ZIP attached via Linear upload + mandatory Testing Package block in the description |
| README issue | main session + documentation | If README content changed: append the standardized block to the README issue description (an external automation consumes it) → **For Test** |
| Release log | main session | Writes `releases/<repo>/<version>/release-log.md` (QA Tracking) + `linear-issues.md` (per-issue status history with timestamps), committed to the workspace |

**Hard stop.** `/release` never: creates/pushes tags, creates GitHub Releases, merges PRs, deploys to WordPress.org/production, or closes Linear issues.

## QA gate (human)

A human installs the ZIP, verifies activation and the changes, and confirms no blockers. Nothing proceeds without this.

## Phase 2 — `/tested <plugin> <version>`

Finalizes after explicit human confirmation. Example: `/tested wpforms-notion 1.4.1`

| Step | What happens |
|---|---|
| Confirm | Requires explicit confirmation that the ZIP was tested and works — asks if missing |
| Verify | `test/<version>` exists on origin · ZIP exists/referenced · issues are in For Test |
| Tag | `v<version>` on the head of `test/<version>`, pushed |
| Release | GitHub Release on the plugin repo only if part of that plugin's documented workflow |
| Close | Original issues + QA issue + README issue → the team's **terminal state** (detected via `list_issue_statuses`, type `completed` — may be Complete/Done/Closed; never hardcoded) |
| Log | Release log updated: terminal transitions appended, tag and release URL recorded |

## Linear status lifecycle

```
Open → In Progress → For Test → Complete/Done/Closed
       (/release      (/release     (/tested succeeds;
        starts)        finishes)     state detected per team)
```

`/tested` is never chained automatically after `/release` — it is always a human decision.

## Variants

- **`/hotfix WPC-123`** — fast-track Phase 1 for bugs: minimal brief, mandatory patch bump, 1 fix cycle max. Also stops at the QA gate; finalized with `/tested`.
- **`/feature WPC-123`** — development + PR, no release lifecycle.
- **`/issue WPC-123`** — brief only.

## Design principles

- **The command orchestrates; agents work.** Branching, packaging, push, tags, Linear status moves are main-session actions. The developer never pushes; the PO never moves issue statuses.
- **The QA gate is structural.** The dangerous actions (tag, release, close) live in a separate command that requires explicit human confirmation.
- **Pushes only to `test/<version>`** — `main`, `release/*`, `feature/*` of the plugin repos are never touched by the workflows.
