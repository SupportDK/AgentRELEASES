# WPC Hello World

**Version**: 1.0.0
**Author**: WP connect
**License**: GPL-2.0-or-later

---

## What it is

WPC Hello World is a minimal WordPress plugin developed by WP connect.

It is a pipeline validation artifact — the first end-to-end deliverable produced by the WPC Agent pipeline (Product Owner → Developer → Documentation). Its purpose is to confirm that the full AI development workflow operates correctly, from specification through implementation to documented release.

It is not intended for production use.

---

## What it does

When active, the plugin displays a success notice across all WordPress admin screens.

The notice reads:

> Hello World WP CONNECT

- No settings page
- No database changes
- No activation or deactivation side effects
- No external dependencies

---

## How to install

1. Copy the `wpc-hello-world` folder into your WordPress installation under `wp-content/plugins/`.
2. Log in to the WordPress admin panel.
3. Go to Plugins > Installed Plugins.
4. Find **WPC Hello World** in the list and click **Activate**.

---

## Expected behavior

After activation, every page in the WordPress admin area will display a green success notice at the top:

> Hello World WP CONNECT

The notice disappears immediately upon deactivation. There is nothing to configure.

---

## Notes

This plugin is a pipeline validation artifact. It was created to verify the WPC Agent development pipeline end to end. It should not be deployed to a live WordPress site.
