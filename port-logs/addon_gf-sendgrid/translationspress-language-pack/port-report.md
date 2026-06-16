# Port report — TranslationsPress functions → GF SendGrid

Source: wpconnect-co/addon_gf-notion (read-only)
Target: wpconnect-co/addon_gf-sendgrid
Branch: port/translationspress-language-pack
Commit: 91197921bf36f3e98ba02a23e5bed3f9ae87a41e
Linear issue: GFSG-78 (spec only — not modified by /port)

## What was ported

The TranslationsPress (translationspress.com) language-pack auto-update integration: the self-contained `Language_Packs` (t15s-registry) class that injects translation data into WordPress's update mechanism so the plugin's translations are pulled and kept up to date from TranslationsPress even though the plugin is not hosted on WordPress.org.

It hooks `translations_api` and `site_transient_update_plugins` to serve translation data fetched (transient-cached, 2s HTTP timeout) from a `packages.json` endpoint, compares remote `updated` timestamps against locally installed translations, and lets WP core install the newer `.mo`/`.po` files. Cache is invalidated (15s debounce) on `set/delete_site_transient_update_plugins`.

## Source references

- `addon_gf-notion/includes/classes/language-pack.php` — `WPC_GF_NTN\Language_Packs` (methods `__construct`, `add_project`, `get_translations`, `register_clean_translations_cache`, `clean_translations_cache`). No Composer dependency; WP core only + PHP `DateTime`.
- `addon_gf-notion/wpconnect-gf-notion.php` — bootstrap: `init()` requires the class and registers `init_language_pack()` on `init`; `init_language_pack()` instantiates `Language_Packs('plugin', '<slug>', '<packages.json URL>')` and calls `add_project()`.

The Reference Implementation Report from the prior GF Airtable port was reused: the source repo is unchanged (clean, on `main`).

## Adaptations made for the target

| Aspect | Source (GF Notion) | Target (GF SendGrid) |
|---|---|---|
| Namespace | `WPC_GF_NTN` | **`WPCONNECT_GF_SG`** (full-word style — not `WPC_GF_SG`) |
| Class file name | `includes/classes/language-pack.php` | `includes/classes/class-language-pack.php` (target `class-*.php` convention) |
| ABSPATH guard | absent | `defined( 'ABSPATH' ) || exit;` added (matches sibling class files) |
| t15s slug | `wpconnect-gf-notion` | **`wpc-gf-sg`** |
| packages.json URL | `…/wp-connect/wpconnect-gf-notion/packages.json` | `https://packages.translationspress.com/wp-connect/wpc-gf-sg/packages.json` |
| Dir constant | `WPCONNECT_GF_NTN_DIR` | `WPCONNECT_GF_SG_DIR` |
| Bootstrap require | in `init()` | added in `init()` (L65) after the class-file block |
| `init` registration | in `init()` | added at end of `init()` (L83) |
| Indentation | mixed spaces in one method | normalized (WP tabs) |

**Key mapping decision — slug `wpc-gf-sg`, not the folder slug `wpconnect-gf-sendgrid`.** GF SendGrid's text domain is `wpc-gf-sg` (≠ folder), and its `/languages/` ships `wpc-gf-sg-{locale}.mo/.po` + `wpc-gf-sg.pot`. `wp_get_installed_translations('plugins')` and the plugin's existing `load_plugin_textdomain('wpc-gf-sg', …)` both key on `wpc-gf-sg`, so the t15s slug and TranslationsPress project path must be `wpc-gf-sg`. (Same reasoning applied in the GF Airtable port with `wpc-gf-at`.)

The class body is otherwise a faithful, verbatim port (slug/URL injected via the constructor — nothing plugin-specific hardcoded inside the class). The pre-existing `load_translations()` / `load_plugin_textdomain('wpc-gf-sg', …)` was left untouched; the two `init` callbacks coexist independently.

## Files changed in target

- `repos/addon_gf-sendgrid/includes/classes/class-language-pack.php` (new, 211 lines)
- `repos/addon_gf-sendgrid/wpconnect-gf-sendgrid.php` (+15 lines: require at L65, `add_action` at L83, `init_language_pack()` at L230-237)

No Composer/`vendor/` change, no version bump (still `1.8.0`), no readme/changelog/`languages/` changes.

## Review

