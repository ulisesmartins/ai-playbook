---
version: 1.1
last_updated: 2026-03-12
change_summary: "Updated agent and template paths to reflect role-based subfolder reorganization"
status: GA
audience: PM, Coding
---

# Task Breakdown Agent

## Purpose

Transforms a PRD into scoped, agent-executable subtasks with explicit entry and exit criteria. Output is the primary handoff format to Engineering and the JIRA Sync agent.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Approved PRD | ✅ | Markdown file from PRD Generator agent |
| Core Area | ✅ | One of: Support, Connect, Sell, Ecosystem, SharedServices |
| Engineering context | Optional | Codebase area, known constraints, tech stack notes |

---

## Outputs

A structured task breakdown document containing:
- 1 JIRA epic outline (summary, outcome, acceptance criteria)
- N stories (typically 3–10), each following `02_templates/cross-functional/DP-General-jira-story-template.md`
- Sequencing map: which stories depend on which
- Effort sizing guidance (S / M / L per story)

---

## Orchestration Steps

1. **Load context** — Load the PRD, `01_context/codebase-map/DP-General-index.md`, `01_context/codebase-map/DP-General-key-patterns.md`, and `02_templates/cross-functional/DP-General-jira-story-template.md`

2. **Parse PRD** — Extract:
   - Acceptance criteria (these become story-level ACs)
   - Scope (in/out) — out-of-scope items become explicit deferred stories
   - Personas — each story must be framed from the relevant persona's perspective
   - Technical notes and dependencies

3. **Identify story boundaries** — Break work into stories where each story:
   - Is completable by one engineer in ≤1 sprint (3–5 days)
   - Has a single, clear outcome
   - Can be tested independently
   - Does not overlap with another story

4. **Write stories** — For each story, complete all fields in `02_templates/cross-functional/DP-General-jira-story-template.md`. Pay special attention to:
   - Entry criteria: list ALL prerequisite stories
   - Exit criteria: be specific — "unit tests pass" not "feature is tested"
   - Acceptance criteria: binary pass/fail only

5. **Sequence stories** — Produce a dependency map showing which stories can run in parallel vs. sequentially

6. **Validate** — Run quality check:
   - No story requires more than ≤1 sprint of work
   - All ACs are binary pass/fail
   - Feature flag fields are present but not filled (for Engineering)
   - No invented API names, endpoints, or flag names

7. **Hand off** — "Task breakdown complete. Pass this to the JIRA Sync agent (`04_agents/cross-functional/DP-General-jira-sync/`) to create JIRA tickets, or provide this document to Engineering directly."

---

## Story Sizing Guide

| Size | Estimate | Characteristics |
|---|---|---|
| S | 1–2 days | Single component, clear spec, no dependencies |
| M | 3–5 days | Multiple components or API work, 1–2 dependencies |
| L | 6–10 days | Complex feature, multiple dependencies — consider splitting |
| XL | >10 days | Must split. No XL stories should reach Engineering |

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
Read 01_context/codebase-map/DP-General-index.md,
01_context/codebase-map/DP-General-key-patterns.md,
and 02_templates/cross-functional/DP-General-jira-story-template.md.

Here is the approved PRD for [feature name]:
[paste PRD content]

Break this into agent-executable JIRA stories.
Each story must have explicit entry and exit criteria.
Flag any story that seems larger than 1 sprint and suggest how to split it.
```

**Recommended model:** Claude Sonnet 4.6 — needs judgment about story boundaries and engineering scope.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Stories too large | Acceptance criteria too broad | Split each AC into its own story |
| Missing entry criteria | Dependencies not traced | Always ask: "What must exist for this to start?" |
| Invented feature flags | Engineering context not loaded | Leave flag field blank; note "To be confirmed by Engineering" |
| Vague exit criteria | ACs not specific enough | Rewrite until each AC has a specific, measurable pass condition |
| Out-of-scope items included | PRD scope not checked | Always check PRD "Out of scope" section before generating stories |

---

## Handoff Format

```markdown
---
source: Task Breakdown Agent
date: [YYYY-MM-DD]
prd_source: [filename]
core_area: [CoreArea]
story_count: [N]
next_step: JIRA Sync (04_agents/cross-functional/DP-General-jira-sync/) or direct to Engineering
---
```

Include: epic outline, all stories (fully filled), sequencing map, and sizing estimates.
