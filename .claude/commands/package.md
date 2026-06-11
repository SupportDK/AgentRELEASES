---
description: Build a distributable WordPress plugin ZIP in dist/
argument-hint: <plugin-path> [version]
---

# /package $ARGUMENTS

Build a distributable ZIP for the plugin at **$1** (optional version label: $2).

## Steps

1. Verify `$1` is a plugin directory: it must contain a PHP file with a valid plugin header (`Plugin Name:`). If not, stop and report.

2. Read the plugin slug from the directory name and the version from the plugin header. If `$2` is provided and differs from the header version, warn the user (do not modify the header — version bumps belong to `/release`).

3. Build the ZIP:
   - Output: `dist/<slug>.zip` (create `dist/` if missing)
   - The ZIP must contain a single top-level folder named `<slug>/`
   - Include only files required at runtime
   - Exclude: `node_modules/`, `tests/`, `.git*`, dotfiles, `*.zip`, build configs (`package.json`, `composer.json` dev-only, `phpstan.neon`), editor files

   ```bash
   cd <parent-of-plugin> && zip -r "<workspace>/dist/<slug>.zip" "<slug>/" \
     -x "*/node_modules/*" "*/tests/*" "*/.git*" "*/.*" "*.zip"
   ```

4. Verify the ZIP: list its contents (`unzip -l`) and confirm the main plugin file is at `<slug>/<slug>.php` (or the actual main file path).

## Report

- ZIP path and size
- Packaged file structure
- Manual installation instructions: WP Admin → Plugins → Add New → Upload Plugin
