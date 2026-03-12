# Agent Reference

## How to invoke an agent

Each agent is a Claude Code sub-agent defined by a `CLAUDE.md` file in its subdirectory.

To invoke an agent, open Claude Code with the agent's directory as the working context, or reference the agent by name in a multi-agent workflow.

---

## Product Owner

**Directory:** `agents/product-owner/`

**Trigger:** When a new Linear issue needs to be turned into a development task, or when a delivered implementation needs review.

**Inputs:**
- Linear issue URL or ID
- Context about the plugin or feature area

**Outputs:**
- Implementation Brief (Problem, User Story, Scope, Acceptance Criteria, Out of Scope, Risks)
- Implementation Review (PASS/FAIL per criterion, APPROVED/REJECTED)
- Documentation Request (handed to Documentation agent)

**Does not:** write code, modify files, invent features.

---

## Developer

**Directory:** `agents/developer/`

**Trigger:** When the Product Owner delivers an Implementation Brief.

**Inputs:**
- Implementation Brief from the Product Owner
- Repository context

**Outputs:**
- Implemented code (committed to the repository)
- Implementation Summary (files changed, what was done, acceptance criteria check, caveats, suggested commit message)

**Does not:** define requirements, write documentation, skip acceptance criteria.

**WordPress rules:**
- Use `add_action` / `add_filter` for hooks
- Escape all output (`esc_html`, `esc_attr`, `esc_url`)
- Include `ABSPATH` guard in every plugin file
- Follow WordPress naming conventions

---

## Documentation

**Directory:** `agents/documentation/`

**Trigger:** When the Product Owner sends a Documentation Request after an approved implementation.

**Inputs:**
- Implementation Summary from the Developer
- Commit message
- Repository context

**Outputs (only for user-visible changes):**
- Feature Documentation (what changed, why it matters, how it works)
- Changelog entry
- README / docs update (if the feature affects configuration or usage)

**Does not:** write code, document internal refactors or tests, invent features.

---

## Commit Convention

All commits in this repository follow this prefix convention:

| Prefix | Use |
|---|---|
| `feature:` | New functionality |
| `fix:` | Bug fixes |
| `improvement:` | Enhancements to existing features |
| `compatibility:` | WordPress, PHP, WooCommerce, or external compatibility updates |

Messages describe the **user-visible change**, not internal implementation details.
