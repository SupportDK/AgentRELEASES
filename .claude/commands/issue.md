---
description: Refine a Linear issue into an Implementation Brief (PO phase only, no implementation)
argument-hint: WPC-123
---

# /issue $ARGUMENTS

Refine Linear issue **$1** into an Implementation Brief. Do NOT implement anything.

## Steps

1. Delegate to the **product-owner** agent with this task:
   - Read issue $1 from Linear (via Linear MCP).
   - If the description lacks clarity, improve it in Linear (Problem Statement, User Story, Scope, Acceptance Criteria, Out of Scope). Never change status, priority, or assignments.
   - Produce a structured Implementation Brief.

2. Present the Implementation Brief to the user verbatim.

3. Suggest next steps: `/feature $1` to implement without publishing, or `/release $1` for the full pipeline.

## Constraints

- No code changes, no commits, no branches.
- If the issue does not exist or is inaccessible, report the exact error from the Linear MCP.
