# AGENT WPC — Dev & Doc

Multi-agent workspace with three specialized Claude Code sub-agents.

## Agents

| Agent | Directory | Role |
|-------|-----------|------|
| Product Owner | `agents/product-owner/` | Requirements, specs, acceptance criteria, backlog |
| Developer | `agents/developer/` | Implementation, bug fixes, code quality |
| Documentation | `agents/documentation/` | Technical docs, API reference, changelogs |

## Usage

Each agent is invoked by opening its subdirectory as the working directory in Claude Code, or by referencing it as a sub-agent. The `CLAUDE.md` in each directory defines the agent's persona, responsibilities, and output formats.

```
agents/
├── product-owner/
│   └── CLAUDE.md
├── developer/
│   └── CLAUDE.md
└── documentation/
    └── CLAUDE.md
```

## Workflow

1. **Product Owner** writes a spec with acceptance criteria.
2. **Developer** implements against the spec.
3. **Documentation** documents what was built.
4. **Product Owner** reviews the deliverable against acceptance criteria.
