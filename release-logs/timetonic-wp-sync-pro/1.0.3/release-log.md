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
Done (released) — finalized via /tested on 2026-08-18

Tag:
1.0.3 (bare, matching repo convention 1.0.0/1.0.1/1.0.2) → 09d117fc6d18dc19a466a0f72df439c370e07bc6

GitHub Release:
TimeTonic WP Sync 1.0.3 — https://github.com/wpconnect-co/timetonic-wp-sync-pro/releases/tag/1.0.3 (ZIP attached)

ZIP:
timetonic-wp-sync.1.0.3.zip (attached to TIM-111 and to the GitHub Release; local: dist/timetonic-wp-sync.1.0.3.zip)

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
| TIM-61 | For Test → Done | 2026-08-18T07:13:48Z |
| TIM-21 | For Test → Done | 2026-08-18T07:13:49Z |
| TIM-111 (QA) | For Test → Done | 2026-08-18T07:13:48Z |
| TIM-110 (Readme) | For Test → Done | 2026-08-18T07:13:48Z |

## Finalization (/tested — 2026-08-18)

- Terminal state detected for team **TimeTonic**: **Done** (type `completed`; team also has a "Closed" completed-state — "Done" chosen, matching how the issues were already closed).
- All four issues were already in Done at finalization time (moved For Test → Done at ~2026-08-18T07:13:48Z, before this /tested run) — no re-transition needed.
- Tag `1.0.3` (bare) pushed to origin at 09d117f; GitHub Release **TimeTonic WP Sync 1.0.3** created with the QA ZIP attached.
- Not done (out of /tested scope): no PR merge, no wp.org/production deploy.

---

## Correction pass — 2026-08-17 — activation fatal fixed

- **Symptom:** fatal on activation — `require_once … vendor/woocommerce/action-scheduler/action-scheduler.php: Failed to open stream` (`timetonic-wp-sync.php:32`).
- **Cause:** the QA ZIP was packaged without `vendor/`. `composer.json` requires `woocommerce/action-scheduler ^3.7` and the main file hard-`require`s it, but `composer install` was never run before `wp dist-archive`, so Action Scheduler was absent from the ZIP. (`.distignore` excludes `composer.json`/`.lock` but NOT `vendor/`, so vendor ships when present.)
- **Fix:** `composer install --no-dev --optimize-autoloader` (installed Action Scheduler 3.7.2) → rebuilt via `--plugin-dirname=timetonic-wp-sync`. ZIP now 662846 bytes and bundles `vendor/woocommerce/action-scheduler/`. Re-attached on TIM-111.
