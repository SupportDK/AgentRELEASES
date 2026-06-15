# Release log — GF Airtable 2.6.0

Repository: wpconnect-co/addon_gf-at
Branch: release/2.6.0
Commit: 241882c67183a1ae4b91d5d8bd16172241843549
Date: 2026-06-15

## QA Tracking

QA Issue:
Update GF Airtable 2.6.0

Linear ID:
GFAT-140  (https://linear.app/wp-connect/issue/GFAT-140/update-gf-airtable-260)

Linear Project:
GF Airtable v2.6.0

Status:
For Test

ZIP:
wpconnect-gf-airtable.2.6.0.zip  (dist/wpconnect-gf-airtable.2.6.0.zip — attached to GFAT-140)

## Scope — issues in this version

| Issue | Title | Resolution |
|---|---|---|
| GFAT-139 | Paragraph field prepends `<html><body>` | `includes/hooks.php`: gate `HtmlConverter`/`wpautop` on `$field->useRichTextEditor`; non-rich-text → `wp_strip_all_tags()` |
| GFAT-137 | TranslationsPress functions | Ported from GF Notion (`port/translationspress-language-pack`) — `includes/classes/class-language-pack.php` + bootstrap wiring |
| GFAT-136 | Update WordPress 7.0 | `Tested up to: 7.0` |
| GFAT-138 | Add Required PHP and WP | `Requires at least: 6.0`, `Requires PHP: 7.4` in readme + main header |
| GFAT-117 | Readme | 2.6.0 changelog added; README issue moved to For Test |

Excluded: GFAT-118 (Canceled).

## PO Stories

No /stories run for this version. Issues validated inline during /release (Phase 1); customer tickets and project issues provided sufficient technical direction.

## Ported From

This release was built on top of the port branch `port/translationspress-language-pack`, which carries the **TranslationsPress language-pack integration ported from GF Notion** (`wpconnect-co/addon_gf-notion`) for GFAT-137.

- Port report: `port-logs/addon_gf-at/translationspress-language-pack/port-report.md`
- Port commit carried into this release: `5d12f15` — `feature: pull translations from TranslationsPress via language pack updater (ported from addon_gf-notion)`
- Adaptation highlight: t15s slug + TranslationsPress URL use the text domain `wpc-gf-at` (not the folder slug), matching the `/languages/wpc-gf-at-*.mo` prefix.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| GFAT-139 | Todo → In Progress | 2026-06-15T16:59:04Z |
| GFAT-139 | In Progress → For Test | 2026-06-15T17:10:14Z |
| GFAT-137 | Todo → In Progress | 2026-06-15T16:59:05Z |
| GFAT-137 | In Progress → For Test | 2026-06-15T17:10:15Z |
| GFAT-136 | Todo → In Progress | 2026-06-15T16:59:06Z |
| GFAT-136 | In Progress → For Test | 2026-06-15T17:10:17Z |
| GFAT-138 | Todo → In Progress | 2026-06-15T16:59:07Z |
| GFAT-138 | In Progress → For Test | 2026-06-15T17:10:18Z |
| GFAT-117 | Todo → In Progress | 2026-06-15T16:59:09Z |
| GFAT-117 | In Progress → For Test | 2026-06-15T17:19:15Z |
| GFAT-140 (QA) | created → For Test | 2026-06-15T17:10:34Z |

## Next step

After human QA approval: `/tested GF Airtable 2.6.0` (tags v2.6.0, moves issues to terminal state, updates this log).
