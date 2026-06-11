---
description: Development pipeline for a Linear issue — brief, implement, review, push + PR (no release)
argument-hint: WPC-123 | <plugin name>
---

# /feature $ARGUMENTS

Run the development pipeline: brief → implementation → review → push + PR. No version bump, no GitHub Release.

You (the main session) are the orchestrator. Agents do their phase; you do repo acquisition, branching, push, and PR.

## Phase 0 — Target repository resolution

Parse `$ARGUMENTS` (Linear issue ID or plugin display name) and apply the **Repository Resolution Rules** and **Repository Acquisition Workflow** from the root `CLAUDE.md`:

- Resolve plugin → `wpconnect-co/<repository>` (from the argument or from the Linear issue title/body). Never ask if the mapping resolves it; ask only if there is no match.
- Clone into `repos/<repository>/` if absent; otherwise fetch + clean working tree. Checkout the default branch.
- If only a plugin name was given, locate the corresponding Linear issue or ask the user which one to implement.

All git work below happens inside `repos/<repository>/`.

## Phase 1 — Product Owner: brief

Delegate to the **product-owner** agent:
- Read the resolved Linear issue; improve its description if unclear (never change status/priority/assignments).
- Produce an Implementation Brief (Problem, User Story, Scope, Acceptance Criteria, Out of Scope, Risks).

Show the brief to the user, then continue.

## Phase 2 — Branch

> ⚠️ Temporary testing convention: all pushes go to `test/...` branches — never to `main` or `feature/*`.

Create the working branch from the current default branch:

```bash
git checkout -b test/<issue-id>-<short-slug>
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
git push -u origin test/<issue-id>-<short-slug>
```

Create a PR via the GitHub MCP (or `gh pr create` if available): title = main commit message, body = Implementation Brief summary + acceptance criteria checklist.

Update the Linear issue: add a comment with the PR link. Set status to "In Review" only if the workflow allows status changes — otherwise just comment.

## Final report

| Field | Value |
|---|---|
| Issue | WPC-… |
| Repository | wpconnect-co/<repository> |
| Branch | test/<issue-id>-… |
| Commit hash | <hash> |
| Commits | list |
| Review | APPROVED (criteria X/X) |
| PR | URL |

## Failure handling

- Linear issue not found → stop at Phase 1, report.
- Review still failing after 2 fix cycles → stop, present findings, leave branch and commits intact for manual continuation.
- Push rejected → report git error verbatim; do not force-push.
