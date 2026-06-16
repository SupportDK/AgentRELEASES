# Release log — GF Airtable 2.6.0

Repository: wpconnect-co/addon_gf-at
Branch: release/2.6.0
Commit: f6c429374ccb395d0944375642b156d085100cfe
Date: 2026-06-15

> Note: package re-built and re-pushed on 2026-06-15 with commit `9764929` — runtime requirement guard aligned to the declared WP 6.0 / PHP 7.4 minimums (GFAT-138 follow-up). QA ZIP on GFAT-140 was re-attached.
>
> Note: package re-built on 2026-06-16 with commit `f6c4293` — **structure alignment with the TranslationsPress source**. The port had kept the bundled `languages/` directory (`.mo`/`.po`/`.pot`), the local `load_plugin_textdomain()` loader and the `Domain Path` header, whereas the reference plugin (`addon_gf-notion`) removed all of them as part of the TranslationsPress migration. These were removed so translations are served exclusively from translationspress.com (loaded just-in-time by WP core from `wp-content/languages/plugins/`). QA ZIP on GFAT-140 must be re-attached.

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
| GFAT-138 | Add Required PHP and WP | `Requires at least: 6.0`, `Requires PHP: 7.4` in readme + main header; runtime guard `meets_requirements()` tightened to enforce the same minimums |
| GFAT-117 | Readme | 2.6.0 changelog added; README issue moved to For Test |

Excluded: GFAT-118 (Canceled).

## PO Stories

No /stories run for this version. Issues validated inline during /release (Phase 1); customer tickets and project issues provided sufficient technical direction.

## Ported From

This release was built on top of the port branch `port/translationspress-language-pack`, which carries the **TranslationsPress language-pack integration ported from GF Notion** (`wpconnect-co/addon_gf-notion`) for GFAT-137.

- Port report: `port-logs/addon_gf-at/translationspress-language-pack/port-report.md`
- Port commit carried into this release: `5d12f15` — `feature: pull translations from TranslationsPress via language pack updater (ported from addon_gf-notion)`
- Adaptation highlight: t15s slug + TranslationsPress URL use the text domain `wpc-gf-at` (not the folder slug), so the packs are keyed on `wpc-gf-at-*`.
- Structure correction (`f6c4293`, 2026-06-16): the bundled `languages/` directory, the local `load_plugin_textdomain()` loader and the `Domain Path` header were removed to match the source's TranslationsPress migration — the initial port had left them in place. See the port report's "Structure correction" section.

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
