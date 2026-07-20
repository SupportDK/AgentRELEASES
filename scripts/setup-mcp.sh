#!/usr/bin/env bash
# AGENT WPC — MCP setup script
# Loads .env, validates GITHUB_PAT, and registers the GitHub MCP locally.
#
# Design notes (read before editing):
# - wp-devdocs is declared in the versioned .mcp.json (project scope) and
#   loads automatically. Linear and Notion use direct token-authenticated APIs,
#   not MCP servers.
# - github is the exception: its endpoint needs the PAT in an Authorization
#   header. It is registered at LOCAL scope only. NEVER register it with
#   `-s project`: that would write the real token into the versioned
#   .mcp.json and leak it to git.
# - `claude mcp add` syntax: -H/--header is VARIADIC — it swallows every
#   following argument. The server name and URL must come BEFORE -H.
#
# Portable: macOS and Ubuntu (bash + coreutils only).

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
    echo "❌ GITHUB_PAT is a FINE-GRAINED token (github_pat_...)."
    echo ""
    echo "   The GitHub MCP endpoint (https://api.githubcopilot.com/mcp/)"
    echo "   requires a CLASSIC Personal Access Token (ghp_...) with the"
    echo "   'repo' scope. Fine-grained tokens fail with HTTP 400."
    echo ""
    echo "   1. Go to https://github.com/settings/tokens"
    echo "   2. Choose 'Generate new token (classic)'"
    echo "   3. Select the 'repo' scope"
    echo "   4. Replace GITHUB_PAT in $ENV_FILE with the new ghp_... token"
    echo "   5. Re-run: ./scripts/setup-mcp.sh"
    echo ""
    exit 1
    ;;
  *)
    echo "⚠️  GITHUB_PAT does not look like a GitHub token (expected ghp_...)."
    echo "   Continuing anyway — verify it if GitHub MCP fails."
    ;;
esac
echo ""

# ── 4. Register the GitHub MCP (local scope) ─────────────────────────
if ! command -v claude >/dev/null 2>&1; then
  echo "❌ claude CLI not found. Install Claude Code first."
  exit 1
fi

if [ ! -f "$ROOT/.mcp.json" ]; then
  echo "⚠️  .mcp.json not found at project root — wp-devdocs"
  echo "   will not load automatically. Pull the latest repo version."
fi

echo "Cleaning stale Linear/Notion MCP registrations..."
claude mcp remove linear -s local 2>/dev/null || true
claude mcp remove notion -s local 2>/dev/null || true
claude mcp remove wp-devdocs -s local 2>/dev/null || true
claude mcp remove linear-server -s local 2>/dev/null || true
claude mcp remove github -s local 2>/dev/null || true

echo "Registering github MCP (local scope, PAT auth)..."
# NOTE: name and URL must come BEFORE -H (variadic option).
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ \
  -s local \
  -H "Authorization: Bearer $GITHUB_PAT"

# ── 5. Validate ──────────────────────────────────────────────────────
echo ""
echo "Registered servers:"
claude mcp list 2>/dev/null || echo "  (run 'claude mcp list' manually to validate)"

echo ""
echo "Next steps:"
echo "  1. Run: claude   (trust the project so .mcp.json loads wp-devdocs)"
echo "  2. Linear and Notion use direct API tokens supplied by the active Hermes/Orion environment."
echo "  3. Validate:"
echo "       claude mcp get github"
echo "       claude mcp get wp-devdocs"
echo "     Expected: Status: Connected"
echo "  4. Run /setup for the full workspace check."