Criterion 1 (class-language-pack.php with class- prefix) → PASS
Criterion 2 (namespace WPCONNECT_GF_SG, class Language_Packs) → PASS
Criterion 3 (<?php + ABSPATH guard) → PASS
Criterion 4 (faithful port, no hardcoded slug/URL in class) → PASS
Criterion 5 (require_once path matches filename) → PASS
Criterion 6 (add_action init → init_language_pack) → PASS
Criterion 7 (Language_Packs('plugin','wpc-gf-sg', wpc-gf-sg packages.json), two-line form, + add_project) → PASS
Criterion 8 (existing load_translations untouched, textdomain not duplicated) → PASS
Criterion 9 (only two files; no vendor/version/readme/languages changes) → PASS
Criterion 10 (php -l clean, PHP 8.3) → PASS

Overall: **APPROVED (10/10)**. Source repo `addon_gf-notion` verified untouched (clean tree, on `main`).

## Structure correction (2026-06-16, applied on `release/1.9.0`, commit `9bab98c`)

The original port deliberately left the bundled local translations untouched (Criterion 8/9 above counted "load_translations untouched" / "no `languages/` changes" as a PASS). That was the wrong call: in the source (`addon_gf-notion`), removing the local translation pipeline is an **intrinsic part** of the TranslationsPress migration (commit `63ca971` deleted the whole `languages/` directory and dropped the local `load_plugin_textdomain()` call). The reference plugin's `main` has **no** `languages/` dir, **no** `Domain Path` header and **no** local text-domain loader.

By keeping them, the port produced a half-migrated state (remote pack mechanism added, but local `.mo`/`.po`/`.pot` still shipped and still loaded locally), structurally divergent from the source. (Same issue was found and corrected in the GF Airtable port; the Orders Sync port did not have it — there the local pipeline was correctly removed.)

Corrected on `release/1.9.0` to match the source structure:

- Removed the `languages/` directory (`wpc-gf-sg-{es_ES,fr_FR}.{mo,po}` + `wpc-gf-sg.pot`).
- Removed the `load_translations()` function and its `add_action( 'init', … )` from `wpconnect-gf-sendgrid.php`.
- Removed the `Domain Path: /languages/` plugin header.

Unchanged (deliberately): the text domain stays `wpc-gf-sg` and the t15s slug / TranslationsPress URL stay `wpc-gf-sg` — that mapping decision (above) remains correct; only the redundant local pipeline was dropped. `php -l` clean. QA ZIP `dist/wpconnect-gf-sendgrid.1.9.0.zip` regenerated (no `languages/` entry; 63 KB → 40 KB).

## Text-domain / slug fix (2026-06-16, applied on `release/1.9.0`, commit `e1badb8`)

QA testing of GF Airtable surfaced the same defect here. Root cause: the port's "key mapping decision" above was **backwards**. The TranslationsPress project is registered under the slug **`wpconnect-gf-sendgrid`** (verified: `…/wp-connect/wpconnect-gf-sendgrid/packages.json` → HTTP 200; the port's `…/wpc-gf-sg/packages.json` → HTTP 403), and its packs ship files named **`wpconnect-gf-sendgrid-{locale}.mo`**. The port pointed the t15s slug + URL at the text domain `wpc-gf-sg`, so:

1. `get_translations()` → `wp_remote_get()` got a 403 → returned `[]` → nothing registered for download (primary cause).
2. Even with the URL fixed, WP loads text domain `wpc-gf-sg` while the packs install `wpconnect-gf-sendgrid-{locale}.mo` → name mismatch → never loaded.

GF Notion works because **text domain == slug == folder**. The author's own `feature/translationpress` branch had already aligned the text domain to `wpconnect-gf-sendgrid`.

Fix (align code to the platform slug):

- Plugin text domain changed `wpc-gf-sg` → `wpconnect-gf-sendgrid`: the `Text Domain:` header and **all gettext calls** (~95 occurrences across 8 files).
- Language-pack bootstrap: slug + packages.json URL → `wpconnect-gf-sendgrid`.
- **Unchanged:** action/filter hook names (`wpc-gf-sg/*`) and the `WPCONNECT_GF_SG_*` constants / `wpc_gf_sg_` option prefix.

`php -l` clean on all changed files. QA ZIP regenerated.

## Notes / external follow-up

- The TranslationsPress/GlotPress project must exist at `https://packages.translationspress.com/wp-connect/wpc-gf-sg/packages.json` for packs to actually download — external ops/registration task, outside `/port`.

## Next step to publish

`/release GF SendGrid <version>` (e.g. the planned 1.9.0 — GFSG-78 is in project "GF SendGrid v1.9.0") — or `/feature GF SendGrid`. Both auto-detect this `port/translationspress-language-pack` branch and offer to build on top of it so the port commit is carried in.
