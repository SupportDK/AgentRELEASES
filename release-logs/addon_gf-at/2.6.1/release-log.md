# Release log — GF Airtable 2.6.1

Repository: wpconnect-co/addon_gf-at
Branch: release/2.6.1
Commit: fd528240036720aae896008e6e73854fb25bed33
Date: 2026-11-17

## QA Tracking

QA Issue:
Update GF Airtable 2.6.1

Linear ID:
GFAT-156  (https://linear.app/wp-connect/issue/GFAT-156/update-gf-airtable-261)

Linear Project:
GF Airtable v2.6.1

Status:
For Test

ZIP:
wpconnect-gf-airtable.2.6.1.zip  (dist/wpconnect-gf-airtable.2.6.1.zip — attached to GFAT-156, 120858 bytes)

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
