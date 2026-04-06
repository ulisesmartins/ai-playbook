---
version: 1.0
last_updated: 2026-03-10
status: GA
core_area: Support
skill_used: /draft-prd
reviewer: Senior PM, Connect & Support
---

# Example PRD: AI Coaching Summary

> **How to use this example:** This is an annotated AI-generated PRD. Callout boxes marked **AI note** explain what the agent did; boxes marked **PM edit** explain where human judgment was needed. Use it as a calibration reference when evaluating `/draft-prd` outputs.

---

## Prompt Used

```
/draft-prd

Feature: Automatically generate a post-call coaching summary for supervisors
that highlights agent behaviors worth coaching — tone shifts, missed resolution
opportunities, compliance gaps — based on Dialpad AI transcript analysis.

Core Area: Support
Target personas: Supervisor / Coach, Admin
JIRA epic: not yet created
```

**Context loaded:**
- `01_context/company/DP-General-mission-and-strategy.md`
- `01_context/product-areas/Support-context.md`
- `01_context/personas-and-icps/DP-General-user-personas.md`
- `02_templates/pm/DP-General-prd-template.md`

---

## Header

| Field | Value |
|---|---|
| Feature Name | AI Coaching Summary |
| Core Area | Support |
| PM | *[your name]* |
| Design | *TBD* |
| Engineering Lead | *TBD* |
| JIRA Epic | *Not yet created* |
| Design Studio | *Not yet created* |
| Status | Draft |
| Target Gate 1 | Q2 FY27 |
| Target GA | Q3 FY27 |

> **AI note:** The agent defaulted to Q2/Q3 based on the mission-and-strategy doc's FY27 planning horizon. The PM updated this to match actual sprint capacity — the agent's estimate was directionally right but needed calibration against roadmap.

---

## 1. Product Abstract

AI Coaching Summary automatically generates a structured post-call summary for supervisors after each agent interaction, surfacing specific behaviors worth coaching — tone shifts, missed de-escalation moments, compliance language gaps, and unresolved customer issues. The feature is triggered when a call ends and the AI transcript is available, delivering a prioritized coaching card to the supervisor's Dialpad dashboard within two minutes. It targets Contact Center supervisors at SMB and mid-market accounts managing teams of 5–50 agents, where structured coaching time is limited and informal feedback is inconsistent.

> **PM edit:** The agent's first draft said "helps supervisors be better coaches." This was rewritten to include the specific behaviors surfaced, the delivery timing, and the target segment — all things the agent knew from context but didn't foreground. Always push the abstract to be specific.

---

## 2. Context & Problem

### What is changing?

Today, supervisors receive raw call transcripts and AI sentiment scores in Dialpad, but no structured coaching signal. They must manually review transcripts — which takes 10–15 minutes per call — to identify coachable moments. Most supervisors only review 5–10% of calls, leaving the majority of coaching opportunities missed. Agents receive feedback infrequently and without specificity, leading to inconsistent performance improvement.

### Why does this matter right now?

Dialpad's FY27 Support pillar prioritizes increasing supervisor leverage — enabling a smaller supervisor-to-agent ratio without sacrificing agent performance quality. AI Coaching Summary directly addresses this by reducing transcript review time from ~12 minutes to <2 minutes per call, enabling supervisors to coach 3–5× more calls per week. Competitors (Five9, Talkdesk) have launched basic post-call AI summaries; differentiation through coaching-specific signals (not just sentiment) is the strategic wedge.

### The "Why" (Drivers)

- **User Pain Point:** Supervisors spend 10+ minutes per call to extract actionable coaching insight from raw transcripts; most calls go unreviewed.
- **Business Driver:** Coaching quality is a top-3 reason cited in CC churned-customer interviews. Improving supervisor leverage is a FY27 OKR.
- **Constraint or Risk:** If we don't ship in Q2, we risk losing mid-market deals where coaching tooling is an active evaluation criterion.

### Desired Outcome

