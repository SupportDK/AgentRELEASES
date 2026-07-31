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
Done  (tag v2.5.3 pushed)

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
| CF7AT-58 (QA) | For Test → Done | 2026-07-31T12:48:59Z |
| CF7AT-56 | For Test → Done | 2026-07-31T12:48:55Z |
| CF7AT-57 | For Test → Done | 2026-07-31T12:48:57Z |

## Finalization (/tested)

- QA approved by human tester on 2026-07-31 (ZIP activates correctly, changes work, no blockers).
- Tag: **v2.5.3** pushed to `origin` on head of `release/2.5.3` (`c04dbf56c9742c68f34dfbd51ca375f1a43e3020`).
- GitHub Release: not created (not part of this plugin's workflow / per user request).
- Terminal state used: **Done** (team "CF7 Airtable" has two completed-type states — Closed and Done; Done was chosen per the Complete/Done preference rule).
- Issues closed: CF7AT-56, CF7AT-57, QA issue CF7AT-58.

## WordPress.org publication (post-/tested manual step)

- SVN deploy completed 2026-07-31: `trunk/` bumped to 2.5.3 and `tags/2.5.3/` created in a single commit — **r3630039** (committer `wpconnectco`).
- `trunk/readme.txt` `Stable tag: 2.5.3` → release published to users.
- Files changed in trunk: `add-on-cf7-for-airtable.php`, `changelog.txt`, `includes/fields.php`, `readme.txt` (same file set as 2.5.2; no adds/removes).
- Source of truth for the SVN sync: the QA-approved ZIP `dist/add-on-cf7-for-airtable.2.5.3.zip` (distributable file set only — no dev/, node_modules, package.json, readme.md).

Still pending (manual): reply to the WordPress Plugins Team review (ID `P0TDX156090HGN`) confirming 2.5.3 addresses all three findings and is uploaded to SVN.
