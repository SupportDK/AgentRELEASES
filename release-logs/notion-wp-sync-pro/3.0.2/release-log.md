# Release log — Notion WP Sync Pro+ 3.0.2

Repository: wpconnect-co/notion-wp-sync-pro
Branch: release/3.0.2
Commit: bb6023330472479809d5ad32a0667fa6e8dcb443
Date: 2026-11-05

## QA Tracking

QA Issue:
Update Notion WP Sync Pro+ 3.0.2

Linear ID:
NOWPS-401  (https://linear.app/wp-connect/issue/NOWPS-401/update-notion-wp-sync-pro-302)

Linear Project:
Notion WP Sync Pro+ v3.0.2 (7e846d7a-b224-4424-ad6c-9eac1ff4c5e4)

Status:
Closed (terminal state; human QA approved 2026-11-10)

ZIP:
notion-wp-sync.3.0.2.zip  (dist/notion-wp-sync.3.0.2.zip, 999671 bytes — attached to NOWPS-401)

## PO Stories

No /stories run for this version.

## Scope

| Issue | Title | Outcome |
|---|---|---|
| NOWPS-400 | changelog.txt: fix "WP connect" brand casing | Done |
| NOWPS-395 | Licensing: send full home_url() (www / non-www bug) | Done |
| NOWPS-392 | Update WordPress to 7.1 compatibility | Done |
| NOWPS-390 | Mapping should clean up options => name | Done (source + rebuilt JS bundle) |
| NOWPS-389 | reset_errors should also reset 'last_error' meta | Done |
| NOWPS-387 | explode_fields to be checked | Investigated — buggy array_slice pattern not present in this codebase; no code change |
| NOWPS-381 | Check delete_removed_contents (bis) | Done |
| NOWPS-378 | Admin::TOP_MENU_SLUG != x-wp-sync-core-text-domain | Done (settings-page screen ID from TOP_MENU_SLUG) |
| NOWPS-370 | Readme | Description set to plaintext changelog block; moved to For Test |

## Changelog 3.0.2

```plaintext
= 3.0.2 =
*Release Date: 5th November 2026*

* Compatibility with WordPress 7.1
* Improvement: Settings page tooltips now work correctly regardless of the plugin menu slug.
* Fix: license activation, deactivation and check now send the full site URL to avoid www/non-www mismatch.
* Fix: switching a mapping row destination field now clears the previously set custom field name.
* Fix: removed content deletion is now skipped when scheduled tasks have failed, preventing accidental data loss.
* Fix: reset errors now also clears the last error entry shown in the connection status.
```

## Packaging notes

- `composer install --no-dev --optimize-autoloader` run before packaging (runtime `vendor/` required: `vendor/autoload.php` + `vendor/woocommerce/action-scheduler/action-scheduler.php`); both verified inside the ZIP.
- `wp dist-archive` unavailable here (dist-archive-command requires wp-cli ^3.0; installed 2.12.0) — used the `/package` fallback: rsync honoring `.distignore`, single top-level `notion-wp-sync-pro-plus/` folder, zipped. Verified: one top folder, no dev cruft, 616 files.
- NOWPS-390 built JS bundle `assets/js/metabox-mapping/main.js` rebuilt from React source and confirmed to carry the fix.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| NOWPS-400 | Backlog → In Progress | 2026-11-05T20:43Z |
| NOWPS-395 | Todo → In Progress | 2026-11-05T20:43Z |
| NOWPS-392 | Backlog → In Progress | 2026-11-05T20:43Z |
| NOWPS-390 | Backlog → In Progress | 2026-11-05T20:43Z |
| NOWPS-389 | Backlog → In Progress | 2026-11-05T20:43Z |
| NOWPS-387 | Backlog → In Progress | 2026-11-05T20:43Z |
| NOWPS-381 | Backlog → In Progress | 2026-11-05T20:43Z |
| NOWPS-378 | Backlog → In Progress | 2026-11-05T20:43Z |
| NOWPS-400 | In Progress → For Test | 2026-11-05T20:56Z |
| NOWPS-395 | In Progress → For Test | 2026-11-05T20:56Z |
| NOWPS-392 | In Progress → For Test | 2026-11-05T20:56Z |
| NOWPS-390 | In Progress → For Test | 2026-11-05T20:56Z |
| NOWPS-389 | In Progress → For Test | 2026-11-05T20:56Z |
| NOWPS-387 | In Progress → For Test | 2026-11-05T20:56Z |
| NOWPS-381 | In Progress → For Test | 2026-11-05T20:56Z |
| NOWPS-378 | In Progress → For Test | 2026-11-05T20:56Z |
| NOWPS-401 (QA issue) | created → For Test | 2026-11-05T20:57Z |
| NOWPS-370 (Readme) | Backlog → For Test | 2026-11-05T20:59Z |
| NOWPS-400 | For Test → Closed | 2026-11-10T08:02Z |
| NOWPS-395 | For Test → Closed | 2026-11-10T08:02Z |
| NOWPS-392 | For Test → Closed | 2026-11-10T08:02Z |
| NOWPS-390 | For Test → Closed | 2026-11-10T08:02Z |
| NOWPS-389 | For Test → Closed | 2026-11-10T08:02Z |
| NOWPS-387 | For Test → Closed | 2026-11-10T08:02Z |
| NOWPS-381 | For Test → Closed | 2026-11-10T08:02Z |
| NOWPS-378 | For Test → Closed | 2026-11-10T08:02Z |
| NOWPS-401 (QA issue) | For Test → Closed | 2026-11-10T08:02Z |
| NOWPS-370 (Readme) | For Test → Closed | 2026-11-10T08:02Z |

Tag / GitHub Release:
NOT created manually. Repo uses tag-and-deploy.yml (auto tag, release and deploy on merge of release/3.0.2 PR to main; tags are bare `3.0.2`). Merge was not authorized in /tested; tag arrives with the human-approved merge.

## Project

Notion WP Sync Pro+ v3.0.2 → Completed, target 2026-11-10, color #bec2c8. Next project: Notion WP Sync Pro+ v3.0.3 (NOWPS-402 Readme, NOWPS-403 New Strings).

## Next step

Merge release/3.0.2 PR to main (human) → pipeline tags 3.0.2, releases, deploys.
