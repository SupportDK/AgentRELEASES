# Release log — GF TimeTonic 1.1.0

Repository: wpconnect-co/addon_gf-timetonic
Branch: release/1.1.0
Commit: 27291f343fa26a5d6bbaf18379af370d20360d4b
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
wpconnect-gf-timetonic.1.1.0.zip  (dist/wpconnect-gf-timetonic.1.1.0.zip, 36857 bytes — attached to TIM-97)

## Scope

In scope (11 issues + 3 review-wrappers → all For Test):
- TIM-20 / TIM-74 — load_plugin_textdomain moved to `init` (WP 6.7 just-in-time fix); manual load kept.
- TIM-65 — textdomain loading corrected (full removal deferred with TranslationsPress / TIM-92).
- TIM-63 — PHP 7.4 minimum + Gravity Forms tested up to 2.10.
- TIM-68 — WordPress 7.0 compatibility.
- TIM-60 — plugin-row "site" link → https://wpconnect.co/timetonic-integration-wordpress/ (Plugin URI).
- TIM-40 / TIM-72 — field-mapping first-field selectable without clicking X.
- TIM-59 / TIM-70 — updater no longer affects other plugins' update entries.
- TIM-58 — license status admin notices (expired / disabled / not-activated / update-unavailable).
- TIM-64 — support + documentation links on the settings page.
- TIM-30 — readme.txt updated (Stable tag 1.1.0, Tested up to 7.0, PHP 7.4, GF 2.10, changelog).
- TIM-42 — README.md technical doc (repo root; excluded from ZIP).

Deferred (NOT built — pending clarification):
- TIM-9 (French translation), TIM-92 (TranslationsPress migration), TIM-11 (file-upload bug).

Reference: adapted from GF Airtable (addon_gf-at 2.6.0) — same file structure. Not a literal copy.

## PO Stories

No /stories run for this version. Story-quality validation performed inline during Phase 1 discovery (TIM-9, TIM-92 flagged empty → deferred; TIM-11 needs Loom repro → deferred).

## Workflow Status History

| Issue | Transition | Timestamp (UTC) |
|---|---|---|
| TIM-65 | Todo → In Progress | 2026-08-13T21:00:29Z |
| TIM-20 | Todo → In Progress | 2026-08-13T21:00:31Z |
| TIM-74 | Todo → In Progress | 2026-08-13T21:00:32Z |
| TIM-63 | Todo → In Progress | 2026-08-13T21:00:34Z |
| TIM-68 | Todo → In Progress | 2026-08-13T21:00:36Z |
| TIM-60 | Todo → In Progress | 2026-08-13T21:00:38Z |
| TIM-40 | Todo → In Progress | 2026-08-13T21:00:40Z |
| TIM-72 | Todo → In Progress | 2026-08-13T21:00:41Z |
| TIM-59 | Todo → In Progress | 2026-08-13T21:00:43Z |
| TIM-70 | Todo → In Progress | 2026-08-13T21:00:46Z |
| TIM-58 | Todo → In Progress | 2026-08-13T21:00:48Z |
| TIM-64 | Todo → In Progress | 2026-08-13T21:00:50Z |
| TIM-30 | Todo → In Progress | 2026-08-13T21:00:52Z |
| TIM-42 | Todo → In Progress | 2026-08-13T21:00:54Z |
| TIM-65,20,74,63,68,60,40,72,59,70,58,64,30,42 | In Progress → For Test | 2026-08-13T21:26:32–50Z |
| TIM-97 (QA issue) | created → For Test | 2026-08-13T21:27:12Z |

## Next step

Human QA tests the ZIP. On approval, finalize with `/tested GF TimeTonic 1.1.0`.
