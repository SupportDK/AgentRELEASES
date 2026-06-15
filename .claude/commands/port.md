---
description: Port a feature from a reference plugin into a target plugin — analyze the source, adapt to the target, leave commits on a port/ branch. Feeds /release or /feature; never publishes.
argument-hint: <feature> from <source-plugin> to <target-plugin> [--issue WPC-123]
---

# /port $ARGUMENTS

Port a feature that already exists in a **source plugin** into a **target plugin**, adapting it to the target's conventions. This command does analysis + adaptation + local commits only — it **STOPS** there. Publishing is done afterwards with `/release <target> <version>` or `/feature <target>`.

You (the main session) are the orchestrator. Agents do their phase; you do repo acquisition and branching.

Parse `$ARGUMENTS` as: `<feature description> from <source-plugin> to <target-plugin>` with an optional `--issue WPC-123`.

## Phase 0 — Resolve both repos

Apply the **Repository Resolution Rules** + **Repository Acquisition Workflow** from the root `CLAUDE.md` to BOTH plugins (commercial name → `wpconnect-co/<repository>`):

- **Source**: clone into `repos/<source-repository>/` if absent (else fetch). **Read-only — never create a branch or modify it.**
- **Target**: clone into `repos/<target-repository>/` if absent (else fetch + clean working tree). Checkout the default branch, up to date.

If either name cannot be resolved from the mapping, ask the user.

## Phase 1 — Analyze the source (code-analyst)

Delegate to the **code-analyst** agent:

- Source repo: `repos/<source-repository>/`
- Feature: the natural-language description from `$ARGUMENTS` (and the `--issue` Linear issue as spec, if provided).
- Produce the **Reference Implementation Report** (entry points, files & symbols, data flow, dependencies, integration points, porting risks, open questions).

Present the Report. If the analyst could not locate the feature, stop and ask the user for a pointer.

## Phase 2 — Port Brief (product-owner)

Delegate to the **product-owner** agent with the Report + the target plugin:

- Cross-reference the Report against the target (`repos/<target-repository>/`): does the target already have an equivalent? what differs (prefixes, text domain, namespace, settings structure)?
- Produce a **Port Brief**: scope, acceptance criteria **adapted to the target** (not a blind copy), out of scope, risks.

## Phase 3 — Branch (target only)

```bash
git -C repos/<target-repository> checkout -b port/<slug>
```

`<slug>` = 2–4 kebab-case words from the feature. Never push to `main`.

## Phase 4 — Adapt into the target (developer)

Delegate to the **developer** agent with the Port Brief + the Reference Implementation Report:

- **Adapt, do not copy literally**: respect the target's function prefixes, text domain, namespace, directory structure, registration/settings pattern, autoloader.
- WordPress correctness: `ABSPATH` guard, output escaping, correct hooks, naming conventions.
- Local commits with the project convention, each message ending with `(ported from <source-repository>)`.
- The developer must NOT push.

## Phase 5 — Review (product-owner)

Delegate to the **product-owner** agent with the diff (`git -C repos/<target-repository> diff <default>...port/<slug>`): every acceptance criterion → PASS/FAIL. REJECTED → back to developer (max 2 cycles, then report open findings and stop).

## Phase 6 — Port report + STOP

Write `port-logs/<target-slug>/<slug>/port-report.md` in the workspace and commit it:

```markdown
# Port report — <feature> → <Target Plugin>

Source: wpconnect-co/<source-repository>
Target: wpconnect-co/<target-repository>
Branch: port/<slug>
Linear issue: <WPC-123 or n/a>

## What was ported
<summary>

## Source references
<key files/symbols from the Reference Implementation Report>

## Adaptations made for the target
<prefixes / text domain / namespace / structure changes>

## Files changed in target
- repos/<target-repository>/...

## Review
Criterion 1 → PASS
...
```

Final output:

```text
Status: Ported — not published

Source:  <Source Plugin>  (wpconnect-co/<source-repository>, read-only)
Target:  <Target Plugin>  (wpconnect-co/<target-repository>)
Branch:  port/<slug>
Commits: <list, each "(ported from <source-repository>)">
Review:  APPROVED (criteria X/X)
Report:  port-logs/<target-slug>/<slug>/port-report.md

Next step to publish:
/release <target-plugin> <version>     (full QA lifecycle)
  or
/feature <target-plugin>               (PR only)
```

## STOP — restrictions

`/port` must NOT: push any branch, create tags or GitHub Releases, move or create Linear issues, generate a release ZIP, or modify the source plugin. All of that belongs to `/release` / `/feature` (and `/tested`).

## Failure handling

- Feature not found in the source → stop after Phase 1, report what was searched, ask for a pointer.
- Review failing after 2 cycles → stop, present open findings, leave the `port/<slug>` branch and commits intact for manual continuation.
- Source and target resolve to the same repo → stop and report (nothing to port).