| Outcome Type | Description | How we'll know we got there |
|---|---|---|
| **User outcome** | Supervisors can review and act on coaching insights for all calls, not just sampled ones | % of calls receiving at least one coaching action increases from ~10% to ≥40% |
| **Business outcome** | Reduced CC churn through improved agent performance quality | 10% reduction in "agent quality" churn reason within 2 quarters of GA |
| **Product outcome** | Coaching Summary establishes AI transcript → supervisor workflow pattern, enabling future Coaching Playbooks feature | Feature adoption ≥60% among eligible supervisors within 90 days |

> **AI note:** The agent generated this table correctly on the first pass. It correctly linked the business outcome to the churn interview data mentioned in the brief context. Minor edits were made to sharpen the measurement method column.

---

## 3. Target ICP & Persona

### Ideal Customer Profile

| Attribute | Value |
|---|---|
| Segment | SMB / Mid-market |
| Industry | Financial services, healthcare, retail |
| Company size | 50–500 seats |
| Current state / competing solution | Using Dialpad CC or evaluating vs. Five9/Talkdesk |
| Decision trigger | Supervisor-to-agent ratio squeeze; compliance audit; agent performance review cycle |

### Target User Personas

| Persona | Role in this feature | In scope? |
|---|---|---|
| CC Agent | Receives coaching from supervisor; no direct interaction with this feature | No — downstream beneficiary only |
| Supervisor / Coach | Primary consumer of coaching summaries; takes coaching action | **Yes — primary** |
| Admin | Configures which behaviors to surface; sets coaching cadence | **Yes — secondary** |
| Knowledge Worker | N/A | No |
| Billing Admin | N/A | No |

---

## 4. Proposed Solution

### What we're building

After each call, the Dialpad AI pipeline analyzes the transcript for six coaching signal categories (tone, resolution, compliance, objection handling, empathy, and talk ratio) and generates a structured coaching card delivered to the supervisor's dashboard. Supervisors can dismiss, bookmark, or escalate a coaching card to a 1:1 agenda item in one click.

### User Experience Summary

1. Call ends; Dialpad AI transcript is generated within ~60 seconds.
2. Coaching Summary pipeline runs scoring against six signal categories.
3. Supervisor sees a coaching card appear in their "Coaching" dashboard tab, ranked by signal severity.
4. Card shows: agent name, call date, top 3 coaching moments (quoted transcript fragment + signal label), suggested coaching prompt.
5. Supervisor can: mark as reviewed, add to 1:1 agenda, or dismiss.
6. Admin can configure which signal categories are active and set minimum severity threshold for card generation.

### Scope

**In scope (must-have for this release):**
- Coaching card generation from completed CC calls with AI transcripts
- Six coaching signal categories (tone, resolution, compliance, objection handling, empathy, talk ratio)
- Supervisor dashboard tab: Coaching
- Card actions: mark reviewed, add to 1:1 agenda, dismiss
- Admin configuration: enable/disable signal categories, set severity threshold
- Email digest: daily summary of unreviewed coaching cards (opt-in)

**Out of scope (explicitly deferred):**
- Agent-facing coaching view — deferred to Coaching Playbooks phase 2
- Real-time coaching (in-call alerts) — separate initiative with different infra requirements
- Coaching analytics / trend dashboard — deferred to phase 2
- Integration with third-party LMS (Lessonly, Seismic) — post-GA

---

## 5. Acceptance Criteria

| # | Criterion | Persona | Priority |
|---|---|---|---|
| AC-1 | A coaching card is generated for every completed CC call where an AI transcript is available, within 3 minutes of call end | Supervisor | Must |
| AC-2 | Each coaching card displays at least 1 and at most 5 coaching moments, each with: quoted transcript fragment, signal category label, and suggested coaching prompt | Supervisor | Must |
| AC-3 | Supervisor can mark a card as reviewed, and the card moves to the Reviewed tab without page reload | Supervisor | Must |
| AC-4 | Supervisor can add a coaching card to a 1:1 agenda item; the agenda item appears in the next scheduled 1:1 with that agent | Supervisor | Must |
| AC-5 | Admin can disable any of the 6 signal categories; disabled categories produce no coaching moments in generated cards | Admin | Must |
| AC-6 | Coaching cards are NOT visible to CC Agents or Knowledge Workers | Supervisor | Must |
| AC-7 | When no coaching moments meet the minimum severity threshold, no card is generated for that call | System | Should |

