# Release log — WP Sync for Notion 1.7.2

Repository: wpconnect-co/notion-wp-sync
Branch: release/1.7.2
Commit: 396d761d87ee8c416395aed004e18829eab81780
Date: 2026-08-14

## QA Tracking

QA Issue:
Update WP Sync for Notion 1.7.2

Linear ID:
NOWPS-385 (https://linear.app/wp-connect/issue/NOWPS-385/update-wp-sync-for-notion-172)

Linear Project:
WP Sync for Notion v1.7.2

Status:
Done (released) — finalized via /tested on 2026-08-18

Tag:
1.7.2 (bare, matching repo convention 1.7.0/1.7.1) → 396d761d87ee8c416395aed004e18829eab81780

GitHub Release:
WP Sync for Notion 1.7.2 — https://github.com/wpconnect-co/notion-wp-sync/releases/tag/1.7.2 (ZIP attached)

ZIP:
notion-wp-sync.1.7.2.zip (attached to NOWPS-385 and to the GitHub Release; local: dist/notion-wp-sync.1.7.2.zip)

Plugin dirname inside ZIP: wp-sync-for-notion (wp.org slug / text domain)

## Scope

| Issue | Type | Summary |
|---|---|---|
| NOWPS-351 | Compatibility | Compatibility with WordPress 7.0 (`Tested up to: 7.0`) |
| NOWPS-357 | Fix | Prevent content deletion when a sync is interrupted or a new sync starts before the previous one finishes (guard in `Action_Consumer::consume()` discards stale/mismatched-run actions) |
| NOWPS-376 | Improvement | Document the Notion API as an external service in `readme.txt` (`== External services ==`) |
| NOWPS-365 | Improvement | Remove left WP Connect logo from admin header; enlarge plugin title |

Excluded: NOWPS-373 "New Strings to translate" (Canceled).

## README issue

NOWPS-372 "Readme" — updated with the 1.7.2 changelog block, moved to For Test.

## PO Stories

No /stories run for this version. PO review (Phase 4): APPROVED — all four issues PASS acceptance criteria. Human-QA note on NOWPS-357: verify a cancel-then-immediate-relaunch sync still cleans up genuinely removed content at the end of the new completed run.

## Notes

- This release was created on top of `main`, which was already at 1.7.1 (1.7.1 shipped Jan 2026). 1.7.2 is a fresh patch scoped from the renamed `WP Sync for Notion v1.7.2` Linear project.
- No port branch involved.
- **2026-08-15 — QA ZIP repackaged (packaging fix, no code/version change).** The first 1.7.2 QA ZIP shipped without `vendor/`, so activating the plugin threw a fatal error: `require_once(.../vendor/woocommerce/action-scheduler/action-scheduler.php): Failed to open stream` (main file `notion-wp-sync.php:32`). Root cause: `vendor/` is gitignored and is never committed, and `composer install` was not run before packaging, so `wp dist-archive` had no vendor tree to include (`.distignore` does not exclude `vendor`). Fix: ran `composer install --no-dev --optimize-autoloader` (action-scheduler 3.6.1 from committed `composer.lock`), then re-ran `wp dist-archive ./ --plugin-dirname=wp-sync-for-notion`. New ZIP: 293 files (was 181), includes `vendor/woocommerce/action-scheduler/action-scheduler.php` + `vendor/autoload.php`, single top-level `wp-sync-for-notion/`, no dev cruft. **Re-attach `dist/notion-wp-sync.1.7.2.zip` to NOWPS-385 for QA.**

## Workflow Status History

| Issue | Transition | Timestamp (UTC) |
|---|---|---|
| NOWPS-351 | Backlog → In Progress | 2026-08-14T09:52:23Z |
| NOWPS-357 | Backlog → In Progress | 2026-08-14T09:52:24Z |
| NOWPS-376 | Backlog → In Progress | 2026-08-14T09:52:26Z |
| NOWPS-365 | Backlog → In Progress | 2026-08-14T09:52:28Z |
| NOWPS-351 | In Progress → For Test | 2026-08-14T10:03:48Z |
| NOWPS-357 | In Progress → For Test | 2026-08-14T10:03:49Z |
| NOWPS-376 | In Progress → For Test | 2026-08-14T10:03:50Z |
| NOWPS-365 | In Progress → For Test | 2026-08-14T10:03:51Z |
| NOWPS-385 (QA) | created → For Test | 2026-08-14T10:04:05Z |
| NOWPS-372 (Readme) | Backlog → For Test | 2026-08-14T10:05:03Z |
| NOWPS-351 | For Test → Done | 2026-08-18T06:59:28Z |
| NOWPS-357 | For Test → Done | 2026-08-18T06:59:28Z |
| NOWPS-376 | For Test → Done | 2026-08-18T06:59:28Z |
| NOWPS-365 | For Test → Done | 2026-08-18T06:59:28Z |
| NOWPS-385 (QA) | For Test → Done | 2026-08-18T06:59:28Z |
| NOWPS-372 (Readme) | For Test → Done | 2026-08-18T06:59:28Z |

## Finalization (/tested — 2026-08-18)

- Terminal state detected for team **Notion WP Sync**: **Done** (type `completed`).
- All six issues were already in Done at finalization time (moved For Test → Done at 2026-08-18T06:59:28Z, before this /tested run) — no re-transition needed.
- Tag `1.7.2` (bare) pushed to origin at 396d761; GitHub Release **WP Sync for Notion 1.7.2** created with the QA ZIP attached.
- Not done (out of /tested scope): no PR merge, no wp.org/production deploy.
