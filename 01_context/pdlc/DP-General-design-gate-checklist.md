---
classification: DP-Official
path: 01_context/pdlc/DP-General-design-gate-checklist.md
last_updated: 2026-03-09
---

# Dialpad Design Gate Checklist — Gate 1

## Purpose

This checklist defines what the EPD trio (PM + Design + Engineering) must produce to pass the **Design Review Gate (Gate 1)**. It is the contract between the trio and EPD Staff before development begins.

Gate 1 is Design-led. PM contributes problem framing and business context. Engineering contributes feasibility and early scope input.

> Source: [Gate Reviews w/ EPD Staff](https://dialpad.atlassian.net/wiki/spaces/EPD/pages/81625653) | [Gate 1 Design Review Template](https://docs.google.com/presentation/d/1ba3Jr-fTvJX4OxNEqs7Ctpood2qpKkLbVCwpVKpwHr4)

---

## Gate 1 Presentation Checklist

### Section 1 — User Needs & Problem Definition

- [ ] **JTBD (Jobs to Be Done)** defined — what is the user trying to accomplish?
- [ ] **User problem** articulated clearly — what friction, failure, or gap exists today?
- [ ] **Impact statement** — why does solving this matter to the business and to users?
- [ ] **Priority and urgency** justified — why now?

---

### Section 2 — Personas

- [ ] **Target personas confirmed** — who specifically will use this feature?
- [ ] Personas aligned with `01_context/personas-and-icps/DP-General-user-personas.md`
- [ ] Persona roles called out (e.g., Agent, Supervisor, Admin, Knowledge Worker)
- [ ] Out-of-scope personas explicitly noted if applicable

---

### Section 3 — Proposed Solution

- [ ] **Final flows** presented — not wireframes or concepts; final design direction
- [ ] **Copy included** in flows — not placeholder text
- [ ] **Before/After** shown for any changes to existing features
- [ ] Edge cases and error states covered (at minimum: empty state, loading, error, success)
- [ ] Mobile considerations noted if applicable
- [ ] Accessibility requirements noted (color contrast, keyboard nav, screen reader)
- [ ] Feature activation and discoverability plan (in-product ingress points)

---

### Section 4 — UX Scores & Research

- [ ] **UX Scorecard results** shared if applicable (Dialpad current + competition + pre-EAP)
- [ ] Key learnings and opportunities from scorecard called out
- [ ] **Research summary** — interviews, support tickets, NPS themes, Gong call patterns
- [ ] **Competitive analysis** — how do competitors solve this? Dialpad's differentiation?

---

### Section 5 — Scope & Timeline

- [ ] **Feature scope defined** — what is IN and what is explicitly OUT
- [ ] **Project tier confirmed** (T1 / T2 / T3)
- [ ] **Engineering complexity** assessed — preliminary LOE or risk from EM/Eng
- [ ] **Timeline proposed** — target code complete and First Thursday date
- [ ] **Dependencies** identified — teams, infrastructure, external systems
- [ ] **Risks** called out — what could block or delay delivery?

---

### Section 6 — EAP Plan (if applicable)

- [ ] EAP customer list identified or sourced
- [ ] EAP scope defined — what customers see vs. what is held back
- [ ] EAP feedback channel created (e.g., `#feedback-eap-[feature-name]`)
- [ ] EAP timeline included in overall project timeline

---

### Section 7 — GTM & CX Readiness

- [ ] **CX Feature Introduction meeting** scheduled with NPI team (or noted N/A)
- [ ] **Release tier** identified (T1 / T2 / T3 for GTM)
- [ ] **PMM loop** started — PMM has been informed
- [ ] Help Center update scope noted

---

## Design Leadership Pre-Review Checklist

Complete this BEFORE requesting EPD Gate 1. Design Leadership must approve before EPD Staff review.

- [ ] Work shared in weekly Design critique or with Design Manager
- [ ] Design Lead has reviewed and approved final direction
- [ ] Design Leadership review deck prepared using [DLT Review Template](https://dialpad.atlassian.net/wiki/x/5ILzMQ)
- [ ] All Design Studio files using DT9 Component Library + DT9 Design Tokens (Rebrand 2025)

---

## Scheduling Instructions

1. Request gate review **2 weeks in advance** via `gate-reviews@dialpad.com`
2. Include: Eng DRI, PM DRI, Design DRI in the request
3. **3 days before:** send deck and demo recording link in the email thread
4. Attendees: EPD Staff + PM owner + Designer or EM as needed. POC: Helena Raspo.

---

## AI Validation Guidance

When using an agent to prepare for Gate 1:

- [ ] Personas referenced exist in `01_context/personas-and-icps/DP-General-user-personas.md`
- [ ] Competitor claims sourced from `01_context/company/DP-General-competitive-positioning.md`
- [ ] Product features grounded in relevant `01_context/product-areas/` file
- [ ] Scope statements explicit about what is OUT of scope
- [ ] No invented feature flags, API names, or JIRA ticket numbers