---

## 6. Success Metrics

| Metric | Baseline | Target | Measurement Method |
|---|---|---|---|
| % of calls receiving at least one coaching action | ~10% | ≥40% within 90 days of GA | Amplitude: coaching_action_taken event / total_calls |
| Supervisor weekly active usage | N/A (new feature) | ≥60% of eligible supervisors WAU | Amplitude: coaching_tab_viewed |
| Time to coaching action per call | ~12 min | <2 min median | Amplitude: time between call_ended and coaching_action_taken |
| Coaching-related churn reason | Baseline from CS churn interviews | 10% reduction within 2 quarters | CS churn tagging in Salesforce |

---

## 7. Competitive Context

| Competitor | Their approach | Dialpad advantage |
|---|---|---|
| Five9 | Post-call sentiment summary; no structured coaching signal categories | Dialpad surfaces specific coachable moments with quoted transcript context and suggested prompts — not just a sentiment score |
| Talkdesk | AI coaching "suggestions" integrated with Talkdesk Coaching module | Dialpad's signal categories are configurable by admin; Talkdesk's are fixed. Dialpad also connects to 1:1 agenda workflow natively |
| Observe.AI | Deep coaching AI product, standalone | Full standalone product — higher price, no native Dialpad integration. Dialpad wins on workflow integration and price for SMB/mid-market |

> **PM edit:** The agent's competitive table was accurate but didn't call out Observe.AI. This was added manually after Glean research. Always check the competitive section against `DP-General-competitive-positioning.md` AND a Glean search for recent competitive intel.

---

## 8. Dependencies

| Dependency | Type | Team | Status |
|---|---|---|---|
| AI transcript pipeline | Backend | AI Platform | Confirmed — transcript available within 60s of call end |
| 1:1 agenda integration | Frontend / Backend | Cowork | TBD — needs design review with Cowork PM by 2026-04-01 |
| Signal scoring model | Backend / ML | AI Platform | In progress — model card expected 2026-03-28 |
| Admin configuration UI | Frontend | Dialpad Settings | Confirmed |

---

## 9. Packaging & Rollout

| Field | Value |
|---|---|
| Which tiers include this feature? | Advanced / Premium (CC add-on tiers) |
| Feature flag name | *Provided by Engineering* |
| EAP plan | Yes — 3 design partner accounts recruited from CS, starting Q2 FY27 |
| GA timeline | Q3 FY27 |
| GTM release tier | T2 — blog post, sales enablement deck, in-app announcement |

---

## 10. Open Questions

| # | Question | Owner | Target resolution date |
|---|---|---|---|
| Q-1 | Should coaching cards be generated for non-CC calls (e.g. Connect calls)? Supervisor use case is less clear. | PM | 2026-04-01 |
| Q-2 | What is the signal scoring model's precision/recall on compliance category? False positives here carry risk. | AI Platform | 2026-03-28 |
| Q-3 | Does the 1:1 agenda integration require a separate JIRA epic with Cowork? | PM + Cowork PM | 2026-04-01 |

---

## 11. Appendix

*Design Studio prototype link: [to be added at Gate 1]*
*Signal category definitions: see AI Platform confluence page (link via Glean: "coaching signal taxonomy")*

---

> **Overall reviewer note:** The agent produced a complete, structured PRD on the first pass. The sections that needed the most human editing were: (1) the product abstract — too vague, (2) the competitive table — missing Observe.AI, (3) the success metrics baselines — the agent wrote "N/A" for WAU baseline, which is correct but needs a note explaining why. Total editing time: ~25 minutes. Unedited token count was ~2,400 words; final version is ~2,800 words after PM additions.
