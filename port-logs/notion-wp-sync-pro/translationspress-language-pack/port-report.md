# Port report — TranslationsPress language-pack integration → Notion WP Sync Pro+

Source: wpconnect-co/air-wp-sync-pro (read-only, branch `release/3.0.0`)
Target: wpconnect-co/notion-wp-sync-pro
Branch: port/translationspress-language-pack
Commit: a473ec0
Linear issue: NOWPS-360 (spec only — not modified by /port)

## What was ported

The TranslationsPress (translationspress.com) language-pack auto-update integration: a self-contained `Language_Packs` (t15s-registry) class that injects translation data into WordPress's update mechanism so the plugin's translations are pulled and kept up to date from TranslationsPress even though the plugin is not hosted on WordPress.org.

It hooks `translations_api` and `site_transient_update_plugins` to serve translation data fetched (transient-cached, key `t15s-registry-{slug}-{type}`, 2s HTTP timeout) from a `packages.json` endpoint, compares remote vs locally-installed `PO-Revision-Date`, and lets WP core install the newer `.mo`/`.po`/`.json` files into `WP_LANG_DIR/plugins/`. Cache is invalidated (15s debounce) on `set/delete_site_transient_update_plugins`.

Because "Passage sur TranslationsPress" means *switching* translation delivery to TranslationsPress (not merely bolting it on), the wiring mirrors the source's replace-not-coexist design: when the packages URL is configured, TranslationsPress **replaces** the bundled `load_plugin_textdomain` path; otherwise the previous bundled behavior is preserved as fallback.

## Source references

- `air-wp-sync-pro/vendor_prefixed/wpconnect/x-wp-sync-core/src/Util/Language_Packs.php` — the `Language_Packs` class (methods `__construct($type,$slug,$api_url)`, `add_project`, `get_translations`, `register_clean_translations_cache`, `clean_translations_cache`). No Composer dependency; WP core APIs (`wp_remote_get`, `get/set/delete_site_transient`, `wp_get_installed_translations`, `get_available_languages`) + PHP `DateTime`.
- `air-wp-sync-pro/vendor_prefixed/wpconnect/x-wp-sync-core/src/Bootstrap.php` `init_language_pack()` — the design: `if ($translations_pack_url) { new Language_Packs('plugin','air-wp-sync-pro-plus',$url); ->add_project(); } else { load_plugin_textdomain(...); }`.
- `air-wp-sync-pro/air-wp-sync.php:67` — constant `AIR_WP_SYNC_PRO_TRANSLATIONS_PACK_URL = 'https://packages.translationspress.com/wp-connect/air-wp-sync-pro-plus/packages.json'`.

In the source the mechanism lives inside the shared vendored core (`x-wp-sync-core`); the target does **not** use that architecture, so the class was ported as a standalone plugin class (same standalone approach already used for the gf-at / orders-sync / gf-sendgrid ports of this feature).

## Adaptations made for the target

