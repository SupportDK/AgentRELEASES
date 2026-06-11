# AGENT WPC — Dev & Doc

Multi-agent workspace for WordPress plugin development, powered by Claude Code.

Three specialized agents cover the complete development lifecycle — requirements, implementation, and documentation — orchestrated by workflow commands and connected to Linear, GitHub, and Notion.

---

## Quick Start (new machine, < 5 min)

```bash
# 1. Clone
git clone <repo-url>
cd <repo-folder>

# 2. Local secrets: copy the template and set your GitHub classic PAT
cp .env.example .env
nano .env                    # GITHUB_PAT=ghp_your_real_token

# 3. Register the MCPs (loads .env, validates GITHUB_PAT)
./scripts/setup-mcp.sh

# 4. Open Claude Code and trust the project
claude
```

```text
# 5. Inside Claude Code: authenticate Linear and Notion (GitHub uses the PAT)
/mcp

# 6. Verify everything
/setup
```

Everything else — agents, skills, commands, settings — is versioned in the repo and loads automatically. Full guide: [SETUP.md](SETUP.md).

---

## Workflow Commands

The primary interface. Each command orchestrates the agents end-to-end:

| Command | What it does |
|---------|--------------|
| `/release WPC-123` | Full pipeline: brief → implement → review → version bump → push → GitHub Release → docs → close issue |
| `/feature WPC-123` | Development pipeline without publishing: brief → implement → review → push + PR |
| `/hotfix WPC-123` | Fast-track release for bugs: minimal brief → fix → patch bump → release |
| `/issue WPC-123` | Refine a Linear issue into an Implementation Brief — no implementation |
| `/package <plugin> [version]` | Build a distributable plugin ZIP in `dist/` |
| `/setup` | Verify the workspace setup on this machine |

> ⚠️ `/release` and `/hotfix` are **fully automatic** — they push and publish without intermediate confirmation. Invoking them is your approval.

---

## Agents

| Agent | Role |
|-------|------|
| **product-owner** | Converts Linear issues into Implementation Briefs. Reviews deliverables criterion by criterion. |
| **developer** | Implements against the brief. Smallest safe change, WordPress best practices, local commits only — never pushes. |
| **documentation** | Documents user-visible changes: changelog, release notes, README updates, Notion sync. |

Agents are Claude Code sub-agents defined in `.claude/agents/*.md`. They can also be invoked directly:

```text
Use the product-owner agent to process Linear issue WPC-123.
```

---

## Pipeline (what /release runs)

```
Linear Issue
    ↓
product-owner   →  Implementation Brief
    ↓
developer       →  implementation + local commits
    ↓
product-owner   →  review vs acceptance criteria (max 2 fix cycles)
    ↓
main session    →  version bump, tag, ZIP, push, GitHub Release
    ↓
documentation   →  CHANGELOG, release notes, docs, Notion
    ↓
Linear issue closed with release link
```

---

## Repository Structure

```
.mcp.json                       ← project MCPs: linear, notion, github, wp-devdocs
.claude/
├── agents/                     ← product-owner.md, developer.md, documentation.md
├── commands/                   ← setup, issue, feature, hotfix, release, package
├── skills/                     ← 13 WordPress skills + agent-wpc-setup
├── settings.json               ← versioned permissions + enableAllProjectMcpServers
└── settings.local.json         ← machine-local, never committed
docs/
├── architecture.md             ← system design and integrations
├── agents.md                   ← agent reference
├── workflow.md                 ← step-by-step manual workflow
└── workflows/                  ← human-readable pipeline narratives
plugins/
└── <name>-v<version>/          ← WordPress plugin sandbox
scripts/
├── verify-setup.sh             ← workspace checks (used by /setup)
└── setup-mcp.sh                ← MCP registration fallback
_wp-agent-skills/               ← upstream source of the WP skills
_wp-devdocs-mcp/                ← source of the wp-devdocs MCP (used via npx)
CHANGELOG.md
```

---

## Integrations

- **Linear** — issue source of truth (product-owner reads and refines issues)
- **GitHub** — `origin` for development, `supportdk` for release artifacts
- **Notion** — documentation destination
- **wp-devdocs** — verified WordPress hooks/blocks index (via `npx wp-devdocs-mcp`)

OAuth tokens are always local to each machine. Nothing secret is ever committed.

---

## Documentation

- [docs/agents.md](docs/agents.md) — Agent reference: inputs, outputs, rules, commit convention
- [docs/architecture.md](docs/architecture.md) — System design, skills, MCP strategy
- [docs/workflow.md](docs/workflow.md) — Manual step-by-step workflow with a full example
- [docs/workflows/](docs/workflows/) — Pipeline narratives (release, onboarding)
