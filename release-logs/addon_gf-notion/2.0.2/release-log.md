# Release log — GF Notion 2.0.2 (hotfix)

Repository: wpconnect-co/addon_gf-notion
Branch: release/2.0.2
Commit: 9fca157 (history: 132390d GFNO-103 fix, 9fca157 WP 7.1)
Date: 2026-08-24

## QA Tracking

QA Issue:
Update GF Notion 2.0.2

Linear ID:
GFNO-104  (https://linear.app/wp-connect/issue/GFNO-104/update-gf-notion-202)

Linear Project:
GF Notion v2.0.2

Status:
Done (released)

ZIP:
wpconnect-gf-notion.2.0.2.zip (attached to GFNO-104; also on the GitHub Release)

Tag:
2.0.2 (created by the pipeline on merge of PR #19)

GitHub Release:
https://github.com/wpconnect-co/addon_gf-notion/releases/tag/2.0.2

Deploy:
wpconnect.co deploy success (pipeline run 32723761020) + InstaWP staging refresh success (run 32723760461)

## Scope (hotfix)

- GFNO-103 — Notion API 401: Authorization without Bearer (`api-notion.php:62`) + `sleep(0.25)` → `usleep(250000)` (`:146`). Same defect and fix pattern as CF7 Notion 1.6.3 (CF7NO-85, commit c5c3349).
- Compatibility with WordPress 7.1 (`Tested up to: 7.1`).
- GFNO-105 — Readme issue created (none pre-existed in the project) with the 2.0.2 changelog block, For Test.

## Context

Notion enforces the Bearer scheme since ~11 Aug 2026 (wp.org ticket on CF7 Notion). Sibling sweep status: CF7 Notion 1.6.3 in QA (CF7NO-86); **addon_forms-notion still PENDING the same hotfix** (`includes/classes/class-api-notion.php:69`); notion-wp-sync/pro not affected (already Bearer).

## PO Stories

No /stories run — hotfix with minimal brief (PO agent validated bug + brief, review APPROVED 6/6).

## Workflow Status History

| Issue | Transition | Timestamp (UTC) |
|---|---|---|
| GFNO-103 | created (Backlog) | 2026-08-24 11:31:02 |
| GFNO-103 | Backlog → In Progress | 2026-08-24 11:32:23 |
| GFNO-103 | In Progress → For Test | 2026-08-24 11:35:25 |
| GFNO-104 (QA) | created → For Test | 2026-08-24 11:35:32 |
| GFNO-105 (Readme) | created → For Test | 2026-08-24 11:35:57 |
| GFNO-103 | For Test → Done | 2026-08-24 11:49:46 |
| GFNO-104 (QA) | For Test → Done | 2026-08-24 11:49:48 |
| GFNO-105 (Readme) | For Test → Done | 2026-08-24 11:49:49 |

## Finalized

2026-08-24 via /tested: QA confirmed. PR #19 merged; pipeline tagged 2.0.2, created the GitHub Release and deployed to wpconnect.co (Slack success notification); InstaWP staging refreshed. Issues Done, project Completed.
