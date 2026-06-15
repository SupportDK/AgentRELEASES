---
description: Build a distributable WordPress plugin ZIP in dist/ (wp dist-archive preferred)
argument-hint: <plugin-path> [version]
---

# /package $ARGUMENTS

Build a distributable ZIP for the plugin at **$1** (optional version label: $2).

## Steps

1. Verify `$1` is a plugin directory: it must contain a PHP file with a valid plugin header (`Plugin Name:`). If not, stop and report. Identify the **main plugin file** (the one with the header).

2. Read the plugin slug/dirname and the version from the plugin header. If `$2` is provided and differs from the header version, warn the user (do not modify the header — version bumps belong to `/release`).

3. Build the archive — **preferred**: WP-CLI dist-archive (respects `.distignore`):

   ```bash
   cd "$1" && wp dist-archive ./ --plugin-dirname=<plugin-dirname>
   ```

   **Fallback** (if `wp` or the `dist-archive` command is unavailable): plain zip with a single top-level `<plugin-dirname>/` folder, runtime files only — exclude `node_modules/`, `tests/`, `.git*`, dotfiles, `*.zip`, dev configs (`package.json`, dev-only `composer.json`, `phpstan.neon`), editor files:

   ```bash
   cd <parent-of-plugin> && zip -r "<workspace>/dist/<zip-name>" "<plugin-dirname>/" \
     -x "*/node_modules/*" "*/tests/*" "*/.git*" "*/.*" "*.zip"
   ```

4. **Name the ZIP with the release convention** — main plugin file without `.php`, then the version:

   ```text
   <main-plugin-file-without-.php>.<version>.zip
   ```

   Example: main file `wpconnect-wpf-notion.php`, version `1.4.1` → `wpconnect-wpf-notion.1.4.1.zip`

5. Place the ZIP in the workspace `dist/` directory and verify it: list contents (`unzip -l`) and confirm the main plugin file is at `<plugin-dirname>/<main-file>.php`.

## Report

- ZIP path and size
- Packaged file structure
- Manual installation instructions: WP Admin → Plugins → Add New → Upload Plugin
