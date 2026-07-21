# Release log — GF Brevo Free 2.6.1

Repository: wpconnect-co/gf-sendinblue-free
Branch: release/2.6.1
Commit: 501cd0c (QA-prep corrections; supersedes a55daff)
Date: 2026-07-21

## QA Tracking

QA Issue:
Update GF Brevo Free 2.6.1

Linear ID:
GFSIB-288  (https://linear.app/wp-connect/issue/GFSIB-288/update-gf-brevo-free-261)

Linear Project:
GF Brevo Free v2.6.1  (id: aeaa80a5-afd8-4bdc-bfda-d65707d17d24) — verified

Status:
For Test

ZIP:
addon-gravityforms-sendinblue-free.2.6.1.zip  (dist/addon-gravityforms-sendinblue-free.2.6.1.zip, attached to GFSIB-288)

## Issues in scope

| Issue | Title | Label |
|---|---|---|
| GFSIB-220 | Align platform requirements: PHP 7.4 minimum + GF tested up to 2.10 | Improvement |
| GFSIB-224 | Add support and documentation links to the plugin settings page | Improvement |
| GFSIB-212 | Update WordPress 7.0 (Tested up to) | Update |
| GFSIB-182 | Readme (changelog/readme update) | Readme |

## PO Stories

No /stories run for this version. Story-quality validated inline during Phase 1 (GFSIB-212 and GFSIB-182 were thin but unambiguous).

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| GFSIB-220 | Backlog → In Progress | 2026-07-21T11:38:37Z |
| GFSIB-224 | Backlog → In Progress | 2026-07-21T11:38:40Z |
| GFSIB-212 | Backlog → In Progress | 2026-07-21T11:38:41Z |
| GFSIB-182 | Backlog → In Progress | 2026-07-21T11:38:43Z |
| GFSIB-220 | In Progress → For Test | 2026-07-21T13:09:41Z |
| GFSIB-224 | In Progress → For Test | 2026-07-21T13:09:43Z |
| GFSIB-212 | In Progress → For Test | 2026-07-21T13:09:44Z |
| GFSIB-182 | In Progress → For Test | 2026-07-21T13:10:40Z |
| GFSIB-288 (QA) | created → For Test | 2026-07-21T13:09:59Z |

## Notes

- Packaging: top-level ZIP folder is `addon-gravityforms-sendinblue-free/` (main-file basename, matching the wp.org slug), not the GitHub repo name `gf-sendinblue-free`. Built with `wp dist-archive ./ --plugin-dirname=addon-gravityforms-sendinblue-free`.
- `scripts/sync-linear-template.mjs` ships in the package (present on `main` from a prior ci sync commit); consistent with the QA-approved GF Notion 2.0.1 package, so left as-is.

## QA-prep corrections (2026-07-21, post-package)

Two issues reported against the initial 2.6.1 QA package were fixed on `release/2.6.1` (commit `501cd0c`) and the QA ZIP was rebuilt in place:

- **Wrong support link (free plugin).** The Support link on the settings page (`includes/classes/gf-addon.php`, from GFSIB-224) pointed to `https://support.wpconnect.co` — that is the paid-product support desk. Repointed to the plugin's own wp.org forum `https://wordpress.org/support/plugin/addon-gravityforms-sendinblue-free/`. Also fixed the readme.txt Troubleshooting link, which pointed to the `air-wp-sync` forum (copy-paste error).
- **Minimum WordPress version not shown on install.** The main plugin file header was missing `Requires at least:`, so WordPress showed no minimum WP version. Added `Requires at least: 6.0` to the header (matching the other GF add-ons) and aligned `readme.txt` (was 5.5 → 6.0).

Rebuilt: `dist/addon-gravityforms-sendinblue-free.2.6.1.zip` (contains both fixes; verified). Re-attach/notify on GFSIB-288 so QA tests this build.

## Next step

After human QA approval: `/tested GF Brevo Free 2.6.1` (tags v2.6.1, moves issues to a completed state, updates this log).
