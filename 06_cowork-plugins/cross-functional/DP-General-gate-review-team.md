---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
audience: PM, UI, Coding
---

# Gate Review Team — Full EPD Trio Gate Review Simulation

## Purpose

Simulates the full Gate 1 (Design Review) or Gate 2 (EAP Approval) EPD review from three
perspectives simultaneously. Produces the most comprehensive readiness report available
before submitting to the actual EPD Staff gate review. If the Cowork session says "Not Ready",
do not schedule the human gate review.

---

## Roles

| Role | Represents | Focus |
|---|---|---|
| EPD Staff PM | Product leadership | Strategic fit, scope clarity, success metrics, open questions |
| EPD Staff Design | Design leadership | UX quality, Dialtone compliance, research evidence, accessibility |
| EPD Staff Engineering | Engineering leadership | Technical feasibility, implementation risk, dependency clarity |

---

## Input Required

```
Gate: [Gate 1 / Gate 2]
Feature: [FEATURE_NAME]
Core Area: [CORE_AREA]
Release tier: [T1 / T2 / T3]
[FULL PRD TEXT]
[List of completed artifacts: Design Studio link, prototype link, research summary, etc.]
```

---

## Kickoff Prompt

```
Read the following files:
- 01_context/pdlc/DP-General-phases-and-gates.md
- 01_context/pdlc/DP-General-design-gate-checklist.md
- 01_context/personas-and-icps/DP-General-user-personas.md
- 01_context/codebase-map/DP-General-index.md

You are simulating a [GATE_TARGET] EPD Staff review for:
Feature: [FEATURE_NAME]
Core Area: [CORE_AREA]
Release tier: [RELEASE_TIER]

Here is the PRD and completed artifacts:
[PRD_AND_ARTIFACTS]

Each reviewer plays the role of an EPD Staff member at the actual gate review.
Be direct — EPD Staff will send you back if gaps are found. The goal is to find every
gap before the real meeting, not to make the team feel good about their work.

---

ROLE 1: EPD STAFF PM REVIEWER
Review as EPD Staff PM:
1. Does this feature have clear strategic fit with Dialpad's FY27 priorities?
2. Is the scope small enough for the target release tier (T1/T2/T3)?
3. Are success metrics defined with a measurable target and a baseline?
4. Are open questions documented, or are assumptions hidden as facts?
5. Is the ICP specific? "All customers" is not an ICP.
6. Is the feature tier/plan packaging decided?
7. Would I approve this to move forward, or send it back?

Output:
- Decision: Approve / Conditional (fix X before proceeding) / Send back
- Gaps with specific required fix
- Questions I would ask in the room

---

ROLE 2: EPD STAFF DESIGN REVIEWER
Review as EPD Staff Design:
1. Is there a primary persona with enough specificity to design for?
2. Is the JTBD (job to be done) clear?
3. For Gate 1: Are Design Studio screens present? Do they use Dialtone DT9?
4. For Gate 2: Are all states designed (happy, empty, loading, error)?
5. Is there evidence of user research or usability testing?
6. Are accessibility requirements stated?
7. Would I approve this design to move forward?

Output: same format as Role 1

---

ROLE 3: EPD STAFF ENGINEERING REVIEWER
Review as EPD Staff Engineering:
1. Is technical scope clear enough to estimate?
2. Are dependencies identified with owning teams and timelines?
3. Is the feature flag strategy defined?
4. Are there known technical risks or constraints stated in the PRD?
5. For Gate 2: Has Engineering committed to the EAP scope?
6. Is the rollback plan defined?
7. Would I approve this to move to [next phase]?

Output: same format as Role 1

---

CONSOLIDATED GATE REVIEW SIMULATION:
1. Overall verdict: Approve / Conditional / Send back
   - If Conditional: exact list of items to fix before scheduling the real review
   - If Send back: the specific reason EPD Staff would reject it

2. Blocker table:
   | Blocker | Role | Impact if unresolved | Fix required |
   |---|---|---|---|

3. Gate questions the team should be prepared to answer (the top 5 hardest questions)

4. Confidence score (per role): High / Medium / Low that this passes the real gate
```

---

## Handoff Format

1. Gate readiness report → PM reviews → shares with Engineering lead and Design lead
2. Blocker table → PM creates JIRA tasks for each blocker
3. Gate questions → PM uses to prep the gate review presentation
4. If "Approve": PM schedules the real gate review

---

## Exit Condition

Session is complete when all three roles produce verdicts AND the consolidated report is generated.
If verdict is "Send back" or any role verdict is "Send back": do not schedule the human gate review.

---

## Known Limitations

- Cannot verify Design Studio designs without Design Studio MCP — assess based on PRD description of design state
- Cannot verify API availability or infrastructure capacity — Engineering role flags these as risks
- This simulation reflects the AI's interpretation of gate criteria — human EPD Staff may weigh factors differently
- A passing score in this simulation does not guarantee passing the real gate review
