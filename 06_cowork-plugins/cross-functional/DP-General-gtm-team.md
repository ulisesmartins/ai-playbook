---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
audience: PM, PMM
---

# GTM Team — Multi-Role GTM Artifact Generation Session

## Purpose

Runs a three-role GTM artifact generation session: PM validates product facts, PMM writes
customer-facing messaging, and CX Readiness prepares support materials. Produces a complete
GTM artifact set for T1 and T2 launches aligned to the First Thursday release cadence.

---

## Roles

| Role | Perspective | Output |
|---|---|---|
| PM Reviewer | Product accuracy | Fact-checks messaging against PRD; flags inaccurate claims |
| PMM Writer | Messaging | What's New entry, messaging framework, positioning statement |
| CX Readiness | Support prep | Known issues, CX FAQ, escalation guide for launch day |

---

## Input Required

```
Feature: [FEATURE_NAME]
Core Area: [CORE_AREA]
Release tier: [T1 / T2]
Target release: [MONTH YEAR — First Thursday]
Feature flag: [FLAG_NAME or "GA to all"]
Plans affected: [PLAN_NAMES]
[FULL PRD TEXT]
```

---

## Kickoff Prompt

```
Read the following files:
- 01_context/company/DP-General-brand-voice.md
- 01_context/company/DP-General-competitive-positioning.md
- 01_context/personas-and-icps/DP-General-user-personas.md
- 01_context/personas-and-icps/DP-General-buyer-personas.md
- 02_templates/pm/DP-General-launch-brief-template.md

You are running a GTM artifact generation session for:
Feature: [FEATURE_NAME]
Core Area: [CORE_AREA]
Release tier: [RELEASE_TIER]
Target release: [TARGET_RELEASE]
Plans affected: [PLANS_AFFECTED]

PRD:
[PRD_CONTENT]

---

ROLE 1: PM REVIEWER
Before messaging is written, validate the product facts:
1. List the 5 most important factual claims about this feature (what it does, for whom)
2. Flag any aspect of the PRD that is unclear enough to produce misleading messaging
3. State what this feature does NOT do (important for PMM to avoid overpromising)
4. Identify the primary persona this messaging should speak to (from DP-General-user-personas.md)
5. State the one metric that will prove this feature was worth shipping

Output: fact sheet for PMM to use as source of truth

---

ROLE 2: PMM WRITER
Using the PM fact sheet, generate:

1. WHAT'S NEW ENTRY (50–100 words, customer-facing)
   - Benefit-first, plain language, Dialpad brand voice
   - Do NOT use: "simply", "easy", "quickly", "users", "leverage"
   - Lead with what changed and what the customer can do now

2. MESSAGING FRAMEWORK
   - Problem (1 sentence): the pain before this feature
   - What changed (3 bullets): specific capabilities now available
   - Benefit by persona (1 sentence each for personas in scope)

3. ONE-LINE PITCH (≤15 words, for sales use)
   - Format: "[Persona] can now [do X] so they can [achieve Y]"

4. COMPETITIVE ANGLE (1–2 sentences)
   - Based ONLY on facts in DP-General-competitive-positioning.md
   - Flag if no competitive differentiation can be sourced from file

---

ROLE 3: CX READINESS
Prepare the CX team for launch day:

1. TOP 5 CUSTOMER QUESTIONS on launch day (what will customers ask?)
2. CX ESCALATION GUIDE: for each question, is this answerable by T1 CX or needs escalation?
3. KNOWN ISSUES: what gaps or edge cases might customers hit on day 1?
4. ADMIN SETUP REQUIRED: any steps admins must complete before end users can access the feature?
5. ROLLBACK SIGNAL: what behavior should make CX escalate to Engineering immediately?

---

CONSOLIDATED GTM REPORT:
1. What's New entry (final, ready for publishing after PMM review)
2. Messaging framework (internal use)
3. One-line sales pitch
4. CX readiness checklist (share with CX lead 2 weeks before launch)
5. PMM review checklist (items requiring PMM sign-off before any external use)
```

---

## Handoff Format

1. What's New entry → PMM reviews → publishes on First Thursday
2. Messaging framework → loads into sales enablement materials
3. CX readiness checklist → shared with CX team lead 2 weeks pre-launch
4. Competitive angle → Legal review before external use

---

## Exit Condition

Session complete when all three roles produce outputs AND the consolidated report is generated.
PMM must review all customer-facing copy before any external distribution.

---

## Known Limitations

- What's New entry must be reviewed by PMM before publishing — not ready to publish from this output
- Competitive claims must be verified against `DP-General-competitive-positioning.md` — flag any unverified claim
- CX FAQ is based on the PRD — real launch day questions may differ; update after Week 1
