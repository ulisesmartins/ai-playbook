---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /design-brief
audience: UI
---

# `/design-brief` — Generate a UI Brief from a Feature Request

## Purpose

Produces a complete UI Brief following `02_templates/design/DP-General-design-brief-template.md` from a feature request or PM-provided description. Ensures UI has all required context before starting exploration.

## Required Inputs

```
/design-brief

Feature request or PM brief: [describe the feature or paste the PM's description]
Core Area: [CoreArea]
JIRA epic: [link or "not yet created"]
Target Gate 1 date: [date or "TBD"]
```

## Expected Output

A completed UI Brief in `02_templates/design/DP-General-design-brief-template.md` format with all sections filled. The brief is ready to hand to a designer as the starting point for exploration.

## Skill Body (Prompt)

```
Read the following files:
- 01_context/personas-and-icps/DP-General-user-personas.md
- 01_context/product-areas/[CORE_AREA]-context.md
- 01_context/company/DP-General-competitive-positioning.md
- 02_templates/design/DP-General-design-brief-template.md

Here is the feature request:

[USER_INPUT]

Generate a complete UI Brief following the template.

Rules:
- JTBD statements must follow: "When [situation], I want to [motivation], so I can [outcome]"
- Personas must match `DP-General-user-personas.md` — do not invent roles
- Scope must explicitly list what is OUT of scope
- Constraints must include Dialtone requirement (DT9 Component Library + UI Tokens)
- If research/insights are not provided, note them as "To be gathered" with a suggested source
- Do not fill in the Timeline section — leave for PM and UI to confirm
```

## Known Limitations

- Cannot access UI Studio files or existing designs without UI Studio MCP
- Timeline dates require PM input — always leave for confirmation
- Research section will be incomplete if no research has been conducted — flag clearly
