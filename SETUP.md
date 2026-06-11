# SETUP — New Machine

Canonical setup guide for the AGENT WPC workspace. Target: working in under 5 minutes.

---

## Repository Architecture

**This repository (`SupportDK/AgentRELEASES`) is the agent orchestration workspace:** Claude agents, skills, workflow commands, setup scripts, MCP configuration, documentation, and release automation logic.

**WordPress plugin source code lives elsewhere**, in `wpconnect-co/<plugin-repo>` (e.g. `wpconnect-co/air-wp-sync`). Those repos hold the actual plugin code, feature branches, PRs, releases, and changelogs.

| | Agent workspace | Plugin repos |
|---|---|---|
| Location | `SupportDK/AgentRELEASES` | `wpconnect-co/<plugin-repo>` |
| Role | Orchestration layer | Execution targets |
| Git remote of this repo? | `origin` (the only required remote) | **Never** — accessed dynamically via GitHub MCP / `gh` when `/release`, `/feature` or `/hotfix` run |

> **Design rule:** do not add plugin repositories as git remotes of this workspace. Workflows clone them on demand into the git-ignored `repos/` directory (see `CLAUDE.md` — Repository Resolution Rules).

---

## Setup on a new computer

```bash
# 1. Clone the agent workspace
git clone git@github-supportdk:SupportDK/AgentRELEASES.git
cd AgentRELEASES

# 2. Create your local .env from the template
cp .env.example .env
nano .env          # set GITHUB_PAT=ghp_your_real_token

# 3. Register the GitHub MCP (loads .env, validates the token)
#    linear/notion/wp-devdocs load automatically from .mcp.json
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

The GitHub MCP endpoint does not support Claude Code's OAuth flow (`does not support dynamic client registration`). It requires a Personal Access Token.

> ⚠️ **It MUST be a CLASSIC token (`ghp_...`).**
> Fine-grained tokens (`github_pat_...`) are **rejected by the endpoint with HTTP 400** — the setup script refuses to register them and exits with instructions.

1. Go to <https://github.com/settings/tokens>
2. **Generate new token (classic)** — not "fine-grained"
3. Scope: `repo` (only — don't grant more)
4. Put it in `.env`:

```bash
GITHUB_PAT=ghp_your_real_token
```

Use your **real token** — placeholders like `ghp_TU_TOKEN` will fail with HTTP 400.

| Token type | Prefix | Works? |
|---|---|---|
| Classic PAT | `ghp_...` | ✅ Yes |
| Fine-grained PAT | `github_pat_...` | ❌ No — HTTP 400 |

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
| linear, notion, wp-devdocs MCPs | `.mcp.json` (versioned) — automatic when the project is trusted |
| github MCP | `setup-mcp.sh` registers it at **local scope** with your PAT (never at project scope — that would write the token into the versioned `.mcp.json`) |
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
| `HTTP 400 at https://api.githubcopilot.com/mcp/` | Empty, invalid or **fine-grained** PAT: `.env` needs a real **classic** token (`ghp_...`), then re-run `./scripts/setup-mcp.sh` |
| `GITHUB_PAT is a FINE-GRAINED token` from the script | Generate a **classic** token instead (`ghp_...`, `repo` scope) and replace it in `.env` |
| `error: missing required argument 'name'` from `claude mcp add` | Outdated script — `git pull` (the `-H` flag is variadic and must come AFTER the server name and URL) |
| linear/notion missing | They load from `.mcp.json` — restart `claude` in the project and accept the trust prompt |
| `origin -> SupportDK/AgentRELEASES` check fails | `git remote set-url origin git@github-supportdk:SupportDK/AgentRELEASES.git`. Plugin repos must NOT be remotes of this workspace |
| `GITHUB_PAT not set` from the script | Edit `.env` and set the token, re-run the script |
| wp-devdocs missing | Install Node.js >= 20 (`npx` required) |

More detail: [docs/workflows/onboarding.md](docs/workflows/onboarding.md) and the `agent-wpc-setup` skill.
