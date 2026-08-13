# Release log — GF TimeTonic 1.1.0

Repository: wpconnect-co/addon_gf-timetonic
Branch: release/1.1.0
Commit: 3baee11 (HEAD; remove bundled languages/ — TranslationsPress-only)
Date: 2026-08-13

Plugin type: **premium / WPconnect-distributed** (NOT wordpress.org) — wp.org compliance framing intentionally not applied.

## QA Tracking

QA Issue:
Update GF TimeTonic 1.1.0

Linear ID:
TIM-97  (https://linear.app/wp-connect/issue/TIM-97/update-gf-timetonic-110)

Linear Project:
GF TimeTonic v1.1.0  (770001f0-b704-47e0-bb96-e75daf328d94)

Status:
For Test

ZIP:
wpconnect-gf-timetonic.1.1.0.zip  (dist/wpconnect-gf-timetonic.1.1.0.zip, 34497 bytes — LATEST attachment on TIM-97; rebuilt without languages/. Earlier 38765- and 36857-byte builds superseded)

## Scope

Delivered in two passes on release/1.1.0. All in-scope issues + 3 review-wrappers → For Test (16 issues total).

Pass 1 (commits 6fbce41 → 27291f3):
- TIM-63 — PHP 7.4 minimum + Gravity Forms tested up to 2.10.
- TIM-68 — WordPress 7.0 compatibility.
- TIM-60 — plugin-row "site" link → https://wpconnect.co/timetonic-integration-wordpress/ (Plugin URI).
- TIM-40 / TIM-72 — field-mapping first-field selectable without clicking X.
- TIM-59 / TIM-70 — updater no longer affects other plugins' update entries.
- TIM-58 — license status admin notices (expired / disabled / not-activated / update-unavailable).
- TIM-64 — support + documentation links on the settings page.
- TIM-30 — readme.txt updated (Stable tag 1.1.0, Tested up to 7.0, PHP 7.4, GF 2.10, changelog).
- TIM-42 — README.md technical doc (repo root; excluded from ZIP).

Pass 2 — TranslationsPress migration (commits 629774a, 2245c4b), added at user request:
- TIM-92 — migrated to TranslationsPress (T15S). Text domain aligned `wpc-gf-tmt` → `wpconnect-gf-timetonic`; new `includes/classes/class-language-pack.php` (`Language_Packs`) wired on `init`; URL `https://packages.translationspress.com/wp-connect/wpconnect-gf-timetonic/packages.json`; `.pot` renamed to `wpconnect-gf-timetonic.pot`.
- TIM-65 — `load_plugin_textdomain` **fully removed** (was partially addressed in pass 1; now closed completely — translations load via WP core just-in-time from TP packs).
- TIM-20 / TIM-74 — WP 6.7 `_load_textdomain_just_in_time` notice resolved (no early/manual textdomain load remains).
- TIM-9 — French (and all locales) now delivered via TranslationsPress. **Actual French translation produced**: `wpconnect-gf-timetonic-fr_FR.po` (64 strings, validated via `wp i18n make-mo`). Originally committed under `languages/` in pass 2 (42d6243); **removed from the repo in pass 3** and instead attached to the TIM-9 issue for publishing on TranslationsPress (see Pass 3 below).

Pass 3 — languages/ folder removed (commit 3baee11), correction per user:
- The plugin must NOT ship a `languages/` folder — translations are delivered **exclusively** via TranslationsPress (matches sibling `addon_gf-at`, which ships no `languages/` at all). Removed both `wpconnect-gf-timetonic.pot` and `wpconnect-gf-timetonic-fr_FR.po` from the repo, dropped the `Domain Path: /languages/` header, and added `*.pot` to `.distignore`.
- TIM-9 — the fr_FR `.po` is no longer versioned in the plugin. It is now **attached to the TIM-9 Linear issue** (`wpconnect-gf-timetonic-fr_FR.po`, 12723 bytes) to be published on the TranslationsPress project `wpconnect-gf-timetonic`. A copy is kept at `release-logs/addon_gf-timetonic/1.1.0/wpconnect-gf-timetonic-fr_FR.po`.
- ZIP rebuilt (34497 bytes, no languages/) and re-attached as the LATEST on TIM-97.

Reference: adapted from GF Airtable (addon_gf-at 2.6.0) — same file structure and T15S pattern. Not a literal copy.

⚠️ Infra dependency (TIM-92): the TranslationsPress project `wpconnect-gf-timetonic` must exist on translationspress.com (same convention as `wpconnect-gf-*` siblings). If absent, the integration is inert (no errors) until created.

## Deferred (NOT built)
- TIM-11 (file-upload bug) — needs a reliable reproduction (only a Loom reference exists).

## PO Stories

No /stories run for this version. Story-quality validation performed inline during Phase 1. TIM-92/TIM-9 were initially deferred (empty specs) then implemented in pass 2 after the user confirmed the TranslationsPress direction (valid because this is a premium, non-wp.org plugin).

## Workflow Status History

| Issue | Transition | Timestamp (UTC) |
|---|---|---|
| TIM-65,20,74,63,68,60,40,72,59,70,58,64,30,42 | Todo → In Progress | 2026-08-13T21:00:29–54Z |
| TIM-65,20,74,63,68,60,40,72,59,70,58,64,30,42 | In Progress → For Test | 2026-08-13T21:26:32–50Z |
| TIM-97 (QA issue) | created → For Test | 2026-08-13T21:27:12Z |
| TIM-92 | Todo → In Progress | 2026-08-13T21:35:27Z |
| TIM-9 | Todo → In Progress | 2026-08-13T21:35:28Z |
| TIM-92 | In Progress → For Test | 2026-08-13T22:06:54Z |
| TIM-9 | In Progress → For Test | 2026-08-13T22:06:55Z |

## Next step

Human QA tests the LATEST ZIP on TIM-97. On approval, finalize with `/tested GF TimeTonic 1.1.0`.
