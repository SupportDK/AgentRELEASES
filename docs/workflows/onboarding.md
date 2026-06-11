# Onboarding a New Machine

Human-readable narrative of the setup flow. The executable checks live in [.claude/commands/setup.md](../../.claude/commands/setup.md) and [scripts/verify-setup.sh](../../scripts/verify-setup.sh).

---

## The 4 steps (< 5 minutes)

```bash
# 1. Clone
git clone git@github-crimaco:crimaco197/agent-wpc-dev-doc.git
cd agent-wpc-dev-doc

# 2. Open Claude Code and trust the project
claude
```

```text
# 3. Authenticate the MCPs (inside Claude Code)
/mcp

# 4. Verify
/setup
```

## Why it's only 4 steps

Everything is versioned in the repository:

| Component | Where | Loads how |
|---|---|---|
| MCP servers (linear, notion, github, wp-devdocs) | `.mcp.json` | Automatically when the project is trusted |
| Agents | `.claude/agents/*.md` | Automatically |
| Skills (13 WP + workspace setup) | `.claude/skills/` | Automatically |
| Commands (/release, /feature, …) | `.claude/commands/` | Automatically |
| Permissions | `.claude/settings.json` | Automatically (`enableAllProjectMcpServers`) |

What can never be in the repo — and therefore needs the manual steps:

- **OAuth tokens** (Linear, Notion) → step 3
- **GitHub PAT** → `GITHUB_PAT` environment variable (see below)
- **SSH keys** for the `github-crimaco` / `github-supportdk` host aliases → machine-level git config
- **Project trust** → Claude Code asks once per machine

## GitHub MCP: PAT instead of OAuth

The GitHub MCP endpoint does **not** support Claude Code's OAuth flow (`SDK auth failed: does not support dynamic client registration`). It authenticates via a Personal Access Token referenced as `${GITHUB_PAT}` in `.mcp.json`:

1. Create a PAT at <https://github.com/settings/tokens> (classic token with `repo` scope is enough for PRs and releases).
2. Export it in your shell profile (`~/.zshrc`):

   ```bash
   export GITHUB_PAT="ghp_..."
   ```

3. Restart `claude`. The github MCP loads with the token — no `/mcp` authentication needed for it.

## Prerequisites

- Claude Code installed and authenticated
- Node.js >= 20 (for the wp-devdocs MCP via npx)
- SSH access configured for both GitHub accounts

## Optional: WordPress hooks index

To enable verified hook lookups via wp-devdocs (first time only, 5–10 min, ~500MB):

```bash
npx wp-devdocs-mcp quick-add-all
```

## Troubleshooting

See the `agent-wpc-setup` skill (`.claude/skills/agent-wpc-setup/SKILL.md`) — it covers missing MCPs, OAuth failures, and SSH issues. Or just ask Claude: "why are my MCPs missing?"
