# Release log — GF SendGrid 1.9.0

Repository: wpconnect-co/addon_gf-sendgrid
Branch: release/1.9.0
Commit: bcb86518fbf717a7abe6f9c336594ddc4abb91c4
Date: 2026-06-15

## QA Tracking

QA Issue:
Update GF SendGrid 1.9.0

Linear ID:
GFSG-81  (https://linear.app/wp-connect/issue/GFSG-81/update-gf-sendgrid-190)

Linear Project:
GF SendGrid v1.9.0

Status:
For Test

ZIP:
wpconnect-gf-sendgrid.1.9.0.zip  (dist/wpconnect-gf-sendgrid.1.9.0.zip — attached to GFSG-81)

## Scope — issues in this version

| Issue | Title | Resolution |
|---|---|---|
| GFSG-78 | TranslationsPress functions | Ported from GF Notion (`port/translationspress-language-pack`) — `includes/classes/class-language-pack.php` + bootstrap wiring |
| GFSG-79 | Update WordPress 7.0 | `Tested up to: 7.0` (readme + header) |
| GFSG-80 | Add Required PHP and WP | `Requires at least: 6.0`, `Requires PHP: 7.4` in readme + header; runtime requirement guard tightened to match |
| GFSG-63 | Readme | 1.9.0 changelog added; README issue moved to For Test |

Excluded: GFSG-64 (Canceled).

## PO Stories

No /stories run for this version. Issues validated inline during /release (Phase 1).

## Ported From

This release was built on top of the port branch `port/translationspress-language-pack`, which carries the **TranslationsPress language-pack integration ported from GF Notion** (`wpconnect-co/addon_gf-notion`) for GFSG-78.

- Port report: `port-logs/addon_gf-sendgrid/translationspress-language-pack/port-report.md`
- Port commit carried into this release: `9119792` — `feature: pull translations from TranslationsPress via language pack updater (ported from addon_gf-notion)`
- Adaptation highlight: namespace `WPCONNECT_GF_SG`; t15s slug + TranslationsPress URL use the text domain `wpc-gf-sg` (not the folder slug), matching the `/languages/wpc-gf-sg-*.mo` prefix.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| GFSG-78 | Todo → In Progress | 2026-06-15T17:45:53Z |
| GFSG-78 | In Progress → For Test | 2026-06-15T17:53:12Z |
| GFSG-79 | Todo → In Progress | 2026-06-15T17:45:51Z |
| GFSG-79 | In Progress → For Test | 2026-06-15T17:53:10Z |
| GFSG-80 | Todo → In Progress | 2026-06-15T17:45:54Z |
| GFSG-80 | In Progress → For Test | 2026-06-15T17:53:13Z |
| GFSG-63 | Todo → In Progress | 2026-06-15T17:46:04Z |
| GFSG-63 | In Progress → For Test | 2026-06-15T17:54:45Z |
| GFSG-81 (QA) | created → For Test | 2026-06-15T17:53:24Z |

## Next step

After human QA approval: `/tested GF SendGrid 1.9.0` (tags v1.9.0, moves issues to terminal state, updates this log).
