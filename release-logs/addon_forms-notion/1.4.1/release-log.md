# Release log — WPForms Notion 1.4.1

Repository: wpconnect-co/addon_forms-notion
Branch: test/1.4.1
Commit: bf7ba73
Date: 2026-06-11

## QA Tracking

QA Issue:
Update WPForms Notion 1.4.1

Linear ID:
WPFNO-36 (https://linear.app/wp-connect/issue/WPFNO-36/update-wpforms-notion-141)

Linear Project:
WPForms Notion v1.4.1

Status:
For Test

ZIP:
wpconnect-wpf-notion.1.4.1.zip

## PO Stories

No /stories run for this version

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| WPFNO-32 | Todo → In Progress | 2026-06-11T16:31:34Z |
| WPFNO-33 | Todo → In Progress | 2026-06-11T16:31:35Z |
| WPFNO-35 | Todo → In Progress | 2026-06-11T16:31:41Z |
| WPFNO-32 | In Progress → For Test | 2026-06-11T16:34:18Z |
| WPFNO-33 | In Progress → For Test | 2026-06-11T16:34:20Z |
| WPFNO-35 | In Progress → For Test | 2026-06-11T16:34:21Z |
| WPFNO-36 | created → For Test | 2026-06-11T15:16:25Z |
| WPFNO-36 | project assigned (WPForms Notion v1.4.1) | 2026-06-11T16:34:22Z |

## QA Fixes (post-package, same version)

Found during human QA on WordPress 6.7 (WP_DEBUG log):

`Function _load_textdomain_just_in_time was called incorrectly` for the `wpconnect-wpf-notion` domain (translation triggered before `init`).

- **Fix commit:** `5e0af10` on `release/1.4.1`
- **Change:** `get_requirements()` no longer translates during `plugins_loaded`; returns stable untranslated keys, with translatable labels moved to `notice_for_missing_requirements()` (admin_notices, after init). Text domain now loads on `init`.
- **Repackaged** the same version and **replaced** the ZIP attached to the QA issue (old attachment deleted, corrected build uploaded). ZIP verified to contain the fix.
- No version bump (per QA decision to iterate on the release branch before /tested).

## Changelog house-format (2026-07-20)

readme.txt changelog aligned to the wpconnect house style (`*Release Date: ...*` + `* ` bullets, order Compatibility → Feature → Improvement → Fix). Release dates added from git tags (1.4.1 dated 21st July 2026 as the current QA release). Commit `76f2950` on `release/1.4.1`; ZIP re-attached to WPFNO-36 (attachment `4b6c8ba3`, SHA `1052c7b8e3fe1d5c6352e83f2d2b9271e32a55c2a7d2b95c31c94f7447bb2a94`).
