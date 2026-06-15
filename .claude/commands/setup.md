---
description: Verify and complete the AGENT WPC workspace setup on this machine
---

# /setup — AGENT WPC Workspace Verification

You are the onboarding assistant for the AGENT WPC workspace. Verify the setup on this machine and guide the user through anything missing.

## Step 1 — Run the verification script

```bash
./scripts/verify-setup.sh
```

Required checks (FAIL): structure (.mcp.json, .env, .env.example, CLAUDE.md), agents, commands, skills, `origin -> SupportDK/AgentRELEASES`, tooling (node >= 20, npx, claude CLI, GITHUB_PAT classic), MCPs **connected**, secrets hygiene.

Optional checks (WARN only, never fail setup): gh CLI installed, plugin repo mapping in CLAUDE.md, GitHub access to wpconnect-co repositories.

## Step 2 — Interpret results

For each ❌ failure, apply the matching fix:

| Failure | Fix |
|---|---|
| `.mcp.json` / structure missing | Repo incomplete — `git pull` or re-clone |
| `.env` missing | `cp .env.example .env`, then edit it and set `GITHUB_PAT` |
| `GITHUB_PAT` not set | GitHub MCP needs a **classic** PAT (its endpoint does not support OAuth). Create one at github.com/settings/tokens (`repo` scope), set `GITHUB_PAT=ghp_...` in `.env`, then re-run `./scripts/setup-mcp.sh` |
| Agent missing | `.claude/agents/<name>.md` should exist in the repo — `git status` / `git pull` |
| Command missing | Same — commands are versioned in `.claude/commands/` |
| MCP not registered | Run `./scripts/setup-mcp.sh` (loads `.env` and registers all four MCPs). Alternative: restart `claude` and accept the project-MCP trust prompt |
| `origin -> SupportDK/AgentRELEASES` fails | `git remote set-url origin git@github-supportdk:SupportDK/AgentRELEASES.git` (requires the `github-supportdk` SSH host alias). Plugin repos (`wpconnect-co/*`) are execution targets accessed via GitHub MCP / `gh` — never add them as remotes |
| Optional warnings (gh CLI, wpconnect-co access) | Informative only — they never fail setup. `gh` and wpconnect-co access are needed at workflow runtime (`/release`, `/feature`), not for the workspace |
| node < 20 | Install Node.js 20+ (required by wp-devdocs MCP) |
| settings.local.json / `.env` not ignored | Check `.gitignore` contains `.claude/settings.local.json`, `.env` and `!.env.example` |

## Step 3 — MCP authentication

The script cannot verify OAuth. Tell the user to run `/mcp` and authenticate:

- Linear
- Notion

**GitHub uses the PAT from `.env`, not OAuth** — no `/mcp` step needed for it. If GitHub fails with HTTP 400, the token in `.env` is empty or invalid. `wp-devdocs` needs no auth (local npx process).

Validation commands:

```bash
claude mcp get github
claude mcp get linear
claude mcp get notion
```

Expected: `Status: Connected` for each.

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
