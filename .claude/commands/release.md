---
description: Phase 1 of the release lifecycle — develop, package and prepare a version for human QA. STOPS before tagging/publishing; finalize with /tested after QA.
argument-hint: <plugin> <version>   (e.g. wpforms-notion 1.4.1)
---

# /release $ARGUMENTS

Prepare plugin version **$ARGUMENTS** for human QA testing. This command runs the full development cycle and **STOPS** once the test package is ready. It never finalizes the release — that is `/tested`, triggered manually by a human after QA.

You (the main session) are the orchestrator. Agents do their phase; you do repo acquisition, branching, packaging, push, and all Linear status moves.

## Phase 0 — Resolve target

Parse `$ARGUMENTS` as `<plugin> <version>`:

1. **Resolve the repository** via the Repository Resolution Rules in the root `CLAUDE.md` (commercial name or repo slug → `wpconnect-co/<repository>`). Never ask if the mapping resolves it; ask only if there is no match.
2. **Acquire the repo**: verify it exists, clone into `repos/<repository>/` if absent (`git@github.com:wpconnect-co/<repository>.git`), otherwise fetch + clean working tree. Checkout the default branch, up to date.
3. `<version>` is the explicit target version for this release.

All git work below happens inside `repos/<repository>/`.

## Phase 1 — Linear discovery + brief (product-owner)

Delegate to the **product-owner** agent:

- Search Linear for the issues related to this plugin and version (plugin name in title/body/labels, version references, recent open issues for the plugin).
- **Light story-quality validation**: check each issue for a user story and acceptance criteria. Improve descriptions only when obviously necessary (one-liners, missing criteria). If several issues need deep refinement, recommend running `/stories <plugin> <version>` first instead of doing heavy rewriting inline — but do not block the release on it.
- Note the **Linear project/release/milestone** each issue belongs to — needed later for the QA issue (Phase 7).
- Produce a consolidated Implementation Brief covering the issues in scope for this version.

Present the list of issues found and the brief; if no issues match, ask the user which Linear issues belong to this version. If `release-logs/<plugin-slug>/<version>/po-stories.md` exists, read it as context — the stories were already refined.

## Phase 1.5 — Mark work started (main session)

Before development begins, move **every issue in scope** to status **In Progress**:

