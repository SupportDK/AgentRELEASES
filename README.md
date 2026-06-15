# AGENT WPC — Dev & Doc

Multi-agent workspace for WordPress plugin development, powered by Claude Code.

Three specialized agents cover the complete development lifecycle — requirements, implementation, and documentation — orchestrated by workflow commands and connected to Linear, GitHub, and Notion.

---

## Quick Start (new machine, < 5 min)

```bash
# 1. Clone the agent workspace
git clone git@github-supportdk:SupportDK/AgentRELEASES.git
cd AgentRELEASES

# 2. Local secrets: copy the template and set your GitHub PAT
#    ⚠️ Must be a CLASSIC token (ghp_...), scope `repo`.
#    Fine-grained tokens (github_pat_...) do NOT work (HTTP 400).
cp .env.example .env
nano .env                    # GITHUB_PAT=ghp_your_real_token

# 3. Register the GitHub MCP (loads .env, validates the token;
#    linear/notion/wp-devdocs load automatically from .mcp.json)
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
| `/release <plugin> <version>` | **Phase 1**: find Linear issues → implement → review → push `release/<version>` → test ZIP → issues to *For Test* → QA issue. **Stops for human QA** |
| `/tested <plugin> <version>` | **Phase 2** (manual, after QA): tag `v<version>` → push tag → issues to *Closed*. Never runs automatically |
| `/hotfix WPC-123` | Fast-track Phase 1 for bugs: minimal brief → fix → patch bump → test ZIP → stops for QA |
| `/feature WPC-123` | Development pipeline without releasing: brief → implement → review → push + PR |
| `/stories <plugin> <version>` | PO refines the version's Linear issues into complete user stories (acceptance criteria, scope, testing notes) — run before `/release` |
| `/issue WPC-123` | Refine a Linear issue into an Implementation Brief — no implementation |
| `/package <plugin> [version]` | Build a distributable plugin ZIP (`wp dist-archive`, named `<main-file>.<version>.zip`) |
| `/setup` | Verify the workspace setup on this machine |

> The release lifecycle has a **human QA gate**: `/release` prepares everything and stops; only after you test the ZIP do you run `/tested` to finalize. `/release` never tags, publishes, merges, deploys, or closes issues.

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

## Release lifecycle

```
/release <plugin> <version>
    ↓
Linear discovery → Implementation Brief (product-owner)
    ↓
Development on branch release/<version> (developer)
    ↓
Review vs acceptance criteria (product-owner, max 2 cycles)
    ↓
ZIP generated (<main-file>.<version>.zip) + branch pushed
    ↓
Issues moved to For Test · QA issue "Update <Plugin> <Version>" created
    ↓
🧑 Human tests the ZIP          ← QA gate
    ↓
/tested <plugin> <version>      ← manual trigger only
    ↓
Tag v<version> created + pushed
    ↓
Issues moved to Closed → Release completed
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
- **GitHub** — `origin` = this workspace (`SupportDK/AgentRELEASES`). Plugin repos (`wpconnect-co/<plugin-repo>`) are **execution targets** accessed via GitHub MCP / `gh` during workflows — never remotes of this repo
- **Notion** — documentation destination
- **wp-devdocs** — verified WordPress hooks/blocks index (via `npx wp-devdocs-mcp`)

OAuth tokens are always local to each machine. Nothing secret is ever committed.

---

## Documentation

- [docs/agents.md](docs/agents.md) — Agent reference: inputs, outputs, rules, commit convention
- [docs/architecture.md](docs/architecture.md) — System design, skills, MCP strategy
- [docs/workflow.md](docs/workflow.md) — Manual step-by-step workflow with a full example
- [docs/workflows/](docs/workflows/) — Pipeline narratives (release, onboarding)
