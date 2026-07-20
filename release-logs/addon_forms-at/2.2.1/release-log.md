# Release log — WPForms Airtable 2.2.1

Repository: wpconnect-co/addon_forms-at
Branch: test/2.2.1
Commit: b9d40b1
Date: 2026-06-11

## QA Tracking

QA Issue:
Update WPForms Airtable 2.2.1

Linear ID:
WPFAT-36 (https://linear.app/wp-connect/issue/WPFAT-36/update-wpforms-airtable-221)

Linear Project:
WPForms Airtable v2.2.1

Status:
For Test

ZIP:
wpconnect-wpf-airtable.2.2.1.zip

## PO Stories

[po-stories.md](./po-stories.md) — 4 issues refinados (WPFAT-32/33/34/35); stories creadas antes del release con /stories.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| WPFAT-32 | Backlog → In Progress | 2026-06-11T17:00:17Z |
| WPFAT-33 | Backlog → In Progress | 2026-06-11T17:00:21Z |
| WPFAT-34 | Backlog → In Progress | 2026-06-11T17:00:24Z |
| WPFAT-35 | Backlog → In Progress | 2026-06-11T17:00:28Z |
| WPFAT-32 | In Progress → For Test | 2026-06-11T17:14:13Z |
| WPFAT-33 | In Progress → For Test | 2026-06-11T17:14:14Z |
| WPFAT-34 | In Progress → For Test | 2026-06-11T17:14:15Z |
| WPFAT-35 | In Progress → For Test | 2026-06-11T17:14:17Z |
| WPFAT-36 | created → For Test | 2026-06-11T17:14:32Z |

## QA Fixes (post-package, same version)

Found during human QA on WordPress 6.7 (WP_DEBUG log):

`Function _load_textdomain_just_in_time was called incorrectly` for the `wpconnect-wpf-airtable` domain (translation triggered before `init`).

- **Fix commit:** `e122b4d` on `release/2.2.1`
- **Change:** `get_requirements()` no longer translates during `plugins_loaded`; returns stable untranslated keys, with translatable labels moved to `notice_for_missing_requirements()` (admin_notices, after init). Text domain now loads on `init`.
- **Repackaged** the same version and **replaced** the ZIP attached to the QA issue (old attachment deleted, corrected build uploaded). ZIP verified to contain the fix.
- No version bump (per QA decision to iterate on the release branch before /tested).

## Changelog house-format (2026-07-20)

readme.txt changelog aligned to the wpconnect house style (`*Release Date: ...*` + `* ` bullets, order Compatibility → Feature → Improvement → Fix). Release dates added from git tags (2.2.1 dated 21st July 2026 as the current QA release). Commit `ce81cd5` on `release/2.2.1`; ZIP re-attached to WPFAT-36 (attachment `883f60a6`, SHA `5cc1c166e1ceb2ef1fad2efbce0ec1a80472dc2b49d51cb0295ce2efd5687e56`).
