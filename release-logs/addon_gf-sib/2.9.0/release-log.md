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
For Test

ZIP:
wpconnect-gf-sendinblue.2.9.0.zip  (dist/wpconnect-gf-sendinblue.2.9.0.zip — attached to GFSIB-218)

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

## Next step

After human QA approval: `/tested GF Brevo 2.9.0` (tags v2.9.0, moves issues to terminal state, updates this log).
