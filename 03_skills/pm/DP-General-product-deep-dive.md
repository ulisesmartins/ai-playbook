---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /product-deep-dive
audience: PM
---

# `/product-deep-dive` — Draft a Product Area Deep Dive

## Purpose

Drafts the full Product Deep Dive pre-read document for a given product area (e.g., Billing,
Connect, Sell). Produces a structured Google Doc-ready artifact that EPD leadership can read
in ≤3 minutes and discuss in ≤30 minutes live. Drives decisions and outcome visibility —
not status theater.

**Owners presenting:** PM + Eng Lead + Design Lead.
**Pre-read deadline:** EOD Friday before the Tuesday meeting, shared in PM channel + calendar invite.
**Format:** One master Google Doc per product area, one tab per quarter. Keep the prior update in
the same tab; move older updates to an archival tab.

---

## Required Inputs

```
/product-deep-dive

Product area: [e.g., Billing / Connect / Sell / Support / SharedServices]
Quarter: [e.g., Q1 FY27]
PM lead: [name]
Eng lead: [name]
Design lead: [name]

Paste any of the following you have (use whatever is available):
- OKR status / quarter goals
- Key metrics (WAU, DAU, ARR, NNARR, adoption %, engagement)
- Recent launches (name, date, expected outcome, early result)
- Current roadmap items (Now / Next / Later)
- Known risks or cross-team dependencies
- Customer/field signal (call notes, QBR themes, CS feedback)
- Exec asks or decisions needed
- What changed since last update (if this is a subsequent quarter)
```

---

## Expected Output

A complete deep dive pre-read doc with all 8 sections populated, ≤4 pages, outcome-focused,
decision-ready. Includes a self-check at the end.

---

## Skill Body (Prompt)

