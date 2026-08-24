# Release log — GF Brevo Free 2.6.2

Repository: wpconnect-co/gf-sendinblue-free
Branch: release/2.6.2
Commit: 9b1fcf1 (HEAD; history: e7c3240 GFSIB-295, e9f3f4e GFSIB-296, 1d7444e WP 7.1, a053896 API error details, ac6a6d8 404 endpoint fix, 9b1fcf1 GFSIB-298)
Date: 2026-08-24

## QA Tracking

QA Issue:
Update GF Brevo Free 2.6.2

Linear ID:
GFSIB-297  (https://linear.app/wp-connect/issue/GFSIB-297/update-gf-brevo-free-262)

Linear Project:
GF Brevo Free v2.6.2

Status:
Done (released)

ZIP:
addon-gravityforms-sendinblue-free.2.6.2.zip (attached to GFSIB-297; also on the GitHub Release)

Tag:
2.6.2 (created by the auto tag-and-deploy pipeline on merge of PR #12)

GitHub Release:
https://github.com/wpconnect-co/gf-sendinblue-free/releases/tag/2.6.2

wp.org:
deployed — trunk Stable tag 2.6.2, Tested up to 7.1 (pipeline run 32720780713)

## Scope

- GFSIB-295 — Declare GPL license and document the Brevo external service (Improvement, wp.org compliance)
- GFSIB-296 — Feed settings: show Brevo API errors instead of silently hiding the "Add to list" section (Fix)
- GFSIB-298 — Free version allowed mapping Pro-only attributes: admin.js disabling never ran (GF renders the map after DOM ready; observer targeted a not-yet-existing tbody) and process_feed had no server-side filter. Fixed: MutationObserver on the section (subtree), cache buster bump, and save_feed_settings() now strips non-allowed keys (EMAIL + boolean attributes, fail-open on API error). Commit 9b1fcf1 (Bug, found during QA)
- GFSIB-290 — New Strings to translate (answered: 3 new strings, comment on the issue)
- GFSIB-289 — Readme (changelog block set, For Test)
- Compatibility with WordPress 7.1 (`Tested up to: 7.1`, commit 1d7444e — added post-review on user request)
- Improvement: API errors now surface Brevo response details — message + code — for all error codes, not only missing_parameter/invalid_parameter (commit a053896, api-sendinblue.php request(); prompted by an uninformative generic 404 during QA).
- Fix: ROOT CAUSE of the missing list selector found during QA — Brevo now 404s the trailing-slash route `contacts/lists/`; aligned with Pro (`contacts/lists`), commit ac6a6d8. ZIP and QA attachment regenerated (final build 9b1fcf1).

## Context

GFSIB-296 originates from a user report that the "Add to list" selector no longer appears in feed settings: the field is only rendered when the Brevo lists API call succeeds with ≥1 list; WP_Error/empty results were silently swallowed. Related: the wp.org readme of 2.6.1 was hot-fixed on 2026-08-24 (SVN r3663105, readme-only, no release) to tag multi-list selection as Pro.

## PO Stories

No /stories run for this version (both issues carried complete acceptance criteria; brief produced inline by product-owner agent).

## Workflow Status History

| Issue | Transition | Timestamp (UTC) |
|---|---|---|
| GFSIB-295 | Backlog → In Progress | 2026-08-24 10:22:19 |
| GFSIB-296 | Backlog → In Progress | 2026-08-24 10:22:20 |
| GFSIB-290 | Backlog → In Progress | 2026-08-24 10:22:22 |
| GFSIB-295 | In Progress → For Test | 2026-08-24 10:27:55 |
| GFSIB-296 | In Progress → For Test | 2026-08-24 10:27:56 |
| GFSIB-290 | In Progress → For Test | 2026-08-24 10:27:58 |
| GFSIB-297 (QA) | created → For Test | 2026-08-24 10:28:15 |
| GFSIB-289 (Readme) | Backlog → For Test | 2026-08-24 10:28:42 |
| GFSIB-298 | created (In Progress) → For Test | 2026-08-24 11:03:21 |
| GFSIB-295 | For Test → Done | 2026-08-24 11:16:18 |
| GFSIB-296 | For Test → Done | 2026-08-24 11:16:19 |
| GFSIB-298 | For Test → Done | 2026-08-24 11:16:20 |
| GFSIB-290 | For Test → Done | 2026-08-24 11:16:22 |
| GFSIB-289 | For Test → Done | 2026-08-24 11:16:23 |
| GFSIB-297 (QA) | For Test → Done | 2026-08-24 11:16:25 |

## Finalized

2026-08-24 via /tested: QA confirmed by human (build 9b1fcf1). PR #12 release/2.6.2 → main merged; pipeline auto-tagged 2.6.2, created the GitHub Release and deployed to wp.org (verified: trunk Stable tag 2.6.2 / Tested up to 7.1). All issues Done.