- Tool: `mcp__linear__save_issue` with `id: <issue identifier>` and `state: "In Progress"` (if the team uses a different name, resolve it first with `mcp__linear__list_issue_statuses(team)` and use the team's "started"-type state).
- Record each transition (issue, from → to, timestamp) — it goes into the release log in Phase 9.

## Phase 2 — Branch

```bash
git checkout -b release/<version>
```

Example: `release/1.4.1`. Pushes only ever go to `release/<version>` — never to `main`.

## Phase 3 — Implementation (developer)

Delegate to the **developer** agent with the Implementation Brief:

- Implement the changes for all issues in scope.
- Update the plugin's readme/changelog files **inside the plugin repo** if the changes are user-visible (this is part of the release deliverable, not workspace documentation).
- Bump `Version:` in the plugin header to `<version>` (and any other version constants the plugin uses).
- Self-review, then local commits with the convention `feature|fix|improvement|compatibility:`.
- The developer must NOT push.

## Phase 4 — Review (product-owner)

Delegate to the **product-owner** agent with the Implementation Summary and the diff: every acceptance criterion → PASS/FAIL. REJECTED → back to the developer (max 2 cycles, then ABORT before any push and report).

## Phase 5 — Package (ZIP)

Only after APPROVED. Inside `repos/<repository>/`:

1. **Preferred:** use WP-CLI dist-archive:
   ```bash
   wp dist-archive ./ --plugin-dirname=<plugin-dirname>
   ```
   **Fallback** (if `wp` or the dist-archive command is unavailable): apply the `/package` zip procedure (single top-level `<plugin-dirname>/` folder, runtime files only).

2. **Rename to the naming convention** — main plugin file without `.php`, then the version:
   ```text
   <main-plugin-file-without-.php>.<version>.zip
   ```
   Example: main file `wpconnect-wpf-notion.php`, version `1.4.1` → `wpconnect-wpf-notion.1.4.1.zip`

3. Move the ZIP to the workspace `dist/` directory and verify its contents (`unzip -l`).

## Phase 6 — Commit + push

```bash
git push -u origin release/<version>
```

## Phase 7 — Linear updates (main session)

Use these exact Linear MCP tools — all of these capabilities are confirmed available (create issues, update issues/status, comments, file attachments):

1. **Move every original issue in scope to For Test**: `mcp__linear__save_issue` with `id` + `state: "For Test"` (resolve the exact state name via `mcp__linear__list_issue_statuses(team)` if needed). Record each transition.

2. **Create the QA issue** — this step is MANDATORY and must never be silently skipped:
   - **Determine the Linear project first**: take the project/release/milestone of the original issues (noted in Phase 1). If the source issues belong to **different projects, STOP and ask the user** which project the QA issue should use.
   - Tool: `mcp__linear__save_issue` with NO `id`, `title: "Update <Plugin Name> <Version>"` (e.g. `Update WPForms Notion 1.4.1`), the `team` of the original issues, **`project: <same project as the original issues>`** (and `milestone` if the originals use one), and the description from step 4. Project assignment at creation is supported by the MCP.
   - If creation with `project` fails: create the issue first, then update it (`save_issue` with `id` + `project`) to assign the project.
   - **Verify creation AND project assignment**: fetch the issue back with `mcp__linear__get_issue`, record the identifier, and confirm it belongs to the expected project. If the project could not be assigned, say so explicitly in the final output with a warning — **never leave the QA issue unassigned silently**.

3. **Move the QA issue to For Test** (same `save_issue` + `state` call, or set `state` at creation).

4. **QA issue description — the Testing Package block is mandatory**, with or without attachment support:

   ```markdown
   ## Testing Package

   ZIP:
   <zip filename>

   Path:
   <local path>

   Download:
   <link if available>

   Plugin:
   <plugin>

   Version:
   <version>

   Branch:
   release/<version>
   ```

   Plus a clear note that the tester must use **that ZIP** to test.

5. **Attach the ZIP file** to the QA issue (confirmed supported):
   1. `mcp__linear__prepare_attachment_upload` (issue, filename, `contentType: "application/zip"`, exact size in bytes)
   2. `curl -X PUT --data-binary @dist/<zip>` to the returned `uploadRequest.url` with ALL returned headers verbatim (within 60s)
   3. `mcp__linear__create_attachment_from_upload` with the returned `assetUrl`
   If any upload step fails, fall back to the Testing Package block alone (already present per step 4) and report the upload failure in the final output.

## Phase 8 — README issue (if applicable)

If the implementation modified `README`/readme-related content of the plugin (an external automation reads the README Linear issue description to update documentation):

1. Detect the README/readme.txt changes in the diff.
2. Locate the Linear issue for the README of this version — or create one if missing.
3. Append the changelog to its **description**:

   ```markdown

   <markdown content or changelog/readme section>

   ```

4. Move the README issue to **For Test**.

(Full README block format: see the documentation agent's "README Issue Content" section.)

## Phase 9 — Release log (main session)

Create/update the release log files in the workspace under `release-logs/<plugin-slug>/<version>/` and commit them to the workspace repo:

**`release-log.md`**:

```markdown
# Release log — <Plugin Name> <Version>

Repository: wpconnect-co/<repository>
Branch: release/<version>
Commit: <hash>
Date: <ISO date>

## QA Tracking

QA Issue:
Update <Plugin Name> <Version>

Linear ID:
<identifier from Phase 7.2>  (<link>)

Linear Project:
<project assigned in Phase 7.2>

Status:
For Test

ZIP:
<zip filename>

## PO Stories

<link to po-stories.md if it exists, with a one-line summary — otherwise "No /stories run for this version">

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| WPC-… | Open → In Progress | <ts> |
| WPC-… | In Progress → For Test | <ts> |
| QA issue | created → For Test | <ts> |
```

**`linear-issues.md`**: one section per issue in scope (identifier, title, link) with its own `## Workflow Status History` (Open → In Progress → For Test → Complete) and timestamps when available. `/tested` appends the terminal transitions later.

## STOP — restrictions

`/release` must NOT, under any circumstance:

- Create or push a Git tag
- Create a GitHub Release
- Merge any Pull Request
- Deploy to WordPress.org or production
- Close Linear issues

Those actions belong to `/tested`, after explicit human QA approval. Never chain `/tested` automatically.

## Final output

```text
Status: Waiting for human QA

Plugin:
<Plugin Name>

Version:
<Version>

Branch:
release/<version>

ZIP:
<zip path or link>

Original issues moved to:
For Test

QA issue:
Update <Plugin Name> <Version>  (<Linear identifier> — verified created)

README issue:
<issue key if applicable>

QA issue project:
<Linear project assigned — or explicit WARNING if assignment failed>

Release log:
release-logs/<plugin-slug>/<version>/release-log.md

Next step after human testing:
/tested <plugin> <version>
```

If the QA issue could not be created or the ZIP upload failed, the output MUST say so explicitly with the error — never report success for a skipped step.

## Failure handling

- No matching Linear issues → ask the user which issues belong to this version before implementing anything.
- Review failing after 2 cycles → ABORT before any push; nothing leaves the machine.
- `wp dist-archive` unavailable → use the `/package` fallback and note it in the output.
- ZIP attachment upload fails → the Testing Package block (Phase 7.4) already covers the tester; report the upload error.
- QA issue creation fails → STOP, report the exact MCP error. Never silently skip it.