```
Read the following files:
- 01_context/company/DP-General-pm-ai-mindset.md
- 01_context/personas-and-icps/DP-General-user-personas.md
- 01_context/product-areas/[CORE_AREA]-context.md (if available)

You are a Senior PM at Dialpad drafting the [QUARTER] Product Deep Dive pre-read for
[PRODUCT_AREA]. EPD leadership will read this in ≤3 minutes and discuss for ≤30 minutes.

Input:
[USER_INPUT]

Rules before you write:
- Every claim must reference a metric, time window, or a link placeholder — no unanchored assertions
- Bullets, not prose — CPO/CTO/HoD reads, not literary critics
- Max 4 pages total (excluding appendix)
- Write outcomes, not activity — "we shipped X" is not interesting; "X moved Y by Z%" is
- If you don't have data for a field, write [DATA NEEDED: description] — do not fabricate numbers
- Purple instruction text in the template is deleted — do not reproduce instructions in the output

---

SECTION 1: HEADER
Product area: [PRODUCT_AREA]
Quarter: [QUARTER]
Leads: PM: [PM_LEAD] | Eng: [ENG_LEAD] | Design: [DESIGN_LEAD]
Key Links: [DATA NEEDED: links to adoption, engagement, revenue dashboards]

---

SECTION 2: EXECUTIVE SUMMARY
Max 8 bullets. All outcome- and decision-focused. A CPO/CTO/HoD reads in 3 minutes and "gets it."

Include (if data is available):
- Quarter status: Green / Yellow / Red — and why in 1 clause
- Outcome headline: "We [hit/missed] <core outcome> by X% vs target, driven by Y."
- What's working (top 2): concrete wins tied to metrics or customer impact
- What's not working (top 2): concrete issues with scale/impact stated
- OKR status: 1-2 bullets (on track / at risk / off, with key driver)
- Forward view: next quarter priorities & timeline headline (1-2 bullets)
- Alignment to yearly themes: "This ladders up to <Theme> via <explanation>."
- Asks from execs (max 3): framed as "Decide X vs Y" or "Unblock dependency on <team>"

---

SECTION 3: OUTCOMES & METRICS

3.1 Standard Metrics — fill every row you have data for; leave [DATA NEEDED] if not:

| Metric | Definition | Target (Q) | Actual (QTD) | Trend vs. last Q | Notes |
|---|---|---|---|---|---|
| Adoption: WAU | | | | | |
| Adoption: DAU | | | | | |
| Adoption: % of TAM | | | | | |
| Engagement: [Core action/WAU] | | | | | |
| Engagement: Retention / stickiness | | | | | |
| Revenue: ARR | | | | | |
| Revenue: NNARR | | | | | |

3.2 Product-Specific Metrics — top 2-4 metrics that drive the business story for this area:

| Metric | Definition | Target (Q) | Actual (QTD) | Trend vs. last Q | Notes |
|---|---|---|---|---|---|
| [Metric 1] | | | | | |
| [Metric 2] | | | | | |
| [Metric 3] | | | | | |
| [Metric 4] | | | | | |

One sentence of insight per metric (not restating the number — state what it means).

---

SECTION 4: WHAT WE SHIPPED & WHAT WE LEARNED

Top 3-5 launches since last update. Focus on learning and impact, not completeness.

For each launch:
- Launch: [NAME]
- What: one-line description
- Who: primary user / segment
- When: launch date or window
- Expected outcome: metric + direction you were trying to move
- Result: early adoption/engagement/revenue data + key qualitative signal
- Insight: "We learned that ___." — include what surprised you

Then:
WHAT'S WORKING (max 3 bullets): Patterns of repeatable success tied to metrics.
WHAT'S NOT WORKING (max 3 bullets): Patterns of failure or friction — be specific about scale.

---

SECTION 5: ROADMAP & TIMELINE (NOW / NEXT / LATER)

Timeline-anchored — not a feature list.

NOW (current quarter, max 3 initiatives):
For each:
- Name
- Hypothesis: "We believe X will cause Y because Z."
- Primary metric + guardrail metric
- Timeline: start → key milestones → target customer-facing date
- Status: Green / Yellow / Red — 1-line reason

NEXT (next quarter, max 4 initiatives):
For each:
- Name
- Problem statement (1 sentence)
- Primary metric
- Earliest likely start
- Dependencies (team + what's needed)

LATER (following quarters, max 5 — directional only):
For each: Name + 1 sentence. Tie to yearly theme if applicable: "Supports Theme: <name>."

---

SECTION 6: OKR STATUS SNAPSHOT

| Objective | Key Result | Current | Goal | Status | Commentary |
|---|---|---|---|---|---|
| | | | | On track / At risk / Behind / Severely behind | |

---

SECTION 7: RISKS, DEPENDENCIES, AND TRADEOFFS

TOP 3 RISKS:
For each:
- Description (1-2 sentences)
- Probability / Impact: H / M / L
- Mitigation and owner
- Timeline sensitivity: "If not addressed by <date>, then <impact>."

CROSS-TEAM DEPENDENCIES:
For each: Who / what (team + dependency) | By when | Risk if late

EXPLICIT TRADEOFFS (2-3 bullets):
"We are choosing X over Y this quarter, which means Z impact on <metric/customer>."

---

SECTION 8: GTM, CUSTOMER SIGNAL, AND ADOPTION MOTION
(Include only if GTM-driven; keep short — link to call notes rather than retell)

Key customer stories (max 3): customer + scenario + what changed (win/loss/churn/expansion)
GTM plays in flight: top 2-3 motions tied to this product this quarter
Adoption blockers from field: 2-3 bullets summarizing what Sales/CS are saying

---

SECTION 9: ASKS & DECISIONS (optional — only if you have a real exec ask)
Max 3 asks. This is the bridge to real decisions.

For each ask:
- Decision needed: phrased as a question
- Options considered: 2-3 bullets
- Team recommendation: 1 line
- Impact if we decide now vs. delay 1 quarter
- Owner / DRI

---

SELF-CHECK before finalizing:
1. Can a CPO read the Executive Summary in 3 minutes and understand the business situation? (Y/N)
2. Does every metric have a source link or [DATA NEEDED] placeholder? (Y/N)
3. Is every "Now" roadmap item timeline-anchored, not just named? (Y/N)
4. Are the top risks stated honestly, not softened? (Y/N)
5. Is the total length ≤4 pages (excluding appendix)? (Y/N)
Flag any "N" with a specific fix needed.
```


