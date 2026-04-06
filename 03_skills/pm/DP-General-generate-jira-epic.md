---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /generate-jira-epic
audience: PM
---

# `/generate-jira-epic` — Convert PRD into a JIRA Epic with Stories

## Purpose

Converts an approved PRD into a structured JIRA epic with subtask stories, following `02_templates/cross-functional/DP-General-jira-epic-template.md` and `02_templates/cross-functional/DP-General-jira-story-template.md`.

## Required Inputs

```
/generate-jira-epic

[Paste PRD content or provide the PRD file path]
JIRA project key: [e.g., DP]
Core Area: [CoreArea]
```

## Expected Output

1. JIRA epic definition (title, description, epic-level ACs)
2. N stories with full fields: summary, user story, entry criteria, exit criteria, acceptance criteria, dependencies
3. Sequencing map showing which stories depend on which

If JIRA MCP is configured, the agent can create the tickets directly. Otherwise, output is formatted for manual copy-paste into JIRA.

## Skill Body (Prompt)

```
Read the following files before starting:
- 01_context/codebase-map/DP-General-index.md
- 01_context/codebase-map/DP-General-key-patterns.md
- 02_templates/cross-functional/DP-General-jira-epic-template.md
- 02_templates/cross-functional/DP-General-jira-story-template.md

Here is the PRD to convert into JIRA tickets:

[USER_INPUT — PRD content]

Generate:
1. One JIRA epic following the epic template format.
2. All necessary stories following the story template format.

Rules:
- Each story must be completable by one engineer in ≤1 sprint.
- Each story must have explicit entry criteria AND exit criteria.
- All acceptance criteria must be binary pass/fail.
- Do not fill in the feature flag field — leave it blank for Engineering.
- Do not invent API endpoint names or service names.
- Produce a dependency/sequencing map after the stories.
```

## Known Limitations

- Requires JIRA MCP to create tickets directly (see `09_mcps/guides/DP-General-atlassian-setup.md`)
- Story pointing is done by Engineering during sprint planning — leave blank
- Feature flag names must come from Engineering — never generate them
