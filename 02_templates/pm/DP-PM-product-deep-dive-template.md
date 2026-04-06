---
version: 1.1
last_updated: 2026-03-13
change_summary: "Synced section structure with /product-deep-dive skill"
status: GA
---

# Product Deep Dive — [Product Area] · [Quarter]

> **Purpose:** Give EPD leadership a clear view of outcomes, what's working/not, and what to focus on.
> Target: ≤ 4 pages as pre-read · ≤ 30 minutes live · drive decisions, not status theater.
>
> **How to use this template:**
> - One master Google Doc per product area. Add a new tab for each quarter / deep dive update.
> - Top of each tab: "Qx FYyy — Latest Update" section.
> - Keep one prior update in the same tab; move older updates to an archival tab.
> - Pre-read: share in PM channel + calendar invite by EOD Friday before the Tuesday meeting.
> - Owners presenting: PM · Eng Lead · Design Lead.
> - Optional: link up to 3 slides (visuals only — funnels, timelines, architectures) from the doc.
> - Generate this doc using the [`/product-deep-dive`](../../03_skills/pm/DP-General-product-deep-dive.md) skill.

---

## Section 1 — Header

| Field | Value |
|---|---|
| Product Area | Support / Connect / Sell / Ecosystem / SharedServices |
| Quarter | Qx FYyy |
| PM | |
| Eng Lead | |
| Design Lead | |
| Key Links | [Adoption dashboard] · [Engagement dashboard] · [Revenue dashboard] |
| Visual slides (optional) | [Link — max 3 slides] |
| Prior update | [Link to prior tab/section] |

---

## Section 2 — Executive Summary

*Max 8 bullets. All outcome- and decision-focused. A CPO/CTO/HoD reads in 3 minutes and "gets it."*

- **Quarter status:** Green / Yellow / Red — [1-clause reason]
- **Outcome headline:** We [hit/missed] [core outcome] by X% vs target, driven by [Y].
- **What's working (1):** [Concrete win tied to a metric or customer impact]
- **What's working (2):** [Concrete win tied to a metric or customer impact]
- **What's not working (1):** [Concrete issue with scale/impact stated]
- **What's not working (2):** [Concrete issue with scale/impact stated]
- **OKR status:** [On track / at risk / off — 1-line driver]
- **Forward view:** [Next quarter priorities & timeline headline]
- **Yearly theme alignment:** "This ladders up to [Theme] via [explanation]."
- **Asks from leadership (max 3):** [Framed as "Decide X vs Y" or "Unblock dependency on [team]"]

---

## Section 3 — Outcomes & Metrics

### 3.1 Standard Metrics

*Leave [DATA NEEDED] if you don't have a value — do not fabricate numbers.*

| Metric | Definition | Target (Q) | Actual (QTD) | Trend vs. last Q | Notes |
|---|---|---|---|---|---|
| Adoption: WAU | | | | | |
| Adoption: DAU | | | | | |
| Adoption: % of TAM | | | | | |
| Engagement: [Core action/WAU] | | | | | |
| Engagement: Retention / stickiness | | | | | |
| Revenue: ARR | | | | | |
| Revenue: NNARR | | | | | |

### 3.2 Product-Specific Metrics

*Top 2–4 metrics that drive the business story for this area.*

| Metric | Definition | Target (Q) | Actual (QTD) | Trend vs. last Q | Notes |
|---|---|---|---|---|---|
| | | | | | |
| | | | | | |
| | | | | | |

*One sentence of insight per metric — state what it means, not what the number is.*

---

## Section 4 — What We Shipped & What We Learned

*Top 3–5 launches since last update. Focus on learning and impact, not completeness.*

**Launch: [Name]**
- What: [One-line description]
- Who: [Primary user / segment]
- When: [Launch date or window]
- Expected outcome: [Metric + direction you were trying to move]
- Result: [Early adoption/engagement/revenue data + key qualitative signal]
- Insight: "We learned that ___."

*(Repeat for each launch)*

---

**What's Working** *(max 3 bullets — patterns of repeatable success tied to metrics)*

- [Pattern] — [Evidence]
- [Pattern] — [Evidence]
- [Pattern] — [Evidence]

**What's Not Working** *(max 3 bullets — specific about scale and root cause)*

- [Problem] — [Scale / impact]
- [Problem] — [Scale / impact]
- [Problem] — [Scale / impact]

---

## Section 5 — Roadmap & Timeline (Now / Next / Later)

### NOW — Current quarter (max 3 initiatives)

**[Initiative name]**
- Hypothesis: "We believe [X] will cause [Y] because [Z]."
- Primary metric: · Guardrail metric:
- Timeline: [Start] → [Key milestones] → [Target customer-facing date]
- Status: Green / Yellow / Red — [1-line reason]

*(Repeat)*

### NEXT — Next quarter (max 4 initiatives)

**[Initiative name]**
- Problem: [1 sentence]
- Primary metric:
- Earliest likely start:
- Dependencies: [Team + what's needed]

*(Repeat)*

### LATER — Following quarters (max 5 — directional only)

- **[Initiative]** — [1 sentence]. *Supports Theme: [name].*

---

## Section 6 — OKR Status Snapshot

| Objective | Key Result | Current | Goal | Status | Commentary |
|---|---|---|---|---|---|
| | | | | On track / At risk / Behind / Severely behind | |

---

## Section 7 — Risks, Dependencies & Tradeoffs

### Top 3 Risks

| Risk | Probability / Impact | Mitigation & Owner | Timeline sensitivity |
|---|---|---|---|
| | H / M / L · H / M / L | | If not addressed by [date], then [impact] |
| | | | |
| | | | |

### Cross-Team Dependencies

| Team + Dependency | By when | Risk if late |
|---|---|---|
| | | |

### Explicit Tradeoffs *(2–3 bullets)*

- "We are choosing [X] over [Y] this quarter, which means [Z impact on metric/customer]."

---

## Section 8 — GTM, Customer Signal & Adoption Motion

*Include only if GTM-driven. Keep short — link to call notes rather than retelling them.*

**Key customer stories (max 3):** [Customer + scenario + what changed: win/loss/churn/expansion]

**GTM plays in flight:** [Top 2–3 motions tied to this product this quarter]

**Adoption blockers from field:** [2–3 bullets summarizing what Sales/CS are saying]

---

## Section 9 — Asks & Decisions

*Max 3 asks. Only include real exec decisions — remove this section if there are none.*

| # | Decision needed | Options considered | Recommendation | Impact of delay | Owner / DRI |
|---|---|---|---|---|---|
| D-1 | [Framed as a question] | | | | |
| D-2 | | | | | |

---

> **Pre-read quality check — before sharing:**
> - [ ] Executive Summary readable in ≤ 3 minutes — outcome headline is concrete and honest
> - [ ] Every metric has a source link or [DATA NEEDED] — no fabricated numbers
> - [ ] Every Now initiative is timeline-anchored, not just named
> - [ ] "What's Not Working" is direct — no softening language that hides the real signal
> - [ ] Tradeoffs are explicit — what are we *not* doing and what's the cost
> - [ ] Total length ≤ 4 pages (excluding appendix / slide links)
> - [ ] Shared in PM channel + calendar invite by EOD Friday
