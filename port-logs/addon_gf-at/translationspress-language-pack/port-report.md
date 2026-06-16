# Port report — TranslationsPress functions → GF Airtable

Source: wpconnect-co/addon_gf-notion (read-only)
Target: wpconnect-co/addon_gf-at
Branch: port/translationspress-language-pack
Commit: 5d12f15c709f944658539b1377899f6b5de21083
Linear issue: GFAT-137 (spec only — not modified by /port)

## What was ported

The TranslationsPress (translationspress.com) language-pack auto-update integration: the self-contained `Language_Packs` (t15s-registry) class that injects translation data into WordPress's update mechanism so the plugin's translations are pulled and kept up to date from TranslationsPress even though the plugin is not hosted on WordPress.org.

It hooks `translations_api` and `site_transient_update_plugins` to serve translation data fetched (transient-cached, 2s HTTP timeout) from a `packages.json` endpoint, compares remote `updated` timestamps against locally installed translations, and lets WP core install the newer `.mo`/`.po` files. Cache is invalidated (15s debounce) on `set/delete_site_transient_update_plugins`.

## Source references

- `addon_gf-notion/includes/classes/language-pack.php` — `WPC_GF_NTN\Language_Packs` (methods `__construct`, `add_project`, `get_translations`, `register_clean_translations_cache`, `clean_translations_cache`). No Composer dependency; uses WP core (`wp_remote_get`, `get/set/delete_site_transient`, `wp_get_installed_translations`, `get_available_languages`) + PHP `DateTime`.
- `addon_gf-notion/wpconnect-gf-notion.php` — bootstrap: `init()` (on `plugins_loaded`) requires the class and registers `init_language_pack()` on `init`; `init_language_pack()` instantiates `Language_Packs('plugin', 'wpconnect-gf-notion', '…/wpconnect-gf-notion/packages.json')` and calls `add_project()`.

## Adaptations made for the target

| Aspect | Source (GF Notion) | Target (GF Airtable) |
|---|---|---|
| Namespace | `WPC_GF_NTN` | `WPC_GF_AT` |
| Class file name | `includes/classes/language-pack.php` | `includes/classes/class-language-pack.php` (target `class-*.php` convention) |
| ABSPATH guard | absent | `defined( 'ABSPATH' ) || exit;` added (matches target's other class files) |
| t15s slug | `wpconnect-gf-notion` | **`wpc-gf-at`** |
| packages.json URL | `…/wp-connect/wpconnect-gf-notion/packages.json` | `https://packages.translationspress.com/wp-connect/wpc-gf-at/packages.json` |
| Bootstrap require | in `init()` | added in `init()` after `class-plugin-updater.php` |
| `init` registration | in `init()` | added at end of `init()` |
| Indentation | mixed spaces in one method | normalized to tabs (WP style) |

**Key mapping decision — slug `wpc-gf-at`, not the folder slug `wpconnect-gf-airtable`.** In GF Notion the text domain equals the folder slug, so the source value was unambiguous. GF Airtable's text domain is `wpc-gf-at` (≠ folder `wpconnect-gf-airtable`), and its `/languages/` already ships `wpc-gf-at-{locale}.mo/.po` + `wpc-gf-at.pot`. `wp_get_installed_translations('plugins')` and the plugin's existing `load_plugin_textdomain('wpc-gf-at', …)` both key on `wpc-gf-at`, so the t15s slug and the TranslationsPress project path must be `wpc-gf-at` for version comparison and loading to work.

The class body is otherwise a faithful, verbatim port (slug/URL are injected via the constructor — nothing plugin-specific is hardcoded inside the class). The pre-existing `load_translations()` / `load_plugin_textdomain('wpc-gf-at', …)` in the target was left untouched (the source had no such call); the two `init` callbacks coexist independently.

## Files changed in target

- `repos/addon_gf-at/includes/classes/class-language-pack.php` (new, 206 lines)
- `repos/addon_gf-at/wpconnect-gf-airtable.php` (+17 lines: require at L59, `add_action` at L73, `init_language_pack()` at L166–173)

No Composer/`vendor/` change, no version bump (still `2.5.0`), no readme/changelog/`languages/` changes.

## Review

Criterion 1 (class-language-pack.php with class- prefix) → PASS
Criterion 2 (namespace WPC_GF_AT, class Language_Packs) → PASS
Criterion 3 (<?php + ABSPATH guard) → PASS
Criterion 4 (faithful port, no hardcoded slug/URL in class) → PASS
Criterion 5 (require_once path matches filename) → PASS
Criterion 6 (add_action init → init_language_pack) → PASS
Criterion 7 (Language_Packs('plugin','wpc-gf-at', wpc-gf-at packages.json) + add_project) → PASS
Criterion 8 (existing load_translations untouched) → PASS
Criterion 9 (no vendor/version/readme/languages changes) → PASS
Criterion 10 (php -l clean, PHP 8.3) → PASS

Overall: **APPROVED (10/10)**. Source repo `addon_gf-notion` verified untouched (clean tree, still on `main`, no branch created).

## Structure correction (2026-06-16, applied on `release/2.6.0`, commit `f6c4293`)

The original port deliberately left the bundled local translations untouched (Criterion 9 above counted "no `languages/` changes" as a PASS). That was the wrong call: in the source (`addon_gf-notion`), removing the local translation pipeline is an **intrinsic part** of the TranslationsPress migration (commit `63ca971` deleted the whole `languages/` directory and dropped the local `load_plugin_textdomain()` call). The reference plugin's `main` has **no** `languages/` dir, **no** `Domain Path` header and **no** local text-domain loader. The author's own prior `feature/translationpress` branch on the target had likewise removed `languages/`.

By keeping them, the port produced a half-migrated state (remote pack mechanism added, but local `.mo`/`.po`/`.pot` still shipped and still loaded locally), structurally divergent from the source.

Corrected on `release/2.6.0` to match the source structure:

- Removed the `languages/` directory (`wpc-gf-at-{de_DE,es_ES,fr_FR}.{mo,po}` + `wpc-gf-at.pot`).
- Removed the `load_translations()` function and its `add_action( 'init', … )` from `wpconnect-gf-airtable.php`.
- Removed the `Domain Path: /languages/` plugin header.

Unchanged (deliberately): the text domain stays `wpc-gf-at` and the t15s slug / TranslationsPress URL stay `wpc-gf-at` — that mapping decision (above) remains correct; only the redundant local pipeline was dropped. `php -l` clean. QA ZIP `dist/wpconnect-gf-airtable.2.6.0.zip` regenerated (no `languages/` entry; 114 KB → 76 KB).

## Notes / external follow-up

- The TranslationsPress/GlotPress project must exist at `https://packages.translationspress.com/wp-connect/wpc-gf-at/packages.json` for packs to actually download — that is an external ops/registration task, outside `/port`.

## Next step to publish

`/release GF Airtable 2.6.0` (full QA lifecycle) — or `/feature GF Airtable` (PR only). Both auto-detect this `port/translationspress-language-pack` branch and offer to build on top of it so the port commit is carried in.
