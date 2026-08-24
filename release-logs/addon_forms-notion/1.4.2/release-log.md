# Release log — WPForms Notion 1.4.2 (hotfix)

Repository: wpconnect-co/addon_forms-notion
Branch: release/1.4.2
Commit: ee7417e (history: 33a9592 WPFNO-37 fix, ee7417e WP 7.1)
Date: 2026-08-24

## QA Tracking

QA Issue:
Update WPForms Notion 1.4.2

Linear ID:
WPFNO-38  (https://linear.app/wp-connect/issue/WPFNO-38/update-wpforms-notion-142)

Linear Project:
WPForms Notion v1.4.2

Status:
For Test

ZIP:
wpconnect-wpf-notion.1.4.2.zip (attached to WPFNO-38; local copy in dist/)

## Scope (hotfix)

- WPFNO-37 — Notion API 401: Authorization without Bearer (`class-api-notion.php:69`) + `sleep(0.25)` → `usleep(250000)` (`:170`). Third sibling of CF7NO-85 / GFNO-103.
- Compatibility with WordPress 7.1 (`Tested up to: 7.1`).
- WPFNO-39 — Readme issue created (none pre-existed) with the 1.4.2 changelog block, For Test.

## Context

Notion enforces the Bearer scheme since ~11 Aug 2026 (wp.org ticket on CF7 Notion). Sibling sweep COMPLETE: CF7 Notion 1.6.3 (CF7NO-86), GF Notion 2.0.2 (GFNO-104), WPForms Notion 1.4.2 (WPFNO-38) — all three in QA. notion-wp-sync / notion-wp-sync-pro not affected (already use Bearer).

## PO Stories

No /stories run — hotfix with minimal brief (PO validated bug; review APPROVED 6/6).

## Workflow Status History

| Issue | Transition | Timestamp (UTC) |
|---|---|---|
| WPFNO-37 | created (Backlog) | 2026-08-24 11:37:42 |
| WPFNO-37 | Backlog → In Progress | 2026-08-24 11:39:04 |
| WPFNO-37 | In Progress → For Test | 2026-08-24 11:42:11 |
| WPFNO-38 (QA) | created → For Test | 2026-08-24 11:42:17 |
| WPFNO-39 (Readme) | created → For Test | 2026-08-24 11:42:37 |

## Next step

Human QA on the attached ZIP, then `/tested WPForms Notion 1.4.2`.
Note: repo has tag-and-deploy.yml — /tested must merge the release PR, NOT tag manually.
