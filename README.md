# AGENT WPC — Dev & Doc

Multi-agent workspace for WordPress plugin development, powered by Claude Code sub-agents.

Three specialized agents cover the complete development lifecycle: requirements, implementation, and documentation.

---

## Agents

| Agent | Role | Trigger |
|-------|------|---------|
| **Product Owner** | Converts Linear issues into structured specs. Reviews deliverables. | New Linear issue or finished implementation |
| **Developer** | Implements against the spec. Delivers testable ZIP packages. | Receiving an Implementation Brief |
| **Documentation** | Documents user-visible changes. Writes changelog entries. | After an approved implementation |

---

## Pipeline

```
Linear Issue
    ↓
Product Owner  →  Implementation Brief
    ↓
Developer      →  Implementation Summary + ZIP package
    ↓
Manual Testing     (APPROVED / REJECTED)
    ↓
Documentation  →  Changelog + docs update
    ↓
Product Owner  →  Final review (APPROVED / REJECTED)
    ↓
git commit (local)  →  git push (manual)
```

---

## How to Use

Agents are defined in `.claude/agents/` as Claude Code sub-agents and are invoked by name from the project root.

**Invoke an agent from the project root:**

```
Use the product-owner agent to process Linear issue WPC-123.

Use the developer agent to implement this brief: [paste brief]

Use the documentation agent to document this implementation: [paste summary]
```

**Or open a focused session from the agent directory:**

```bash
cd agents/product-owner && claude
cd agents/developer && claude
cd agents/documentation && claude
```

---

## Prerequisites

- [Claude Code](https://claude.ai/code) installed and authenticated
- Linear MCP configured in `~/.claude/settings.json`
- WordPress skills pre-installed at `.claude/skills/` (already included in this repo)

---

## Repository Structure

```
.claude/
├── agents/
│   ├── product-owner/CLAUDE.md    ← full agent definition (with frontmatter)
│   ├── developer/CLAUDE.md        ← full agent definition
│   └── documentation/CLAUDE.md    ← full agent definition
├── skills/                         ← 13 WordPress skills (auto-activated)
└── settings.json                   ← git operation permissions
agents/
├── product-owner/CLAUDE.md         ← lightweight agent definition
├── developer/CLAUDE.md             ← lightweight agent definition
└── documentation/CLAUDE.md         ← lightweight agent definition
docs/
├── architecture.md                 ← system design and integrations
├── agents.md                       ← agent reference: inputs, outputs, rules
└── workflow.md                     ← step-by-step workflow with examples
plugins/
└── <name>-v<version>/              ← WordPress plugin sandbox
CHANGELOG.md
README.md
```

---

## Documentation

- [docs/agents.md](docs/agents.md) — Agent reference: inputs, outputs, rules, commit convention
- [docs/architecture.md](docs/architecture.md) — System design, skills, MCP integrations
- [docs/workflow.md](docs/workflow.md) — Step-by-step workflow guide with a full example
