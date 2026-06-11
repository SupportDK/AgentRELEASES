#!/usr/bin/env bash
# AGENT WPC — workspace verification script
# Used by the /setup command and runnable standalone after cloning.
#
# Architecture (see SETUP.md):
# - This repo (SupportDK/AgentRELEASES) is the agent ORCHESTRATION workspace.
#   Required remote: origin -> SupportDK/AgentRELEASES.
# - WordPress plugin repos (wpconnect-co/<repo>) are EXECUTION TARGETS,
#   accessed dynamically via GitHub MCP / gh during /release, /feature,
#   /hotfix. They are NEVER git remotes of this workspace.
#
# Required checks FAIL the setup; optional checks only WARN.

PASS=0
FAIL=0
WARN=0

check() {
  local label="$1"
  local result="$2"
  if [ "$result" = "0" ]; then
    echo "  ✅ $label"
    PASS=$((PASS + 1))
  else
    echo "  ❌ $label"
    FAIL=$((FAIL + 1))
  fi
}

warn_check() {
  local label="$1"
  local result="$2"
  if [ "$result" = "0" ]; then
    echo "  ✅ $label"
    PASS=$((PASS + 1))
  else
    echo "  ⚠️  $label (warning — does not fail setup)"
    WARN=$((WARN + 1))
  fi
}

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT" || exit 1

# Load .env if present (source of GITHUB_PAT and other MCP variables)
if [ -f ".env" ]; then
  set -a
  # shellcheck disable=SC1091
  . ".env"
  set +a
fi

echo "AGENT WPC — Setup Verification"
echo "Workspace: $ROOT"
echo ""

echo "## Structure (required)"
[ -f ".mcp.json" ]; check ".mcp.json present" $?
[ -f ".env.example" ]; check ".env.example present" $?
[ -f ".env" ]; check ".env present (copy from .env.example if missing)" $?
[ -f ".claude/settings.json" ]; check ".claude/settings.json present" $?
[ -f "CLAUDE.md" ]; check "CLAUDE.md present (repository resolution rules)" $?
[ -d "docs" ]; check "docs/ present" $?

echo ""
echo "## Agents (required)"
for agent in product-owner developer documentation; do
  [ -f ".claude/agents/${agent}.md" ]; check "agent: ${agent}" $?
done

echo ""
echo "## Workflow commands (required)"
for cmd in setup issue feature hotfix release package; do
  [ -f ".claude/commands/${cmd}.md" ]; check "command: /${cmd}" $?
done

echo ""
echo "## Skills (required)"
SKILL_COUNT=$(find .claude/skills -name "SKILL.md" -maxdepth 2 2>/dev/null | wc -l | tr -d ' ')
[ "$SKILL_COUNT" -ge 14 ]; check "skills installed ($SKILL_COUNT found, expected >= 14)" $?

echo ""
echo "## Git remote (required)"
# This workspace IS SupportDK/AgentRELEASES — origin must point to it.
# Plugin repos (wpconnect-co/*) must NOT be remotes here.
ORIGIN_URL=$(git remote get-url origin 2>/dev/null || echo "")
printf '%s' "$ORIGIN_URL" | grep -q "SupportDK/AgentRELEASES"
check "origin -> SupportDK/AgentRELEASES (found: ${ORIGIN_URL:-none})" $?

echo ""
echo "## Tooling (required)"
command -v node >/dev/null 2>&1; check "node installed" $?
if command -v node >/dev/null 2>&1; then
  NODE_MAJOR=$(node -v | sed 's/v\([0-9]*\).*/\1/')
  [ "$NODE_MAJOR" -ge 20 ]; check "node >= 20 (found $(node -v))" $?
fi
command -v npx >/dev/null 2>&1; check "npx installed (wp-devdocs MCP)" $?
command -v claude >/dev/null 2>&1; check "claude CLI installed" $?
[ -n "$GITHUB_PAT" ]; check "GITHUB_PAT set via .env or environment (GitHub MCP auth)" $?
if [ -n "$GITHUB_PAT" ]; then
  case "$GITHUB_PAT" in
    ghp_*) true ;;
    *) false ;;
  esac
  check "GITHUB_PAT is a CLASSIC token (ghp_..., not fine-grained)" $?
fi

echo ""
echo "## MCP servers — must be Connected (required)"
if command -v claude >/dev/null 2>&1; then
  MCP_LIST=$(claude mcp list 2>/dev/null)
  for mcp in linear notion github wp-devdocs; do
    printf '%s\n' "$MCP_LIST" | grep -i "^${mcp}:" | grep -q "✔"
    check "mcp connected: $mcp" $?
  done
  echo ""
  echo "  ℹ️  linear/notion need OAuth via /mcp · github needs GITHUB_PAT in .env + ./scripts/setup-mcp.sh"
else
  echo "  ⚠️  claude CLI not found — skipping MCP checks"
  FAIL=$((FAIL + 1))
fi

echo ""
echo "## Secrets hygiene (required)"
git check-ignore -q .claude/settings.local.json; check ".claude/settings.local.json is git-ignored" $?
git check-ignore -q .env; check ".env is git-ignored" $?
! git check-ignore -q .env.example; check ".env.example is NOT git-ignored (versioned)" $?

echo ""
echo "## Plugin repository access (optional — warnings only)"
# Plugin repos live in wpconnect-co/* and are accessed via GitHub MCP / gh
# at workflow runtime. None of this is required for the workspace itself.
command -v gh >/dev/null 2>&1; warn_check "GitHub CLI (gh) installed" $?
grep -q "Repository Resolution Rules" CLAUDE.md 2>/dev/null
warn_check "known plugin repositories mapped in CLAUDE.md" $?
if [ -n "$GITHUB_PAT" ]; then
  case "$GITHUB_PAT" in ghp_*)
    git ls-remote "https://x-access-token:${GITHUB_PAT}@github.com/wpconnect-co/air-wp-sync.git" HEAD >/dev/null 2>&1
    warn_check "GitHub access to wpconnect-co repositories (tested: air-wp-sync)" $?
  ;; esac
fi

echo ""
echo "────────────────────────────────"
echo "Result: $PASS passed, $FAIL failed, $WARN warnings"
if [ "$FAIL" -gt 0 ]; then
  echo "Run /setup inside Claude Code for guided fixes."
  exit 1
fi
echo "Workspace ready ✅  (warnings, if any, do not block setup)"