| Aspect | Source (air-wp-sync-pro / x-wp-sync-core) | Target (Notion WP Sync Pro+) |
|---|---|---|
| Location | vendored shared core `vendor_prefixed/.../Util/Language_Packs.php` | standalone `includes/class-notion-wp-sync-language-pack.php` |
| Namespace | `...\WPConnect\X_WP_Sync_Core\Util` | `Notion_WP_Sync_Pro` |
| Class name | `Language_Packs` | `Language_Packs` |
| ABSPATH guard | absent | **absent** — matches target siblings (`class-notion-wp-sync-*.php` have no guard; the main file's `WPINC` check is the sole entry guard) |
| t15s slug | `air-wp-sync-pro-plus` | **`notion-wp-sync-pro-plus`** (== text domain) |
| Dir/URL constant | `AIR_WP_SYNC_PRO_TRANSLATIONS_PACK_URL` | `NOTION_WP_SYNC_PRO_TRANSLATIONS_PACK_URL` |
| packages.json URL | `…/wp-connect/air-wp-sync-pro-plus/packages.json` | `https://packages.translationspress.com/wp-connect/notion-wp-sync-pro-plus/packages.json` |
| Wiring | core `Bootstrap::init_language_pack()` via `Plugin_Context` | new `Notion_WP_Sync::init_language_pack()` on `init` priority 0 |
| Indentation | mixed | normalized to tabs (WP style) |

**Slug/URL decision — `notion-wp-sync-pro-plus`.** The target's text domain is `notion-wp-sync-pro-plus`, so WP installs and loads TranslationsPress packs at `WP_LANG_DIR/plugins/notion-wp-sync-pro-plus-{locale}.mo`. The t15s slug and the `packages.json` path must equal the text domain for version comparison and just-in-time loading to work. This mirrors the source's own `<plugin>-pro-plus` convention (air-wp-sync-pro-plus), so it is internally consistent — no GF-style text-domain/slug mismatch here.

**Critical adaptation — the `load_textdomain_mofile` reroute conflict (this was the crux of the port).** The target's `Notion_WP_Sync` constructor previously registered, unconditionally:
- `add_action('init', 'load_textdomain', 0)` → `load_plugin_textdomain('notion-wp-sync-pro-plus', …/languages)`
- `add_filter('load_textdomain_mofile', 'load_textdomain_mofile', 10, 2)` → **reroutes** any `WP_LANG_DIR/plugins/notion-wp-sync-pro-plus-{locale}.mo` load back to the plugin's bundled `/languages/` folder.

TranslationsPress installs packs into exactly `WP_LANG_DIR/plugins/notion-wp-sync-pro-plus-{locale}.mo`, so the existing reroute would hijack that load and point WP at the bundled folder (which only contains legacy `wp-sync-for-notion-*` files) — silently killing the feature. A naive "coexist / don't touch existing code" port (as used for gf-at/orders-sync, which had no such reroute) is therefore functionally broken here.

Resolution (faithful to the source's replace-not-coexist design): the two constructor registrations were replaced by a single `init_language_pack()` method (still on `init` priority 0) with an if/else:
- **TranslationsPress active** (constant defined & truthy): `new Language_Packs('plugin','notion-wp-sync-pro-plus', NOTION_WP_SYNC_PRO_TRANSLATIONS_PACK_URL); ->add_project();` — neither `load_plugin_textdomain` nor the `load_textdomain_mofile` filter are registered, so the TranslationsPress packs in `WP_LANG_DIR/plugins/` are never rerouted.
- **Fallback** (constant absent/falsy): the original behavior is preserved — the `load_textdomain_mofile` filter is registered **before** `load_plugin_textdomain(...)` (so the reroute is active during the initial load, matching the original constructor-time registration order), then `load_plugin_textdomain(...)` runs exactly as before.

The class body itself is an otherwise faithful port — slug/URL injected via the constructor, nothing plugin-specific hardcoded inside the class. No other class was modified.

## Files changed in target

- `repos/notion-wp-sync-pro/includes/class-notion-wp-sync-language-pack.php` (new, 208 lines)
- `repos/notion-wp-sync-pro/notion-wp-sync.php` (+2 lines: `NOTION_WP_SYNC_PRO_TRANSLATIONS_PACK_URL` constant + `require_once` for the new class)
- `repos/notion-wp-sync-pro/includes/class-notion-wp-sync.php` (constructor: `load_textdomain`/`load_textdomain_mofile` registrations replaced by `init_language_pack` on `init` priority 0; `load_textdomain()` method replaced by `init_language_pack()` with the if/else; `load_textdomain_mofile()` method kept for the fallback path)

No Composer/`vendor/` change, no version bump (still `2.8.2`), no readme/changelog/`languages/` changes.

## Review

Criterion 1 (new class file, namespace `Notion_WP_Sync_Pro`, no ABSPATH guard) → PASS
Criterion 2 (faithful port of `Language_Packs`, no hardcoded slug/URL/text-domain) → PASS
Criterion 3 (`NOTION_WP_SYNC_PRO_TRANSLATIONS_PACK_URL` constant, exact URL) → PASS
Criterion 4 (`require_once` before use) → PASS
Criterion 5 (`Language_Packs('plugin','notion-wp-sync-pro-plus',URL)` + `add_project()` when truthy) → PASS
Criterion 6 (TP active → neither `load_plugin_textdomain` nor `load_textdomain_mofile` reroute run) → PASS
Criterion 7 (fallback preserved, filter registered before `load_plugin_textdomain`) → PASS *(initially FAIL — ordering regression caught in review cycle 1, fixed by swapping the two lines; re-verified PASS)*
Criterion 8 (no version bump, still 2.8.2) → PASS
Criterion 9 (no readme/languages/composer changes) → PASS
Criterion 10 (`php -l` clean on all 3 files) → PASS
Criterion 11 (only 3 files touched) → PASS
Criterion 12 (commit ends `(ported from air-wp-sync-pro)`; source repo clean/untouched) → PASS

Overall: **APPROVED (12/12)** after one review cycle. Source repo `air-wp-sync-pro` verified untouched (clean tree, still on `release/3.0.0`, no branch created).

## Notes / external follow-up

- **TranslationsPress project must be published.** For packs to actually download, a TranslationsPress project must exist at `https://packages.translationspress.com/wp-connect/notion-wp-sync-pro-plus/packages.json`. Prior ports (orders-sync, gf-at) observed HTTP 403 until the project was published — this is an external ops/registration task, outside `/port`, not a code defect. Verify the platform slug matches `notion-wp-sync-pro-plus` (the GF Airtable port history shows a slug mismatch can silently break loading).
- **Legacy bundled language files.** `repos/notion-wp-sync-pro/languages/` currently ships `wp-sync-for-notion-{locale}.mo/.po` (legacy naming) rather than `notion-wp-sync-pro-plus-{locale}.mo`. This pre-existing inconsistency is unrelated to this port and was left untouched (renaming/regenerating them is out of scope). Once TranslationsPress is published, translations are delivered via the packs regardless.

## Next step to publish

`/release Notion WP Sync Pro+ 3.0.0` (NOWPS-360 is in project "Notion WP Sync Pro+ v3.0.0") — or `/feature Notion WP Sync Pro+`. Both auto-detect this `port/translationspress-language-pack` branch and offer to build on top of it so the port commit is carried in.
