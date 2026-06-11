# Workflow Guide

Step-by-step guide for the full development cycle: from Linear issue to committed code.

---

## Overview

```
1. Product Owner reads Linear issue → writes Implementation Brief
2. Developer implements against the brief → delivers ZIP + Implementation Summary
3. Human validates the ZIP manually → APPROVED or REJECTED
4. Documentation Agent documents user-visible changes
5. Product Owner reviews deliverable against acceptance criteria
6. git commit (local) → git push (manual, explicit)
```

---

## Step 1 — Product Owner: Issue to Brief

**Trigger:** A Linear issue is ready for development.

**Input:** Linear issue ID or URL (e.g. `WPC-94`)

**Invoke:**
```
Use the product-owner agent to process Linear issue WPC-94 and produce an Implementation Brief.
```

**Output format:**

```
## Implementation Brief

**Problem Statement**
[What problem this solves and for whom]

**User Story**
As a [user type], I want [action] so that [outcome].

**Scope**
- [What is included]
- [Technical boundaries]

**Acceptance Criteria**
1. [Verifiable, testable condition]
2. [Verifiable, testable condition]

**Out of Scope**
- [Explicitly excluded items]

**Risks**
- [Potential issues or unknowns]
```

**Rules the PO follows:**
- Does not write code
- Does not invent features beyond the issue
- If the issue is unclear, updates the Linear description before writing the brief
- Uses MoSCoW (Must / Should / Could / Won't) to prioritize scope

---

## Step 2 — Developer: Brief to Implementation

**Trigger:** Product Owner delivers an Implementation Brief.

**Input:** The full Implementation Brief (paste it in)

**Invoke:**
```
Use the developer agent to implement the following brief: [paste Implementation Brief]
```

**What happens internally:**
1. Developer inspects the repo to understand the current architecture
2. Implements the minimum required change
3. Performs a mandatory self-review (WordPress best practices, escaping, hooks, plugin header)
4. Creates a testable ZIP package in `dist/`
5. **Stops and waits for human validation** — does not commit until approved

**Output format:**

```
## Implementation Summary

**Files Changed**
- plugins/test-v1.0.0/wpc-plugin/wpc-plugin.php

**Changes Made**
[Short explanation of what was implemented and why]

**Acceptance Criteria Check**
Criterion 1 → PASS
Criterion 2 → PASS

**Edge Cases / Caveats**
[Anything that may need future attention]

**ZIP Package**
- Path: dist/wpc-plugin.zip
- Structure: wpc-plugin/wpc-plugin.php
- Testing: Install via WP Admin → Plugins → Add New → Upload Plugin

**Suggested Commit Message**
feature: add [description]
```

---

## Step 3 — Manual Validation

**Trigger:** Developer delivers the ZIP package.

Install the plugin in a WordPress test environment and verify each acceptance criterion manually.

**If APPROVED:**
```
APPROVED. Create the local commit.
```
The Developer creates the commit with the suggested message.

**If REJECTED:**
```
REJECTED. [Describe exactly what failed and why]
```
The Developer reads the feedback, fixes the implementation, and delivers a new ZIP. The loop repeats until approved.

---

## Step 4 — Documentation: Summary to Docs

**Trigger:** After the implementation is approved and committed.

**Input:** The Implementation Summary + commit message

**Invoke:**
```
Use the documentation agent to document this implementation:
[paste Implementation Summary]
Commit message: feature: add [description]
```

**Output (only for user-visible changes):**

```
## Feature Documentation

**What changed**
[Clear description of the change from the user's perspective]

**Why it matters**
[User benefit or problem solved]

**How it works**
[Brief technical explanation if relevant]

## Changelog Entry
feature: add [description]

## README / Docs Update (if needed)
[Updated section name and content]
```

**The Documentation Agent does NOT document:**
- Internal refactors or code cleanup
- Tests
- Formatting changes
- Internal bug fixes not visible to users

---

## Step 5 — Product Owner: Final Review

**Trigger:** Documentation Agent delivers docs.

**Input:** Implementation Summary + Documentation

**Invoke:**
```
Use the product-owner agent to review this deliverable against the original acceptance criteria:
[paste Implementation Summary]
[paste Documentation]
```

**Output format:**

```
## Implementation Review

Criterion 1 → PASS
Criterion 2 → PASS

**Decision: APPROVED**

[Optional: notes or follow-up recommendations]
```

If any criterion is FAIL, the PO returns a REJECTED decision with specific feedback. The Developer fixes and resubmits.

---

## Step 6 — git push

Push is always manual and explicit. No agent pushes automatically.

```bash
git log --oneline    # verify the commit looks correct
git push             # push when you're ready
```

---

## Full Example

**Issue:** WPC-94 — Add Hello World notice in WordPress admin

### Step 1 — PO Brief

```
Problem: Validate the AI development pipeline with a minimal plugin artifact.
User Story: As a developer, I want a Hello World plugin that shows a notice in WP admin so that I can confirm the pipeline works end-to-end.
Acceptance Criteria:
1. Plugin activates without PHP errors
2. Shows a "Hello World WP CONNECT" success notice in the WP admin dashboard
3. Makes no database changes
4. Has no external dependencies
Out of Scope: Settings page, custom post types, frontend output.
```

### Step 2 — Developer Output

```
Files Changed: plugins/test-v1.0.0/wpc-hello-world/wpc-hello-world.php
Criteria Check: All 4 criteria PASS
ZIP: dist/wpc-hello-world.zip
Commit: feature: add Hello World WP CONNECT plugin
```

### Step 3 — Validation

Install ZIP via WP Admin → activate → confirm green notice appears → **APPROVED**

### Step 4 — Documentation

```
Changelog Entry: feature: add Hello World WP CONNECT plugin
```

### Step 5 — PO Review

All criteria PASS → **APPROVED**

### Step 6

```bash
git push
```
