# Architecture

## Overview

AGENT WPC is a multi-agent AI development workspace built on Claude Code sub-agents.

Three specialized agents cover distinct phases of the software development lifecycle. Each agent has a clearly bounded role and is connected to external tools (Linear for issue tracking, GitHub for version control).

---

## Pipeline

```
Linear Issue
     │
     ▼
Product Owner Agent
  └─ Reads issue → writes Implementation Brief
     │
     ▼
Developer Agent
  └─ Implements against spec → delivers ZIP + Implementation Summary
     │
     ▼
Human Validation  (APPROVED / REJECTED)
     │
     ▼
Documentation Agent
  └─ Documents user-visible changes → updates CHANGELOG, docs/
     │
     ▼
Product Owner Agent
  └─ Reviews deliverable against acceptance criteria → APPROVED / REJECTED
     │
     ▼
git commit (local)  →  git push (manual, explicit)
```

---

## Agents

### Product Owner (`agents/product-owner/`)

Reads Linear issues. Converts them into structured Implementation Briefs. Reviews finished deliverables criterion by criterion. Triggers the Documentation agent on approval.

Full definition: `.claude/agents/product-owner/CLAUDE.md`

### Developer (`agents/developer/`)

Implements against the Implementation Brief. Makes the smallest safe change. Creates testable ZIP packages for WordPress plugins. Performs a mandatory self-review before presenting results. Commits locally only after explicit approval.

Full definition: `.claude/agents/developer/CLAUDE.md`

### Documentation (`agents/documentation/`)

Documents reality — never assumptions. Only documents user-visible changes. Produces Feature Documentation, Changelog Entries, and README/docs updates.

Full definition: `.claude/agents/documentation/CLAUDE.md`

---

## Skills

13 WordPress-specific skills are installed in `.claude/skills/`. They are activated automatically when a task matches their scope.

| Skill | Scope |
|-------|-------|
| `wordpress-router` | Classify WP repos and route to the correct skill/workflow |
| `wp-project-triage` | Detect project type, tooling, PHP and WP versions |
| `wp-block-development` | Gutenberg blocks: block.json, attributes, rendering, deprecations |
| `wp-block-themes` | Block themes: theme.json, templates, patterns, style variations |
| `wp-plugin-development` | Plugin architecture, hooks, Settings API, security patterns |
| `wp-rest-api` | REST routes, endpoints, schema, authentication |
| `wp-interactivity-api` | Frontend with data-wp-* directives and Interactivity API stores |
| `wp-abilities-api` | Permissions, capabilities, REST auth |
| `wp-wpcli-and-ops` | WP-CLI commands, automation, multisite, search-replace |
| `wp-performance` | Profiling, caching, DB optimization, Server-Timing |
| `wp-phpstan` | Static analysis with PHPStan for WordPress |
| `wp-playground` | WordPress Playground for instant local environments |
| `wpds` | WordPress Design System |

---

## Integrations

### Linear

Configured via MCP in `.claude/settings.local.json`.

The Product Owner agent reads issues from Linear as the source of truth for requirements. It can also update issue descriptions to improve clarity before writing the brief.

**Permitted MCP operations:**

| Tool | Purpose |
|------|---------|
| `get_team` | List available teams |
| `list_issues` | List project issues |
| `get_issue` | Read full issue details |
| `save_issue` | Update issue description |

### GitHub

Two remotes are configured:

| Remote | Purpose |
|--------|---------|
| `origin` (`crimaco197/agent-wpc-dev-doc`) | Main development repository |
| `supportdk` (`SupportDK/AgentRELEASES`) | Release artifact distribution |

**Git rules:** commits are created locally by the Developer agent after approval. Push to remote is always a manual, explicit step.

---

## Repository Structure

```
/
├── .claude/
│   ├── agents/
│   │   ├── product-owner/CLAUDE.md    ← full agent definition (frontmatter + instructions)
│   │   ├── developer/CLAUDE.md        ← full agent definition
│   │   └── documentation/CLAUDE.md    ← full agent definition
│   ├── skills/                         ← 13 WordPress skills (auto-activated)
│   │   ├── wordpress-router/
│   │   ├── wp-block-development/
│   │   └── ...
│   ├── settings.json                   ← git operation permissions (shared)
│   └── settings.local.json             ← Linear MCP + local permissions (not committed)
│
├── agents/
│   ├── product-owner/CLAUDE.md         ← lightweight alias for directory-based invocation
│   ├── developer/CLAUDE.md             ← lightweight alias
│   └── documentation/CLAUDE.md         ← lightweight alias
│
├── docs/
│   ├── architecture.md                 ← this file
│   ├── agents.md                       ← agent reference: inputs, outputs, rules
│   └── workflow.md                     ← step-by-step workflow guide
│
├── plugins/
│   └── <name>-v<version>/              ← WordPress plugin sandbox (isolated from production)
│       └── <plugin-slug>/
│           ├── <plugin-slug>.php
│           ├── README.md
│           └── CHANGELOG.md
│
├── CHANGELOG.md
└── README.md
```

---

## Sandbox Plugins

The `plugins/` directory contains plugin implementations developed and tested within this workspace.

Subdirectories follow the naming convention `<name>-v<version>/` to isolate sandbox experiments from production code.

The Developer agent only modifies files within the active sandbox directory. It never touches production code.

**First artifact:** `plugins/test-v1.0.0/wpc-hello-world/` — a minimal Hello World plugin that validated the full pipeline end-to-end (issue WPC-94).
