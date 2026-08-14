# Release log — wpDataTables Airtable Add-On 1.1.0

Repository: wpconnect-co/addon_wpdatatables-airtable
Branch: release/1.1.0
Commit: ca94a69ee9fb4ad2d95fb80ce7ebecb0c13b89cc
Date: 2026-08-14

## QA Tracking

QA Issue:
Update wpDataTables Airtable Add-On 1.1.0

Linear ID:
WPC-111 (https://linear.app/wp-connect/issue/WPC-111/update-wpdatatables-airtable-add-on-110)

Linear Project:
wpDataTables Airtable Add-On v1.1.0

Status:
For Test

ZIP:
wpconnect-wpdatatables-airtable.1.1.0.zip (attached to WPC-111; local: dist/wpconnect-wpdatatables-airtable.1.1.0.zip)

Plugin dirname inside ZIP: wpconnect-wpdatatables-airtable

## Scope

| Issue | Type | Summary |
|---|---|---|
| WPC-84 | Compatibility | Compatibility with WordPress 7.0 (`Tested up to: 7.0`) |
| WPC-83 | Fix | Updater no longer suppresses update checks for other plugins (removed premature `last_checked`/`checked` writes in `check_update()`) |
| WPC-82 | Improvement (Urgent) | Admin notices on plugins.php for license not-activated / expired / disabled (new `class-license-notices.php`, `API_Licensing::get_license_status()`) |
| WPC-97 | Improvement | Load translations from TranslationsPress (new self-contained T15S `class-language-packs.php`) |

Excluded: WPC-72 "New Strings to translate" (Canceled).

## README issue

WPC-71 "Readme" — updated with the 1.1.0 changelog block, moved to For Test.

## PO Stories

No /stories run for this version. PO review (Phase 4): APPROVED — all four issues PASS.

## ⚠️ QA confirmation items (defaulted, not blocking)

1. Product/pricing URL for WPC-82 notices — `WPC_WPD_AT_WPC_PRODUCT_PAGE_URL = https://wpconnect.co/wpdatatables-airtable-add-on/` (best guess; confirm real product page).
2. TranslationsPress project slug in `WPC_WPD_AT_TRANSLATIONS_PACK_URL` — `wpconnect-wpdatatables-airtable` (confirm against TranslationsPress dashboard; wrong slug = translations silently absent, no fatal).
3. WPC-82 edge case: an already-expired license with no stored `license_status` shows "not activated" until the next activation/check — accepted by PO as safe UX.

## Notes

- First tagged release will be v1.1.0 via /tested (repo currently has no tags; v1.0.0 untagged). No port branch involved.

## Workflow Status History

| Issue | Transition | Timestamp (UTC) |
|---|---|---|
| WPC-84 | Todo → In Progress | 2026-08-14T10:15:42Z |
| WPC-83 | Todo → In Progress | 2026-08-14T10:15:45Z |
| WPC-82 | Todo → In Progress | 2026-08-14T10:15:47Z |
| WPC-97 | Todo → In Progress | 2026-08-14T10:15:49Z |
| WPC-84 | In Progress → For Test | 2026-08-14T10:31:07Z |
| WPC-83 | In Progress → For Test | 2026-08-14T10:31:09Z |
| WPC-82 | In Progress → For Test | 2026-08-14T10:31:11Z |
| WPC-97 | In Progress → For Test | 2026-08-14T10:31:13Z |
| WPC-111 (QA) | created → For Test | 2026-08-14T10:31:30Z |
| WPC-71 (Readme) | Todo → For Test | 2026-08-14T10:31:58Z |

## Next step

After human QA approval: `/tested wpDataTables Airtable Add-On 1.1.0` (tags v1.1.0, moves issues to terminal state, updates this log). `/release` did NOT tag, release, or close anything.
