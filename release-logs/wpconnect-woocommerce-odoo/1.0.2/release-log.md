# Release log — Sync Woo Orders to Odoo 1.0.2

Repository: wpconnect-co/wpconnect-woocommerce-odoo
Branch: release/1.0.2 (from main @ d4cbd93, no port/* branch)
Commit: f6075a9aad63ec8193755649b5d12d333257201c
Date: 2026-11-17T09:21:00Z

## QA Tracking

QA Issue:
Update Sync Woo Orders to Odoo 1.0.2

Linear ID:
ODO-62  (https://linear.app/wp-connect/issue/ODO-62/update-sync-woo-orders-to-odoo-102)

Linear Project:
Sync Woo Orders to Odoo v1.0.2 (ac7827bb-3516-4c97-9471-a25a4b593ac1) — verified via get_issue

Status:
For Test

ZIP:
wpconnect-woocommerce-odoo.1.0.2.zip (dist/, 1000198 bytes, sha256 63ff63c07a3d656d3279d19e721cabe2a65584fe9197bc97105cec33ddae9c13) — attached to ODO-62

## PO Stories

No /stories run for this version.

## Scope

| Issue | Title | Change |
|---|---|---|
| ODO-56 | Licensing: send full home_url() (www / non-www bug) | `includes/class-licensing.php`: activate/deactivate/check_license send `'url' => home_url()` (updater untouched) |
| ODO-46 | Update WordPress to 7.1 compatibility | `Tested up to: 7.1` in plugin header + readme.txt |
| ODO-61 | readme.txt Changelog must be link-only + backfill changelog.txt | changelog.txt gains 1.0.0 (date from tag 1.0.0 = 2025-10-21); readme Changelog = link to https://wpconnect.co/documentation/sync-woocommerce-orders-to-odoo/changelog/ (verified 200; short /changelog/changelog-sync-woocommerce-orders-odoo/ redirects to the product page) |
| ODO-45 | Readme | 1.0.2 changelog entry; plaintext changelog block set on the issue |

Commits: 8d75013 fix (licensing), ee81548 compatibility (WP 7.1), c20ca06 improvement (changelog move), f6075a9 version bump 1.0.2.

## Packaging

`composer install --no-dev --optimize-autoloader`, then `wp dist-archive ./ --plugin-dirname=wpconnect-woocommerce-odoo` (WP-CLI packages loaded via WP_CLI_PACKAGES_DIR=/home/cristian/.wp-cli/packages because the headless HOME differs). Verified with unzip: single top folder `wpconnect-woocommerce-odoo/`, `vendor/autoload.php` and `vendor/woocommerce/action-scheduler/action-scheduler.php` present, no `.git`/`node_modules`/`dev`/`tests`/`assets/src`, Version 1.0.2.

## Review

Product-owner review: APPROVED (no FAIL). QA-pending: www and non-www license flow, re-check of a site activated under 1.0.1 (URL now sent with protocol), WordPress 7.1 order sync. Keep `www-site-match.php` in EDD License to CRM.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| ODO-61 | Backlog → In Progress | 2026-11-17T09:18:36Z |
| ODO-56 | Todo → In Progress | 2026-11-17T09:18:38Z |
| ODO-46 | Backlog → In Progress | 2026-11-17T09:18:39Z |
| ODO-45 | Backlog → In Progress | 2026-11-17T09:18:40Z |
| ODO-56 | In Progress → For Test | 2026-11-17T09:20:22Z |
| ODO-46 | In Progress → For Test | 2026-11-17T09:20:23Z |
| ODO-61 | In Progress → For Test | 2026-11-17T09:20:24Z |
| ODO-62 (QA issue) | created → For Test | 2026-11-17T09:20:36Z |
| ODO-45 | In Progress → For Test | 2026-11-17T09:20:57Z |

Not done by /release (belongs to /tested): tag, GitHub Release, merge, deploy, closing issues. Repo has tag-and-deploy.yml (auto tag/release/deploy on merge of release/* to main).
