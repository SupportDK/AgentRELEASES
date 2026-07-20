# Release log — CF7 Notion 1.6.2

Repository: wpconnect-co/addon_cf7-notion
Branch: release/cf7-notion-1.6.2
Commit: 99ecf03ca4742d1e654736e4105306da764cdff6
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
8b91bfd6540934fca0eab777d602a972738fc8d4592ef07752e297b394240aa3

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
