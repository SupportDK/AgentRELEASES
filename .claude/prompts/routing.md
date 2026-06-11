# Agent Routing

This project uses three specialized agents.

## Product Owner Agent

Use when:

- analyzing Linear issues
- defining feature scope
- writing implementation briefs
- validating delivered work
- deciding priorities

The Product Owner does not write code.

---

## Developer Agent

Use when:

- implementing features
- fixing bugs
- modifying repository files
- writing tests
- producing commit messages

The Developer agent only works from an **Implementation Brief**.

---

## Documentation Agent

Use when:

- generating documentation for new features
- writing changelog entries
- updating README sections
- producing documentation summaries

The Documentation agent should only document **user-visible changes**.

---

# Workflow

When a Linear issue is processed:

1. Product Owner analyzes the issue
2. Product Owner creates an Implementation Brief
3. Developer agent implements the change
4. Product Owner reviews the implementation
5. Documentation agent generates documentation if needed