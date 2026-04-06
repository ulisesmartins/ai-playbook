---
classification: DP-Official
path: 01_context/pdlc/DP-General-phases-and-gates.md
last_updated: 2026-03-09
---

# Dialpad PDLC — Phases, Gates & Project Tiers

## 1. Overview

Dialpad's Product Development Life Cycle (PDLC) follows a **Triple Diamond** model: Discover → Define → Design → Develop → Deploy. It is structured around **three mandatory gates** where EPD Staff (CPO, CTO, VP Design) review and approve before work advances.

> Source: [EPD Product Development Lifecycle](https://dialpad.atlassian.net/wiki/spaces/EPD/pages/629407858) | [Gate Reviews w/ EPD Staff](https://dialpad.atlassian.net/wiki/spaces/EPD/pages/81625653)

---

## 2. Project Tiers

Every project is classified into a tier before entering the PDLC. The tier determines which gates and activities are required.

| Tier | Definition | Effort | Example |
|---|---|---|---|
| **Tier 1** | Major feature or new product launch. Heavily cross-functional with multi-quarter effort. | Complex | Contact Center launch, new product line |
| **Tier 2** | Incremental feature addition. Cross-functional with dependencies or a quarter-long effort. | Medium | Add-on SKU, partner integration (e.g., Miro, Zoho) |
| **Tier 3** | Small improvements or bug fixes. Low cross-functional dependency, ≤1 month effort. | Light | UI updates, usability fixes |

---

## 3. Gates

### Gate 0.5 — Project Approval (Optional)
**Goal:** Align on direction and resolve open questions before committing to a design sprint.

**When to use:** For early-stage projects with significant scope or feasibility ambiguity.

**Required:**
- Problem definition: what we're solving, user benefit, why it matters
- Objectives and measurable goals
- Roadmap and risks overview

---

### Gate 1 — Design Review (Required T1/T2; Recommended T3)
**Goal:** Review problem definition, proposed solution, and execution plan. Achieve EPD Staff consensus on approach before development begins.

**Ownership:** Design-led. PM and EM participate.

**Required Checklist:**
- [ ] User Needs and Problem Definition (JTBD confirmed)
- [ ] Personas confirmed and aligned to target users
- [ ] Proposed Solution: final flows and copy (before/after for existing features)
- [ ] UX Scorecard results (if applicable)
- [ ] Research and competitive analysis summary
- [ ] Scope and Timeline defined
- [ ] EAP plan (if EAP required)
- [ ] CX Feature Introduction meeting scheduled with NPI team

**Scheduling:** Request 2 weeks in advance via `gate-reviews@dialpad.com`. Send deck and demo recording 3 days before. POC: Helena Raspo.

**Design Leadership Pre-review:** Required before Gate 1. Book weekly Design Leadership slot.

---

### Gate 2 — EAP / Internal Approval (Required T1/T2)
**Goal:** Validate working build before limited customer exposure. Confirm EAP readiness.

**Required:**
- [ ] Working EAP-ready build
- [ ] EAP scope and customer list confirmed
- [ ] QA sign-off
- [ ] Training checklist complete
- [ ] CX/Support enablement in progress

---

### Gate 3 — GA Approval (Required T1/T2)
**Goal:** Final sign-off before general availability. Validate production readiness and GTM completeness.

**Required:**
- [ ] Feature complete and production-stable
- [ ] Product Launch Checklist complete
- [ ] PMM messaging finalized
- [ ] Help Center content published or staged
- [ ] Post-launch metric review scheduled

---

## 4. Deliverables by Tier

| Phase | T1/T2 Required | T3 Minimum |
|---|---|---|
| Discover | Project Brief | JIRA Epic |
| Define | Product Spec, Design Spec | — |
| Design | Gate 1: Design Review | Gate 1 (Recommended) |
| Design Handoff | Design Handoff to Dev, Eng Spec | — |
| Develop | Eng Handoff to QA, QA Sign-off | QA Sign-off |
| EAP | Gate 2: EAP Approval | — |
| GA | Product Launch Checklist, Gate 3 | — |
| Post-Launch | Metric review with EPD Staff | — |

---

## 5. Spec Types

| Spec | Owner | Required For |
|---|---|---|
| Product Spec | PM | T1/T2 |
| Product Spec Lite | PM | T2 light or T3 |
| Design Spec | Designer | T1/T2 |
| Engineering Spec | Engineering | T1/T2 |
| Engineering Spec Lite | Engineering | T2 light or T3 |

---

## 6. First Thursday Release Cadence

Dialpad ships production-ready improvements on the **first Thursday of every month**.

- Features must be code-complete and QA'd before the First Thursday deadline
- GTM artifacts (What's New, release notes, CS training) must be ready concurrently
- T3 features may ship on rolling basis; T1/T2 features target First Thursday
- T1 features (major): blog, email announcements | T2: email + newsletter | T3: newsletter/roundup

---

## 7. How to Use This File

- **Agents:** Load when generating a PDLC checklist, gate review deck outline, or project tier assessment.
- **PMs:** Reference `DP-General-design-gate-checklist.md` for the detailed Gate 1 deliverable list.
- **Validation:** Do not invent gate criteria — only assert what is documented here.
