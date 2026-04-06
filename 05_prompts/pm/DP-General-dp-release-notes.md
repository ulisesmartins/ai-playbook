---
version: 1.1
last_updated: 2026-03-30
change_summary: "Rename from release-notes to dp-release-notes"
status: GA
category: gtm-artifacts
audience: PM, PMM, Coding
---

# Release Notes — Generate Release Notes from a Feature Summary

## Purpose

Generates two formats of release notes from a feature summary or PRD: (1) customer-facing changelog
entry for the Dialpad What's New page, and (2) technical release notes for internal engineering/QA
use. Aligns with the First Thursday release cadence.

---

## Context to Load Before Running

- `01_context/company/DP-General-brand-voice.md`
- `01_context/personas-and-icps/DP-General-user-personas.md`
- The approved PRD or feature summary

---

## Prompt Body

```
You are a Dialpad PM writing release notes for the [MONTH YEAR] First Thursday release.

Feature summary:
[FEATURE_SUMMARY]

Core Area: [CORE_AREA]
Release tier: [T1 / T2 / T3]
Feature flag: [FLAG_NAME or "GA to all"]
Plans/tiers affected: [PLAN_NAMES or "all plans"]
Breaking changes: [YES/NO — describe if yes]

Generate two release note formats:

FORMAT 1: CUSTOMER-FACING CHANGELOG (What's New page)
- Length: 50–80 words
- Structure: 1 headline sentence (benefit-first) + 2–3 supporting sentences
- Tone: Dialpad brand voice — confident, human, direct, no jargon
- Lead with what changed and what the customer can do now
- Do NOT mention internal feature flag names, architecture details, or "backend"
- Avoid: "simply", "easy", "quickly", "users", "leverage", "utilize"

FORMAT 2: TECHNICAL RELEASE NOTES (internal/engineering)
- Length: as needed
- Structure:
  - Summary: 1 sentence technical description
  - What changed: bullet list of specific code/API/data changes
  - Feature flag: flag name, default state (on/off), which plans/orgs it applies to
  - Migration steps: any action required by admin, customer, or engineering team
  - Known issues: any bugs or edge cases not fixed in this release
  - Rollback plan: how to disable if a critical issue is found post-deploy
  - Testing: what was tested, what environments, known gaps

Rules:
- Customer-facing notes: zero technical terms, zero internal names
- Technical notes: be precise — state the flag name, affected endpoint, and migration step
- If breaking changes exist, technical notes MUST include the rollback plan
```

---

## Variables

| Variable | Description | Example |
|---|---|---|
| `[FEATURE_SUMMARY]` | Brief description or PRD abstract | "AI CSAT now supports Spanish and French" |
| `[CORE_AREA]` | Support / Connect / Sell / Ecosystem / SharedServices | `Support` |
| `[FLAG_NAME]` | Feature flag or "GA to all" | `dp_ai_csat_multilingual` |
| `[PLAN_NAMES]` | Plans this applies to | "Ai Contact Center, Enterprise" |
| `[MONTH YEAR]` | Release month | `April 2026` |

---

## Usage Example

```
Feature summary: Power Dialer now auto-advances to the next prospect when a call ends,
eliminating the manual click required between dials. Available for all Sell users.

Core Area: Sell
Release tier: T2
Feature flag: GA to all
Plans/tiers affected: Dialpad Sell (all tiers)
Breaking changes: No
```

---

## Expected Output

Two formatted blocks:
1. `## Customer-Facing Release Note` — ready to paste into What's New page
2. `## Technical Release Notes` — ready for engineering changelog or Notion

---

## Known Limitations

- Customer-facing copy must be reviewed by PMM before publishing
- Cannot confirm plan/tier mapping without reviewing Billing/Packaging context
- Technical notes require Engineering input for accurate rollback procedure
- Cannot access Datadog/deployment system — rollback steps must be provided by Engineering
