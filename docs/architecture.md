# Architecture

## Overview

Agent WPC is a multi-agent AI development workspace built on Claude Code sub-agents.

Three specialized agents handle distinct phases of the software development lifecycle. Each agent operates from its own subdirectory and is defined by a `CLAUDE.md` file.

---

## Pipeline

```
Linear Issue
     │
     ▼
Product Owner Agent
  └─ Reads issue → writes Implementation Brief
     │
     ▼
Developer Agent
  └─ Implements against spec → returns Implementation Summary
     │
     ▼
Documentation Agent
  └─ Documents user-visible changes → updates CHANGELOG, docs/
     │
     ▼
Product Owner Agent
  └─ Reviews deliverable against acceptance criteria → APPROVED / REJECTED
```

---

## Agents

### Product Owner (`agents/product-owner/`)

- Reads Linear issues
- Produces structured Implementation Briefs
- Reviews deliverables criterion by criterion
- Triggers the Documentation agent
- Uses MoSCoW prioritization

### Developer (`agents/developer/`)

- Implements against the Implementation Brief
- Makes the smallest safe change
- Follows WordPress best practices for plugin code
- Performs a self-review before presenting results
- Reports: files changed, what was done, acceptance criteria check, caveats

### Documentation (`agents/documentation/`)

- Documents reality — never assumptions
- Only documents user-visible changes
- Produces: Feature Documentation, Changelog Entry, optional README/Docs update
- Does not write code

---

## Repository Structure

```
/
├── agents/
│   ├── product-owner/CLAUDE.md
│   ├── developer/CLAUDE.md
│   └── documentation/CLAUDE.md
├── docs/
│   ├── architecture.md       ← this file
│   ├── agents.md             ← agent reference
│   └── workflow.md           ← step-by-step workflow guide
├── plugins/
│   └── <plugin-name>/        ← plugin implementations
├── CHANGELOG.md
└── README.md
```

---

## Sandbox Plugins

The `plugins/` directory contains plugin implementations developed and tested within this workspace.

Subdirectories follow the naming convention `<name>-v<version>/` to isolate sandbox experiments from production code.
