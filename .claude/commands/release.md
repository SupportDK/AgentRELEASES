---
description: Full automated release pipeline for a Linear issue — brief, implement, review, version, ZIP, push, GitHub Release, docs, close issue
argument-hint: WPC-123
---

# /release $ARGUMENTS

Run the **fully automated** release pipeline for Linear issue **$1**. Invoking this command is the user's explicit approval for the entire pipeline, including push and publication — do not pause for intermediate confirmations.

You (the main session) are the orchestrator. Agents do their phase; you do branching, version bump, packaging, push, tagging, and the GitHub Release.

## Phase 1 — Product Owner: brief

Delegate to the **product-owner** agent:
- Read issue $1 from Linear; improve its description if unclear (never change status/priority/assignments).
- Produce an Implementation Brief (Problem, User Story, Scope, Acceptance Criteria, Out of Scope, Risks).

## Phase 2 — Branch

```bash
git checkout -b release/$1
```

## Phase 3 — Developer: implementation

Delegate to the **developer** agent with the full Implementation Brief:
- Implement the smallest safe change satisfying all acceptance criteria.
- Self-review (WordPress best practices, escaping, hooks, ABSPATH, scope).
- Local commits with the convention `feature|fix|improvement|compatibility: <user-visible change>`.
- Return the Implementation Summary including a **Suggested Version Bump** (patch/minor/major). The developer must NOT push.

## Phase 4 — Product Owner: review

Delegate to the **product-owner** agent with the Implementation Summary and the diff:
- Every acceptance criterion → PASS/FAIL; WordPress quality check; verdict APPROVED/REJECTED.

**If REJECTED:** return findings to the **developer** to fix, then re-review. Maximum 2 fix cycles — after that, ABORT the release: stop, report open findings, leave the branch intact, do not push anything.

## Phase 5 — Version, package, push, release (main session)

Only after APPROVED:

1. **Version bump** — determine the new version from the current plugin header + suggested bump (feature → minor, fix → patch, breaking → major). Update:
   - `Version:` in the plugin header
   - Plugin changelog file if present
   Commit: `improvement: bump version to X.Y.Z` (or fold into the release commit).

2. **Package** — apply the `/package` procedure: build `dist/<slug>.zip` with a single top-level `<slug>/` folder, runtime files only. Verify with `unzip -l`.

3. **Push + tag**:
   ```bash
   git push -u origin release/$1
   git tag v<X.Y.Z>
   git push origin v<X.Y.Z>
   ```

4. **GitHub Release** — create a release on the `supportdk` remote repository (SupportDK/AgentRELEASES) via the GitHub MCP or `gh release create`, with:
   - tag `v<X.Y.Z>`, title `<plugin-name> v<X.Y.Z>`
   - the ZIP attached as an asset
   - release notes from Phase 6 (create as draft first if notes are not ready, then finalize)

## Phase 6 — Documentation

Delegate to the **documentation** agent with the Implementation Summary, commits, and version:
- Update `CHANGELOG.md` (root and/or plugin changelog).
- Produce Release Notes (summary + grouped changes) — use them for the GitHub Release body.
- Update README/docs if the change affects configuration or usage.
- Prepare Notion page content; publish it via the Notion MCP from the main session.

## Phase 7 — Close the loop

- Comment on Linear issue $1 with: release URL, version, ZIP link.
- Set the issue status to "Done" via the Linear MCP.

## Final report

| Field | Value |
|---|---|
| Issue | $1 |
| Branch | release/$1 |
| Version | vX.Y.Z |
| Commits | list |
| Review | APPROVED (criteria X/X) |
| ZIP | dist/<slug>.zip |
| Release | URL |
| Notion | page URL |
| Linear | Done |

## Failure handling

- Review failing after 2 fix cycles → ABORT before any push; nothing is published.
- Push/tag/release errors → report verbatim, do not force-push, list exactly which steps completed so the user can resume manually.
- If the GitHub Release fails after push, the branch and tag remain — report and let the user retry just the release step.
