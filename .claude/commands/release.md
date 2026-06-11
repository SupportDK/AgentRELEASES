---
description: Full automated release pipeline — brief, implement, review, version, ZIP, push, GitHub Release, docs, close issue
argument-hint: WPC-123 | <plugin name> [version]
---

# /release $ARGUMENTS

Run the **fully automated** release pipeline. Invoking this command is the user's explicit approval for the entire pipeline, including push and publication — do not pause for intermediate confirmations.

You (the main session) are the orchestrator. Agents do their phase; you do repo acquisition, branching, version bump, packaging, push, tagging, and the GitHub Release.

## Phase 0 — Target repository resolution

Parse `$ARGUMENTS` — it can be a Linear issue ID (`WPC-123`), a plugin display name (`Air WP Sync Pro+`), or a plugin name + explicit version (`GF Airtable 2.5.1`):

1. **Resolve the repository** using the Repository Resolution Rules in the root `CLAUDE.md` (plugin display name → `wpconnect-co/<repository>`). If the argument is a Linear issue, read it first and resolve the plugin from the issue title/body. Never ask for the repository if it can be resolved from the mapping; if no match exists, ask the user.
2. **Acquire the repo** per the Repository Acquisition Workflow: verify it exists, clone into `repos/<repository>/` if absent (`git@github.com:wpconnect-co/<repository>.git`), otherwise fetch and require a clean working tree. Checkout the default branch, up to date.
3. **Explicit version:** if a version was passed in `$ARGUMENTS`, it overrides the computed bump in Phase 5.
4. If no Linear issue was given, find the matching issue in Linear (by plugin name and recent activity) or ask the user which issue to release.

All git work in Phases 2–5 happens inside `repos/<repository>/`.

## Phase 1 — Product Owner: brief

Delegate to the **product-owner** agent:
- Read the resolved Linear issue; improve its description if unclear (never change status/priority/assignments).
- Produce an Implementation Brief (Problem, User Story, Scope, Acceptance Criteria, Out of Scope, Risks).

## Phase 2 — Branch

Inside `repos/<repository>/`:

```bash
git checkout -b release/<issue-id>
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

1. **Version bump** — if an explicit version was passed in `$ARGUMENTS` (Phase 0), use it. Otherwise determine it from the current plugin header + suggested bump (feature → minor, fix → patch, breaking → major). Update:
   - `Version:` in the plugin header
   - Plugin changelog file if present
   Commit: `improvement: bump version to X.Y.Z` (or fold into the release commit).

2. **Package** — apply the `/package` procedure: build `dist/<slug>.zip` (in this workspace's `dist/`, not inside the plugin repo) with a single top-level `<slug>/` folder, runtime files only. Verify with `unzip -l`.

3. **Push + tag** (inside `repos/<repository>/`):
   ```bash
   git push -u origin release/<issue-id>
   git tag v<X.Y.Z>
   git push origin v<X.Y.Z>
   ```

4. **GitHub Release** — create a release on the **target plugin repository** (`wpconnect-co/<repository>`) via the GitHub MCP or `gh release create`, with:
   - tag `v<X.Y.Z>`, title `<plugin-name> v<X.Y.Z>`
   - the ZIP attached as an asset
   - release notes from Phase 6 (create as draft first if notes are not ready, then finalize)

   Never create plugin releases on `SupportDK/AgentRELEASES` — that repo is the orchestration workspace, not a plugin repo.

## Phase 6 — Documentation

Delegate to the **documentation** agent with the Implementation Summary, commits, and version:
- Update `CHANGELOG.md` (root and/or plugin changelog).
- Produce Release Notes (summary + grouped changes) — use them for the GitHub Release body.
- Update README/docs if the change affects configuration or usage.
- Prepare Notion page content; publish it via the Notion MCP from the main session.

## Phase 7 — Close the loop

- Comment on the Linear issue with: release URL, version, ZIP link.
- Set the issue status to "Done" via the Linear MCP.

## Final report

| Field | Value |
|---|---|
| Issue | WPC-… |
| Repository | wpconnect-co/<repository> |
| Branch | release/<issue-id> |
| Commit hash | <hash> |
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
