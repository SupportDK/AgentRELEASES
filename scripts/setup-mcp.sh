#!/usr/bin/env bash

set -e

echo "Setting up MCP servers for AGENT WPC..."

claude mcp remove linear -s local 2>/dev/null || true
claude mcp remove notion -s local 2>/dev/null || true
claude mcp remove github -s local 2>/dev/null || true
claude mcp remove linear-server -s local 2>/dev/null || true

claude mcp add --transport http linear https://mcp.linear.app/mcp -s local
claude mcp add --transport http notion https://mcp.notion.com/mcp -s local
claude mcp add --transport http github https://api.githubcopilot.com/mcp/ -s local

echo ""
echo "MCP servers added."
echo "Next:"
echo "1. Run: claude"
echo "2. Inside Claude Code, run: /mcp"
echo "3. Authenticate Linear, Notion and GitHub."
