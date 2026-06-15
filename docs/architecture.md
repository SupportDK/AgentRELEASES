# Architecture

## Overview

AGENT WPC is a portable multi-agent AI development workspace built on Claude Code.

Three specialized agents cover distinct phases of the software development lifecycle, orchestrated by **workflow commands** that run in the main session. Everything — agents, skills, commands, MCP declarations — is versioned in the repository, so cloning the repo on a new machine yields a working workspace in under 5 minutes.

---

## Release lifecycle (two phases, human QA gate)

```
/release <plugin> <version>          ← Phase 1
     │
     ▼
product-owner: finds Linear issues for plugin+version → Implementation Brief
     │
     ▼
main session: branch release/<version> in repos/<repository>/
     │
     ▼
developer: implements + plugin readme/changelog + version bump → local commits
     │
     ▼
product-owner: reviews acceptance criteria (max 2 cycles, then abort)
     │
     ▼
main session: ZIP (wp dist-archive → <main-file>.<version>.zip) → push release/<version>
     │
     ▼
main session: Linear → issues to For Test · QA issue "Update <Plugin> <Version>" · README issue block
     │
     ▼
🛑 STOP — Waiting for human QA
     │
     ▼  (human tests the ZIP and confirms)
/tested <plugin> <version>           ← Phase 2, manual trigger only
     │
     ▼
tag v<version> pushed → issues to Closed → release completed
```

The QA gate is structural: `/release` never tags, publishes, merges, deploys or closes issues — those actions live exclusively in `/tested`, which requires explicit human confirmation and is never chained automatically.

---

## Orchestration model

- **Commands orchestrate** (`.claude/commands/*.md`): they run in the main session, sequence the phases, and own all side effects with external systems — branching, push, tags, releases, Linear status, Notion pages.
- **Agents work** (`.claude/agents/*.md`): each receives its inputs and returns its outputs without knowing the full pipeline. The developer never pushes; the PO never writes code; documentation never touches code.
- **Skills inform** (`.claude/skills/`): auto-activated WordPress expertise available to any agent.

| Command | Purpose |
|---|---|
| `/release <plugin> <version>` | Phase 1: develop → release/<version> → ZIP → Linear For Test → STOP for human QA |
| `/tested <plugin> <version>` | Phase 2 (manual): tag + push tag → Linear Closed. The QA approval gate |
| `/hotfix WPC-123` | Fast-track Phase 1 for bugs: minimal brief → fix → patch bump → stops for QA |
| `/feature WPC-123` | Development only: brief → implement → review → push + PR |
| `/issue WPC-123` | Brief only — refine requirements, no implementation |
| `/package <plugin>` | Distributable ZIP (`wp dist-archive`, `<main-file>.<version>.zip`) in `dist/` |
| `/setup` | Verify the workspace on this machine |

---

## Agents

### product-owner (`.claude/agents/product-owner.md`)

Reads Linear issues (via Linear MCP), improves descriptions, writes Implementation Briefs, reviews deliverables criterion by criterion (including WordPress quality signals), and produces Documentation Requests. Never writes code. Tools: Read, Grep, Glob, Bash.

### developer (`.claude/agents/developer.md`)

Implements against the Implementation Brief. Smallest safe change, WordPress best practices, mandatory self-review, local commits with the project convention. **Never pushes** — push belongs to the main session. When used standalone (outside a workflow command), it builds a testable ZIP and stops for manual validation. Tools: Read, Grep, Glob, Bash, Edit, Write.

### documentation (`.claude/agents/documentation.md`)

Documents reality — never assumptions. Only user-visible changes. Produces Feature Documentation, Changelog Entries, Release Notes, README updates, and Notion page content. Tools: Read, Grep, Glob, Write.

---

## Skills

14 skills in `.claude/skills/`, auto-activated by task match. Naming convention separates domains:

- `wp-*`, `wordpress-router`, `wpds` — WordPress domain (vendored from `_wp-agent-skills/`; do not edit by hand)
- `agent-wpc-setup` — workspace onboarding

