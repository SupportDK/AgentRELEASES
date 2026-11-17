# Release log — GF Brevo 2.9.1

Repository: wpconnect-co/addon_gf-sib
Branch: release/2.9.1
Commit: 4f075dd6b0c54ad700d3b80913a3862580fddb6a (QA-approved head; original QA build 58710ee)
Date: 2026-11-17

## QA Tracking

QA Issue:
Update GF Brevo 2.9.1

Linear ID:
GFSIB-307  (https://linear.app/wp-connect/issue/GFSIB-307/update-gf-brevo-291)

Linear Project:
GF Brevo v2.9.1 (a615eb46-3851-4895-aed9-3b4d4467b446) — verified by fetching the issue back

Status:
Closed  (finalized by /tested 2026-11-17 after explicit human QA approval by Cris)

ZIP:
wpconnect-gf-sendinblue.2.9.1.zip  (dist/wpconnect-gf-sendinblue.2.9.1.zip — revised build from release/2.9.1 @ 4f075dd, 85441 bytes, SHA-256 fbc8503a427607a9e414724bab740aa4c79839d9c6d434cc1a023bc4fa789d28, attached to GFSIB-307; this is the ZIP approved in QA)

Packaging note: `wp dist-archive` is not installed on this host, so the `/package` fallback was used
(rsync honouring `.distignore` + zip). Verified: single top-level folder `wpconnect-gf-sendinblue/`
(= Text Domain), 24 entries, no dev cruft, header Version and WPCONNECT_GF_SIB_VERSION = 2.9.1.
No composer runtime dependencies (no vendor/ required).

Tag:
none created by /tested (operator instruction; repo has tag-and-deploy.yml — tag 2.9.1 + GitHub Release + deploy are produced by the pipeline when release/2.9.1 is merged to main, which was NOT done here)

GitHub Release:
not created

Tag / GitHub Release / Deploy (as recorded by /release):
Not done by /release. This repo's CI (`tag-and-deploy.yml`) tags and deploys on merge of
release/2.9.1 → main; see /tested.

## Scope — issues in this version

| Issue | Title | Resolution |
|---|---|---|
| GFSIB-304 (Urgent) | Licensing: send full home_url() (www / non-www bug) | `api-licensing.php`: constructor args (used by activate/deactivate) and `check_license` now send `'url' => home_url()`; updater untouched |
| GFSIB-302 | Add WP connect logo to the settings page | `GF_Addon::plugin_settings_page()` renders a logo banner above settings (`settings_brand_logo()`), asset `assets/images/wpconnect-logo.png`, mirrors GF Dialog Insight |
| GFSIB-301 | WordPress 7.1 compatibility | `Tested up to: 7.1` |
| GFSIB-221 | Readme | 2.9.1 changelog entry; Readme issue description set and moved to For Test |

Commits (release/2.9.1, on top of main bb23239):
- fcf4c88 fix: license activation and validation on www sites (send full site URL)
- f6246a5 improvement: WP connect logo added to the settings page
- 58710ee compatibility: WordPress 7.1 (bump to 2.9.1, changelog)
- 4f075dd improvement: add Help section with Documentation and Support links to the settings page (added after the original QA build; included in the approved ZIP)

PO review: APPROVED (cycle 1). Runtime checks left to human QA: www license activation/check/update
download (HTTP 200), non-www regression, logo rendering, WP 7.1 smoke test.

House-style note: this plugin still has no `changelog.txt` and keeps the full changelog inline in
readme.txt. No verified wpconnect.co changelog URL exists for the pro add-on (probed slugs 404), so
the 2.9.1 entry was added inline, consistent with 2.9.0; migration to changelog.txt + link-only
readme section is left as follow-up.

## PO Stories

No /stories run for this version. Issues carried explicit acceptance criteria; validated inline.

## Workflow Status History

| Issue | Transition | Timestamp |
|---|---|---|
| GFSIB-304 | Todo → In Progress | 2026-11-17T09:11:07Z |
| GFSIB-302 | Backlog → In Progress | 2026-11-17T09:11:08Z |
| GFSIB-301 | Backlog → In Progress | 2026-11-17T09:11:09Z |
| GFSIB-221 | Backlog → In Progress | 2026-11-17T09:11:10Z |
| GFSIB-304 | In Progress → For Test | 2026-11-17T09:13:03Z |
| GFSIB-302 | In Progress → For Test | 2026-11-17T09:13:04Z |
| GFSIB-301 | In Progress → For Test | 2026-11-17T09:13:05Z |
| GFSIB-307 (QA issue) | created → For Test | 2026-11-17T09:13:14Z |
| GFSIB-221 | In Progress → For Test | 2026-11-17T09:13:36Z |
| GFSIB-307 (QA) | For Test → Closed | 2026-11-17T11:01:43Z |
| GFSIB-304 | For Test → Closed | 2026-11-17T11:01:45Z |
| GFSIB-302 | For Test → Closed | 2026-11-17T11:01:46Z |
| GFSIB-301 | For Test → Closed | 2026-11-17T11:01:47Z |
| GFSIB-221 | For Test → Closed | 2026-11-17T11:01:50Z |

## Finalization (/tested, 2026-11-17)

- Human QA approval: explicit, by Cris, for the revised ZIP above (SHA-256 verified locally before finalizing; ZIP contents compared byte-for-byte against `git archive 4f075dd` — identical).
- Verified: origin/release/2.9.1 = 4f075dd6b0c54ad700d3b80913a3862580fddb6a; all 5 issues were in For Test.
- Not done, per operator instruction: no merge of release/2.9.1 into main, no tag, no GitHub Release, no production deploy.
- Issues: Closed, assigned to support@wpconnect.co; GFSIB-307 filled with Medium / XS (label Update already present). Existing priority/estimate on other issues left unchanged.
- Project GF Brevo v2.9.1 (P-GFSIB-260): Completed, target date 2026-11-17, color #bec2c8 (icon Database kept).
- Next project: GF Brevo v2.9.2 did not exist → created P-GFSIB-335 (Database / #4cb782 / Low / lead support@wpconnect.co), seeded with GFSIB-308 Readme and GFSIB-309 New Strings to translate.
- Carry-overs: none (no open issues left in v2.9.1).
