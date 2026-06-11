---
name: agent-wpc-setup
description: Use this skill when setting up, cloning, migrating, or onboarding the AGENT WPC Claude Code workspace on a new computer. It helps verify project structure, configure MCP authentication for Linear, Notion, and GitHub, and validate agents, skills, and commands availability.
---

# AGENT WPC Setup Skill

This skill helps configure the AGENT WPC workspace after cloning the repository on a new machine.

## When to use

Use this skill when the user says things like:

- "I cloned AGENT WPC on another computer"
- "Set up the MCPs"
- "Configure Linear, Notion and GitHub"
- "Prepare this Claude Code project"
- "Why are my MCPs missing?"
- "Onboard a new teammate"

## How portability works

Everything needed is **versioned in the repository**:

| Component | Location | Loaded automatically? |
|---|---|---|
| MCP servers | `.mcp.json` (project root) | Yes — when the user trusts the project |
| Agents | `.claude/agents/*.md` | Yes |
| Skills | `.claude/skills/*/SKILL.md` | Yes |
| Commands | `.claude/commands/*.md` | Yes |
| Settings | `.claude/settings.json` | Yes (`enableAllProjectMcpServers: true`) |

The ONLY per-machine steps are: trusting the project, OAuth authentication, and SSH keys.

## Setup workflow

### 1. Verify project structure

Confirm the user is inside the AGENT WPC repository.

Expected items:

```text
.mcp.json
.claude/agents/product-owner.md
.claude/agents/developer.md
.claude/agents/documentation.md
.claude/commands/
.claude/skills/
docs/
scripts/
```

### 2. Create the local .env

Secrets live in a git-ignored `.env` at the project root, created from the versioned template:

```bash
cp .env.example .env
```

Then the user edits `.env` and sets a **GitHub classic PAT** (`ghp_...`, `repo` scope, from https://github.com/settings/tokens):

```bash
GITHUB_PAT=ghp_real_token_here
```

Fine-grained tokens (`github_pat_...`) and placeholders do NOT work (HTTP 400).

### 3. Register MCP servers

Run the setup script — it loads `.env`, validates `GITHUB_PAT` (refusing to continue if missing), and registers the four MCPs:

```bash
./scripts/setup-mcp.sh
```

It registers: linear, notion (HTTP/OAuth), github (HTTP with the PAT in the Authorization header), and wp-devdocs (npx stdio). It never prints the full token.

### 4. Authenticate OAuth MCPs

Inside Claude Code, run:

```text
/mcp
```

Guide the user through OAuth authentication for:

- Linear
- Notion

**GitHub needs no `/mcp` authentication** — it is already authenticated via the PAT from `.env`. If GitHub shows `SDK auth failed: does not support dynamic client registration` or `HTTP 400`, the `.env` token is missing or invalid — fix `.env` and re-run `./scripts/setup-mcp.sh`.

`wp-devdocs` runs locally via npx and needs no authentication — only Node.js >= 20.

### 5. Validate the installation

```bash
claude mcp list
claude mcp get linear
claude mcp get notion
claude mcp get github
```

Expected: `Status: Connected` for all HTTP MCPs.

Then run the project verification script (it loads `.env` automatically):

```bash
./scripts/verify-setup.sh
```

Or simply run `/setup` inside Claude Code.

### 6. (Optional) Index WordPress hooks for wp-devdocs

First time only, to populate the local hooks database:

```bash
npx wp-devdocs-mcp quick-add-all
```

Takes 5–10 minutes, ~500MB local SQLite database.

## Troubleshooting

### MCP missing after cloning

Cause: the user declined the project trust prompt, or `enableAllProjectMcpServers` is missing.

Resolution: restart `claude` inside the project and accept the prompt. Fallback: `./scripts/setup-mcp.sh` then `/mcp`.

### Authentication failures

Verify:

- The user has access to the corresponding workspace.
- The user is logged into the correct GitHub account.
- The user is logged into the correct Linear workspace.
- The user is logged into the correct Notion workspace.

### GitHub SSH issues

Verify SSH identities:

```bash
ssh -T git@github-crimaco
ssh -T git@github-supportdk
```

Verify remotes:

```bash
git remote -v
```

Expected:

```text
origin      git@github-crimaco:crimaco197/agent-wpc-dev-doc.git
supportdk   git@github-supportdk:SupportDK/AgentRELEASES.git
```

## Important constraints

Do not:

- Store OAuth tokens inside the repository.
- Store GitHub Personal Access Tokens inside the repository.
- Store Linear API keys inside the repository.
- Store Notion secrets inside the repository.
- Commit `.env` (only `.env.example` is versioned) or `.claude/settings.local.json`.
- Print full tokens in console output (mask them).

Authentication must remain local to each machine.

## Goal

The objective of this skill is to reduce onboarding time for a new computer to:

1. Clone repository.
2. `cp .env.example .env` and set `GITHUB_PAT`.
3. Run `./scripts/setup-mcp.sh`.
4. Open `claude`, authenticate Linear/Notion via `/mcp`.
5. Run `/setup` to verify.

Target setup time: less than 5 minutes.
