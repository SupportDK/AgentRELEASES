# Onboarding a New Machine

Human-readable narrative of the setup flow. The canonical quick guide is [SETUP.md](../../SETUP.md); the executable checks live in [.claude/commands/setup.md](../../.claude/commands/setup.md) and [scripts/verify-setup.sh](../../scripts/verify-setup.sh).

---

## The 6 steps (< 5 minutes)

```bash
# 1. Clone
git clone <repo-url>
cd <repo-folder>

# 2. Local secrets file — token must be CLASSIC (ghp_...), scope `repo`
cp .env.example .env
nano .env                  # GITHUB_PAT=ghp_your_real_token

# 3. Register the GitHub MCP (loads .env, validates the token;
#    linear/notion/wp-devdocs load from the versioned .mcp.json)
./scripts/setup-mcp.sh

# 4. Open Claude Code and trust the project
claude
```

```text
# 5. Authenticate Linear and Notion (inside Claude Code)
/mcp

# 6. Verify
/setup
```

## Why it's this short

Everything is versioned in the repository:

| Component | Where | Loads how |
|---|---|---|
| MCP declarations | `.mcp.json` + `scripts/setup-mcp.sh` | Script registers them with your PAT |
| Agents | `.claude/agents/*.md` | Automatically |
| Skills (13 WP + workspace setup) | `.claude/skills/` | Automatically |
| Commands (/release, /feature, …) | `.claude/commands/` | Automatically |
| Permissions | `.claude/settings.json` | Automatically (`enableAllProjectMcpServers`) |
| Secrets template | `.env.example` | You copy it to `.env` (git-ignored) |

What can never be in the repo — and therefore needs the manual steps:

- **`.env` with your real `GITHUB_PAT`** → step 2 (template versioned as `.env.example`)
- **OAuth tokens** (Linear, Notion) → step 5
- **SSH keys** for the `github-crimaco` / `github-supportdk` host aliases → machine-level git config
- **Project trust** → Claude Code asks once per machine

## GitHub MCP: PAT instead of OAuth

The GitHub MCP endpoint does **not** support Claude Code's OAuth flow (`SDK auth failed: does not support dynamic client registration`). It authenticates via a Personal Access Token loaded from `.env`:

1. Create a **classic** PAT at <https://github.com/settings/tokens> with `repo` scope. **Fine-grained tokens (`github_pat_...`) do not work** — the endpoint rejects them with HTTP 400, and the setup script refuses to register them.
2. Set it in `.env` (`GITHUB_PAT=ghp_...`).
3. Run `./scripts/setup-mcp.sh` — it registers the github MCP at **local scope** with the token in the Authorization header. No `/mcp` authentication needed for GitHub.

Why local scope and not project scope: registering github with `-s project` would write the **real token** into the versioned `.mcp.json` and leak it to git. The script never does this, and never prints the full token (masked output only). Never commit `.env`.

## Prerequisites

- Claude Code installed and authenticated
- Node.js >= 20 (for the wp-devdocs MCP via npx)
- SSH access configured for both GitHub accounts

## Validation

```bash
claude mcp get github
claude mcp get linear
claude mcp get notion
```

Expected: `Status: Connected` for each.

## Optional: WordPress hooks index

To enable verified hook lookups via wp-devdocs (first time only, 5–10 min, ~500MB):

```bash
npx wp-devdocs-mcp quick-add-all
```

## Troubleshooting

See [SETUP.md](../../SETUP.md#troubleshooting) and the `agent-wpc-setup` skill (`.claude/skills/agent-wpc-setup/SKILL.md`). Or just ask Claude: "why are my MCPs missing?"
