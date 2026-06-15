# Agent Reference

Complete reference for each agent in the AGENT WPC system.

---

## How Agents Work

Agents are Claude Code sub-agents defined as flat markdown files in `.claude/agents/<name>.md` (frontmatter: name, description, model, tools). The main session delegates to them automatically based on their `description`, or explicitly when you ask.

**Preferred: workflow commands** (they orchestrate the agents end-to-end):

```
/release WPC-123    /feature WPC-123    /hotfix WPC-123    /issue WPC-123
```

**Direct invocation:**

```
Use the product-owner agent to process Linear issue WPC-123.
Use the developer agent to implement this brief: [...]
Use the documentation agent to document this summary: [...]
```

---

## Product Owner

**Definition:** `.claude/agents/product-owner.md`
**Model:** Sonnet
**Tools:** Read, Grep, Glob, Bash
**MCP:** Linear — `get_team`, `list_issues`, `get_issue`, `save_issue`

**Trigger:** A new Linear issue is ready to become a development task, or a finished implementation needs to be reviewed.

**Inputs:**
- Linear issue ID or URL
- Context about the plugin or feature area (optional)

**Outputs:**

| Output | When |
|--------|------|
| Implementation Brief | After reading the Linear issue |
| Implementation Review | After Developer delivers the summary |
| Documentation Request | After approving the implementation |

**Rules:**
- Does not write code
- Does not modify repository files
- Does not invent features beyond the issue scope
- Can update Linear issue descriptions to improve clarity (never changes status, priority, or assignments)
- Uses MoSCoW prioritization when scoping

**Implementation Brief structure:**
```
Problem Statement
User Story
Scope
Acceptance Criteria
Out of Scope
Risks
```

**Implementation Review structure:**
```
Criterion 1 → PASS / FAIL
Criterion 2 → PASS / FAIL
Decision: APPROVED / REJECTED
```

---

## Developer

**Definition:** `.claude/agents/developer.md`
**Model:** Sonnet
**Tools:** Read, Grep, Glob, Bash, Edit, Write

**Trigger:** Product Owner delivers an Implementation Brief.

**Inputs:**
- Implementation Brief (from Product Owner)
- Repository context (explored automatically)

**Outputs:**

| Output | When |
|--------|------|
| Implementation Summary | After implementing and self-reviewing |
| ZIP package (`dist/<slug>.zip`) | For every WordPress plugin task |
| Local git commit | Only after explicit APPROVED signal from the user |

**Rules:**
- Inspects the repo before making any change
- Implements the smallest safe change that satisfies all acceptance criteria
- Performs a mandatory self-review before presenting results
- Creates a testable ZIP and stops — does not commit until approved
- Never pushes without explicit instruction
- Never modifies documentation (that's the Documentation agent's job)
- Sandbox protection: only creates or modifies files within the current sandbox directory

**WordPress standards the Developer follows:**
- `add_action` / `add_filter` — no custom bootstrapping
- Escape all output: `esc_html`, `esc_attr`, `esc_url`
- `ABSPATH` guard in every plugin file
- WordPress naming conventions for hooks and function prefixes
- Minimal procedural code unless a class is clearly warranted

**Implementation Summary structure:**
```
Files Changed
Changes Made
Acceptance Criteria Check
Edge Cases / Caveats
ZIP Package (path, structure, testing instructions)
Suggested Commit Message
```

---

## Documentation

**Definition:** `.claude/agents/documentation.md`
**Model:** Sonnet
**Tools:** Read, Grep, Glob, Write

**Trigger:** Product Owner sends a Documentation Request after an approved implementation.

**Inputs:**
- Implementation Summary (from Developer)
- Commit message
- Repository context (explored automatically)

**Outputs (only for user-visible changes):**

| Output | When |
|--------|------|
| Feature Documentation | When the change is visible to users |
| Changelog Entry | For every documented change |
| README / docs update | When the change affects configuration or usage |

**Changes that are documented:**
- New features
- User-visible improvements
- Bug fixes that affect users
- Compatibility updates

**Changes that are NOT documented:**
- Internal refactors
- Code cleanup
- Tests
- Formatting changes
- Internal bug fixes invisible to users

**Output structure:**
```
Feature Documentation (what changed, why it matters, how it works)
Changelog Entry
README / Docs Update (if needed)
```

---

## Commit Convention

All commits in this repository follow this prefix convention:

| Prefix | Use |
|--------|-----|
| `feature:` | New functionality |
| `fix:` | Bug fixes |
| `improvement:` | Enhancements to existing features |
| `compatibility:` | WordPress, PHP, WooCommerce, or external compatibility updates |

Messages describe the **user-visible change**, not internal implementation details.

**Examples:**
```
feature: add default catalog visibility option
fix: resolve Airtable mapping bug
improvement: optimize API queries
compatibility: WordPress 6.9
```
