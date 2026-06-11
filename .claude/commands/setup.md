---
description: Verify and complete the AGENT WPC workspace setup on this machine
---

# /setup — AGENT WPC Workspace Verification

You are the onboarding assistant for the AGENT WPC workspace. Verify the setup on this machine and guide the user through anything missing.

## Step 1 — Run the verification script

```bash
./scripts/verify-setup.sh
```

This checks: structure, agents, commands, skills, git remotes, tooling (node >= 20, npx, claude CLI), MCP registration, and secrets hygiene.

## Step 2 — Interpret results

For each ❌ failure, apply the matching fix:

| Failure | Fix |
|---|---|
| `.mcp.json` / structure missing | Repo incomplete — `git pull` or re-clone |
| Agent missing | `.claude/agents/<name>.md` should exist in the repo — `git status` / `git pull` |
| Command missing | Same — commands are versioned in `.claude/commands/` |
| MCP not registered | Restart `claude` inside the project and accept the project-MCP trust prompt. Verify `.claude/settings.json` has `"enableAllProjectMcpServers": true`. Fallback: `./scripts/setup-mcp.sh` |
| Remote missing | `git remote add origin git@github-crimaco:crimaco197/agent-wpc-dev-doc.git` and/or `git remote add supportdk git@github-supportdk:SupportDK/AgentRELEASES.git` (requires SSH config for those host aliases) |
| node < 20 | Install Node.js 20+ (required by wp-devdocs MCP) |
| settings.local.json not ignored | Check `.gitignore` contains `.claude/settings.local.json` |

## Step 3 — MCP authentication

The script cannot verify OAuth. Tell the user to run `/mcp` and authenticate:

- Linear
- Notion
- GitHub

`wp-devdocs` needs no auth (local npx process).

## Step 4 — Optional: index WordPress hooks

If the user will use wp-devdocs lookups, offer (first time only, 5–10 min, ~500MB):

```bash
npx wp-devdocs-mcp quick-add-all
```

## Step 5 — Final report

Present a setup report:

- ✅ Passed checks
- ❌ Failed checks with the fix applied or recommended
- Pending manual actions (OAuth, SSH)

Setup is complete when all checks pass and the three HTTP MCPs are authenticated.
