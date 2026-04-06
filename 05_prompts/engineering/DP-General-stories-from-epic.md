---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
category: jira-generation
audience: Coding, PM
---

# Stories from Epic — Break a JIRA Epic into Agent-Executable Stories

## Purpose

Breaks a JIRA epic into correctly scoped engineering stories. Each story is sized for a single
engineer session (≤1 sprint), has binary acceptance criteria, and is structured so an AI coding
agent can execute it without ambiguity. Engineering-focused decomposition — considers
implementation complexity, not just product scope.

---

## Context to Load Before Running

- `01_context/codebase-map/DP-General-index.md`
- `01_context/codebase-map/DP-General-key-patterns.md`
- `02_templates/cross-functional/DP-General-jira-story-template.md`
- The JIRA epic description

---

## Prompt Body

```
You are a Staff Engineer at Dialpad breaking an epic into implementation stories.

Here is the JIRA epic:
[EPIC_CONTENT]

Tech area: [Frontend / Backend / Full-stack / Infra]
Core Area: [CORE_AREA]
Feature flag: [FLAG_NAME or "not used"]

Break this epic into stories from an implementation perspective:

DECOMPOSITION RULES:
1. Feature flag setup is always Story 1 — no other story starts before this is merged
2. Database/schema changes get their own story (include migration plan)
3. API contract changes get their own story (include request/response schema)
4. Frontend and backend are separate stories — no mixed-layer stories
5. Tests are explicit exit criteria on each story OR get their own story if complex
6. Migrations and data backfills get their own story if they touch prod data

FOR EACH STORY, use the template in `02_templates/cross-functional/DP-General-jira-story-template.md`:

Title format: "[Verb] [what] for [feature name]"
Example: "Add CSAT score field to agent_performance_summary table"

Required fields per story:
- User story: As a [persona], I want [action] so that [outcome]
- Scope (in): Exactly what this story covers
- Scope (out): What is explicitly NOT in this story
- Entry criteria: What must exist/be merged before this story can start
- Acceptance criteria: 3–5 binary Given/When/Then ACs
- Exit criteria: What must be true for Done (include test coverage)
- Technical notes: Affected files/services from DP-General-index.md, feature flag behavior
- Dependencies: Blocking stories or external teams

SIZING:
- S = 1–2 days | M = 3–5 days | L = 6–10 days | XL = needs splitting
- Flag any L story for Engineering to split before sprint planning

OUTPUT:
- Story sequence table (order of execution, with dependencies noted)
- Full story descriptions for each story
- Risk flags: any story where scope is unclear or a dependency is unresolved
```

---

## Variables

| Variable | Description | Example |
|---|---|---|
| `[EPIC_CONTENT]` | Full JIRA epic description | Paste epic text |
| `[TECH_AREA]` | Frontend / Backend / Full-stack / Infra | `Full-stack` |
| `[CORE_AREA]` | Support / Connect / Sell / Ecosystem / SharedServices | `Sell` |
| `[FLAG_NAME]` | Feature flag gating the work | `dp_power_dialer_auto_advance` |

---

## Usage Example

```
Tech area: Full-stack
Core Area: Sell
Feature flag: dp_power_dialer_auto_advance

Epic: Power Dialer Auto-Advance
Outcome: The dialer auto-advances to the next contact when a call ends,
reducing dead time between calls by 40%.
ACs: [paste epic ACs]
```

---

## Expected Output

1. Story sequence table (story number, title, size, blocking dependencies)
2. Full story descriptions (all fields from the template)
3. Risk log (stories with unresolved scope, unclear ownership, or external dependencies)

---

## Known Limitations

- Cannot determine exact file paths — use `DP-General-index.md` as a guide; Engineering confirms
- Story points are not set — Engineering owns sizing during sprint planning
- Backend service names must be confirmed by the owning team before sprint start
- Cannot create JIRA tickets directly — requires JIRA MCP (see `09_mcps/`)
