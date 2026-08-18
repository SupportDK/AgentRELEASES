# Release log — Air Woo Sync 2.0.2

Repository: wpconnect-co/air-woo-sync
Branch: release/2.0.2
Commit: 63886b3
Date: 2026-08-18

## QA Tracking

QA Issue:
Update Air Woo Sync 2.0.2

Linear ID:
AWS-139  (https://linear.app/wp-connect/issue/AWS-139/update-air-woo-sync-202)

Linear Project:
Air Woo Sync v2.0.2  (verified — QA issue landed in the same project as source issues)

Status:
For Test

ZIP:
air-wp-sync.2.0.2.zip  (attached to AWS-139; local: dist/air-wp-sync.2.0.2.zip)

## Scope

- **AWS-138 — Fix error update** (Bug): the EDD update checker derived its product slug from the main plugin filename (`air-wp-sync.php` → `air-wp-sync`), colliding with Air WP Sync Pro+/Free on the wpconnect update server. WordPress offered a Pro+ 2.9.x update and "Update now" replaced the plugin with the wrong product. Fix: send a unique product slug `air-wp-sync-for-woocommerce` via new constant `AIR_WP_SYNC_FOR_WOO_WPC_PRODUCT_SLUG`, threaded into the EDD updater `api_data`; the vendored `Updater` now honours an explicit `slug` and falls back to the old filename-derived behaviour when none is passed (backward compatible). `item_id` (21780) unchanged.
- **AWS-127 — Readme**: per-version Readme issue; description set to the 2.0.2 changelog block, moved to For Test.

## Packaging notes

- `composer install --no-dev` was run before packaging to bundle the `woocommerce/action-scheduler` runtime dependency (required at `air-wp-sync.php:84`) — otherwise the ZIP fatals on activation.
- Built via `wp dist-archive ./ --plugin-dirname=air-wp-sync-for-woocommerce`; renamed to `air-wp-sync.2.0.2.zip` (main file `air-wp-sync.php`).
- Verified: single top-level folder `air-wp-sync-for-woocommerce/`, no dev cruft, action-scheduler present, version 2.0.2.

## Open QA-gate risk

The corrected slug `air-wp-sync-for-woocommerce` must match the product registration on the wpconnect.co EDD server. It is corroborated by three independent existing identifiers (package.json `name`, the `--plugin-dirname` archive target, and the TranslationsPress package URL), but server-side registration is unverifiable from the workspace. QA must confirm on staging that (a) the spurious 2.9.x notice is gone AND (b) a legitimate update is still detected (no regression to "no update"). If no update is ever detected, the server slug differs and the constant must be corrected.

## PO Stories

No /stories run for this version.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| AWS-138 | Backlog → In Progress | 2026-08-18T12:31:28Z |
| AWS-138 | In Progress → For Test | 2026-08-18T12:47:06Z |
| AWS-139 (QA) | created → For Test | 2026-08-18T12:47:38Z |
| AWS-127 (Readme) | Backlog → For Test | 2026-08-18T12:48:13Z |
