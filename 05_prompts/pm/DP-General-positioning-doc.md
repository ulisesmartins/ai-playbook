---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
category: gtm-artifacts
audience: PM, PMM
---

# Positioning Doc — Draft Competitive Positioning from PRD and Competitive Context

## Purpose

Generates a structured competitive positioning document for a feature or product area.
Used to align Sales, PMM, and Leadership on how to position the feature against competitors
(Genesys, Five9, Gong, RingCentral, etc.). Based strictly on verifiable facts.

---

## Context to Load Before Running

- `01_context/company/DP-General-competitive-positioning.md`
- `01_context/company/DP-General-brand-voice.md`
- `01_context/personas-and-icps/DP-General-buyer-personas.md`
- `01_context/product-areas/[CORE_AREA]-context.md`
- The approved PRD

---

## Prompt Body

```
You are a PMM at Dialpad writing a competitive positioning document for a new feature.

Here is the approved PRD:
[PRD_CONTENT]

Core Area: [CORE_AREA]
Primary competitors to address: [COMPETITOR_LIST]
Primary buyer persona: [BUYER_PERSONA]

Generate a competitive positioning document with these sections:

1. POSITIONING STATEMENT
   Format: "For [target customer], [product name] is the [category] that [key benefit],
   unlike [competitor], which [limitation]."
   - One statement per primary competitor
   - Base ONLY on facts from DP-General-competitive-positioning.md

2. COMPETITIVE COMPARISON TABLE
   Columns: Capability | Dialpad | [Competitor 1] | [Competitor 2]
   - List the 5–8 most relevant capabilities for this feature
   - Use checkmark / partial / X — define what each means at top of table
   - Source each competitor cell — flag "unverified" if not sourced

3. WIN/LOSS PATTERNS (if known)
   - What objections does Sales encounter most for this feature area?
   - What is the best response to each objection?
   - Source from competitive-positioning.md only — do not invent

4. BATTLE CARD SUMMARY (≤200 words)
   - For Sales use: why us, why now, against [top competitor]
   - Include one discovery question Sales can ask to surface the pain

5. WHAT NOT TO SAY
   - Claims that are unverified or legally risky
   - Internal names or roadmap items that should not be shared externally

Rules:
- Do NOT invent competitor capabilities — flag as "unverified" if unsourced
- Every factual claim about a competitor must cite the source in DP-General-competitive-positioning.md
- Positioning statements must be reviewed by PMM and Legal before Sales use
```

---

## Variables

| Variable | Description | Example |
|---|---|---|
| `[PRD_CONTENT]` | Approved PRD text | Paste PRD |
| `[CORE_AREA]` | Support / Connect / Sell / Ecosystem / SharedServices | `Support` |
| `[COMPETITOR_LIST]` | Comma-separated competitor names | "Genesys, Five9, NICE" |
| `[BUYER_PERSONA]` | Primary buying persona | "CX/Contact Center Buyer" |

---

## Usage Example

```
Core Area: Support
Primary competitors to address: Genesys, Five9
Primary buyer persona: CX/Contact Center Buyer

[Paste PRD for AI CSAT feature]
```

---

## Expected Output

A structured positioning document with all 5 sections, formatted as Markdown. Includes a
"PMM Review Required" checklist for any claims flagged as unverified.

---

## Known Limitations

- Competitive data freshness depends on `DP-General-competitive-positioning.md` — must be kept updated
- Legal review required before sharing externally or using in Sales materials
- Battle card is a draft — Sales Enablement team owns final version
- Win/loss patterns require input from Sales/RevOps if not in the source file
