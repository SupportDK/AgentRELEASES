# Release log — GF Notion 2.0.1

Repository: wpconnect-co/addon_gf-notion
Branch: release/2.0.1
Commit: a214c31
Date: 2026-07-20

## QA Tracking

QA Issue:
Update GF Notion 2.0.1

Linear ID:
GFNO-101 (https://linear.app/wp-connect/issue/GFNO-101/update-gf-notion-201)

Linear Project:
GF Notion v2.0.1

Status:
For Test

ZIP:
wpconnect-gf-notion.2.0.1.zip

SHA256:
35b1679b254fddc2fbcdbba4ff7a1ffa65f2b395bc2ce70c5f6fd56f1fbb5032

## PO Stories

No /stories run for this version. Single scoped issue GFNO-96 (XS).

## Scope

- GFNO-96 — Align platform requirements: `Tested with Gravity Forms up to: 2.10` (was 2.9.24); `Requires PHP: 7.4` confirmed in header + readme. Version bumped 2.0.0 → 2.0.1.
- GFNO-99 — Added Support + Documentation links to the plugin Settings page (GF > Settings > Notion, new "Help" section). Commit `17cfec1`.
- GFNO-102 — Readme issue (changelog 2.0.1) for docs automation.

## Why 2.0.1 (deploy context)

GF Notion 2.0.0 was tagged and had its GitHub Release published, but the `deploy-to-wpconnect` job of run #13 (2026-06-17) FAILED (`{"code":453}` from wpconnect.co). The run is >30 days old so GitHub blocks re-running it, and the reusable deploy workflow is `workflow_call` only (not manually dispatchable). This 2.0.1 release carries a real change (GFNO-96) and, when finalized via `/tested` (merge release/2.0.1 → main), re-runs `auto-tag-and-release` + `deploy-to-wpconnect` for 2.0.1.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| GFNO-96 | Backlog → In Progress | 2026-07-20T19:22:39Z |
| GFNO-96 | In Progress → For Test | 2026-07-20T19:24:15Z |
| GFNO-101 | created → For Test | 2026-07-20T19:24:23Z |
| GFNO-102 | created → For Test (Readme) | 2026-07-20T19:25:17Z |
| GFNO-99 | Backlog → In Progress | 2026-07-20T19:27:57Z |
| GFNO-99 | In Progress → For Test | 2026-07-20T19:30:37Z |
