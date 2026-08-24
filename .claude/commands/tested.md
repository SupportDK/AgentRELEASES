---
description: Phase 2 of the release lifecycle — finalize a release after human QA approval. Tags, closes Linear issues. Must be triggered manually by a human, never chained after /release.
argument-hint: <plugin> <version>   (e.g. wpforms-notion 1.4.1)
---

# /tested $ARGUMENTS

Finalize the release of plugin version **$ARGUMENTS** after a human tester confirmed the ZIP works. This is the QA approval gate — this command is only ever triggered manually by a human, **never** automatically after `/release`.

## Phase 0 — Preconditions (confirmation gate)

This command may only proceed if the user explicitly confirms that:

- The ZIP was tested
- The plugin activates correctly
- The changes work as expected
- No blockers remain

If the invocation does not include this confirmation, **ask for it explicitly and wait** before doing anything else.

Then resolve the repository via the root `CLAUDE.md` mapping and open `repos/<repository>/` (clone if missing, fetch otherwise).

## Phase 1 — Verifications

All must pass before finalizing — if any fails, stop and report:

1. The branch `release/<version>` exists (locally and on `origin`):
   ```bash
   git fetch origin && git rev-parse --verify origin/release/<version>
   ```
2. The ZIP `<main-plugin-file>.<version>.zip` exists in `dist/` or was referenced in the QA issue.
3. The related Linear issues (originals, QA issue `Update <Plugin Name> <Version>`, README issue if any) are in **For Test**.

## Phase 2 — Tag

On the head of `release/<version>`:

```bash
git checkout release/<version> && git pull origin release/<version>
git tag v<version>
git push origin v<version>
```

Example: `v1.4.1`.

## Phase 3 — GitHub Release (optional)

Create a GitHub Release on the **plugin repository** (`wpconnect-co/<repository>`) only if it is part of the documented workflow for this plugin — tag `v<version>`, title `<Plugin Name> v<version>`, the ZIP attached, release notes from the changelog. If unsure whether this plugin publishes GitHub Releases, ask the user.

## Phase 4 — Close Linear issues (main session)

**Detect the team's terminal state — do not hardcode it.** Run `mcp__linear__list_issue_statuses(team)` and pick the completed-type state named **"Closed"** (house rule 2026-08-24 — released issues end in Closed, not Done/Complete). Only if no "Closed" state exists, fall back to another completed-type state and tell the user which one was used.

For **every issue of the release** (originals, QA issue `Update <Plugin Name> <Version>`, README issue if applicable), via `mcp__linear__save_issue`:

- `state: "Closed"`
- `assignee: "support@wpconnect.co"` (Cristian)
- Fill `priority`/`estimate` if missing (bugs: Urgent/S · QA issues: Medium/XS + label `Update` · Readme/Strings: Low/XS) — never override values already set.

Record each transition with timestamp.

## Phase 4.5 — Project housekeeping (main session)

On the release's Linear project (`mcp__linear__save_project` by **ID**):

1. `state: "Completed"` and `targetDate: <release date>`.
2. **Color → light gray `#bec2c8`** (keep the icon). House convention: colored icon = active/upcoming project, gray = released. This is why old completed projects are gray.

## Phase 4.6 — Create the next-version project (main session)

Ensure the next release always has a fresh project, using the `/project` templates (`.claude/commands/project.md`):

1. Compute `N+1` = released version with patch +1 (2.0.0 → 2.0.1).
2. Check if `<Name pattern>N+1` exists (`list_projects`, `includeArchived: true`):
   - **Doesn't exist** → create it per the `/project` flow (template styling + standard Readme/Strings issues).
   - **Exists as the gray auto-created shell** (`#bec2c8`, no icon, empty) → ADOPT it: apply template styling + seed issues. Done.
   - **Exists as a real project** (styled and/or already holds planned issues — e.g. the user created it manually) → leave it untouched and walk upward (`N+2`, `N+3`…) until a version with no project, and create THAT one per the `/project` flow. Example: released 2.0.0, user already created 2.0.1 → create 2.0.2.
3. Carry-over check: move any non-completed issues left in the just-released project into the next active project (ask if ambiguous).

## Phase 5 — Update release log (main session)

In `release-logs/<plugin-slug>/<version>/`:

- `release-log.md`: update `Status:` in **QA Tracking** to the terminal state, append the final transitions (For Test → <terminal state>) with timestamps to **Workflow Status History**, and add the tag (`v<version>`) and release URL if created.
- `linear-issues.md`: append the terminal transition to each issue's status history.

Commit both files to the workspace repo.

## Final output

```text
Status: Release completed

Plugin:
<Plugin Name>

Version:
<Version>  (tag v<version> pushed)

Branch:
release/<version>

GitHub Release:
<URL or "not created (not part of this plugin's workflow)">

Terminal state used:
Closed  (assigned to support@wpconnect.co, priority/estimate filled)

Issues closed:
<list of issue keys>

QA issue closed:
Update <Plugin Name> <Version>

README issue closed:
<issue key or n/a>

Project:
<name> → Completed, target date <date>, color → gray #bec2c8

Next project:
<name of the created/adopted next-version project + seeded issue IDs — or "vN+1 existed (user-created), created vN+2 instead">

Release log updated:
release-logs/<plugin-slug>/<version>/release-log.md
```

## Restrictions

- Never run without the explicit human confirmation of Phase 0.
- Never merge PRs or deploy to WordPress.org/production unless the user explicitly instructs it as an additional step.
- If verifications fail (missing branch, ZIP, or issues not in For Test), do not tag — report what is missing and suggest re-running `/release <plugin> <version>` if needed.
