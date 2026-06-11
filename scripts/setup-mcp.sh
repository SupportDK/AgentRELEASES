#!/usr/bin/env bash
# AGENT WPC — MCP setup script
# Loads .env, validates required variables, and registers the MCP servers.
# Portable: macOS and Ubuntu.

set -e

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ENV_FILE="$ROOT/.env"
ENV_EXAMPLE="$ROOT/.env.example"

echo "AGENT WPC — MCP Setup"
echo ""

# ── 1. Ensure .env exists ────────────────────────────────────────────
if [ ! -f "$ENV_FILE" ]; then
  if [ -f "$ENV_EXAMPLE" ]; then
    cp "$ENV_EXAMPLE" "$ENV_FILE"
    echo "ℹ️  No .env found — created one from .env.example:"
    echo "    $ENV_FILE"
  else
    echo "❌ Neither .env nor .env.example found at project root."
    echo "   Create $ENV_FILE with:"
    echo ""
    echo "   GITHUB_PAT=ghp_your_real_token"
    echo ""
    exit 1
  fi
fi

# ── 2. Load .env ─────────────────────────────────────────────────────
set -a
# shellcheck disable=SC1090
. "$ENV_FILE"
set +a

# ── 3. Validate GITHUB_PAT ───────────────────────────────────────────
if [ -z "${GITHUB_PAT:-}" ]; then
  echo "❌ GITHUB_PAT is not set in .env"
  echo ""
  echo "   1. Create a GitHub CLASSIC token (ghp_...) with 'repo' scope:"
  echo "      https://github.com/settings/tokens"
  echo "   2. Edit $ENV_FILE and set:"
  echo "      GITHUB_PAT=ghp_your_real_token"
  echo "   3. Re-run: ./scripts/setup-mcp.sh"
  echo ""
  exit 1
fi

case "$GITHUB_PAT" in
  ghp_*)
    # Masked confirmation — never print the full token.
    MASKED="$(printf '%s' "$GITHUB_PAT" | cut -c1-7)***"
    echo "✅ GITHUB_PAT loaded ($MASKED)"
    ;;
  github_pat_*)
    echo "⚠️  GITHUB_PAT looks like a FINE-GRAINED token (github_pat_...)."
    echo "   The GitHub MCP endpoint requires a CLASSIC token (ghp_...)."
    echo "   Continuing anyway, but expect HTTP 400 errors."
    ;;
  *)
    echo "⚠️  GITHUB_PAT does not look like a GitHub token (expected ghp_...)."
    echo "   Continuing anyway — verify it if GitHub MCP fails."
    ;;
esac
echo ""

# ── 4. Register MCP servers (local scope) ────────────────────────────
if ! command -v claude >/dev/null 2>&1; then
  echo "❌ claude CLI not found. Install Claude Code first."
  exit 1
fi

echo "Registering MCP servers..."

claude mcp remove linear -s local 2>/dev/null || true
claude mcp remove notion -s local 2>/dev/null || true
claude mcp remove github -s local 2>/dev/null || true
claude mcp remove wp-devdocs -s local 2>/dev/null || true
claude mcp remove linear-server -s local 2>/dev/null || true

claude mcp add --transport http -s local linear https://mcp.linear.app/mcp
claude mcp add --transport http -s local notion https://mcp.notion.com/mcp
claude mcp add --transport http -s local \
  -H "Authorization: Bearer $GITHUB_PAT" \
  github https://api.githubcopilot.com/mcp/

if command -v npx >/dev/null 2>&1; then
  claude mcp add -s local wp-devdocs -- npx -y wp-devdocs-mcp
else
  echo "⚠️  npx not found — skipping wp-devdocs (install Node.js >= 20)."
fi

# ── 5. Validate ──────────────────────────────────────────────────────
echo ""
echo "Registered servers:"
claude mcp list 2>/dev/null || echo "  (run 'claude mcp list' manually to validate)"

echo ""
echo "Next steps:"
echo "  1. Run: claude"
echo "  2. Inside Claude Code, run /mcp and authenticate Linear and Notion (OAuth)."
echo "     GitHub is already authenticated via your PAT — no OAuth needed."
echo "  3. Validate with:  claude mcp get github | grep -i status"
echo "  4. Run /setup for the full workspace check."
