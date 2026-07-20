# Port Pipeline

Human-readable narrative of `/port` — reusing a feature from one plugin in another. The executable definition lives in [.claude/commands/port.md](../../.claude/commands/port.md).

---

## Why

The WP connect plugins (`wpconnect-co/*`) share a common architecture. When a feature is already implemented and proven in one plugin, re-writing it from scratch elsewhere is wasted, risky work. `/port` reads the reference implementation and adapts it into the target, respecting the target's own conventions.

## Flow

```
/port <feature> from <source> to <target>   [--issue WPC-123]
        ↓
Resolve both repos (CLAUDE.md mapping) → clone into repos/
  · source = read-only      · target = port/<slug> branch
        ↓
code-analyst reads the source → Reference Implementation Report
        ↓
product-owner cross-references the target → Port Brief (criteria adapted to target)
        ↓
developer adapts into the target (prefixes, text domain, namespace, structure)
        ↓
product-owner review (max 2 cycles)
        ↓
port-report.md written · STOP (not published)
        ↓
🧑 publish with /release <target> <version>   or   /feature <target>
```

## Roles per phase

| Phase | Actor | Output |
|---|---|---|
| Resolve | main session | both repos in `repos/`; source read-only, target on `port/<slug>` |
| Analyze | code-analyst | Reference Implementation Report (read-only) |
| Brief | product-owner | Port Brief with target-adapted acceptance criteria |
| Adapt | developer | local commits on `port/<slug>`, each `(ported from <source>)` |
| Review | product-owner | PASS/FAIL per criterion |
| Report | main session | `port-logs/<target-slug>/<slug>/port-report.md` |

## Design principles

- **Adapt, never copy literally.** The feature's behavior is preserved; its wiring is re-expressed in the target's conventions. This is why analysis (code-analyst) and adaptation (developer) are separate roles.
- **The source is sacred.** It is never branched or modified — only read.
- **`/port` does not publish.** No push, tag, release, ZIP or Linear changes. It hands a `port/<slug>` branch with local commits to the existing lifecycle (`/release` for the full QA gate, `/feature` for a PR). Both **auto-detect the `port/<slug>` branch** and offer to build the release/feature branch on top of it, so the hand-off is seamless — you don't have to remember the branch name.
- **Traceability.** Every ported commit cites its origin; `port-logs/` records source references and the adaptations made.

## How the feature is identified

- **Natural language** — "the test connection button", "incremental sync". The code-analyst locates it by grepping hooks, UI strings, option names, REST routes.
- **Linear issue** (`--issue WPC-123`) — used as the spec for what the feature should do.

Both can be combined. Pointing at exact files/commits is not part of the flow — the analyst finds the implementation.
