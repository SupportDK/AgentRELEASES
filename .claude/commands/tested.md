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

1. The branch `test/<version>` exists (locally and on `origin`):
   ```bash
   git fetch origin && git rev-parse --verify origin/test/<version>
   ```
2. The ZIP `<main-plugin-file>.<version>.zip` exists in `dist/` or was referenced in the QA issue.
3. The related Linear issues (originals, QA issue `Update <Plugin Name> <Version>`, README issue if any) are in **For Test**.

## Phase 2 — Tag

On the head of `test/<version>`:

```bash
git checkout test/<version> && git pull origin test/<version>
git tag v<version>
git push origin v<version>
```

Example: `v1.4.1`.

## Phase 3 — GitHub Release (optional)

Create a GitHub Release on the **plugin repository** (`wpconnect-co/<repository>`) only if it is part of the documented workflow for this plugin — tag `v<version>`, title `<Plugin Name> v<version>`, the ZIP attached, release notes from the changelog. If unsure whether this plugin publishes GitHub Releases, ask the user.

## Phase 4 — Close Linear issues (main session)

Move to **Closed**:

1. Every original issue of this release
2. The QA issue `Update <Plugin Name> <Version>`
3. The README issue, if applicable

## Final output

```text
Status: Release completed

Plugin:
<Plugin Name>

Version:
<Version>  (tag v<version> pushed)

Branch:
test/<version>

GitHub Release:
<URL or "not created (not part of this plugin's workflow)">

Issues closed:
<list of issue keys>

QA issue closed:
Update <Plugin Name> <Version>

README issue closed:
<issue key or n/a>
```

## Restrictions

- Never run without the explicit human confirmation of Phase 0.
- Never merge PRs or deploy to WordPress.org/production unless the user explicitly instructs it as an additional step.
- If verifications fail (missing branch, ZIP, or issues not in For Test), do not tag — report what is missing and suggest re-running `/release <plugin> <version>` if needed.
