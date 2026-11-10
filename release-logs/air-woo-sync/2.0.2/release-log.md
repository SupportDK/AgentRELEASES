# Release log — Air Woo Sync 2.0.2

Repository: wpconnect-co/air-woo-sync
Branch: release/2.0.2
Commit: 8bbe2e0 (8bbe2e026bedb99004e3e9d4a52648ed4e149f2f)
Date: 2026-11-05

## QA Tracking

QA Issue:
Update Air Woo Sync 2.0.2

Linear ID:
AWS-147  (https://linear.app/wp-connect/issue/AWS-147/update-air-woo-sync-202)

Linear Project:
Air Woo Sync v2.0.2  (verified — QA issue created directly in the same project as the source issues)

Status:
Closed (human QA approved 2026-11-10; tag/release deferred to merge pipeline)

ZIP:
air-wp-sync.2.0.2.zip  (attached to AWS-147; local: dist/air-wp-sync.2.0.2.zip; 1,865,787 bytes)

## Scope (8 issues, project Air Woo Sync v2.0.2)

- **AWS-144 — Licensing: send full home_url() (www bug)** (Bug): `EDD/Licensing.php` stripped the protocol from `home_url()` in `activate_license`/`deactivate_license`/`check_license`, mismatching the updater and causing `site_inactive`/401 on www sites. Fix: send plain `home_url()` in all three methods; updater untouched.
- **AWS-136 — reset_errors also resets 'last_error'** (Bug): `Abstract_Importer::reset_errors()` now also deletes the `last_error` post meta.
- **AWS-134 — delete_removed_contents guard (bis)** (Bug): failed Action Scheduler task detection moved before the `delete_removed_contents` gate; a failed task downgrades status from success so removed content is not deleted on an unclean run (mirrors notion-wp-sync-pro).
- **AWS-135 — explode_fields index drift** (Bug): `Barcode_Source` and `Collaborator_Source` `explode_fields()` rewritten to a single-pass result array; no dropped/misplaced fields when several apply.
- **AWS-141 — WordPress 7.1 compatibility** (Improvement): `Tested up to: 7.1` in plugin header and readme.txt.
- **AWS-131 — Recurring sync should cancel if running** (Bug): verified already implemented — `cron()` skips when a run is active (`get_run_id()` guard). No code change; no changelog entry.
- **AWS-137 — Mapping cleans options.name on destination change** (Bug): verified already present in source and built asset (`assets/js/metabox-mapping/main.js`). No code change.
- **AWS-130 — Admin::TOP_MENU_SLUG vs hardcoded slug** (Bug/Improvement): verified no-op for this plugin — literal `x-wp-sync-core-text-domain` is absent from shipped PHP/JS (only in `dev/` build config). No code change.

## README / changelog

- README/changelog content changed, so the per-version Readme issue was handled (Phase 8): **AWS-140 (Readme)** description set to the 2.0.2 plaintext changelog block and moved to For Test.
- House-style migration performed: created `changelog.txt` (new 2.0.2 entry + migrated prior entries); reduced `readme.txt == Changelog ==` to the `[Full changelog]` link only.

## Packaging notes

- `composer install --no-dev --optimize-autoloader` run before packaging (runtime `woocommerce/action-scheduler` dependency required by the main file) — lock already satisfied, nothing to install.
- `wp dist-archive` is not registered in this environment → used the `/package` fallback: staged a single top-level `air-wp-sync-for-woocommerce/` folder honoring `.distignore` (plus removing dev-only `CLAUDE.md`), zipped, moved to `dist/`.
- Verified in the ZIP: exactly one top folder `air-wp-sync-for-woocommerce/`; no dev cruft (`.git`, `node_modules`, `dev/`, `tests/`, `composer.json`, `package.json`, `assets/src`); runtime `vendor/autoload.php` and `vendor/woocommerce/action-scheduler/action-scheduler.php` present; main file `Version: 2.0.2`, `Tested up to: 7.1`.

## Open QA-gate risks

- **Changelog slug unverified**: `readme.txt` links `https://wpconnect.co/changelog/air-wp-sync-for-woocommerce/`. This slug is inferred (package.json name / dirname / TranslationsPress) but not confirmed against the live wpconnect.co/changelog page. QA should confirm it resolves, else correct the slug.
- **AWS-144 is server-dependent**: confirm on a real www site that activation records the full URL and update download returns 200 (no 401), with non-www unaffected.

## Out of scope (flagged)

- **AWS-138 "Fix error update"** (EDD update-checker slug collision adding `AIR_WP_SYNC_FOR_WOO_WPC_PRODUCT_SLUG`) is NOT in this release's project (still Backlog, unassigned). A prior Aug-2026 `release/2.0.2` prep for AWS-138 was never merged (`main` is still 2.0.1 and the branch is gone from origin). If the update-collision fix is still required, it needs its own scoped release/decision — it is not carried by any of these 8 issues.

## PO Stories

No /stories run for this version. PO flagged AWS-137/AWS-135/AWS-134 as having generic acceptance criteria; implementation proceeded without blocking.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| AWS-144 | Todo → In Progress | 2026-11-05T20:28:13Z |
| AWS-141 | Backlog → In Progress | 2026-11-05T20:28:13Z |
| AWS-137 | Backlog → In Progress | 2026-11-05T20:28:13Z |
| AWS-136 | Backlog → In Progress | 2026-11-05T20:28:13Z |
| AWS-135 | Backlog → In Progress | 2026-11-05T20:28:13Z |
| AWS-134 | Backlog → In Progress | 2026-11-05T20:28:13Z |
| AWS-131 | Backlog → In Progress | 2026-11-05T20:28:13Z |
| AWS-130 | Backlog → In Progress | 2026-11-05T20:28:13Z |
| AWS-144 | In Progress → For Test | 2026-11-05T20:38:08Z |
| AWS-141 | In Progress → For Test | 2026-11-05T20:38:08Z |
| AWS-137 | In Progress → For Test | 2026-11-05T20:38:08Z |
| AWS-136 | In Progress → For Test | 2026-11-05T20:38:08Z |
| AWS-135 | In Progress → For Test | 2026-11-05T20:38:08Z |
| AWS-134 | In Progress → For Test | 2026-11-05T20:38:08Z |
| AWS-131 | In Progress → For Test | 2026-11-05T20:38:08Z |
| AWS-130 | In Progress → For Test | 2026-11-05T20:38:08Z |
| AWS-147 (QA) | created → For Test | 2026-11-05T20:38:30Z |
| AWS-140 (Readme) | Backlog → For Test | 2026-11-05T20:40:00Z |
| AWS-144 | For Test → Closed | 2026-11-10T08:00:17Z |
| AWS-141 | For Test → Closed | 2026-11-10T08:00:17Z |
| AWS-140 (Readme) | For Test → Closed | 2026-11-10T08:00:18Z |
| AWS-137 | For Test → Closed | 2026-11-10T08:00:18Z |
| AWS-136 | For Test → Closed | 2026-11-10T08:00:19Z |
| AWS-135 | For Test → Closed | 2026-11-10T08:00:21Z |
| AWS-134 | For Test → Closed | 2026-11-10T08:00:21Z |
| AWS-131 | For Test → Closed | 2026-11-10T08:00:21Z |
| AWS-130 | For Test → Closed | 2026-11-10T08:00:22Z |
| AWS-147 (QA) | For Test → Closed | 2026-11-10T08:00:16Z |

## Finalization (/tested, 2026-11-10)

- Human QA approval confirmed by Cris for ZIP `air-wp-sync.2.0.2.zip` (sha256 `207b9d91111f42f6298f72d0eec03e49610f9f4854319d18c4ed3108376e2cae`, verified against `dist/`).
- Tag / GitHub Release: **not created here** — repo has `tag-and-deploy.yml`; the pipeline tags and releases when the `release/2.0.2` PR is merged to `main`. No merge or deploy was performed.
- Project `Air Woo Sync v2.0.2` → Completed, target date 2026-11-10, color `#bec2c8`.
- Next project: `Air Woo Sync v2.0.3` already existed with planned backlog issues, so `Air Woo Sync v2.0.4` was created (AWS-148 Readme, AWS-149 New Strings to translate). No carry-overs.
