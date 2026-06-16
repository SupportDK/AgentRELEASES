# Release log — GF SendGrid 1.9.0

Repository: wpconnect-co/addon_gf-sendgrid
Branch: release/1.9.0
Commit: e1badb8fc89128914a5de5116121ba0a026d77c3
Date: 2026-06-15

> Note: package re-built on 2026-06-16 with commit `9bab98c` — **structure alignment with the TranslationsPress source**. The port had kept the bundled `languages/` directory (`.mo`/`.po`/`.pot`), the local `load_plugin_textdomain()` loader and the `Domain Path` header, whereas the reference plugin (`addon_gf-notion`) removed all of them as part of the TranslationsPress migration. These were removed so translations are served exclusively from translationspress.com (loaded just-in-time by WP core from `wp-content/languages/plugins/`). QA ZIP on GFSG-81 re-attached.
>
> Note: package re-built on 2026-06-16 with commit `e1badb8` — **text-domain / slug fix (translations were not loading in QA)**. The TranslationsPress project slug is `wpconnect-gf-sendgrid` (packs ship `wpconnect-gf-sendgrid-{locale}.mo`), but the port pointed the t15s slug + packages.json URL at the text domain `wpc-gf-sg` (HTTP 403 → nothing downloaded; and a name mismatch even if it had). Aligned the plugin text domain to `wpconnect-gf-sendgrid` (header + all gettext calls) and fixed the language-pack slug + URL, matching GF Notion's working model. Hook names (`wpc-gf-sg/*`) unchanged. QA ZIP on GFSG-81 re-attached. See the port report's "Text-domain / slug fix" section.

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
- Adaptation highlight: namespace `WPCONNECT_GF_SG`; t15s slug + TranslationsPress URL use the text domain `wpc-gf-sg` (not the folder slug), so the packs are keyed on `wpc-gf-sg-*`.
- Structure correction (`9bab98c`, 2026-06-16): the bundled `languages/` directory, the local `load_plugin_textdomain()` loader and the `Domain Path` header were removed to match the source's TranslationsPress migration — the initial port had left them in place. See the port report's "Structure correction" section.

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
