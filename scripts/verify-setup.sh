#!/usr/bin/env bash
# AGENT WPC — workspace verification script
# Used by the /setup command and runnable standalone after cloning.

PASS=0
FAIL=0

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

echo "## Structure"
[ -f ".mcp.json" ]; check ".mcp.json present" $?
[ -f ".env.example" ]; check ".env.example present" $?
[ -f ".env" ]; check ".env present (copy from .env.example if missing)" $?
[ -f ".claude/settings.json" ]; check ".claude/settings.json present" $?
[ -d "docs" ]; check "docs/ present" $?
[ -d "plugins" ]; check "plugins/ present" $?

echo ""
echo "## Agents"
for agent in product-owner developer documentation; do
  [ -f ".claude/agents/${agent}.md" ]; check "agent: ${agent}" $?
done

echo ""
echo "## Commands"
for cmd in setup issue feature hotfix release package; do
  [ -f ".claude/commands/${cmd}.md" ]; check "command: /${cmd}" $?
done

echo ""
echo "## Skills"
SKILL_COUNT=$(find .claude/skills -name "SKILL.md" -maxdepth 2 2>/dev/null | wc -l | tr -d ' ')
[ "$SKILL_COUNT" -ge 14 ]; check "skills installed ($SKILL_COUNT found, expected >= 14)" $?

echo ""
echo "## Git remotes"
git remote -v | grep -q "^origin"; check "remote: origin" $?
git remote -v | grep -q "^supportdk"; check "remote: supportdk" $?

echo ""
echo "## Tooling"
command -v node >/dev/null 2>&1; check "node installed" $?
if command -v node >/dev/null 2>&1; then
  NODE_MAJOR=$(node -v | sed 's/v\([0-9]*\).*/\1/')
  [ "$NODE_MAJOR" -ge 20 ]; check "node >= 20 (found $(node -v))" $?
fi
command -v npx >/dev/null 2>&1; check "npx installed (wp-devdocs MCP)" $?
command -v claude >/dev/null 2>&1; check "claude CLI installed" $?
[ -n "$GITHUB_PAT" ]; check "GITHUB_PAT set via .env or environment (GitHub MCP auth)" $?

echo ""
echo "## MCP servers (registration)"
if command -v claude >/dev/null 2>&1; then
  MCP_LIST=$(claude mcp list 2>/dev/null)
  for mcp in linear notion github wp-devdocs; do
    echo "$MCP_LIST" | grep -qi "$mcp"; check "mcp: $mcp" $?
  done
  echo ""
  echo "  ℹ️  OAuth status is not checked here — run /mcp inside Claude Code to authenticate."
else
  echo "  ⚠️  claude CLI not found — skipping MCP checks"
fi

echo ""
echo "## Secrets hygiene"
git check-ignore -q .claude/settings.local.json; check ".claude/settings.local.json is git-ignored" $?
git check-ignore -q .env; check ".env is git-ignored" $?
! git check-ignore -q .env.example; check ".env.example is NOT git-ignored (versioned)" $?

echo ""
echo "────────────────────────────────"
echo "Result: $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
  echo "Run /setup inside Claude Code for guided fixes."
  exit 1
fi
echo "Workspace ready ✅"
