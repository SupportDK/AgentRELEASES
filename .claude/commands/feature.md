---
description: Development pipeline for a Linear issue — brief, implement, review, push + PR (no release)
argument-hint: WPC-123
---

# /feature $ARGUMENTS

Run the development pipeline for Linear issue **$1**: brief → implementation → review → push + PR. No version bump, no GitHub Release.

You (the main session) are the orchestrator. Agents do their phase; you do branching, push, and PR.

## Phase 1 — Product Owner: brief

Delegate to the **product-owner** agent:
- Read issue $1 from Linear; improve its description if unclear (never change status/priority/assignments).
- Produce an Implementation Brief (Problem, User Story, Scope, Acceptance Criteria, Out of Scope, Risks).

Show the brief to the user, then continue.

## Phase 2 — Branch

Create the working branch from the current default branch:

```bash
git checkout -b feature/$1-<short-slug>
```

`<short-slug>` = 2–4 kebab-case words from the issue title.

## Phase 3 — Developer: implementation

Delegate to the **developer** agent with the full Implementation Brief:
- Implement the smallest safe change satisfying all acceptance criteria.
- Self-review (WordPress best practices, escaping, hooks, ABSPATH, scope).
- Create local commits using the convention `feature|fix|improvement|compatibility: <user-visible change>`.
- Return the Implementation Summary. The developer must NOT push.

## Phase 4 — Product Owner: review

Delegate to the **product-owner** agent with the Implementation Summary and the diff (`git diff <base>...HEAD`):
- Check every acceptance criterion → PASS/FAIL.
- Check WordPress quality signals (escaping, hooks, ABSPATH guard).
- Verdict: APPROVED or REJECTED with reasons.

**If REJECTED:** send the findings back to the **developer** agent to fix, then re-review. Maximum 2 fix cycles — after that, stop and report the open findings to the user.

## Phase 5 — Push + PR (main session)

Only after APPROVED:

```bash
git push -u origin feature/$1-<short-slug>
```

Create a PR via the GitHub MCP (or `gh pr create` if available): title = main commit message, body = Implementation Brief summary + acceptance criteria checklist.

Update the Linear issue: add a comment with the PR link. Set status to "In Review" only if the workflow allows status changes — otherwise just comment.

## Final report

| Field | Value |
|---|---|
| Issue | $1 |
| Branch | feature/$1-… |
| Commits | list |
| Review | APPROVED (criteria X/X) |
| PR | URL |

## Failure handling

- Linear issue not found → stop at Phase 1, report.
- Review still failing after 2 fix cycles → stop, present findings, leave branch and commits intact for manual continuation.
- Push rejected → report git error verbatim; do not force-push.
