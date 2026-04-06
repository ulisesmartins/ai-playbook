---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /ticket-breakdown
audience: Coding
---

# `/ticket-breakdown` — Break a JIRA Epic into Scoped, Agent-Sized Stories

## Purpose

Takes a JIRA epic (or epic description) and breaks it into stories that are correctly scoped for individual engineer sessions. Coding-focused — considers implementation complexity, not just product scope.

## Required Inputs

```
/ticket-breakdown

[Paste JIRA epic description and acceptance criteria, or provide JIRA link]
Core Area: [CoreArea]
Tech area: [Frontend / Backend / Full-stack / Infra]
```

## Expected Output

Stories sized for implementation:
- Each story = one engineering session (≤1 sprint)
- Stories separate: data model changes, API changes, frontend, tests, and migrations
- Each story has entry criteria, exit criteria, and acceptance criteria
- Flag dependencies between stories

## Skill Body (Prompt)

```
Read the following files:
- 01_context/codebase-map/DP-General-index.md
- 01_context/codebase-map/DP-General-key-patterns.md
- 02_templates/cross-functional/DP-General-jira-story-template.md

Here is the JIRA epic to break down:

[USER_INPUT]

Tech area: [USER_INPUT]

Break this into implementation stories from an engineering perspective:
1. Separate frontend and backend work into separate stories
2. Database/schema changes get their own story (with migration plan)
3. API changes get their own story (with contract definition)
4. Tests get their own story or are explicit exit criteria on each story
5. Feature flag setup is the first story (always)

Each story must have:
- Entry criteria: what must exist before this story starts
- Exit criteria: what must be true for Done (include tests)
- Acceptance criteria: binary pass/fail

Sizing: S=1-2 days, M=3-5 days, L=6+ days
Flag any L story for splitting.
```

## Known Limitations

- Cannot determine exact file paths without codebase access — use `01_context/codebase-map/DP-General-index.md` for guidance
- Backend service names must be confirmed by the team — do not assume
- Story points set by Coding during sprint planning — leave blank
