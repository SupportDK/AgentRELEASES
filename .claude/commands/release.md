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
- Improve issue descriptions if they lack clarity (never change status/priority/assignments — status moves are done by the main session later).
- Produce a consolidated Implementation Brief covering the issues in scope for this version.

Present the list of issues found and the brief; if no issues match, ask the user which Linear issues belong to this version.

## Phase 2 — Branch

```bash
git checkout -b test/<version>
```

Example: `test/1.4.1`. Pushes only ever go to `test/<version>` — never to `main` or `release/*`.

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
git push -u origin test/<version>
```

## Phase 7 — Linear updates (main session)

1. Move every original issue in scope to status **For Test**.
2. Create a new QA issue titled:
   ```text
   Update <Plugin Name> <Version>
   ```
   Example: `Update WPForms Notion 1.4.1`
3. Move the QA issue to **For Test**.
4. **Attach or reference the ZIP** in the QA issue:
   - Preferred: upload as a Linear attachment (Linear MCP `prepare_attachment_upload` + `create_attachment`).
   - Fallback if attachments are not possible: add to the issue description the local ZIP path, a storage link if uploaded anywhere, and a clear note that the tester must use **that ZIP** to test.

## Phase 8 — README issue (if applicable)

If the implementation modified `README`/readme-related content of the plugin (an external automation reads the README Linear issue description to update documentation):

1. Detect the README/readme.txt changes in the diff.
2. Locate the Linear issue for the README of this version — or create one if missing.
3. Append this block to its **description**:

   ```markdown
   ## README update for <Plugin Name> <Version>

   ### Summary

   <short summary>

   ### Proposed README changes

   <markdown content or changelog/readme section>

   ### Source branch

   test/<version>

   ### Related release

   <plugin> <version>
   ```

4. Move the README issue to **For Test**.

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
test/<version>

ZIP:
<zip path or link>

Original issues moved to:
For Test

QA issue:
Update <Plugin Name> <Version>

README issue:
<issue key if applicable>

Next step after human testing:
/tested <plugin> <version>
```

## Failure handling

- No matching Linear issues → ask the user which issues belong to this version before implementing anything.
- Review failing after 2 cycles → ABORT before any push; nothing leaves the machine.
- `wp dist-archive` unavailable → use the `/package` fallback and note it in the output.
- Linear attachment unsupported → use the documented fallback in Phase 7.4.
