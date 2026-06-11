# WordPress Development Setup

**Installation Date:** 2026-03-12
**Status:** ✅ Complete

---

## 1. WordPress Agent Skills ✅

**Location:** `.claude/skills/`

13 expert skill modules installed:
- `wp-block-development` — Gutenberg block patterns
- `wp-block-themes` — Block theme architecture
- `wp-plugin-development` — Plugin best practices
- `wp-rest-api` — REST API patterns
- `wp-performance` — Performance optimization
- `wp-phpstan` — PHPStan static analysis
- `wp-wpcli-and-ops` — WP-CLI operations
- `wp-interactivity-api` — Interactivity API
- `wp-project-triage` — Project setup
- `wp-playground` — Playground testing
- `wordpress-router` — Routing patterns
- `wp-abilities-api` — Abilities API
- `wpds` — Development standards

These skills are **automatically loaded** by Claude Code.

---

## 2. WordPress DevDocs MCP ✅

**Status:** Configured in `~/.claude/settings.json`

The MCP server provides:
- Real-time WordPress hook indexing
- Block documentation
- Verified source-based information
- Full-text search across hooks

**Requires Initial Setup:**

```bash
npx wp-devdocs-mcp quick-add-all
```

This command indexes:
- WordPress Core hooks
- WooCommerce hooks
- Gutenberg blocks
- Official documentation

Run this once to populate the local database (~500MB).

---

## 3. Project Structure

```
AGENT WPC - DEV & DOC/
├── agents/
│   ├── product-owner/CLAUDE.md     (PO instructions + Linear editing rules)
│   ├── developer/CLAUDE.md         (Implementation guidelines)
│   └── documentation/CLAUDE.md     (Docs creation)
├── .claude/
│   └── skills/                     (13 WordPress skills)
├── _wp-agent-skills/               (Source repo - can be deleted)
├── _wp-devdocs-mcp/                (Source repo - can be deleted)
└── docs/                           (Generated documentation)
```

---

## 4. Next Steps

### For the Product Owner Agent:
- Use Linear to manage WPC team issues
- The PO can now edit Linear issue descriptions to clarify scope
- Brief structure: Problem → User Story → Scope → Acceptance Criteria → Out of Scope

### For the Developer Agent:
- Implement against PO specifications
- Use WordPress skills for best practices
- Leverage wp-devdocs-mcp for accurate hook information

### For the Documentation Agent:
- Document implemented features
- Update README, API docs, CHANGELOG
- Generate from source, not assumptions

---

## 5. WordPress DevDocs First Run

When you're ready to use wp-devdocs-mcp:

```bash
cd /Volumes/Externo\ MAC/AGENT\ WPC\ -\ DEV\ \&\ DOC
npx wp-devdocs-mcp quick-add-all
```

This creates a local SQLite database indexed with WordPress hooks. Takes 5-10 minutes on first run.

---

## 6. Cleanup (Optional)

The `_wp-agent-skills` and `_wp-devdocs-mcp` directories can be deleted once setup is complete — they're no longer needed:

```bash
rm -rf _wp-agent-skills _wp-devdocs-mcp
```

---

**Setup by:** Claude Code (Product Owner Agent)
**MCP Config:** `~/.claude/settings.json`
**Skills Location:** `.claude/skills/`
