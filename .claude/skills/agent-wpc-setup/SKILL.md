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

### 2. Verify MCP loading

The four MCPs (linear, notion, github, wp-devdocs) are declared in `.mcp.json` and load automatically when Claude Code starts in the project directory.

Validate with:

```bash
claude mcp list
```

If a server is missing, the user likely declined the project-MCP prompt — restart Claude Code in the project directory and accept, or check `.claude/settings.json` contains `"enableAllProjectMcpServers": true`.

Fallback (manual registration):

```bash
./scripts/setup-mcp.sh
```

### 3. Authenticate MCP servers

Inside Claude Code, run:

```text
/mcp
```

Guide the user through OAuth authentication for:

- Linear
- Notion
- GitHub

`wp-devdocs` runs locally via npx and needs no authentication — only Node.js >= 20.

### 4. Validate the installation

```bash
claude mcp list
claude mcp get linear
claude mcp get notion
claude mcp get github
```

Expected: `Status: Connected` for all HTTP MCPs.

Then run the project verification script:

```bash
./scripts/verify-setup.sh
```

Or simply run `/setup` inside Claude Code.

### 5. (Optional) Index WordPress hooks for wp-devdocs

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
- Commit `.env` files or `.claude/settings.local.json`.

Authentication must remain local to each machine.

## Goal

The objective of this skill is to reduce onboarding time for a new computer to:

1. Clone repository.
2. Open `claude` and trust the project (MCPs load from `.mcp.json`).
3. Authenticate MCPs via `/mcp`.
4. Run `/setup` to verify.

Target setup time: less than 5 minutes.
