---
name: agent-wpc-setup
description: Use this skill when setting up, cloning, migrating, or onboarding the AGENT WPC Claude Code workspace on a new computer. It helps configure MCP servers, verify project structure, and guide authentication for Linear, Notion, GitHub, and WordPress development tools.
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

## Setup workflow

### 1. Verify project structure

Confirm the user is inside the AGENT WPC repository.

Expected folders:

```text
.claude/
agents/
docs/
scripts/
_wp-agent-skills/
_wp-devdocs-mcp/
```

### 2. Verify setup script

Check whether the following file exists:

```bash
scripts/setup-mcp.sh
```

If missing, instruct the user to restore the repository or pull the latest version.

### 3. Configure MCP servers

Ask the user to execute:

```bash
./scripts/setup-mcp.sh
```

This script should configure the required MCP servers:

- Linear
- Notion
- GitHub

### 4. Open Claude Code

Ask the user to start Claude Code:

```bash
claude
```

### 5. Authenticate MCP servers

Inside Claude Code, ask the user to run:

```text
/mcp
```

Guide the user through the authentication process for:

- Linear
- Notion
- GitHub

### 6. Validate the installation

Verify MCP availability using:

```bash
claude mcp list
```

Then inspect each MCP:

```bash
claude mcp get linear
claude mcp get notion
claude mcp get github
```

Expected result:

```text
Status: Connected
```

for all configured MCPs.

## Troubleshooting

### MCP missing after cloning

Cause:

The project was cloned successfully, but MCP registrations are stored locally by Claude Code and are not automatically transferred between computers.

Resolution:

```bash
./scripts/setup-mcp.sh
```

Then authenticate again through:

```text
/mcp
```

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
- Commit `.env` files containing secrets.

Authentication must remain local to each machine.

## Related components

### Skills

```text
_wp-agent-skills/
```

Contains WordPress-specific skills and workflows.

### MCP

```text
_wp-devdocs-mcp/
```

Provides WordPress documentation search and retrieval capabilities.

### Agents

```text
agents/product-owner/
agents/developer/
```

Contain the AGENT WPC workflow definitions.

## Goal

The objective of this skill is to reduce onboarding time for a new computer to:

1. Clone repository.
2. Run setup script.
3. Authenticate MCPs.
4. Start working.

Target setup time: less than 5 minutes.
