# Release log — CF7 Notion 1.6.2

Repository: wpconnect-co/addon_cf7-notion
Branch: release/1.6.2
Commit: d998bb7
Date: 2026-07-20

## QA Tracking

QA Issue:
Update CF7 Notion 1.6.2

Linear ID:
CF7NO-47 (https://linear.app/wp-connect/issue/CF7NO-47/update-cf7-notion-162)

Linear Project:
CF7 Notion v1.6.2

Status:
For Test

ZIP:
/home/cristian/AgentRELEASES/dist/add-on-cf7-for-notion.1.6.2.zip

SHA256:
8e827eebbda048e3e5cc49a2363d1d83fd899ded35705b898d0b343f4f87b89e

Linear attachment:
CF7NO-47 attachment `24febcf9-4f25-43e9-bcf3-a8a7d7088d1f` — QA ZIP uploaded to Linear for download.

## Changelog dates & format (2026-07-20)

Added release dates to `changelog.txt` entries (format `= x.y.z =` then `*Nth Month YYYY*`), sourced from git tags. Entries within each version ordered Compatibility with WordPress → Feature → Improvement → Fix, single line breaks between entries, blank line between versions. Tags limited to Fix/Improvement/Feature. Versions 1.0.0/1.0.1/1.0.2 have no tag, left undated. Final commit `d998bb7`, ZIP repackaged and re-attached (SHA above).

## PO Stories

No /stories run for this version. CF7NO-46 was handled as a focused WP.org compliance release.

## Scope

- CF7NO-46 — WP.org compliance: remove TranslationsPress and document Notion API external service.
- CF7NO-47 — Human QA package approval issue for CF7 Notion 1.6.2.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| CF7NO-46 | Backlog → For Test | 2026-07-20T14:55:43Z |
| CF7NO-47 | created → For Test | 2026-07-20T14:55:43Z |

## QA instructions

1. Install `/home/cristian/AgentRELEASES/dist/add-on-cf7-for-notion.1.6.2.zip` on a staging WordPress site with Contact Form 7 active.
2. Confirm the plugin activates without fatal errors.
3. Configure or reuse a Notion integration/database mapping and submit a CF7 form.
4. Verify the entry is sent to Notion.
5. Confirm no TranslationsPress updater behavior is present and translations load through WordPress standard mechanisms.
6. Review `readme.txt` External services: it must document only the Notion API.

Hard stop: no tag, merge, GitHub release, SVN publication, or Linear closure before Cris approves this exact ZIP via /tested.

## Post-review corrections (2026-07-20)

Applied after code review, before QA sign-off (same version 1.6.2):

- **Branch renamed** `release/cf7-notion-1.6.2` → `release/1.6.2` (workspace convention `release/<version>`; old remote branch deleted). Work lived in worktree `worktrees/addon_cf7-notion-release-1.6.2`.
- **Translation timing:** `load_translations` moved back to `init` priority 5 (was `plugins_loaded`) — WordPress 6.7+ best practice and the pre-1.6.0 behavior. Commit `6e87c28`.
- Repackaged the same version; ZIP replaced on CF7NO-47 (old attachment deleted, new `add-on-cf7-for-notion.1.6.2.zip`, SHA above). `php -l` OK; no TranslationsPress references remain.
