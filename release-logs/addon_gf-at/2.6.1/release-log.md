# Release log — GF Airtable 2.6.1

Repository: wpconnect-co/addon_gf-at
Branch: release/2.6.1
Commit: 1a36bfbd44038d0ef9fadc73cf1228426faef0c0 (QA-approved head; original QA build fd52824)
Date: 2026-11-17

## QA Tracking

QA Issue:
Update GF Airtable 2.6.1

Linear ID:
GFAT-156  (https://linear.app/wp-connect/issue/GFAT-156/update-gf-airtable-261)

Linear Project:
GF Airtable v2.6.1

Status:
Closed  (finalized by /tested 2026-11-17 after explicit human QA approval by Cris)

ZIP:
wpconnect-gf-airtable.2.6.1.zip  (dist/wpconnect-gf-airtable.2.6.1.zip — revised build from release/2.6.1 @ 1a36bfb, 122199 bytes, SHA-256 e01f1d2598901385b251b9665ff8eaa0cadb534f33b262d33d50b0dd452f25b3, attached to GFAT-156; this is the ZIP approved in QA)

Tag:
none created by /tested (operator instruction; repo has tag-and-deploy.yml — tag 2.6.1 + GitHub Release + deploy are produced by the pipeline when release/2.6.1 is merged to main, which was NOT done here)

GitHub Release:
not created

## Scope — issues in this version

| Issue | Title | Resolution |
|---|---|---|
| GFAT-152 | Licensing: send full home_url() (www / non-www bug) | `includes/classes/class-api-licensing.php`: shared `$args['url']` (activate/deactivate/check) now `home_url()`; updater untouched |
| GFAT-149 | Add WP connect logo to the settings page | `plugin_settings_page()` override renders a standalone logo banner (`assets/images/wpconnect-logo.png`) before Gravity Forms' settings, same as GF Brevo 2.9.1 / GF Dialog Insight |
| GFAT-148 | Update WordPress to 7.1 compatibility | readme.txt `Tested up to: 7.1` |
| GFAT-142 | Readme | 2.6.1 changelog entry in readme.txt; Readme issue description set and moved to For Test |

Commits on release/2.6.1 (base main @ d33177f):

- 807b007 fix: license activation and validation on www sites (send full site URL)
- 1dd5e85 improvement: WP connect logo added to the settings page
- fd52824 compatibility: WordPress 7.1 (bump to 2.6.1, changelog)

PO review: APPROVED (cycle 1). Runtime checks left to human QA: www license activation/check/update
download (HTTP 200), non-www regression, logo rendering, WP 7.1 smoke test.

Packaging: `wp dist-archive` is not registered in this environment, so the ZIP was built with the
/package fallback (git archive of HEAD filtered by `.distignore`). Verified: single top folder
`wpconnect-gf-airtable/` (= Text Domain), 70 files, committed `vendor/autoload.php` +
`league/html-to-markdown` present, logo asset present, header/constant at 2.6.1, no dev cruft.

House-style note: this premium plugin has no `changelog.txt` and keeps the full changelog inline in
readme.txt (no verified wpconnect.co changelog URL), so the 2.6.1 entry was added inline, consistent
with 2.6.0 and GF Brevo 2.9.1. Migration to changelog.txt + link-only readme section is a follow-up.
`package.json` version (2.5.0) was already stale and left untouched.

## PO Stories

No /stories run for this version. Issues carried explicit acceptance criteria; validated inline.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| GFAT-152 | Todo → In Progress | 2026-11-17T09:14:33Z |
| GFAT-149 | Backlog → In Progress | 2026-11-17T09:14:34Z |
| GFAT-148 | Backlog → In Progress | 2026-11-17T09:14:35Z |
| GFAT-142 | Backlog → In Progress | 2026-11-17T09:14:36Z |
| GFAT-152 | In Progress → For Test | 2026-11-17T09:16:22Z |
| GFAT-149 | In Progress → For Test | 2026-11-17T09:16:24Z |
| GFAT-148 | In Progress → For Test | 2026-11-17T09:16:26Z |
| GFAT-156 (QA) | created → For Test | 2026-11-17T09:16:35Z |
| GFAT-142 | In Progress → For Test | 2026-11-17T09:16:56Z |
| GFAT-152 | For Test → Closed | 2026-11-17T10:59:54Z |
| GFAT-149 | For Test → Closed | 2026-11-17T10:59:56Z |
| GFAT-148 | For Test → Closed | 2026-11-17T10:59:57Z |
| GFAT-156 (QA) | For Test → Closed | 2026-11-17T10:59:53Z |
| GFAT-142 | For Test → Closed | 2026-11-17T10:59:58Z |

## Finalization (/tested, 2026-11-17)

- Human QA approval: explicit, by Cris, for the revised ZIP above (SHA-256 verified locally before finalizing).
- Verified: origin/release/2.6.1 = 1a36bfbd44038d0ef9fadc73cf1228426faef0c0; all 5 issues were in For Test.
- Commit added after the original QA build: 1a36bfb improvement: Help section with Documentation and Support links on the global settings page (included in the approved ZIP).
- Not done, per operator instruction: no merge of release/2.6.1 into main, no tag, no GitHub Release, no production deploy.
- Issues: Closed, assigned to support@wpconnect.co; GFAT-156 filled with Medium / XS + label Update.
- Project GF Airtable v2.6.1 (P-GFAT-257): Completed, target date 2026-11-17, color #bec2c8.
- Next project: GF Airtable v2.6.2 (P-GFAT-319) already exists holding planned issues (GFAT-141, GFAT-144, …), so it was left untouched; created GF Airtable v2.6.3 (P-GFAT-334, Database / #f2c94c / Low / lead support@wpconnect.co) seeded with GFAT-157 Readme and GFAT-158 New Strings to translate.
- Carry-overs: none (no open issues left in v2.6.1).
- Follow-up: GFAT-144 (support and documentation links on the settings page, in v2.6.2) looks implemented by commit 1a36bfb shipped in 2.6.1; needs a human decision (close as shipped in 2.6.1 or keep).
