# Release log — TimeTonic WP Sync 1.0.4

Repository: wpconnect-co/timetonic-wp-sync-pro
Branch: release/1.0.4
Commit: 5515a576ae2059ba94db3e56d3599fd11b2cabba
Date: 2026-11-05

## QA Tracking

QA Issue:
Update TimeTonic WP Sync 1.0.4

Linear ID:
TIM-125  (https://linear.app/wp-connect/issue/TIM-125/update-timetonic-wp-sync-104)

Linear Project:
TimeTonic WP Sync v1.0.4 (ff4cd279-2289-48af-aa0a-a761c7d86ce4)

Status:
For Test

ZIP:
timetonic-wp-sync.1.0.4.zip (dist/timetonic-wp-sync.1.0.4.zip, 649190 bytes — attached to TIM-125)

## PO Stories

No /stories run for this version.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| TIM-113 | Backlog → In Progress | 2026-11-05T21:01:55Z |
| TIM-113 | In Progress → For Test | 2026-11-05T21:04:39Z |
| TIM-125 (QA) | created → For Test | 2026-11-05T21:04:39Z |
| TIM-112 (Readme) | Backlog → For Test | 2026-11-05T21:05:33Z |

## Notes

- Scope: TIM-113 — WordPress 7.1 compatibility (Improvement).
- Changes: `Tested up to: 7.1` + `Stable tag: 1.0.4` in readme.txt; `Version: 1.0.4`, `Tested up to: 7.1`, `TIMETONIC_WP_SYNC_VERSION = 1.0.4` in main plugin file; changelog entry `= 1.0.4 =` (Compatibility with WordPress 7.1). No code-logic changes.
- Changelog kept inline in readme.txt (this plugin has no changelog.txt yet; full house-style migration is out of this release's scope).
- Packaging: `wp dist-archive` unavailable (dist-archive command requires wp-cli 3.x; installed wp-cli is 2.12.0) — used the `/package` fallback (manual zip honoring `.distignore`). Runtime `vendor/` vendored via `composer install --no-dev --optimize-autoloader` first; ZIP verified: single top folder `timetonic-wp-sync/`, `vendor/autoload.php` + `vendor/woocommerce/action-scheduler/action-scheduler.php` present, no dev cruft.
