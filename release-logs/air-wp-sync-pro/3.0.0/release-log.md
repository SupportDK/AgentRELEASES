# Release log — Air WP Sync Pro+ 3.0.0

Repository: wpconnect-co/air-wp-sync-pro
Branch: release/3.0.0
Commit: 667a4e7551993b4114478d7af60e1a0d5dc213b0
Date: 2026-06-17

## QA Tracking

QA Issue:
Update Air WP Sync Pro+ 3.0.0

Linear ID:
AWPS-576  (https://linear.app/wp-connect/issue/AWPS-576/update-air-wp-sync-pro-300)

Linear Project:
Air WP Sync Pro+ v3.0.0  (https://linear.app/wp-connect/project/air-wp-sync-pro-v300-9a23e92df99c)

Status:
For Test

ZIP:
air-wp-sync.3.0.0.zip  (dist/air-wp-sync.3.0.0.zip — attached to AWPS-576)

## Scope

| Issue | Title | Type | Result |
|---|---|---|---|
| AWPS-535 | Support AI Airtable Fields (`aiText`) | Feature | Implemented — review APPROVED |
| AWPS-517 | Readme | Readme | Changelog updated; moved to For Test |
| ~~AWPS-518~~ | New Strings to translate | Improvement | **Canceled in Linear — out of scope** |

### What shipped (AWPS-535)
- New `AI_Text_Source` normalises Airtable `aiText` cells before mapping (`airwpsync/pre_import_record_data`): `generated` → plain text `value`; `loading`/`empty`/`error`/unknown-state → `Skip_Field_Value` sentinel (preserves existing WP content, no overwrite); `error` logs `errorType` (warning).
- New `Skip_Field_Value` sentinel + guard in `Format_Data_Destination::format_data()` → true per-field skip.
- Generic fallback: any unknown structured field (`{state,value}` object) is unwrapped to `value` so it never breaks the rest of the record.
- `aiText` added to `$string_supported_sources` and `$multiple_lines_text_supported_sources` in `Airtable_Formatter`.
- `aiText` is read-only (Airtable → WP only); no write-back path.
- Version bumped to 3.0.0 (`air-wp-sync.php` header + `AIR_WP_SYNC_PRO_VERSION`, `readme.txt` Stable tag, `package.json`).

### Validate-only at QA (no code change)
AI-generated `singleSelect` / `multipleSelects` / `number` / `currency` / `percent` keep working via existing mapping.

## Build / Packaging notes
- `wp dist-archive` was **unavailable** (the `dist-archive-command` package requires WP-CLI ≥ 2.13; this env has 2.12.0). Used the `/package` fallback: rsync staging into a single top-level `air-wp-sync-pro-plus/` folder, applying `.distignore`, then `zip`.
- `vendor/` was generated locally with Composer 2.10.1 (`composer install --no-dev`) so the ZIP ships `vendor/autoload.php` (classmap including the new classes, verified) + `woocommerce/action-scheduler`. Smoke test confirmed both new classes autoload and instantiate.
- ZIP: 469 files, ~1.18 MB. Single top-level folder, version 3.0.0 verified inside.

## ⚠️ Maintenance caveat (must be tracked)
The new/edited source files live in the committed `vendor_prefixed/` tree because the upstream packages (`dev/wpconnect/packages/`) are **not vendored** in this repo. The same change must be **upstreamed** to the `air-wp-sync-core` / `x-wp-sync-core` packages, otherwise a future re-prefix run (`dev/wpconnect/bin/prefix-dependencies.js`) would overwrite them.

## PO Stories
No `/stories` run for this version (issue AWPS-535 was already detailed with testable acceptance criteria).

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| AWPS-535 | Backlog → In Progress | 2026-06-17T08:52:02Z |
| AWPS-535 | In Progress → For Test | 2026-06-17T09:41:13Z |
| AWPS-576 (QA) | created → For Test | 2026-06-17T09:41:32Z |
| AWPS-517 (Readme) | Backlog → For Test | 2026-06-17T09:43:47Z |

## Next step
After human QA approval: `/tested Air WP Sync Pro+ 3.0.0`
