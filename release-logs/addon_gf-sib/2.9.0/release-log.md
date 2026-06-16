# Release log — GF Brevo 2.9.0

Repository: wpconnect-co/addon_gf-sib
Branch: release/2.9.0
Commit: ec50b7450c80d80212bff412dc2890bead3385bf
Date: 2026-06-15

## QA Tracking

QA Issue:
Update GF Brevo 2.9.0

Linear ID:
GFSIB-218  (https://linear.app/wp-connect/issue/GFSIB-218/update-gf-brevo-290)

Linear Project:
GF Brevo v2.9.0

Status:
Done  (terminal state — finalized 2026-06-16)

ZIP:
wpconnect-gf-sendinblue.2.9.0.zip  (dist/wpconnect-gf-sendinblue.2.9.0.zip — attached to GFSIB-218)

Tag / GitHub Release / Deploy:
Handled by CI, NOT a manual tag. This plugin's `auto-tag-and-release` workflow
(`.github/workflows/tag-and-deploy.yml`) triggers on a `release/*` → `main` PR merge
and then auto-creates the tag `2.9.0`, the GitHub Release, and the deploy. All 8 prior
releases were published this way (author `github-actions[bot]`, tags without `v` prefix).
A manual `v2.9.0`/`2.9.0` tag was briefly pushed during `/tested` and then removed to
avoid colliding with the CI auto-tag on merge.

Release PR (CI trigger, NOT merged):
https://github.com/wpconnect-co/addon_gf-sib/pull/13  (release/2.9.0 → main)
→ Pending: the team merges this PR; CI then performs tag 2.9.0 + GitHub Release + deploy.

## Scope — issues in this version

| Issue | Title | Resolution |
|---|---|---|
| GFSIB-213 (Urgent) | Brevo API unavailable after subscription renewal | Removed trailing slash on `contacts/lists` endpoint in `get_lists()` |
| GFSIB-216 | "No list detected / Brevo API unavailable" | Same fix as GFSIB-213 (`contacts/lists` endpoint) |
| GFSIB-217 | Double opt-in returns 404 | Removed trailing slash on `contacts/doubleOptinConfirmation` endpoint |
| GFSIB-204 | Redirect URL with query parameter corrupted | `esc_url()` → `esc_url_raw()` for `redirectionUrl` |
| GFSIB-206 | Logo not displaying in Safari | Rewrote `brevo-logo.svg` (inline `fill`, removed `<style>` + XML prolog) |
| GFSIB-215 | "API valid; error appears" | Resolved by the Contacts Lists endpoint fix (no gform JS dependency found) |
| GFSIB-211 | Compatibility with WordPress 7.0 | `Tested up to: 7.0` |
| GFSIB-178 | Readme | 2.9.0 changelog added; README issue moved to For Test |

Excluded: GFSIB-179 (Canceled).

## PO Stories

No /stories run for this version. Issues were validated inline during /release (Phase 1); descriptions from customer tickets provided sufficient technical direction. GFSIB-215 ambiguity was investigated by the developer and resolved (no separate JS fix needed).

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| GFSIB-213 | Todo → In Progress | 2026-06-15T15:47:28Z |
| GFSIB-213 | In Progress → For Test | 2026-06-15T16:01:01Z |
| GFSIB-217 | Todo → In Progress | 2026-06-15T15:47:29Z |
| GFSIB-217 | In Progress → For Test | 2026-06-15T16:01:06Z |
| GFSIB-216 | Todo → In Progress | 2026-06-15T15:47:30Z |
| GFSIB-216 | In Progress → For Test | 2026-06-15T16:01:10Z |
| GFSIB-215 | Todo → In Progress | 2026-06-15T15:47:31Z |
| GFSIB-215 | In Progress → For Test | 2026-06-15T16:01:24Z |
| GFSIB-206 | Todo → In Progress | 2026-06-15T15:47:32Z |
| GFSIB-206 | In Progress → For Test | 2026-06-15T16:01:35Z |
| GFSIB-204 | Todo → In Progress | 2026-06-15T15:47:33Z |
| GFSIB-204 | In Progress → For Test | 2026-06-15T16:01:42Z |
| GFSIB-211 | Todo → In Progress | 2026-06-15T15:47:34Z |
| GFSIB-211 | In Progress → For Test | 2026-06-15T16:01:55Z |
| GFSIB-178 | Todo → In Progress | 2026-06-15T15:47:36Z |
| GFSIB-178 | In Progress → For Test | 2026-06-15T16:03:03Z |
| GFSIB-218 (QA) | created → For Test | 2026-06-15T16:02:10Z |
| GFSIB-213 | For Test → Done | 2026-06-15T16:24:49Z |
| GFSIB-217 | For Test → Done | 2026-06-15T16:24:48Z |
| GFSIB-216 | For Test → Done | 2026-06-15T16:24:48Z |
| GFSIB-215 | For Test → Done | 2026-06-15T16:24:48Z |
| GFSIB-206 | For Test → Done | 2026-06-15T16:24:49Z |
| GFSIB-204 | For Test → Done | 2026-06-15T16:24:49Z |
| GFSIB-211 | For Test → Done | 2026-06-15T16:24:49Z |
| GFSIB-178 | For Test → Done | 2026-06-15T16:24:49Z |
| GFSIB-218 (QA) | For Test → Done | 2026-06-15T16:24:48Z |

> Note: all issues were already in **Done** when `/tested` ran on 2026-06-16 (closed
> 2026-06-15T16:24, before this run — manual close or prior partial `/tested`). `/tested`
> recorded the existing terminal state rather than re-moving them. Terminal state used: **Done**
> (team "GF Brevo" has two completed-type states: Done, Closed).

## /tested outcome (2026-06-16)

- Verifications: branch `origin/release/2.9.0` ✅, ZIP in `dist/` ✅, tag `2.9.0` absent ✅.
- Issues already in terminal **Done** (not For Test) — flagged to the user; user approved finalizing.
- Tag: NOT pushed manually (a brief manual tag was created then removed). Tagging is delegated
  to CI on PR merge per this plugin's `auto-tag-and-release` workflow.
- GitHub Release + deploy: handled by CI on PR merge — not created manually here.
- PR #13 (`release/2.9.0 → main`) opened as the CI trigger, left **unmerged** (merge/deploy is the team's step).

## CI merge + outcome (2026-06-16)

- PR #13 (`release/2.9.0 → main`) **merged** at 2026-06-16T08:43 (merge commit `9d67661`) — explicit user instruction.
- Workflow `auto-tag-and-release` (run 27605459191) **FAILED** at step "Install WP-CLI".
- **No tag `2.9.0`, no GitHub Release, no deploy** were produced. `deploy` job was skipped.

### Root cause (upstream, not plugin code)
The shared workflow `wpconnect-co/github-workflows/.github/workflows/auto-tag-and-release.yml@v1.3`
downloads the stable `wp-cli.phar` (currently **2.12.0**) then runs
`wp package install wp-cli/dist-archive-command`, which resolves to `dev-main`. That dev branch now
requires `wp-cli/wp-cli ^2.13`, incompatible with the 2.12.0 phar → Composer exit code 2 → job fails.

```
wp-cli/dist-archive-command dev-main requires wp-cli/wp-cli ^2.13 -> found wp-cli/wp-cli[2.12.0]
```

This is environmental/upstream drift and affects **every** plugin using `auto-tag-and-release@v1.3`,
independent of GF Brevo 2.9.0's code (which is correct: header `Version: 2.9.0`, `Stable tag: 2.9.0`).

### Remediation (pending decision)
Fix the shared workflow's "Install WP-CLI" step to pin a compatible combination, e.g.
`wp package install wp-cli/dist-archive-command:@stable` pinned to a release supporting wp-cli ^2,
or fetch a wp-cli.phar build ≥ 2.13. Then re-run the failed run 27605459191 (replays the merged-PR
event → produces tag `2.9.0` + Release + deploy). Re-running before the fix will fail identically.

## Resolution — CI fixed and release completed (2026-06-16)

The blocker was fixed by bumping the plugin's `.github/workflows/tag-and-deploy.yml` from
`github-workflows@v1.3` → **`@v1.4`** (both `auto-tag-and-release` and `deploy-to-wpconnect`).
`v1.4` pins `wp-cli/dist-archive-command:3.1.0` (requires `wp-cli ^2`, satisfied by the 2.12.0 phar),
replacing v1.3's unpinned `dev-main` install that required `wp-cli ^2.13`.

Sequence:
- PR #14 (`chore/ci-bump-workflows-v1.4` → main) — merged `a16a201`. Bumps CI to @v1.4. Did not trigger release.
- PR #15 (`release/2.9.0` → main, empty re-trigger commit) — merged `be03817`.
- Run **27606454236** (`auto-tag-and-release@v1.4`) → **success**: Install WP-CLI ✅, Build ✅, Release ✅;
  `deploy` job ✅ (Prod / wpconnect.co), Slack success notification ✅.

Final artifacts:
- Tag: **2.9.0** → `be0381746ef633011d408bd23d923ab50e739c8d`
- GitHub Release: https://github.com/wpconnect-co/addon_gf-sib/releases/tag/2.9.0 (by github-actions[bot], 2026-06-16T09:01:37Z)
- Deploy: completed to Prod.

## Status of finalization

COMPLETE — issues in terminal **Done**; tag `2.9.0` + GitHub Release published; deployed to Prod.

### Recurrence prevention
`v1.3` of the shared workflow is broken for ALL plugins (unpinned `dist-archive-command`). Any plugin
still on `@v1.3` will fail its next release the same way. Move each plugin's `tag-and-deploy.yml` to
`@v1.4` (or later) before its next `/release`. Tracked in workspace memory `gf-brevo-ci-release`.
