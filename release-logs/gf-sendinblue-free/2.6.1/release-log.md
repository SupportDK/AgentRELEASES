# Release log — GF Brevo Free 2.6.1

Repository: wpconnect-co/gf-sendinblue-free
Branch: release/2.6.1
Commit: a55daff8f649296f157e1a4cf737c7a2e9be3aca
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

## Next step

After human QA approval: `/tested GF Brevo Free 2.6.1` (tags v2.6.1, moves issues to a completed state, updates this log).
