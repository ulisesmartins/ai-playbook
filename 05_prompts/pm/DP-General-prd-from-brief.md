---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
category: prd-drafting
audience: PM
---

# PRD from Brief — Generate a Structured PRD from a Feature Brief

## Purpose

Transforms a raw feature brief, Slack thread, or executive ask into a fully structured PRD that meets Dialpad's Gate 1 (Design Review) readiness criteria. Grounds the PRD in real Dialpad personas, ICPs, and product area context.

---

## Context to Load Before Running

Load these files into context before using this prompt:

- `01_context/company/DP-General-brand-voice.md`
- `01_context/personas-and-icps/DP-General-user-personas.md`
- `01_context/personas-and-icps/DP-General-icp.md`
- `01_context/product-areas/[CORE_AREA]-context.md`
- `02_templates/pm/DP-General-prd-template.md`
- `07_examples/` — reference PRD example for your Core Area if available

---

## Prompt Body

```
You are a Senior PM at Dialpad writing a PRD that will be reviewed at Gate 1 (Design Review).

Here is the feature brief / input:
[FEATURE_BRIEF]

Core Area: [CORE_AREA]
Release tier: [T1 / T2 / T3]
Target release: [MONTH YEAR or "TBD"]

Using the PRD template in `02_templates/pm/DP-General-prd-template.md`, generate a complete PRD:

1. Abstract — 2–3 sentences. What changes, for whom, and why now.
2. Context & Problem — Current state, customer pain, why this matters to Dialpad's strategy.
3. Target ICP & Personas — Pull from `01_context/personas-and-icps/`. Name the primary persona and
   the buying persona. State who is NOT in scope.
4. Proposed Solution — What we are building. Be specific about what the product does, not how we
   build it.
5. Acceptance Criteria — Binary pass/fail criteria. Each AC must be testable by an agent or QA
   engineer without interpretation.
6. Success Metrics — Primary metric (single number that moves), secondary metrics (≤3), guardrail
   metrics (what must not regress).
7. Competitive Context — State how competitors handle this. Use only facts — do not fabricate
   competitor claims.
8. Dependencies — Other teams, services, or APIs this work depends on.
9. Packaging & Rollout — Feature flag name (if applicable), EAP plan, GA plan, tier/plan packaging.
10. Open Questions — Unresolved decisions that must be answered before Gate 2.
11. Appendix — Research links, prior art, Design Studio links.

Rules:
- Do NOT use: "simply", "easy", "quickly", "users" (use persona names instead)
- Every persona reference must come from `01_context/personas-and-icps/DP-General-user-personas.md`
- ACs must be written so an agent can self-validate: "Given X, when Y, then Z"
- Flag any section you cannot complete due to missing input — do not fabricate
- Success metrics must reference Dialpad's analytics capabilities, not hypothetical tracking
```

---

## Variables

| Variable | Description | Example |
|---|---|---|
| `[FEATURE_BRIEF]` | Raw brief, Slack thread, or exec ask | "Add AI CSAT to coaching dashboard" |
| `[CORE_AREA]` | Support / Connect / Sell / Ecosystem / SharedServices | `Support` |
| `[T1/T2/T3]` | Project tier per PDLC | `T2` |
| `[MONTH YEAR]` | Target First Thursday release | `May 2026` |

---

## Usage Example

```
Load context files for Sell, then run:

You are a Senior PM at Dialpad writing a PRD...

Feature brief: We want to add a Power Dialer mode to the Sell dialer that auto-advances to
the next contact when a call ends without requiring manual click. Goal: reduce dead time between
calls by 40%. Primary users: outbound SDRs using Dialpad Sell.

Core Area: Sell
Release tier: T2
Target release: June 2026
```

---

## Expected Output

A complete PRD file with all 11 sections populated, YAML frontmatter, and a Gate 1 readiness
status of Ready or a gap list of what's missing.

---

## Known Limitations

- Cannot verify competitor claims — PM must review Section 7 before Gate 1
- Cannot access JIRA or Monday to check existing epics — provide epic context manually
- Does not generate Design Studio designs — hand off to `/design-brief` after PRD approval
- Success metrics require Analytics team confirmation for tracking feasibility
