# Port report — TranslationsPress functions → Orders Sync to Airtable for WooCommerce

Source: wpconnect-co/addon_gf-notion (read-only)
Target: wpconnect-co/orders-sync-to-airtable-for-woocommerce
Branch: port/translationspress-language-pack
Commit: 2a2ff21
Linear issue: WPC-99 (spec only — not modified by /port)

## What was ported

The TranslationsPress (translationspress.com) language-pack auto-update integration: the self-contained `Language_Packs` (t15s-registry) class that injects translation data into WordPress's update mechanism so the plugin's translations are pulled and kept up to date from TranslationsPress even though the plugin is not hosted on WordPress.org.

It hooks `translations_api` and `site_transient_update_plugins` to serve translation data fetched (transient-cached, 2s HTTP timeout) from a `packages.json` endpoint, compares remote `updated` timestamps against locally installed translations, and lets WP core install the newer `.mo`/`.po` files into `WP_LANG_DIR/plugins/`. Cache is invalidated (15s debounce) on `set/delete_site_transient_update_plugins`.

## Source references

- `addon_gf-notion/includes/classes/language-pack.php` — `WPC_GF_NTN\Language_Packs` (methods `__construct`, `add_project`, `get_translations`, `register_clean_translations_cache`, `clean_translations_cache`). No Composer dependency; WP core only + PHP `DateTime`.
- `addon_gf-notion/wpconnect-gf-notion.php` — bootstrap: top-level `init_language_pack()` instantiating `Language_Packs('plugin', '<slug>', '<packages.json URL>')` + `add_project()`, registered on `init`.

The Reference Implementation Report from the prior ports was reused — the source repo is unchanged (clean, on `main`).

## Adaptations made for the target

This target is a **WooCommerce plugin**, structurally different from the GF add-ons ported previously.

| Aspect | Source (GF Notion) | Target (Orders Sync to Airtable for Woo) |
|---|---|---|
| Namespace | `WPC_GF_NTN` | **`Orders_Sync_to_Airtable_for_WooCommerce`** |
| Class file name | `includes/classes/language-pack.php` | `includes/class-language-pack.php` (target `class-*.php` convention) |
| ABSPATH guard | absent | **absent** — the target's sibling `class-*.php` files have no entry guard, so none was added (matching the target convention; differs from the GF Airtable/SendGrid ports, which DID add one to match THEIR siblings) |
| Dir constant | `WPCONNECT_GF_NTN_DIR` | `ORDERS_SYNC_TO_AIRTABLE_FOR_WOOCOMMERCE_PLUGIN_DIR` (note `_PLUGIN_DIR`) |
| t15s slug | `wpconnect-gf-notion` | **`orders-sync-to-airtable-for-woocommerce`** (text domain == folder slug) |
| packages.json URL | `…/wp-connect/wpconnect-gf-notion/packages.json` | `https://packages.translationspress.com/wp-connect/orders-sync-to-airtable-for-woocommerce/packages.json` |
| Bootstrap | require + `add_action('init', …init_language_pack)` in `init()` | `require_once` in the main file's require block + top-level `init_language_pack()` (wrapped in a `function_exists` guard, matching the file's `deactivate`/`uninstall` style) + `add_action('init', …)` |
| Indentation | mixed spaces in one method | normalized to tabs |

**Key mapping decision — slug `orders-sync-to-airtable-for-woocommerce`.** The plugin's text domain equals its folder slug, so the slug is unambiguous. The target has **no `/languages` directory, no `.pot/.mo` files, and no `load_plugin_textdomain` call** — there was no existing translation infrastructure. As in the source (GF Notion, which also had no `load_plugin_textdomain`), none was added: WordPress 4.6+ installs language packs to `WP_LANG_DIR/plugins/<text-domain>-<locale>.mo` and auto-loads them just-in-time. Adding a languages folder or textdomain loader was explicitly out of scope.

**Init priority interplay (verified safe):** `init_language_pack()` runs on `init` at default priority 10; the plugin's `Bootstrap::init()` runs at priority 100; the class's internal `register_clean_translations_cache()` is deferred to `init` priority 9999. 10 < 100 < 9999 — the translation-API filters are registered before Bootstrap's heavier setup and the cache-cleaner fires last, all correct.

The class body is otherwise a faithful, verbatim port (slug/URL injected via the constructor — nothing plugin-specific hardcoded inside the class). No existing class (`Bootstrap`, etc.) was modified.

## Files changed in target

- `repos/orders-sync-to-airtable-for-woocommerce/includes/class-language-pack.php` (new, 203 lines)
- `repos/orders-sync-to-airtable-for-woocommerce/orders-sync-to-airtable-for-woocommerce.php` (+16 lines: require at L63, `init_language_pack()` at L102-114, `add_action` at L115)

No Composer/`vendor/` change, no version bump (still `1.0.0`), no readme/changelog/`languages/` changes.

## Review

Criterion 1 (class-language-pack.php with class- prefix) → PASS
Criterion 2 (namespace Orders_Sync_to_Airtable_for_WooCommerce, class Language_Packs) → PASS
Criterion 3 (header convention, NO ABSPATH guard matching siblings) → PASS
Criterion 4 (faithful port, no hardcoded slug/URL in class) → PASS (indentation defect flagged by review, fixed in commit 2a2ff21)
Criterion 5 (require_once with _PLUGIN_DIR constant, correct path) → PASS
Criterion 6 (init_language_pack with correct slug/URL, two-line form, add_action) → PASS
Criterion 7 (no load_plugin_textdomain, no /languages, no vendor/version/Bootstrap changes; only two files) → PASS
Criterion 8 (php -l clean, PHP 8.3) → PASS

Overall: **APPROVED (8/8)**. The review's one minor finding (mixed indentation inherited from the source in `clean_translations_cache`) was corrected to tabs before finalizing. Source repo `addon_gf-notion` verified untouched (clean tree, on `main`).

## Notes / external follow-up

- The TranslationsPress/GlotPress project must exist at `https://packages.translationspress.com/wp-connect/orders-sync-to-airtable-for-woocommerce/packages.json` for packs to actually download — external ops/registration task, outside `/port`.
- This plugin currently ships no `/languages` folder or `.pot`. Translations are delivered entirely via TranslationsPress packs once the project is registered.

### Slug verification (2026-06-16)

Triggered by the text-domain/slug bug found in the GF Airtable & GF SendGrid ports. Checked here too — **no defect**: the code is internally consistent and matches the platform. Confirmed by the user, the TranslationsPress project for this plugin uses **name `orders-sync-to-airtable-for-woocommerce` and slug `orders-sync-to-airtable-for-woocommerce`**, which equals the plugin's text domain, the `Language_Packs` slug, and the `packages.json` URL path. No code change needed (this plugin's text domain already equals its folder slug, so it never had the GF mismatch).

The endpoint currently returns **HTTP 403** — the TranslationsPress project is **not published yet** under that slug. This is the pending external registration task above, not a code bug. Once the project is created and the POT/translations are uploaded, packs will download automatically with no re-release.

## Next step to publish

`/release Orders Sync to Airtable for Woo 1.1.0` (WPC-99 is in project "Orders Sync to Airtable for Woo v1.1.0") — or `/feature`. Both auto-detect this `port/translationspress-language-pack` branch and offer to build on top of it so the port commit is carried in.
