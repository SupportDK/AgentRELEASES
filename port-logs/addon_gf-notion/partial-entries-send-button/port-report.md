# Port report — Partial Entries & "Send to Notion" button → GF Notion

Source: wpconnect-co/addon_gf-at  (GF Airtable, read-only)
Target: wpconnect-co/addon_gf-notion  (GF Notion)
Branch: port/partial-entries-send-button
Linear issues: GFNO-83 (Partial Entries support), GFNO-82 ("Send to Notion" button) — project "GF Notion v2.0.0", team GF Notion

## What was ported

Two sibling features from GF Airtable, adapted to GF Notion's conventions:

- **Feature A — GF Partial Entries support (GFNO-83):** GF Notion now reacts to the
  Gravity Forms Partial Entries add-on. A per-feed opt-in checkbox
  (`partial-entries-enabled`) is shown in the feed settings **only when**
  `class_exists('GF_Partial_Entries')`. When enabled, partial saves/updates are sent
  to Notion through the normal `process_feed()` pipeline, with change-detection on
  updates via a per-feed snapshot meta (no duplicate sends when nothing changed).

- **Feature B — "Send to Notion" resend button (GFNO-82):** the existing (display-only)
  Notion metabox on the GF entry-detail page now renders a per-feed "Send to Notion"
  link. Clicking it re-runs `process_feed()` for that feed/entry after a capability
  and nonce check, then shows a confirmation and the refreshed API result.

## Source references (GF Airtable)

- Partial entries hooks: `includes/hooks.php:454-472` (closures on
  `gform_partialentries_post_entry_saved` / `_updated`).
- Core method: `GF_Addon::process_partial_entry_for_airtable()` —
  `includes/classes/class-gf-addon.php:814-856`.
- Feed checkbox: `feed_settings_fields()` — `class-gf-addon.php:622-642`
  (guarded by `class_exists('GF_Partial_Entries')`, meta `partial-entries-enabled`).
- Resend ("Retry"): `Hooks\render_entry_metabox()` — `includes/hooks.php:202-289`
  (`?retryfeed=` + nonce → `process_feed`); `Helpers\add_or_update_url_param()`
  — `includes/helpers.php:110-120`.

## Adaptations made for the target

| Aspect | GF Airtable (source) | GF Notion (target) |
|---|---|---|
| Namespace | `WPC_GF_AT` | `WPC_GF_NTN` |
| Function prefix / accessor | `wpconnect_gf_airtable_get_addon()` | `wpconnect_gf_notion_get_addon()` |
| Text domain | `wpc-gf-at` | `wpconnect-gf-notion` |
| Core method | `process_partial_entry_for_airtable()` | `process_partial_entry_for_notion()` |
| Snapshot meta key | `partial_entry_airtable_values_{id}` | `partial_entry_notion_values_{id}` |
| Result meta key | `wpc_airtable_feed_{id}_result` | `notion_api_response:{id}` (existing format, untouched) |
| Resend GET param | `retryfeed` | `sendfeed` |
| Nonce action / field | `wpc_gf_at_retry_action` / `wpc_gf_at_retry_nonce` | `wpc_gf_ntn_send_action` / `wpc_gf_ntn_send_nonce` |
| Button label | "Retry" | "Send to Notion" |
| Confirmation | "Record has been resubmitted to Airtable." | "Entry has been sent to Notion." |
| Dispatch | direct `create_airtable_entry_after_form_submission()` | `$this->process_feed()` (preserves `wpc-gf-ntn/process-form-entry` pipeline) |

Hook callbacks were written as **named functions** in the `WPC_GF_NTN\Hooks` namespace
(matching GF Notion's existing style) rather than closures. Partial-entry registration
is wrapped in `class_exists('GF_Partial_Entries')`.

## Files changed in target

- `repos/addon_gf-notion/includes/classes/gf-addon.php`
  — new `process_partial_entry_for_notion()`; `partial-entries-enabled` checkbox in
    `feed_settings_fields()` (guarded).
- `repos/addon_gf-notion/includes/hooks.php`
  — `handle_partial_entry_saved()` / `handle_partial_entry_updated()` + hook registration;
    resend handling and "Send to Notion" link inside `render_entry_metabox()`.
- `repos/addon_gf-notion/includes/helpers.php`
  — new `Helpers\add_or_update_url_param()`.

## Commits

- `5e62e91 feature: add Gravity Forms Partial Entries support (ported from addon_gf-at)`
- `296af00 feature: add "Send to Notion" resend button on entry detail (ported from addon_gf-at)`

## Review (product-owner — APPROVED, 19/19)

Feature A:
- A1 checkbox hidden when GF Partial Entries inactive → PASS
- A2 checkbox shown per feed when active → PASS
- A3 unchecked feed → no Notion write → PASS
- A4 first partial save → `process_feed`, result meta written → PASS
- A5 changed update → dispatched, snapshot updated → PASS
- A6 unchanged update → no dispatch → PASS
- A7 standard submission unaffected → PASS
- A8 hooks on `_saved`/`_updated` with false/true, correct singleton → PASS

Feature B:
- B9 "Send to Notion" link per processed feed → PASS
- B10 valid nonce + cap → `process_feed` → PASS
- B11 success → confirmation + refreshed result → PASS
- B12 API error → shown, no fatal → PASS
- B13 invalid nonce → `wp_die(403)` → PASS
- B14 missing capability → `wp_die(403)` → PASS
- B15 multiple feeds → each link scoped to its feed_id → PASS

Cross-cutting: `$_GET` sanitized (`absint`/`wp_unslash`) + nonce verified before state
change → PASS; output escaped with `wpconnect-gf-notion` text domain → PASS; no Airtable
leftovers (grep clean) → PASS; `php -l` clean on all three files → PASS.

Notes (non-blocking, not introduced by this port): the `$error_data` undefined-variable
on the non-`WP_Error` Notion error sub-path is pre-existing on `main` and guarded by
`isset()`; the "Send to Notion" button is intentionally absent on entries with no prior
processed feed.

## Status

Ported — NOT published. No push, tag, release, ZIP, or Linear change performed.

Next step to publish (auto-detects this `port/partial-entries-send-button` branch):
- `/release GF Notion 2.0.0` (full QA lifecycle), or
- `/feature GF Notion` (PR only)
