---
version: 1.1
last_updated: 2026-03-12
change_summary: "Updated agent and template paths to reflect role-based subfolder reorganization"
status: GA
audience: PM
---

# PRD Generator Agent

## Purpose

Takes a feature brief (verbal description, Confluence doc, or JIRA epic) and produces a structured, agent-ready PRD following the `02_templates/pm/DP-General-prd-template.md` format.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Feature brief | ✅ | Free text, Confluence URL, or JIRA epic link |
| Core Area | ✅ | One of: Support, Connect, Sell, Ecosystem, SharedServices |
| Target personas | ✅ | From `01_context/personas-and-icps/DP-General-user-personas.md` |
| JIRA epic link | Optional | For referencing existing requirements |
| Design Studio link | Optional | If design exploration has started |

---

## Outputs

A completed PRD in `02_templates/pm/DP-General-prd-template.md` format, saved as:
`[CoreArea]-[feature-name]-prd.md`

The PRD is **agent-ready**: structured so the Task Breakdown agent (`04_agents/pm/DP-General-task-breakdown/`) can consume it directly in the next session.

---

## Orchestration Steps

1. **Load context** — Load `01_context/company/DP-General-mission-and-strategy.md`, the relevant `01_context/product-areas/[CoreArea]-context.md`, `01_context/personas-and-icps/DP-General-user-personas.md`, and `01_context/personas-and-icps/DP-General-icp.md`

2. **Load template** — Load `02_templates/pm/DP-General-prd-template.md`

3. **Clarify before generating** — Ask the user:
   - What is the core user problem this feature solves?
   - Which personas are in scope?
   - What is explicitly out of scope?
   - Are there known business drivers or FY27 priorities this connects to?
   - Are there existing JIRA tickets, Design Studio frames, or Confluence docs to reference?

4. **Generate PRD draft** — Fill all sections of the template. Write "N/A — [reason]" if a section does not apply. Do not use "TBD" without a target resolution date.

5. **Validate output** — Run the agent's own quality check:
   - All acceptance criteria are binary pass/fail
   - No invented feature flags, API names, or JIRA references
   - Personas linked to `01_context/personas-and-icps/DP-General-user-personas.md`
   - Success metrics have baselines and measurement methods

6. **Hand off** — Present the completed PRD and instruct the user: "This PRD is ready to pass to the Task Breakdown agent. Start a new session with `04_agents/pm/DP-General-task-breakdown/CLAUDE.md` and provide this PRD as input."

---

## Best Prompt/Agent Combination

**Best opening prompt (copy-paste into new session):**

```
Read 01_context/company/DP-General-mission-and-strategy.md,
01_context/product-areas/[CoreArea]-context.md,
01_context/personas-and-icps/DP-General-user-personas.md,
and 02_templates/pm/DP-General-prd-template.md.

I need a PRD for: [brief feature description]
Core Area: [CoreArea]
Key personas: [list]

Ask me clarifying questions before drafting.
```

**Recommended model:** Claude Sonnet 4.6 or higher — requires nuanced judgment on scope and business context.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Invented product details | Context files not loaded | Always load `[CoreArea]-context.md` before generating |
| Vague acceptance criteria | Brief too high-level | Ask clarifying questions in Step 3 before generating |
| Missing success metrics | PM hasn't defined them | Flag as open question; do not invent metrics |
| Over-scoped PRD | Too many features in one brief | Scope to one discrete feature per PRD; split if needed |
| Stale competitive data | Using general knowledge | Only assert competitors from `DP-General-competitive-positioning.md` |

---

## Handoff Format

Output the PRD as a markdown file with the header:

```markdown
---
source: PRD Generator Agent
date: [YYYY-MM-DD]
core_area: [CoreArea]
next_step: Task Breakdown (04_agents/pm/DP-General-task-breakdown/)
---
```

Pass this file as-is to the Task Breakdown agent. Do not summarize or truncate.
