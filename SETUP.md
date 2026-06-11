# SETUP — New Machine

Canonical setup guide for the AGENT WPC workspace. Target: working in under 5 minutes.

---

## Setup on a new computer

```bash
# 1. Clone
git clone <repo-url>
cd <repo-folder>

# 2. Create your local .env from the template
cp .env.example .env
nano .env          # set GITHUB_PAT=ghp_your_real_token

# 3. Register the MCP servers (loads .env automatically)
./scripts/setup-mcp.sh

# 4. Open Claude Code and trust the project
claude
```

```text
# 5. Inside Claude Code: authenticate Linear and Notion (OAuth in browser)
/mcp

# 6. Verify the whole workspace
/setup
```

GitHub does **not** need `/mcp` authentication — it is already authenticated with your PAT from `.env`.

---

## The GITHUB_PAT token

The GitHub MCP endpoint does not support Claude Code's OAuth flow (`does not support dynamic client registration`). It requires a Personal Access Token:

1. Go to <https://github.com/settings/tokens>
2. **Generate new token (classic)** — must be classic (`ghp_...`); fine-grained tokens (`github_pat_...`) do not work with this endpoint
3. Scope: `repo`
4. Put it in `.env`:

```bash
GITHUB_PAT=ghp_your_real_token
```

Use your **real token** — placeholders like `ghp_TU_TOKEN` will fail with HTTP 400.

---

## Validation

```bash
claude mcp get github
claude mcp get linear
claude mcp get notion
```

Expected result for each:

```text
Status: Connected
```

Or run the full diagnostic (also used by `/setup`):

```bash
./scripts/verify-setup.sh
```

---

## What's automatic vs manual

| Component | How it loads |
|---|---|
| Agents, skills, commands, settings | Versioned in `.claude/` — automatic |
| MCP declarations | `.mcp.json` (project) + `setup-mcp.sh` (local registration with your PAT) |
| Linear / Notion auth | OAuth via `/mcp` — once per machine |
| GitHub auth | `GITHUB_PAT` in `.env` — once per machine |
| wp-devdocs | npx, no auth (needs Node.js >= 20) |

---

## Security

- **Never commit `.env`** — it is git-ignored (`.env.example` is the only versioned template).
- **Never commit tokens** of any kind (PAT, API keys, OAuth secrets).
- Use a GitHub **classic PAT with `repo` scope only** — don't grant more scopes than needed.
- The setup script never prints your full token (only a masked prefix like `ghp_abc1***`).
- If a token leaks, revoke it immediately at <https://github.com/settings/tokens> and create a new one.

---

## Troubleshooting

| Symptom | Cause / fix |
|---|---|
| `SDK auth failed: does not support dynamic client registration` | GitHub MCP can't use OAuth — use the PAT flow above |
| `HTTP 400 at https://api.githubcopilot.com/mcp/` | Empty or invalid PAT: check `.env` has a real classic token, then re-run `./scripts/setup-mcp.sh` |
| MCPs missing after cloning | Run `./scripts/setup-mcp.sh`, or restart `claude` and accept the project trust prompt |
| `GITHUB_PAT not set` from the script | Edit `.env` and set the token, re-run the script |
| wp-devdocs missing | Install Node.js >= 20 (`npx` required) |

More detail: [docs/workflows/onboarding.md](docs/workflows/onboarding.md) and the `agent-wpc-setup` skill.
