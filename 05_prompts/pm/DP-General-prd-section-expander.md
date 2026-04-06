---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
category: prd-drafting
audience: PM
---

# PRD Section Expander — Deepen a Specific PRD Section

## Purpose

Takes a weak, thin, or placeholder section of an existing PRD and expands it to Gate 1 quality.
Use this when a full PRD exists but one or more sections are flagged as incomplete by the gate
review process or by a reviewer.

---

## Context to Load Before Running

- `01_context/pdlc/DP-General-phases-and-gates.md` — Gate 1 checklist
- `01_context/personas-and-icps/DP-General-user-personas.md`
- `01_context/personas-and-icps/DP-General-icp.md`
- `01_context/product-areas/[CORE_AREA]-context.md`
- The existing PRD (paste or provide file path)

---

## Prompt Body

```
You are a Senior PM at Dialpad. I have a PRD that needs one or more sections expanded.

Here is the full PRD:
[FULL_PRD_CONTENT]

Section to expand: [SECTION_NAME]

Reviewer feedback (if any): [FEEDBACK or "none"]

Core Area: [CORE_AREA]

Expand the [SECTION_NAME] section so it meets Gate 1 quality:

For Acceptance Criteria:
- Rewrite each AC in Given/When/Then format
- Every AC must be binary (pass or fail), not subjective
- Add edge cases: error states, empty states, permission boundaries

For Success Metrics:
- Define a single primary metric with a measurable target
- Add ≤3 secondary metrics with baselines (state if baseline is unknown)
- Add guardrail metrics: what must NOT regress

For ICP & Personas:
- Name specific personas from DP-General-user-personas.md
- State explicitly who is out of scope
- Map each persona to the pain point they experience today

For Competitive Context:
- Structure as a table: Competitor | How they handle it today | Our differentiation
- State only verifiable facts — flag any claim you cannot verify

For Dependencies:
- List team name, what is needed, and whether it is blocking or non-blocking
- Flag any dependency on infra, data pipeline, or external API

Return ONLY the expanded section — do not rewrite the entire PRD.
```

---

## Variables

| Variable | Description |
|---|---|
| `[FULL_PRD_CONTENT]` | Paste the current PRD text |
| `[SECTION_NAME]` | E.g., "Acceptance Criteria", "Success Metrics", "Competitive Context" |
| `[FEEDBACK]` | Reviewer's comment about why the section was flagged |
| `[CORE_AREA]` | Support / Connect / Sell / Ecosystem / SharedServices |

---

## Usage Example

```
Section to expand: Acceptance Criteria
Reviewer feedback: "These ACs are too vague — 'works correctly' is not testable"
Core Area: Connect

[Paste PRD]
```

---

## Expected Output

The expanded section only, formatted as Markdown, ready to paste back into the PRD. Includes
a brief note on any information the PM must supply to complete the expansion.

---

## Known Limitations

- Cannot fabricate baseline metrics — if no baseline exists, it will state "baseline unknown"
- Competitor table accuracy must be verified by PMM before Gate 1
- Cannot access Design Studio or JIRA to cross-reference designs or existing stories
