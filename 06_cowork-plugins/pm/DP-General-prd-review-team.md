---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
audience: PM, UI, Coding
---

# PRD Review Team — Multi-Role PRD Critique Before Gate 1

## Purpose

Runs a structured multi-role PRD critique from three perspectives: PM quality (scope, ACs, metrics),
Design readiness (persona clarity, UX requirements), and Engineering feasibility (technical scope,
ambiguity, dependencies). Output is a consolidated readiness report with gaps by role.

---

## Roles

| Role | Perspective | Focus |
|---|---|---|
| PM Reviewer | Product quality | Scope clarity, ACs completeness, success metrics, open questions |
| Design Reviewer | UX readiness | Persona specificity, JTBD clarity, design constraints, handoff completeness |
| Engineering Reviewer | Technical feasibility | Ambiguity in scope, missing API contracts, dependency clarity, edge cases |

---

## Input Required

```
Gate target: [Gate 1 / Gate 2]
Core Area: [CORE_AREA]
[FULL PRD TEXT]
```

---

## Kickoff Prompt

```
Read the following files:
- 01_context/pdlc/DP-General-phases-and-gates.md
- 01_context/pdlc/DP-General-design-gate-checklist.md
- 01_context/personas-and-icps/DP-General-user-personas.md
- 01_context/codebase-map/DP-General-index.md

You are running a multi-role PRD review for Gate [GATE_TARGET].

Here is the PRD:
[PRD_CONTENT]

Core Area: [CORE_AREA]

Run three parallel reviews. Each review is independent — do not reference the other reviews
while writing. After all three reviews are complete, produce a consolidated report.

---

ROLE 1: PM REVIEWER
Review the PRD from a product management perspective:
1. Is the scope clearly bounded? Would two PMs interpret it the same way?
2. Are acceptance criteria binary (pass/fail)? Could QA execute them without interpretation?
3. Is the primary metric measurable? Is there a baseline?
4. Are open questions documented (not swept under the rug)?
5. Is the ICP/persona specific? Or does it say "all users"?

Output format:
- Status: Ready / Not Ready / Blocked
- Passed items (brief evidence)
- Gaps (specific, with recommended fix)
- Blockers (will definitely cause gate failure)

---

ROLE 2: DESIGN REVIEWER
Review the PRD from a design readiness perspective:
1. Is the primary persona named and specific enough to design for?
2. Is the JTBD (job to be done) clear enough to make design decisions?
3. Are there design constraints or non-negotiables stated?
4. Is the success state (what "good" looks like) described?
5. Are empty, error, and loading states mentioned in scope?

Output format: same as PM Reviewer

---

ROLE 3: ENGINEERING REVIEWER
Review the PRD from an engineering feasibility perspective:
1. Is there ambiguity in scope that would cause sprint planning confusion?
2. Are API contracts or data models implied but not specified?
3. Are dependencies identified with owning teams?
4. Are feature flag requirements stated?
5. Are there edge cases in the ACs that Engineering will ask about?

Output format: same as PM Reviewer

---

CONSOLIDATED REPORT:
After all three reviews, produce:
1. Overall status: Ready / Not Ready / Blocked
2. Role-by-role gap summary (table: Gap | Role | Severity | Recommended fix)
3. Top 3 blockers (if any) that must be resolved before Gate [GATE_TARGET]
4. Recommended next steps for PM
```

---

## Handoff Format

The output of this session is a readiness report. PM takes the report and:
1. Fixes blocker gaps before scheduling the gate review
2. Adds design constraints to the design brief (`/design-brief`)
3. Adds engineering gaps to the pre-sprint planning notes

---

## Exit Condition

Session is complete when all three role reviews are done AND the consolidated report is produced.
The exit condition is NOT "no more gaps" — the goal is a complete gap list, not a perfect PRD.

---

## Known Limitations

- Cannot verify Design Studio designs — review is based on PRD text only
- Cannot verify API availability or service ownership — Engineering must confirm
- Consolidated report reflects the agent's interpretation — human reviewers may catch additional gaps
