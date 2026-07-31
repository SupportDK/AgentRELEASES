# Release log — Add-On for Contact Form 7 to Airtable 2.5.3

Repository: wpconnect-co/addon_cf7-airtable
Branch: release/2.5.3
Commit: c04dbf56c9742c68f34dfbd51ca375f1a43e3020
Date: 2026-07-31

## Summary

Resolves the WordPress.org Plugin Directory review findings (CF7AT-56) plus the readme update (CF7AT-57):

- Improvement: Declared `License: GPLv2 or later` / `License URI` in the plugin header (previously only in readme.txt).
- Improvement: Declared `Requires Plugins: contact-form-7` in the plugin header.
- Fix: Attachment URLs now built from `wp_upload_dir()` basedir → baseurl mapping (with `wp_normalize_path()` prefix guard) instead of the brittle `ABSPATH`/`home_url()` conversion in `includes/fields.php`; robust for custom/symlinked/multisite/non-standard upload locations.
- Version bumped to 2.5.3 (`Version:` header, `WPCONNECT_WPCF7_AT_VERSION` constant, readme.txt `Stable tag:`); changelog entry added to `changelog.txt` and `readme.txt`.

Product-owner review: **APPROVED** (all CF7AT-56 acceptance criteria PASS). Sweep confirmed `fields.php:400` was the only offending path→URL conversion in the plugin.

## QA Tracking

QA Issue:
Update CF7 Airtable 2.5.3

Linear ID:
CF7AT-58  (https://linear.app/wp-connect/issue/CF7AT-58/update-cf7-airtable-253)

Linear Project:
CF7 Airtable v2.5.3

Status:
For Test

ZIP:
add-on-cf7-for-airtable.2.5.3.zip  (attached to CF7AT-58; local: dist/add-on-cf7-for-airtable.2.5.3.zip)

## PO Stories

No /stories run for this version.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| CF7AT-56 | Todo → In Progress | 2026-07-31T11:36:18Z |
| CF7AT-57 | Todo → In Progress | 2026-07-31T11:36:24Z |
| CF7AT-58 (QA) | created → For Test | 2026-07-31T11:48:11Z |
| CF7AT-56 | In Progress → For Test | 2026-07-31T11:48:12Z |
| CF7AT-57 | In Progress → For Test | 2026-07-31T11:48:48Z |

## Restrictions honored

No tag, no GitHub Release, no PR merge, no wp.org/SVN deploy, no Linear issue closed. Finalization deferred to `/tested`.

Note: The Linear issue CF7AT-56 also lists WordPress.org SVN commit + review-team reply as steps — these are intentionally out of scope for `/release` and remain pending manual/`/tested` action after human QA.
