---
description: Build a distributable WordPress plugin ZIP in dist/ (wp dist-archive preferred)
argument-hint: <plugin-path> [version]
---

# /package $ARGUMENTS

Build a distributable ZIP for the plugin at **$1** (optional version label: $2).

## Steps

1. Verify `$1` is a plugin directory: it must contain a PHP file with a valid plugin header (`Plugin Name:`). If not, stop and report. Identify the **main plugin file** (the one with the header).

2. Read the plugin slug/dirname and the version from the plugin header. If `$2` is provided and differs from the header version, warn the user (do not modify the header — version bumps belong to `/release`).

3. **Vendor runtime composer dependencies first (or the ZIP fatals on activation).** If the plugin has a `composer.json` with a non-dev `require`, or the main file `require_once`s anything under `vendor/` (grep for `vendor/autoload.php` or `vendor/…` requires — e.g. `air-wp-sync-pro`, `notion-wp-sync`, `notion-wp-sync-pro` require `vendor/woocommerce/action-scheduler/action-scheduler.php`), then `vendor/` **must** physically exist before packaging. A fresh clone does **not** ship `vendor/` (it is gitignored), and `.distignore` does **not** exclude `vendor/`, so run:

   ```bash
   cd "$1" && composer install --no-dev --optimize-autoloader
   ```

   Notes: this is idempotent and does **not** overwrite a committed `vendor_prefixed/` tree (scoped deps), so a hand-applied patch there survives — but re-apply any patch you may have reverted before packaging. Skip only if the plugin has no runtime composer dependency.

4. Build the archive — **preferred**: WP-CLI dist-archive (respects `.distignore`):

   ```bash
   cd "$1" && wp dist-archive ./ --plugin-dirname=<plugin-dirname>
   ```

   **Fallback** (if `wp` or the `dist-archive` command is unavailable): plain zip with a single top-level `<plugin-dirname>/` folder, runtime files only — exclude `node_modules/`, `tests/`, `.git*`, dotfiles, `*.zip`, dev configs (`package.json`, dev-only `composer.json`, `phpstan.neon`), editor files:

   ```bash
   cd <parent-of-plugin> && zip -r "<workspace>/dist/<zip-name>" "<plugin-dirname>/" \
     -x "*/node_modules/*" "*/tests/*" "*/.git*" "*/.*" "*.zip"
   ```

5. **Name the ZIP with the release convention** — main plugin file without `.php`, then the version:

   ```text
   <main-plugin-file-without-.php>.<version>.zip
   ```

   Example: main file `wpconnect-wpf-notion.php`, version `1.4.1` → `wpconnect-wpf-notion.1.4.1.zip`

6. Place the ZIP in the workspace `dist/` directory and verify it: list contents (`unzip -l`) and confirm the main plugin file is at `<plugin-dirname>/<main-file>.php`. **If the plugin has a runtime `vendor/` dependency (step 3), also confirm `vendor/autoload.php` and each required package file (e.g. `vendor/woocommerce/action-scheduler/action-scheduler.php`) are present in the ZIP** — a top-folder/file-count check does not catch a missing `vendor/`, which only surfaces as a fatal on activation.

## Report

- ZIP path and size
- Packaged file structure
- Manual installation instructions: WP Admin → Plugins → Add New → Upload Plugin
