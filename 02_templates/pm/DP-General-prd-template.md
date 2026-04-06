---
version: 1.1
last_updated: 2026-03-11
change_summary: "Added Desired Outcome subsection to The Why (Drivers)"
status: GA
---

# PRD Template — [Feature Name]

> **Instructions for AI agents:** Fill in all sections. Do not skip sections. Write "N/A — [reason]" if a section truly does not apply. Do not use "TBD" without a resolution date. Load `01_context/product-areas/[CoreArea]-context.md` and `01_context/personas-and-icps/` before filling in Sections 2–5.

---

## Header

| Field | Value |
|---|---|
| Feature Name | |
| Core Area | Support / Connect / Sell / Ecosystem / SharedServices |
| PM | |
| Design | |
| Engineering Lead | |
| JIRA Epic | |
| Design Studio | |
| Status | Draft / In Review / Approved |
| Target Gate 1 | |
| Target GA | |

---

## 1. Product Abstract

*One paragraph (3–5 sentences). What is this feature? What does it do? Who is it for? Why does it matter now?*

---

## 2. Context & Problem

### What is changing?

*Describe the current state. What does the user experience today? What gap or friction exists?*

### Why does this matter right now?

*What is the business driver? Why is this the right time to build it? Reference FY27 priorities from `01_context/company/DP-General-mission-and-strategy.md` if applicable.*

### The "Why" (Drivers)

- **User Pain Point:** *Specific, observable friction in the user's workflow*
- **Business Driver:** *Revenue impact, churn risk, competitive gap, or strategic priority*
- **Constraint or Risk:** *What happens if we don't build this?*

### Desired Outcome

*What measurable change in user behavior, business result, or product capability does this feature drive? Be specific — describe the "after" state, not the feature itself.*

| Outcome Type | Description | How we'll know we got there |
|---|---|---|
| **User outcome** | *What the user can now do or feel that they couldn't before* | *Observable behavior or metric* |
| **Business outcome** | *Revenue, retention, expansion, or efficiency impact* | *KPI or leading indicator* |
| **Product outcome** | *Capability unlocked for Dialpad as a platform* | *Feature adoption or downstream enablement* |

> **Agent note:** At least one User outcome and one Business outcome are required. Product outcome is optional. Do not restate the solution — describe the result of the solution being in place.

---

## 3. Target ICP & Persona

### Ideal Customer Profile

*Copy the relevant ICP from `01_context/personas-and-icps/DP-General-icp.md` and adapt.*

| Attribute | Value |
|---|---|
| Segment | VSB / SMB / Mid-market / Enterprise |
| Industry | |
| Company size | |
| Current state / competing solution | |
| Decision trigger | |

### Target User Personas

*List all personas who will interact with this feature. Reference `01_context/personas-and-icps/DP-General-user-personas.md`.*

| Persona | Role in this feature | In scope? |
|---|---|---|
| CC Agent | | |
| Supervisor / Coach | | |
| Admin | | |
| Knowledge Worker | | |
| Billing Admin | | |

---

## 4. Proposed Solution

### What we're building

*2–3 sentences describing the solution at a high level.*

### User Experience Summary

*Walk through the key user flow in plain language. Not a technical spec — describe what the user sees and does.*

1. User navigates to [location]
2. User sees [element]
3. User takes [action]
4. System responds with [result]

### Scope

**In scope (must-have for this release):**
- Item 1
- Item 2

**Out of scope (explicitly deferred):**
- Item 1 — deferred because [reason]
- Item 2 — deferred because [reason]

---

## 5. Acceptance Criteria

*Each criterion must be binary: an agent or QA engineer can verify it as pass/fail without ambiguity.*

| # | Criterion | Persona | Priority |
|---|---|---|---|
| AC-1 | [Feature] is visible to [Persona] when [condition] | | Must |
| AC-2 | [Action] results in [outcome] within [time/condition] | | Must |
| AC-3 | [Error state] displays [specific message] when [condition] | | Must |
| AC-4 | [Feature] is NOT visible to [Persona] without [permission/flag] | | Must |

---

## 6. Success Metrics

| Metric | Baseline | Target | Measurement Method |
|---|---|---|---|
| | | | |

*Tie metrics to FY27 KPIs from `01_context/company/DP-General-mission-and-strategy.md` where possible.*

---

## 7. Competitive Context

*How do key competitors solve this? What is Dialpad's differentiation? Reference `01_context/company/DP-General-competitive-positioning.md`.*

| Competitor | Their approach | Dialpad advantage |
|---|---|---|
| | | |

---

## 8. Dependencies

| Dependency | Type | Team | Status |
|---|---|---|---|
| | Frontend / Backend / Infra / External | | Confirmed / TBD |

---

## 9. Packaging & Rollout

| Field | Value |
|---|---|
| Which tiers include this feature? | Essentials / Advanced / Premium / Add-on |
| Feature flag name | *Provided by Engineering* |
| EAP plan | Yes / No — [details] |
| GA timeline | |
| GTM release tier | T1 / T2 / T3 |

---

## 10. Open Questions

| # | Question | Owner | Target resolution date |
|---|---|---|---|
| Q-1 | | | |

---

## 11. Appendix

*Optional: Wireframes, data models, competitive screenshots, research summaries, or other supporting material.*

---

> **Agent output quality check:** Before submitting this PRD, verify:
> - [ ] All sections filled (no TBDs without resolution dates)
> - [ ] Personas linked to `01_context/personas-and-icps/DP-General-user-personas.md`
> - [ ] Acceptance criteria are binary pass/fail, not descriptive
> - [ ] No invented feature names, flag names, or JIRA ticket numbers
> - [ ] Success metrics have baselines and measurement methods
> - [ ] Desired Outcome table has at least one User outcome and one Business outcome — not a restatement of the solution
