---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /draft-prd
audience: PM
---

# `/draft-prd` — Draft a Structured PRD

## Purpose

Drafts a complete PRD following `02_templates/pm/DP-General-prd-template.md` from a feature brief. Loads Dialpad-specific context automatically before generating.

## Required Inputs

Provide at least one of the following when invoking:

- Feature description (free text) — what you want to build and why
- JIRA epic link — the agent will read the epic for context
- Confluence doc link — the agent will read the doc for context
- Core Area — Support / Connect / Sell / Ecosystem / SharedServices

## How to Use

```
/draft-prd

Feature: [describe the feature in 1–3 sentences]
Core Area: [CoreArea]
Target personas: [list]
JIRA epic: [link or "not yet created"]
```

## Expected Output

A completed PRD in `02_templates/pm/DP-General-prd-template.md` format with all sections filled. The agent will ask clarifying questions before generating if the brief is insufficient.

## Skill Body (Prompt)

```
Read the following files before starting:
- 01_context/company/DP-General-mission-and-strategy.md
- 01_context/product-areas/[CORE_AREA]-context.md
- 01_context/personas-and-icps/DP-General-user-personas.md
- 01_context/personas-and-icps/DP-General-icp.md
- 01_context/company/DP-General-competitive-positioning.md
- 02_templates/pm/DP-General-prd-template.md

You are acting as a Senior PM at Dialpad. Draft a PRD for the following feature:

[USER_INPUT]

Before generating:
1. Ask up to 5 clarifying questions if the brief is ambiguous.
2. Confirm the target personas and what is explicitly out of scope.

When generating:
- Fill every section. Write "N/A — [reason]" if a section truly does not apply.
- Do not use "TBD" without a resolution date.
- Write acceptance criteria as binary pass/fail statements.
- Do not invent feature flag names, API endpoints, or JIRA ticket numbers.
- Validate all Dialpad product claims against the loaded context files.
```

## Known Limitations

- Does not access JIRA or Confluence directly without MCP configured
- Cannot determine feature flag names — leave blank for Engineering
- May generate overly broad scope if brief is vague — always ask clarifying questions
- Competitive claims must be validated against `DP-General-competitive-positioning.md`
