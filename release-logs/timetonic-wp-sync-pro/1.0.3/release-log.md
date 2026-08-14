# Release log — TimeTonic WP Sync 1.0.3

Repository: wpconnect-co/timetonic-wp-sync-pro
Branch: release/1.0.3
Commit: 09d117fc6d18dc19a466a0f72df439c370e07bc6
Date: 2026-08-14

## QA Tracking

QA Issue:
Update TimeTonic WP Sync 1.0.3

Linear ID:
TIM-111 (https://linear.app/wp-connect/issue/TIM-111/update-timetonic-wp-sync-103)

Linear Project:
TimeTonic WP Sync v1.0.3

Status:
For Test

ZIP:
timetonic-wp-sync.1.0.3.zip (attached to TIM-111; local: dist/timetonic-wp-sync.1.0.3.zip)

Plugin dirname inside ZIP: timetonic-wp-sync

## Scope

| Issue | Type | Summary |
|---|---|---|
| TIM-61 | Compatibility | Compatibility with WordPress 7.0 (`Tested up to: 7.0` in header + readme, made consistent) |
| TIM-21 | Fix | PHP 8.2 deprecation notices — declared previously-dynamic properties `source_field` + `taxonomy` on base `Timetonic_WP_Sync_Import_Context` |

## Version note

1.0.1 (Apr 2025) and 1.0.2 (Oct 2025) were already released; `main` was at 1.0.2. The requested "1.0.1" was already shipped, so this release is the correct next patch **1.0.3**. The Linear project was **renamed from "TimeTonic WP Sync v1.0.1" to "TimeTonic WP Sync v1.0.3"** (id 80780d64-4dbf-4a05-8cc6-2654e710b5af) to match.

## README issue

TIM-110 "Readme" — updated with the 1.0.3 changelog block, moved to For Test.

## PO Stories

No /stories run for this version. PO review (Phase 4): APPROVED. Independent project-wide scan found no other undeclared assigned properties and no __get/__set. QA advisory: run one full sync under PHP 8.2 with WP_DEBUG_LOG to confirm no Deprecated notices remain.

## Workflow Status History

| Issue | Transition | Timestamp (UTC) |
|---|---|---|
| TIM-61 | Backlog → In Progress | 2026-08-14T10:44:31Z |
| TIM-21 | Backlog → In Progress | 2026-08-14T10:44:32Z |
| TIM-61 | In Progress → For Test | 2026-08-14T10:57:01Z |
| TIM-21 | In Progress → For Test | 2026-08-14T10:57:03Z |
| TIM-111 (QA) | created → For Test | 2026-08-14T10:57:15Z |
| TIM-110 (Readme) | Backlog → For Test | 2026-08-14T10:57:42Z |

## Next step

After human QA approval: `/tested TimeTonic WP Sync 1.0.3` (tags v1.0.3, moves issues to terminal state, updates this log). `/release` did NOT tag, release, or close anything.
