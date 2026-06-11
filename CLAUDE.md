# AGENT WPC — Workspace Rules

Multi-agent WordPress development workspace. Pipeline: Linear → product-owner → developer → review → publish → documentation. Primary interface: `/release`, `/feature`, `/hotfix`, `/issue`, `/package`, `/setup`.

## Repository Resolution Rules

Before implementing any issue, determine which GitHub repository must be used. Users refer to plugins by their **commercial name** — always resolve it with this mapping. **Never ask for the repository name if it can be resolved here.** If no match exists, ask the user to specify the repository.

All plugin repositories live in the GitHub organization **`wpconnect-co`**:
`https://github.com/wpconnect-co/<repository>`

| Display Name | Repository |
|-------------|------------|
| Air WP Sync Free | air-wp-sync |
| Air WP Sync Pro+ | air-wp-sync-pro |
| Air Woo Sync | air-woo-sync |
| Notion WP Sync Free | notion-wp-sync |
| Notion WP Sync Pro+ | notion-wp-sync-pro |
| TimeTonic WP Sync | timetonic-wp-sync-pro |
| Orders Sync to Airtable for Woo | orders-sync-to-airtable-for-woocommerce |
| Sync Woo Orders to Odoo | wpconnect-woocommerce-odoo |
| CF7 Airtable | addon_cf7-airtable |
| CF7 Notion | addon_cf7-notion |
| GF Brevo Free | gf-sendinblue-free |
| GF Odoo | addon_gf-odoo |
| GF Notion | addon_gf-notion |
| GF Brevo | addon_gf-sib |
| GF SendGrid | addon_gf-sendgrid |
| GF Airtable | addon_gf-at |
| GF TimeTonic | addon_gf-timetonic |
| WPForms Airtable | addon_forms-at |
| WPForms Notion | addon_forms-notion |
| wpDataTables Airtable | addon_wpdatatables-airtable |

Resolution examples:

- `/release Air WP Sync Pro+` → repository `air-wp-sync-pro`
- `/release GF Airtable 2.5.1` → repository `addon_gf-at`, explicit version `2.5.1`
- A Linear issue mentioning "Notion WP Sync Pro+" → repository `notion-wp-sync-pro`

## Repository Acquisition Workflow

When a workflow command targets a plugin repository:

1. Resolve the plugin name to its repository (mapping above; also scan the Linear issue title/body for plugin names).
2. Verify the repository exists (GitHub MCP or `git ls-remote`).
3. Clone it into `repos/<repository>/` if not already present:
   `git clone git@github.com:wpconnect-co/<repository>.git repos/<repository>`
   (HTTPS fallback: `https://github.com/wpconnect-co/<repository>.git`)
4. If already present: `git fetch` and ensure a clean working tree before starting.
5. Checkout the appropriate branch. **Temporary testing convention: all workflow pushes go to `test/...` branches** (`test/<version>` for /release and /hotfix, `test/<issue-id>-<slug>` for /feature) — never to `main`, `release/*` or `feature/*` until the pipeline is validated.
6. Analyze the codebase before making changes.
7. Implement, commit (project convention `feature|fix|improvement|compatibility:`), push per the workflow's rules.
8. Generate a testable ZIP package when required (into this workspace's `dist/`).
9. Always report: repository used, branch used, commit hash, ZIP location.

`repos/` is git-ignored — cloned plugin repositories are never committed to this workspace.

## Conventions

- Commits: `feature|fix|improvement|compatibility: <user-visible change>`
- Agents: developer never pushes; push/tags/releases are main-session actions inside workflow commands.
- Secrets: `.env` (git-ignored, template `.env.example`); never commit tokens.
