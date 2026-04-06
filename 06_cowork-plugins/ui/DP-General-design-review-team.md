---
version: 1.0
last_updated: 2026-03-13
change_summary: "Initial version"
status: GA
audience: UI, PM
---

# UI Review Team — Multi-Role UI Critique Before Gate 2

## Purpose

Runs a structured multi-role design critique from three perspectives: visual & brand quality,
Dialtone design system compliance, and product/UX clarity. Output is a consolidated readiness
report with severity-ranked gaps by role.

---

## Roles

| Role | Perspective | Focus |
|---|---|---|
| Visual Reviewer | Brand & polish | Hierarchy, spacing, typography, color usage, motion |
| Dialtone Reviewer | UI system compliance | Token usage, component variants, pattern consistency |
| UX Reviewer | Product clarity | JTBD alignment, empty/error/loading states, edge cases, handoff completeness |

---

## Input Required

```
Gate target: [Gate 2 / Gate 3]
Core Area: [CORE_AREA]
Feature name: [FEATURE_NAME]
[FIGMA URL or design description / screen paste]
```

---

## Kickoff Prompt

```
Read the following files:
- 01_context/pdlc/DP-General-phases-and-gates.md
- 01_context/pdlc/DP-General-design-gate-checklist.md
- 01_context/design-system/DP-General-tokens.md
- 01_context/design-system/DP-General-component-library.md
- 01_context/personas-and-icps/DP-General-user-personas.md

You are running a multi-role design review for Gate [GATE_TARGET].

Feature: [FEATURE_NAME]
Core Area: [CORE_AREA]
UI input: [FIGMA_URL_OR_DESCRIPTION]

Run three parallel reviews. Each review is independent — do not reference the other reviews
while writing. After all three reviews are complete, produce a consolidated report.

---

ROLE 1: VISUAL REVIEWER
Review the design from a visual quality and brand perspective:
1. Is the visual hierarchy clear? Does the primary action stand out?
2. Is spacing consistent with the 4px/8px grid?
3. Are font sizes and weights from the Dialtone type scale?
4. Is color usage limited to Dialtone tokens (no hardcoded hex)?
5. Does motion/transition (if any) follow Dialtone motion principles?

Output format:
- Status: Ready / Not Ready / Blocked
- Passed items (brief evidence)
- Gaps (specific, with recommended fix)
- Blockers (will definitely cause gate failure)

---

ROLE 2: DIALTONE REVIEWER
Review the design from a design system compliance perspective:
1. Are all colors Dialtone tokens (--dt-color-*)?
2. Are spacing values on the 4/8px grid (--dt-space-*)?
3. Are components using the correct Dialtone variant (not custom one-offs)?
4. Are interactive states (hover, focus, disabled, loading) covered?
5. Are any new patterns proposed? If so, is there a justification for not using existing ones?

Output format: same as Visual Reviewer

---

ROLE 3: UX REVIEWER
Review the design from a product clarity and handoff perspective:
1. Is the JTBD (job to be done) solved by this design clearly visible in the flow?
2. Are empty, error, and loading states designed (not just the happy path)?
3. Are edge cases covered (long text, zero data, permission errors)?
4. Is the persona from the PRD reflected in the design decisions?
5. Is the design handoff-complete (no "TBD" screens, no placeholder content)?

Output format: same as Visual Reviewer

---

CONSOLIDATED REPORT:
After all three reviews, produce:
1. Overall status: Ready / Not Ready / Blocked
2. Role-by-role gap summary (table: Gap | Role | Severity | Recommended fix)
3. Top 3 blockers (if any) that must be resolved before Gate [GATE_TARGET]
4. Recommended next steps for Designer
```

---

## Handoff Format

The output of this session is a design readiness report. Designer takes the report and:
1. Resolves blocker gaps before scheduling the gate review
2. Updates the design file with fixes and links the report in the Figma file description
3. Shares the consolidated report with PM and Coding leads

---

## Exit Condition

Session is complete when all three role reviews are done AND the consolidated report is produced.
The exit condition is NOT "no gaps" — the goal is a complete, prioritised gap list.

---

## Known Limitations

- Cannot directly inspect a Figma file — review is based on the design description or screenshot provided
- Cannot verify live Dialtone token values — use the Dialtone MCP for current token lookups
- Consolidated report reflects agent interpretation — the design team lead should validate severity ratings
