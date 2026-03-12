# Workflow Guide

Step-by-step guide for running a complete development cycle through the Agent WPC pipeline.

---

## Step 1 — Product Owner reads the Linear issue

Invoke the **Product Owner agent** and provide the Linear issue.

The agent will:
- Extract the problem, context, and expected outcome
- Ask clarifying questions if the issue is unclear
- Optionally improve the issue description in Linear

---

## Step 2 — Product Owner writes the Implementation Brief

The Product Owner produces a structured brief:

```
## Implementation Brief

Problem Statement
User Story
Scope
Acceptance Criteria
Out of Scope
Risks / Edge Cases
```

---

## Step 3 — Developer implements

Invoke the **Developer agent** and provide the Implementation Brief.

The Developer will:
- Explore the relevant repository files
- Implement the minimum required change
- Perform a self-review
- Return an Implementation Summary

```
## Implementation Summary

Files Changed
Changes Made
Acceptance Criteria Check (PASS / FAIL per criterion)
Edge Cases / Caveats
Suggested Commit Message
```

---

## Step 4 — Product Owner reviews

The Product Owner reviews the Implementation Summary:

- Checks each acceptance criterion: **PASS** or **FAIL**
- Issues a final decision: **APPROVED** or **REJECTED**

If rejected, the Developer receives targeted feedback and re-implements.

---

## Step 5 — Documentation agent documents

When the implementation is approved, the Product Owner sends a **Documentation Request** to the **Documentation agent**.

The Documentation agent will:
- Determine if the change has user-visible impact
- Produce a Feature Documentation section
- Add a Changelog entry to `CHANGELOG.md`
- Update `README.md` or `docs/` if usage or configuration changed

---

## Step 6 — Commit and push

The Developer commits all changes using the conventional commit format and pushes to the repository.

---

## When to skip steps

| Situation | Skip |
|---|---|
| Internal refactor or test | Steps 5 (no documentation needed) |
| Hotfix with no user impact | Steps 1–2 (brief may be informal) |
| Sandbox experiment | Steps 4–6 optional |
