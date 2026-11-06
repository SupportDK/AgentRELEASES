# Release log — Air WP Sync Pro+ 2.9.5

Repository: wpconnect-co/air-wp-sync-pro
Branch: release/2.9.5
Commit: b25ef387b7637d70f5e96acd9bbeecffd9f76302
Date: 2026-11-06

## QA Tracking

QA Issue:
Update Air WP Sync Pro+ 2.9.5

Linear ID:
AWPS-616  (https://linear.app/wp-connect/issue/AWPS-616/update-air-wp-sync-pro-295)

Linear Project:
Air WP Sync Pro+ v2.9.5 (724be5c8-1a96-4115-8b67-381b936698b7)

Status:
For Test

ZIP:
air-wp-sync.2.9.5.zip  (dist/air-wp-sync.2.9.5.zip — attached to AWPS-616)

## Scope (10 issues)

| Issue | Title | Notes |
|---|---|---|
| AWPS-615 | x-wp-sync-pro-core: send full home_url() in EDD/Licensing.php | Fixed together with AWPS-611 (single code change) |
| AWPS-611 | Licensing: send full home_url() (www / non-www) | EDD/Licensing.php activate/deactivate/check_license now send full home_url() |
| AWPS-610 | Merge patch/2.9.4 | Merged origin/patch/2.9.4 (merge commit a1512a8) |
| AWPS-608 | WordPress 7.1 compatibility | Header + readme Tested up to 7.1; Stable tag 2.9.5 |
| AWPS-604 | Mapping should clean up options => name | mappingManager.js resets options on destination change; shipped bundle rebuilt |
| AWPS-601 | explode_fields to be checked | Offset fix in Barcode_Source + Collaborator_Source |
| AWPS-595 | Check delete_removed_contents (bis) | Deletion skipped when importer errors or failed Action Scheduler tasks |
| AWPS-591 | Admin::TOP_MENU_SLUG != text-domain | Settings-page screen id derived from Admin::TOP_MENU_SLUG |
| AWPS-606 | reset_errors should also reset last_error meta | delete_post_meta(..., 'last_error') added |
| AWPS-600 | Recurring sync should cancel previous running sync | cron() calls end_run('cancel') before run() |

Excluded: AWPS-607 (Canceled — Base64 option-storage discarded by operator). AWPS-587 (Readme — handled in Phase 8, not implementation).

## README Issue

AWPS-587 (Readme) — description set to the 2.9.5 plaintext changelog block; moved to For Test.

## PO Stories

No /stories run for this version.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| AWPS-615 | Todo → In Progress | 2026-11-06T12:10:27Z |
| AWPS-611 | Todo → In Progress | 2026-11-06T12:10:27Z |
| AWPS-610 | Backlog → In Progress | 2026-11-06T12:10:27Z |
| AWPS-608 | Backlog → In Progress | 2026-11-06T12:10:27Z |
| AWPS-604 | Backlog → In Progress | 2026-11-06T12:10:27Z |
| AWPS-601 | Backlog → In Progress | 2026-11-06T12:10:27Z |
| AWPS-595 | Backlog → In Progress | 2026-11-06T12:10:27Z |
| AWPS-591 | Backlog → In Progress | 2026-11-06T12:10:27Z |
| AWPS-606 | Backlog → In Progress | 2026-11-06T12:10:27Z |
| AWPS-600 | Backlog → In Progress | 2026-11-06T12:10:27Z |
| AWPS-615 | In Progress → For Test | 2026-11-06T12:19:34Z |
| AWPS-611 | In Progress → For Test | 2026-11-06T12:19:34Z |
| AWPS-610 | In Progress → For Test | 2026-11-06T12:19:34Z |
| AWPS-608 | In Progress → For Test | 2026-11-06T12:19:34Z |
| AWPS-604 | In Progress → For Test | 2026-11-06T12:19:34Z |
| AWPS-601 | In Progress → For Test | 2026-11-06T12:19:34Z |
| AWPS-595 | In Progress → For Test | 2026-11-06T12:19:34Z |
| AWPS-591 | In Progress → For Test | 2026-11-06T12:19:34Z |
| AWPS-606 | In Progress → For Test | 2026-11-06T12:19:34Z |
| AWPS-600 | In Progress → For Test | 2026-11-06T12:19:34Z |
| AWPS-616 (QA) | created → For Test | 2026-11-06T12:19:40Z |
| AWPS-587 (Readme) | Backlog → For Test | 2026-11-06T12:24:00Z |

## Notes

- AWPS-604 was missed in the initial implementation brief and caught during Phase 8; implemented (commit b25ef38), PO-reviewed, re-packaged and re-pushed before the QA gate. The QA ZIP attached to AWPS-616 contains the fix in the shipped bundle `assets/js/metabox-mapping/main.js`.
- Runtime `vendor/` (action-scheduler + autoload) vendored via `composer install --no-dev --optimize-autoloader` before packaging and verified inside the ZIP.
- ZIP built via the /package fallback (wp dist-archive not registered); single top folder `air-wp-sync-pro-plus/`, no dev cruft.

## Next step

Human QA tests air-wp-sync.2.9.5.zip. On approval: `/tested Air WP Sync Pro+ 2.9.5`.
