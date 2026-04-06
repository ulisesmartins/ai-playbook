---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
category: jira-generation
audience: PM, Coding
---

# Epic from PRD — Turn an Approved PRD into a Structured JIRA Epic

## Purpose

Converts an approved PRD into a JIRA-ready epic using Dialpad's epic template. Produces a
complete epic description with outcome statement, acceptance criteria, story list, and
technical notes. Output is ready for Engineering intake — no translation work needed.

---

## Context to Load Before Running

- `01_context/codebase-map/DP-General-index.md`
- `01_context/codebase-map/DP-General-key-patterns.md`
- `02_templates/cross-functional/DP-General-jira-epic-template.md`
- The approved PRD

---

## Prompt Body

```
You are a Senior PM at Dialpad converting an approved PRD into a JIRA epic for Engineering intake.

Here is the PRD:
[PRD_CONTENT]

Core Area: [CORE_AREA]
Tech area: [Frontend / Backend / Full-stack / Infra]
JIRA project key: [PROJECT_KEY]
Target sprint: [SPRINT or "TBD"]
Feature flag: [FLAG_NAME or "not used"]

Using the template in `02_templates/cross-functional/DP-General-jira-epic-template.md`, generate a JIRA epic:

Epic Summary (title):
- Format: "[Core Area] — [Feature Name]: [Outcome in ≤8 words]"
- Example: "Sell — Power Dialer: Auto-advance calls without manual click"

Epic Description must include:
1. OUTCOME — What does success look like for the customer? (2 sentences max)
2. WHY — Business reason and strategic priority this addresses
3. WHO — Primary persona and ICP segment (from PRD)
4. EPIC-LEVEL ACCEPTANCE CRITERIA
   - 3–5 binary ACs that span the full epic (not story-level details)
   - Each AC: testable by QA without interpretation
5. STORY LIST — Placeholder titles for child stories (to be broken down further)
   - At minimum: Feature flag story, Data/schema story, API story, Frontend story, Tests story
6. TECHNICAL NOTES
   - Affected services (from `01_context/codebase-map/DP-General-index.md`)
   - Feature flag: name, default state, affected plans
   - Known technical constraints from the PRD
7. DEPENDENCIES — Blocking and non-blocking, with owner team
8. LINKS — PRD link, Design Studio link, Monday board ID (if available)

Labels to include: [CORE_AREA_LABEL], [TECH_AREA_LABEL], feature-flag (if applicable)

Rules:
- Epic ACs must be outcome-focused, not implementation-focused
- Do NOT include story-level implementation details in the epic description
- Service names must come from `01_context/codebase-map/DP-General-index.md` — do not guess
- Flag any missing information that Engineering will need before sprint planning
```

---

## Variables

| Variable | Description | Example |
|---|---|---|
| `[PRD_CONTENT]` | Approved PRD | Paste PRD text |
| `[CORE_AREA]` | Support / Connect / Sell / Ecosystem / SharedServices | `Connect` |
| `[TECH_AREA]` | Frontend / Backend / Full-stack / Infra | `Full-stack` |
| `[PROJECT_KEY]` | JIRA project key | `CONN` |
| `[FLAG_NAME]` | Feature flag name | `dp_daart_agentic_summary_v2` |

---

## Usage Example

```
Core Area: Connect
Tech area: Full-stack
JIRA project key: CONN
Feature flag: dp_meeting_transcription_v3

[Paste approved PRD for Meeting Transcription improvements]
```

---

## Expected Output

A complete JIRA epic description formatted in Markdown, ready to paste into the JIRA epic
description field. Includes a pre-flight checklist for PM before submitting to Engineering.

---

## Known Limitations

- Cannot create the JIRA ticket directly — requires JIRA MCP (see `09_mcps/`)
- Service names must be verified by Engineering before sprint planning
- Story list is illustrative — Engineering owns the final story breakdown
- Story point estimates are not generated — Engineering sets these during planning