| Skill | Scope |
|-------|-------|
| `wordpress-router` | Classify WP repos and route to the correct skill/workflow |
| `wp-project-triage` | Detect project type, tooling, PHP and WP versions |
| `wp-block-development` | Gutenberg blocks: block.json, attributes, rendering, deprecations |
| `wp-block-themes` | Block themes: theme.json, templates, patterns, style variations |
| `wp-plugin-development` | Plugin architecture, hooks, Settings API, security patterns |
| `wp-rest-api` | REST routes, endpoints, schema, authentication |
| `wp-interactivity-api` | Frontend with data-wp-* directives and Interactivity API stores |
| `wp-abilities-api` | Abilities API, capabilities, REST auth |
| `wp-wpcli-and-ops` | WP-CLI commands, automation, multisite, search-replace |
| `wp-performance` | Profiling, caching, DB optimization, Server-Timing |
| `wp-phpstan` | Static analysis with PHPStan for WordPress |
| `wp-playground` | WordPress Playground for instant local environments |
| `wpds` | WordPress Design System |
| `agent-wpc-setup` | Onboarding the workspace on a new machine |

---

## MCP strategy

Declared in `.mcp.json` at the project root (versioned, loaded automatically when the project is trusted):

| Server | Transport | Purpose | Auth |
|---|---|---|---|
| `linear` | HTTP | Issue source of truth | OAuth via `/mcp`, local per machine |
| `notion` | HTTP | Documentation destination | OAuth via `/mcp`, local per machine |
| `github` | HTTP | PRs, releases | OAuth via `/mcp`, local per machine |
| `wp-devdocs` | stdio (`npx wp-devdocs-mcp`) | Verified WP hooks/blocks index | None (Node >= 20) |

Rules:

- `.mcp.json` and `.claude/settings.json` (with `enableAllProjectMcpServers: true`) are versioned.
- OAuth tokens and `.claude/settings.local.json` are **never** committed.
- `scripts/setup-mcp.sh` remains as a manual fallback; `scripts/verify-setup.sh` is the diagnostic used by `/setup`.
- wp-devdocs first run: `npx wp-devdocs-mcp quick-add-all` to index hooks (optional, ~500MB).

---

## Repository architecture

| | Agent workspace (this repo) | Plugin repositories |
|---|---|---|
| Location | `SupportDK/AgentRELEASES` | `wpconnect-co/<plugin-repo>` |
| Contains | Agents, skills, commands, scripts, MCP config, docs, release automation logic | Plugin source, feature branches, PRs, releases, ZIPs, changelogs |
| Role | Orchestration layer | Execution targets |
| Git remote here | `origin` (the only required remote) | **Never** — accessed via GitHub MCP / `gh` at workflow runtime, cloned on demand into the git-ignored `repos/` directory |

Plugin name → repository mapping lives in the root `CLAUDE.md` (Repository Resolution Rules).

Git rules: agents only commit locally. Push, tags, and releases are main-session actions performed by the workflow commands — always against the target plugin repository, never against this workspace.

---

## Repository structure

```
/
├── .mcp.json                          ← project MCPs (versioned)
├── .gitignore                         ← only .claude/settings.local.json stays local
├── .claude/
│   ├── agents/
│   │   ├── product-owner.md           ← flat native sub-agent format
│   │   ├── developer.md
│   │   └── documentation.md
│   ├── commands/
│   │   ├── setup.md  issue.md  feature.md
│   │   ├── hotfix.md  release.md  package.md
│   ├── skills/                        ← 14 skills (auto-activated)
│   ├── settings.json                  ← versioned permissions + enableAllProjectMcpServers
│   └── settings.local.json            ← machine-local, git-ignored
├── docs/
│   ├── architecture.md                ← this file
│   ├── agents.md                      ← agent reference
│   ├── workflow.md                    ← manual step-by-step workflow
│   └── workflows/
│       ├── release-pipeline.md        ← release narrative
│       └── onboarding.md              ← onboarding narrative
├── plugins/
│   └── <name>-v<version>/             ← WordPress plugin sandbox
├── scripts/
│   ├── verify-setup.sh                ← diagnostics (used by /setup)
│   └── setup-mcp.sh                   ← MCP registration fallback
├── _wp-agent-skills/                  ← upstream source of the WP skills
├── _wp-devdocs-mcp/                   ← source of the wp-devdocs MCP (consumed via npx)
├── CHANGELOG.md
└── README.md
```

---

## Sandbox plugins

The `plugins/` directory contains plugin implementations developed and tested within this workspace. Subdirectories follow `<name>-v<version>/` to isolate sandbox experiments from production code. The developer agent only modifies files within the active sandbox directory.

**First artifact:** `plugins/test-v1.0.0/wpc-hello-world/` — minimal Hello World plugin that validated the pipeline end-to-end (issue WPC-94).
