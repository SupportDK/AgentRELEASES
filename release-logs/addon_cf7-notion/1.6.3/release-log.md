# Release log — CF7 Notion 1.6.3 (hotfix)

Repository: wpconnect-co/addon_cf7-notion
Branch: release/1.6.3
Commit: f7c3f9a (history: c5c3349 CF7NO-85 fix, f7c3f9a WP 7.1 + readme changelog order)
Date: 2026-08-24

## QA Tracking

QA Issue:
Update CF7 Notion 1.6.3

Linear ID:
CF7NO-86  (https://linear.app/wp-connect/issue/CF7NO-86/update-cf7-notion-163)

Linear Project:
CF7 Notion v1.6.3

Status:
Done (released)

ZIP:
add-on-cf7-for-notion.1.6.3.zip (attached to CF7NO-86; also on the GitHub Release)

Tag:
1.6.3 (created by the pipeline on merge of PR #13)

GitHub Release:
https://github.com/wpconnect-co/addon_cf7-notion/releases/tag/1.6.3

wp.org:
deployed — trunk Stable tag 1.6.3, Tested up to 7.1 (pipeline run 32723558755)

## Scope (hotfix)

- CF7NO-85 — Notion API calls fail with 401: Authorization header sent without "Bearer" prefix (Bug, from wp.org support ticket https://wordpress.org/support/topic/1-6-2-sends-notion-token-without-bearer-every-api-call-fails-with-401/). Fix: Bearer scheme with double-prefix guard (`class-api-notion.php:65`) + `sleep(0.25)` → `usleep(250000)` (`:163`).
- Compatibility with WordPress 7.1 (`Tested up to: 7.1`) — added on user request.
- CF7NO-83 — New Strings to translate: answered NO (comment on the issue).
- CF7NO-82 — Readme: changelog block set, For Test. (Note: CF7NO-81 is a duplicate "Readme" issue in the same project, left untouched.)

## Context

Notion enforces the `Bearer` scheme on the Authorization header since ~11 Aug 2026; the plugin always sent the bare token, so 1.6.2 is fully broken in production. Siblings with the SAME bug (bare token) detected during this hotfix: **addon_forms-notion** (`includes/classes/class-api-notion.php:69`) and **addon_gf-notion** (`includes/classes/api-notion.php:62`) — pending their own hotfixes. `notion-wp-sync` already uses Bearer correctly.

## PO Stories

No /stories run — hotfix with minimal brief (PO agent validated the bug and produced the brief inline).

## Workflow Status History

| Issue | Transition | Timestamp (UTC) |
|---|---|---|
| CF7NO-85 | created (Backlog) | 2026-08-24 11:21:28 |
| CF7NO-85 | Backlog → In Progress | 2026-08-24 11:22:54 |
| CF7NO-85 | In Progress → For Test | 2026-08-24 11:27:00 |
| CF7NO-86 (QA) | created → For Test | 2026-08-24 11:27:10 |
| CF7NO-82 (Readme) | Backlog → For Test | 2026-08-24 11:27:30 |
| CF7NO-83 (Strings) | Backlog → For Test | 2026-08-24 11:27:44 |
| CF7NO-85 | For Test → Done | 2026-08-24 11:47:40 |
| CF7NO-86 (QA) | For Test → Done | 2026-08-24 11:47:41 |
| CF7NO-82 (Readme) | For Test → Done | 2026-08-24 11:47:42 |
| CF7NO-83 (Strings) | For Test → Done | 2026-08-24 11:47:43 |

## Finalized

2026-08-24 via /tested: QA confirmed. PR #13 merged; pipeline tagged 1.6.3, created the GitHub Release and deployed to wp.org (verified: trunk Stable tag 1.6.3 / Tested up to 7.1). Issues Done. CF7NO-81 (duplicate Readme) linked as duplicate of CF7NO-82 (already archived).
