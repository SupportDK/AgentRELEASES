# Release log — CF7 Airtable 2.5.2

Repository: wpconnect-co/addon_cf7-airtable
Branch: release/2.5.2
Commit: 6111205
Date: 2026-07-20

## Post-QA changes (2026-07-20)

After CF7AT-55 was marked Done (no v2.5.2 tag created yet), additional changes were pushed to `release/2.5.2` at the user's request; these live in git and will be included when `/tested` tags the branch:

- `load_translations` moved to `init` priority 5 (was `plugins_loaded`) — WordPress 6.7 best practice; behaviorally inert here.
- `changelog.txt` + `readme.txt`: release dates added (from git tags) and entries reorganized (Compatibility with WordPress → Feature → Improvement → Fix, single line breaks). Tags limited to Fix/Improvement/Feature. Versions 1.0.0/1.0.1/1.0.2/1.1.0/1.1.1 have no tag, left undated.
- `readme.md` (developer doc, not shipped): TranslationsPress references removed.

The Linear QA ZIP on CF7AT-55 (Done) was intentionally left as the originally-approved build; final branch commit is `05052f7`.

## QA Tracking

QA Issue:
Update CF7 Airtable 2.5.2

Linear ID:
CF7AT-55 (https://linear.app/wp-connect/issue/CF7AT-55/update-cf7-airtable-252)

Linear Project:
CF7 Airtable v2.5.2

Status:
For Test

ZIP:
add-on-cf7-for-airtable.2.5.2.zip

## PO Stories

No /stories run for this version. Issues refined inline during Phase 1 (product-owner). CF7AT-51 was already well-written; CF7AT-52/53 had minimal descriptions resolved during implementation.

## Scope

- CF7AT-51 — Modifications WP.org (remove TranslationsPress, prefix AJAX action + JS object, readme compliance, version bump)
- CF7AT-54 — Restore WordPress.org-managed translations (contained within CF7AT-51)
- CF7AT-52 — Readme (External services rewrite + 2.5.2 changelog) — README issue; description updated for docs automation
- CF7AT-53 — New Strings to translate — no new translatable strings; recommend Cancel during /tested

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| CF7AT-51 | Backlog → In Progress | 2026-07-20T14:39:25Z |
| CF7AT-54 | Backlog → In Progress | 2026-07-20T14:39:27Z |
| CF7AT-52 | Backlog → In Progress | 2026-07-20T14:39:28Z |
| CF7AT-53 | Backlog → In Progress | 2026-07-20T14:39:29Z |
| CF7AT-51 | In Progress → For Test | 2026-07-20T14:49:48Z |
| CF7AT-54 | In Progress → For Test | 2026-07-20T14:49:49Z |
| CF7AT-52 | In Progress → For Test | 2026-07-20T14:49:51Z |
| CF7AT-53 | In Progress → For Test | 2026-07-20T14:49:52Z |
| CF7AT-55 | created → For Test | 2026-07-20T14:50:09Z |

## Changelog house-format (2026-07-20)

changelog.txt + readme.txt aligned to the wpconnect house style (matching air-wp-sync / orders-sync): `*Release Date: Nth Month YYYY*` + `* ` bullets, order Compatibility → Feature → Improvement → Fix. Historical release dates added (git tags + GitHub releases; oldest from git history). 1.1.1 left undated (no tag/release). Final commit `61ca6e5` (git only — CF7AT-55 Done, QA ZIP unchanged).

## Readme structure unified (2026-07-20)

readme.txt aligned to the shared CF7 free-add-on structure: added "How does it work? How to use it?" (after Installation) and "Support" (after Changelog). Section order now matches CF7 Notion exactly: Description → Features → Installation → How does it work? → FAQ → External services → Screenshots → Changelog → Support → Troubleshooting. Commit `88e46c9` (git only — CF7AT-55 Done).
