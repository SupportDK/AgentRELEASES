# Release log — Orders Sync to Airtable for WooCommerce 1.0.1

Repository: wpconnect-co/orders-sync-to-airtable-for-woocommerce
Branch: release/1.0.1  (renamed from release/1.1.0)
Commit: 2228518 (renumber to 1.0.1; on top of e025285…60c3487)
Date: 2026-06-15 (prepared) · 2026-07-21 (renumbered 1.1.0 → 1.0.1)

## Version renumber (2026-07-21)

Per maintainer decision this ships as **1.0.1**, not 1.1.0: the scope was reduced to a
compatibility patch once WPC-99 (TranslationsPress language pack) was dropped, so a patch
bump is correct rather than a minor.

- Plugin `Version` header, `ORDERS_SYNC_TO_AIRTABLE_FOR_WOOCOMMERCE_VERSION` constant,
  readme `Stable tag` and `changelog.txt` heading changed 1.1.0 → 1.0.1 (commit `2228518`).
- Branch renamed `release/1.1.0` → `release/1.0.1` (old branch deleted local + remote).
- PR **#9** (`release/1.0.1` → `main`) opened; PR **#6** (`release/1.1.0`) closed as superseded.
- **Still on 1.1.0 (follow-up):** the dist ZIP (`orders-sync-to-airtable-for-woocommerce.1.1.0.zip`)
  and the Linear QA issue WPC-100 / project "v1.1.0" — rename/rebuild before QA sign-off.

## QA Tracking

QA Issue:
Update Orders Sync to Airtable for Woo 1.0.1  (renamed from 1.1.0)

Linear ID:
WPC-100  (https://linear.app/wp-connect/issue/WPC-100/update-orders-sync-to-airtable-for-woo-101)

Linear Project:
Orders Sync to Airtable for Woo v1.0.1

Status:
Done ⚠️ (stale — issue was marked Done 2026-07-20; re-prepped for 1.0.1 QA, may need moving back to For Test)

ZIP:
orders-sync-to-airtable-for-woocommerce.1.0.1.zip  (dist/ — rebuilt on release/1.0.1 commit 2228518, re-attached to WPC-100, old 1.1.0 attachments removed; bundles vendor/ action-scheduler 3.9.3 via composer install --no-dev)

## Scope — issues in this version

| Issue | Title | Resolution |
|---|---|---|
| WPC-99 | TranslationsPress functions | Code ported from GF Notion (`port/translationspress-language-pack`) — `includes/class-language-pack.php` + wiring; readme `== External Services ==` TranslationsPress disclosure added (WordPress.org requirement) |
| WPC-98 | Compa WordPress 7.0 | `Tested up to: 7.0` (header + readme) |
| WPC-69 | Readme | changelog.txt 1.1.0 entry; readme.txt Tested up to / Stable tag / External Services updated; README issue moved to For Test |

Excluded: WPC-70 (Canceled, pre-existing). **WPC-77 (mapping empty-fields bug) was cancelled during this release** per maintainer decision — compiled-JS UI bug, no repro, not verifiable here.

## PO Stories

No /stories run for this version. Issues validated inline during /release (Phase 1). WPC-77 was assessed as a compiled-JS UI bug without reproduction steps and cancelled rather than refined.

## Ported From

This release was built on top of the port branch `port/translationspress-language-pack`, which carries the **TranslationsPress language-pack integration ported from GF Notion** (`wpconnect-co/addon_gf-notion`) for WPC-99.

- Port report: `port-logs/orders-sync-to-airtable-for-woocommerce/translationspress-language-pack/port-report.md`
- Port commit carried into this release: `2a2ff21` — `feature: pull translations from TranslationsPress via language pack updater (ported from addon_gf-notion)`
- Adaptation highlights: namespace `Orders_Sync_to_Airtable_for_WooCommerce`; slug + URL use the text domain `orders-sync-to-airtable-for-woocommerce`; no ABSPATH guard (matching the target's sibling classes); no `load_plugin_textdomain` / `/languages` added.

## Packaging note

`vendor/` is git-ignored and absent from the repo; the plugin hard-requires `vendor/woocommerce/action-scheduler/action-scheduler.php` at runtime. Composer was not installed on the build machine, so it was bootstrapped (Composer 2.10.1) and `composer install --no-dev` was run to populate `vendor/` (action-scheduler 3.9.3, pinned by composer.lock) before building the dist ZIP. The release branch itself does NOT contain vendor/ (correct — vendor is a build-time artifact).

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| WPC-99 | Todo → In Progress | 2026-06-15T18:28:02Z |
| WPC-99 | In Progress → For Test | 2026-06-15T18:36:39Z |
| WPC-98 | Todo → In Progress | 2026-06-15T18:28:03Z |
| WPC-98 | In Progress → For Test | 2026-06-15T18:36:43Z |
| WPC-69 | Todo → In Progress | 2026-06-15T18:28:04Z |
| WPC-69 | In Progress → For Test | 2026-06-15T18:37:45Z |
| WPC-77 | Todo → Canceled (excluded from release) | 2026-06-15T18:27:58Z |
| WPC-100 (QA) | created → For Test | 2026-06-15T18:37:00Z |

## Next step

After human QA approval: `/tested Orders Sync to Airtable for Woo 1.1.0` (tags v1.1.0, moves issues to terminal state, updates this log).
