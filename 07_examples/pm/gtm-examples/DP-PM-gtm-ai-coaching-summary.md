---
version: 1.0
last_updated: 2026-03-10
status: GA
core_area: Support
skill_used: GTM Generator Agent
reviewer: Senior PM, Connect & Support
---

# Example GTM Brief: AI Coaching Summary

> **How to use this example:** This is an annotated AI-generated GTM brief produced by the GTM Generator agent from the [AI Coaching Summary PRD](../prd-examples/DP-PM-prd-ai-coaching-summary.md). Callout boxes explain where the agent performed well and where human judgment was essential.

---

## Prompt Used

```
Run the GTM Generator agent.
Input: 04_agents/pm/DP-General-gtm-generator/CLAUDE.md
PRD: 07_examples/pm/prd-examples/DP-PM-prd-ai-coaching-summary.md
Release tier: T2
Target launch: Q3 FY27
```

---

## 1. Feature Summary (1-liner)

**AI Coaching Summary** automatically surfaces the top coaching moments from every agent call — so supervisors spend less time reviewing transcripts and more time developing their teams.

> **AI note:** The agent generated 3 one-liner variants and asked the PM to pick. The selected version prioritizes the supervisor time-saving angle over the technology angle — consistent with how Dialpad sells outcomes, not features.

---

## 2. Target Audience

| Audience | Role in Launch |
|---|---|
| Contact Center Supervisors | Primary end user — coaching card consumer |
| CC Admins | Configures signal categories and thresholds |
| AEs / SEs | Demo audience at launch; feed into Q3 sales cycle |
| CS / Onboarding | Trains supervisors during implementation |

---

## 3. Positioning

### Category
AI-powered agent performance coaching — inside the tools supervisors already use.

### Positioning Statement
*For Contact Center supervisors who struggle to keep up with agent coaching volume, AI Coaching Summary is a post-call intelligence feature built into Dialpad that automatically surfaces the most important coaching moments from every call. Unlike manual transcript review or standalone coaching products like Observe.AI, Dialpad's coaching summary is integrated into the supervisor's native workflow — no new product, no new tab, no new contract.*

### Messaging Pillars

| Pillar | Headline | Supporting proof points |
|---|---|---|
| Save time | Coach every call, not just the ones you have time for | Reduces transcript review from 12 min to <2 min per call |
| Actionable, not informational | Know exactly what to say in your next 1:1 | Quoted transcript fragments + suggested coaching prompts — not just sentiment scores |
| Built-in, not bolted-on | Works inside Dialpad — no new product to buy or learn | Native dashboard tab; connects directly to 1:1 agenda; zero new tooling |

> **PM edit:** The agent's first messaging pillar was "AI-powered coaching" — this was replaced with "Coach every call, not just the ones you have time for" because it leads with the customer outcome, not the technology. The rule: never lead with AI as a feature; lead with what AI makes possible.

---

## 4. GTM Motion

### Release Tier: T2

| Channel | Action | Owner | Due |
|---|---|---|---|
| In-app announcement | Feature callout banner on Supervisor dashboard tab at launch | Product / Growth | GA day |
| Blog post | "How AI is changing the way Contact Center supervisors coach" | PMM | GA -7 days |
| Sales enablement deck | 3-slide competitive comparison (vs. Observe.AI, Five9, Talkdesk) | PM + PMM | GA -14 days |
| CS onboarding | Updated CC onboarding playbook with Coaching Summary setup guide | CS | GA -7 days |
| EAP partner comms | Case study or testimonial quote from 1 design partner | PM + CS | GA day |
| Webinar (optional) | Live demo with Q&A for CC admin audience | PMM | GA +30 days |

---

## 5. Launch Readiness Checklist

- [ ] PRD approved at Gate 2
- [ ] Design Studio prototype reviewed and signed off
- [ ] Signal scoring model precision/recall validated by AI Platform (Q-2 from PRD resolved)
- [ ] 1:1 agenda integration scoped and committed (Q-3 from PRD resolved)
- [ ] EAP accounts live and onboarded (min 3)
- [ ] CS onboarding playbook updated
- [ ] Sales enablement deck drafted and reviewed by AE lead
- [ ] In-app announcement copy reviewed by PMM
- [ ] Feature flag tested in staging
- [ ] Help center article drafted
- [ ] Analytics instrumentation validated (Amplitude events firing)

---

## 6. EAP Plan

| Item | Detail |
|---|---|
| EAP accounts | 3 design partner accounts from CS pipeline; mix of Financial Services and Retail |
| EAP start | 2026-05-01 (Q2 FY27) |
| Success criteria | ≥2 accounts achieve ≥40% coaching action rate within 30 days |
| Feedback cadence | Weekly 30-min call with primary supervisor contact + async Glean survey |
| Go/no-go decision | 2026-06-15 based on EAP data + model precision validation |

---

## 7. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Compliance signal false positives create legal concern | Medium | High | Restrict compliance category to EAP accounts; require legal review of signal taxonomy before GA |
| Supervisors don't adopt — dismiss cards without acting | Medium | Medium | Email digest as fallback; in-app nudge after 7 days without coaching action |
| 1:1 agenda integration slips past GA | Low | Low | Ship without 1:1 integration as phase 1; add as GA+30 follow-on |
| Observe.AI partnership announcements before launch | Low | Medium | Accelerate sales enablement deck; coordinate PR timing with PMM |

> **AI note:** The agent generated the risks table automatically from the PRD's Open Questions and Dependencies sections. This is one of the highest-leverage parts of the GTM agent — it cross-references the PRD to populate risk items that the PM might otherwise miss.

---

> **Overall reviewer note:** The GTM agent produced a solid first-draft brief in ~4 minutes from the PRD. The sections that needed editing: (1) messaging pillars — lead with outcomes not technology; (2) launch checklist — agent missed the help center article and analytics instrumentation items; (3) EAP success criteria — agent wrote "positive feedback" which is not measurable; PM replaced with a specific metric. Total editing time: ~15 minutes.
