---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /gate-review-checklist
audience: PM, UI, Coding
---

# `/gate-review-checklist` — Validate EPD Trio Readiness for Design or Build Gate

## Purpose

Runs through the Gate 1 (Design Gate) or Gate 2 (Build Gate) checklist and produces a readiness report. Identifies gaps that must be resolved before scheduling the gate review. Eliminates common gate failures by surfacing issues early.

## Required Inputs

```
/gate-review-checklist

Gate: [Gate 1 / Gate 2]
Feature: [name or description]
[Paste or describe what has been completed so far]
Design Studio link: [if available]
PRD link: [if available]
```

## Expected Output

A readiness report:
- **Status:** Ready / Not Ready / Blocked
- **Completed items:** What is done and passes the checklist
- **Gaps:** What is missing or needs work (with specific fix guidance)
- **Blockers:** Items that will definitely cause EPD Staff to send you back

## Skill Body (Prompt)

```
Read the following files:
- 01_context/pdlc/DP-General-design-gate-checklist.md
- 01_context/pdlc/DP-General-phases-and-gates.md
- 01_context/personas-and-icps/DP-General-user-personas.md

Gate target: [USER_INPUT]
Feature: [USER_INPUT]

What has been completed so far:
[USER_INPUT]

Run through every item in the gate checklist:
1. For each item: Is it complete? Evidence?
2. If incomplete: What specifically is needed to complete it?
3. Flag any item that EPD Staff will definitely call out as a blocker.

Produce a readiness report:
- Status: Ready / Not Ready / Blocked
- Completed items (with brief evidence)
- Gaps (with specific fix guidance and owner)
- Blockers (items that WILL cause the review to fail)

Be direct — do not soften gaps. The goal is to fix issues before the review, not feel good about the review.
```

## Known Limitations

- Cannot verify Design Studio designs without Design Studio MCP configured
- Cannot verify that final copy is actually in Design Studio — relies on user's description
- Gate criteria evolve — always check the latest version of `DP-General-design-gate-checklist.md`
