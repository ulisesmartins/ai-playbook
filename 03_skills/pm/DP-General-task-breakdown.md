---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /task-breakdown
audience: PM
---

# `/task-breakdown` — Transform PRD into Agent-Executable Subtasks

## Purpose

Converts a PRD or epic into scoped, agent-executable subtasks with explicit entry and exit criteria. The output is the primary handoff format from PM to Engineering.

## Required Inputs

```
/task-breakdown

[Paste PRD content or JIRA epic link]
Core Area: [CoreArea]
```

## Expected Output

1. JIRA epic outline (title, description, epic-level acceptance criteria)
2. All stories with: summary, user story, entry criteria, exit criteria, acceptance criteria, sizing (S/M/L)
3. Dependency/sequencing map
4. Effort summary: total stories, estimated sprints

## Skill Body (Prompt)

```
Read the following files:
- 01_context/codebase-map/DP-General-index.md
- 01_context/codebase-map/DP-General-key-patterns.md
- 02_templates/cross-functional/DP-General-jira-story-template.md
- 01_context/personas-and-icps/DP-General-user-personas.md

Here is the PRD/epic to break down:

[USER_INPUT]

Break this into agent-executable stories following these rules:
1. Each story = one engineering session (≤1 sprint, ≤5 days)
2. Each story has explicit ENTRY criteria (what must be true before it starts)
3. Each story has explicit EXIT criteria (what must be true for it to be Done)
4. All acceptance criteria are binary pass/fail — no "works correctly"
5. Features flagged stories with a placeholder: Feature flag: [TBD by Engineering]
6. Do NOT invent API names, flag names, or endpoint paths
7. Items from the PRD "Out of scope" section become deferred stories labeled [DEFERRED]

After the stories, produce:
- A sequencing map (which stories block which)
- Effort sizing: S=1-2 days, M=3-5 days, L=6+ days (flag L stories for splitting)
```

## Known Limitations

- Cannot determine feature flag names — always leave as TBD for Engineering
- Story effort sizing is a guide, not a commitment — Engineering confirms during sprint planning
- Does not create JIRA tickets directly — use `/generate-jira-epic` or the JIRA Sync agent for that
