---
description: Create the next-version Linear project for a plugin from its stored template (name, icon, color, priority, lead, team) and seed its standard issues
argument-hint: <plugin> [version]
---

# /project $ARGUMENTS

Create (or adopt) the Linear **version project** for plugin **$1**, version **$2**, using the plugin's stored template below. Never create blind — an automation may already have created the project.

## Phase 0 — Resolve

1. Resolve `$1` against the **Plugin Project Templates** table below (same commercial names as the repository mapping in the root `CLAUDE.md`). If no template row matches, STOP and ask — do not invent styling.
2. If `$2` (version) is missing: resolve the repo via the CLAUDE.md mapping, read the `Version:` header on `main`, propose next patch (X.Y.Z+1) and confirm with the user.
3. Project name = `<Name pattern><version>` (e.g. pattern `GF Brevo Free v` + `2.6.4` → `GF Brevo Free v2.6.4`).

## Phase 1 — Check for an existing project (MANDATORY)

The repos' `sync-linear-template.yml` automation often auto-creates the next-version project minutes after a release merges (learned 2026-08-24: creating blind produced duplicates).

- `mcp__linear__list_projects` with `query: "<full project name>"` and `includeArchived: true`.
- **Exists (usually gray `#bec2c8`, no icon):** ADOPT it — apply the template styling with `save_project` on its **ID**. Do not create a second one.
- **Duplicates found:** keep the oldest, style it, and rename the others `[duplicate — canceled] <name>` + state `Canceled` (the MCP cannot delete projects).
- **Not found:** create it.

## Phase 2 — Create / style

`mcp__linear__save_project` with: `name`, `addTeams: [<Team>]` (only on create), `icon`, `color`, `priority` from the template, `lead: "support@wpconnect.co"`, `summary: "Next maintenance release project for <name>."`. State stays Backlog. Target date is set later, at release time (`/tested` housekeeping).

## Phase 3 — Seed standard issues

Every version project carries these two issues. **Check the project's issues first** (`list_issues` by project ID) — the automation may have seeded them; never duplicate (a stray duplicate "Readme" had to be canceled on CF7NO-81).

1. `Readme` — label `Readme`, empty description (filled by `/release` Phase 8).
2. `New Strings to translate` — label `Improvement`, description:
   ```
   There's any new string to translate ?

   Yes or Not ?
   ```

⚠️ Assign issues to the project by **project ID**, not name — `save_issue` fails silently (issue lands without project) when the name is ambiguous.

## Phase 4 — Carry-overs + verify

- List non-completed issues left in the **previous** version project of the same plugin; if any, offer to move them into the new project (e.g. CF7NO-84 was left behind in a completed project).
- Fetch the project back and report: name, URL, icon/color, priority, lead, seeded issue IDs.
- Remind the user: **favorites cannot be set via MCP** — starring is one click in the UI.

## Plugin Project Templates

Captured 2026-08-24 from each plugin's latest actively-styled version project (colored icon, not the gray `#bec2c8` auto-created ones). Colors follow the service family; icons: `Present` = free/wp.org, `Chip` = premium (where established), `Database` = plugins without a historical icon (user's pick), `Cart` = Air Woo Sync.

| Display Name | Team (key) | Name pattern | Icon | Color | Priority | Lead |
|---|---|---|---|---|---|---|
| Air WP Sync Free | Air WP Sync (AWPS) | `Air WP Sync Free v` | Present | #f2c94c | Low | support@wpconnect.co |
| Air WP Sync Pro+ | Air WP Sync (AWPS) | `Air WP Sync Pro+ v` | Chip | #f2c94c | Low | support@wpconnect.co |
| Air Woo Sync | Air Woo Sync (AWS) | `Air Woo Sync v` | Cart | #5e6ad2 | Low | support@wpconnect.co |
| Notion WP Sync Free | Notion WP Sync (NOWPS) | `WP Sync for Notion v` | Present | #f7c8c1 | Low | support@wpconnect.co |
| Notion WP Sync Pro+ | Notion WP Sync (NOWPS) | `Notion WP Sync Pro+ v` | Chip | #f7c8c1 | Low | support@wpconnect.co |
| TimeTonic WP Sync | TimeTonic (TIM) | `TimeTonic WP Sync v` | Chip | #eb5757 | Low | support@wpconnect.co |
| Orders Sync to Airtable for Woo | WP connect (WPC) | `Orders Sync to Airtable for Woo v` | Present | #5e6ad2 | Low | support@wpconnect.co |
| Sync Woo Orders to Odoo | Odoo (ODO) | `Sync Woo Orders to Odoo v` | Chip | #714B67 | Low | support@wpconnect.co |
| CF7 Airtable | CF7 Airtable (CF7AT) | `CF7 Airtable v` | Present | #f2c94c | Low | support@wpconnect.co |
| CF7 Notion | CF7 Notion (CF7NO) | `CF7 Notion v` | Present | #f7c8c1 | Low | support@wpconnect.co |
| GF Brevo Free | GF Brevo (GFSIB) | `GF Brevo Free v` | Present | #4cb782 | Low | support@wpconnect.co |
| GF Brevo | GF Brevo (GFSIB) | `GF Brevo v` | Database | #4cb782 | Low | support@wpconnect.co |
| GF Odoo | Odoo (ODO) | `GF Odoo v` | Database | #714B67 | Low | support@wpconnect.co |
| GF Notion | GF Notion (GFNO) | `GF Notion v` | Database | #f7c8c1 | Low | support@wpconnect.co |
| GF SendGrid | GF SendGrid (GFSG) | `GF SendGrid v` | Database | #26b5ce | Low | support@wpconnect.co |
| GF Airtable | GF Airtable (GFAT) | `GF Airtable v` | Database | #f2c94c | Low | support@wpconnect.co |
| GF TimeTonic | TimeTonic (TIM) | `GF TimeTonic v` | Database | #eb5757 | Low | support@wpconnect.co |
| WPForms Airtable | WPForms Airtable (WPFAT) | `WPForms Airtable v` | Database | #f2994a | Low | support@wpconnect.co |
| WPForms Notion | WPForms Notion (WPFNO) | `WPForms Notion v` | Database | #f2994a | Low | support@wpconnect.co |
| wpDataTables Airtable | WP connect (WPC) | `wpDataTables Airtable Add-On v` | Database | #5e6ad2 | Low | support@wpconnect.co |

Plugins whose historical projects had no icon use **Database** (user-chosen 2026-08-24, "like a database"): GF Brevo, GF Odoo, GF Airtable, GF SendGrid, GF TimeTonic, GF Notion, WPForms Airtable, WPForms Notion, wpDataTables Airtable.

Notes:
- Shared teams: AWPS (Free+Pro+), NOWPS (free "WP Sync for Notion" + Pro+), GFSIB (Free+Pro), TIM (TimeTonic WP Sync + GF TimeTonic + TimeTonic WP Sync for WooCommerce), ODO (Sync Woo Orders + GF Odoo), WPC (Orders Sync + wpDataTables).
- The free Notion plugin's project naming is `WP Sync for Notion vX` (not "Notion WP Sync").
- Keep this table in sync: if a template changes in Linear (icon/color/lead), update the row here in the same session.
