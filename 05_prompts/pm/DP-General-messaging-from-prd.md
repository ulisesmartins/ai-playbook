---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
category: gtm-artifacts
audience: PM, PMM
---

# Messaging from PRD — Draft Product Messaging from a PRD

## Purpose

Generates a structured messaging framework from an approved PRD. Produces benefit-first,
persona-specific messaging aligned to Dialpad's brand voice. Output feeds into What's New entries,
sales decks, and launch briefs.

---

## Context to Load Before Running

- `01_context/company/DP-General-brand-voice.md`
- `01_context/company/DP-General-competitive-positioning.md`
- `01_context/personas-and-icps/DP-General-user-personas.md`
- `01_context/personas-and-icps/DP-General-buyer-personas.md`
- `01_context/product-areas/[CORE_AREA]-context.md`
- `02_templates/pm/DP-General-launch-brief-template.md`

---

## Prompt Body

```
You are a PMM at Dialpad drafting product messaging for a new feature launch.

Here is the approved PRD:
[PRD_CONTENT]

Release tier: [T1 / T2 / T3]
Core Area: [CORE_AREA]
Target personas: [LIST_PERSONAS]
Target release: [MONTH YEAR]

Generate the messaging framework:

1. ONE-LINE PITCH (≤15 words)
   - Lead with the outcome, not the feature name
   - Format: "[Persona] can now [do X] so they can [achieve Y]"

2. PROBLEM STATEMENT (1–2 sentences)
   - The pain before this feature existed
   - Ground in a persona's day-in-life from DP-General-user-personas.md

3. WHAT CHANGED (3 bullet points)
   - Each bullet: a specific capability that is new or improved
   - Use active voice, present tense
   - No internal jargon, no feature-flag names

4. BENEFIT BY PERSONA (1 sentence per persona in scope)
   - Format: "For [Persona], [benefit statement]"
   - Benefit must be the outcome, not the feature description

5. WHAT'S NEW ENTRY (50–100 words, customer-facing)
   - Benefit-first, plain language
   - Follow Dialpad brand voice: confident, human, direct
   - Do NOT use: "simply", "easy", "quickly", "users", "leverage", "utilize"
   - Target reading level: Grade 8

6. OBJECTION HANDLING (2–3 objections)
   - State the objection and a 1-sentence response
   - Base responses only on facts in the PRD and competitive-positioning.md

Rules:
- Do NOT invent competitor claims — only use facts from DP-General-competitive-positioning.md
- Every persona name must match DP-General-user-personas.md exactly
- Flag any claim that requires PMM verification before publishing
```

---

## Variables

| Variable | Description | Example |
|---|---|---|
| `[PRD_CONTENT]` | Approved PRD text | Paste PRD |
| `[CORE_AREA]` | Support / Connect / Sell / Ecosystem / SharedServices | `Sell` |
| `[LIST_PERSONAS]` | Personas in scope for this launch | "Supervisor/Coach, CC Agent" |
| `[MONTH YEAR]` | Target launch month | `April 2026` |

---

## Usage Example

```
Core Area: Support
Target personas: CC Agent, Supervisor/Coach
Release tier: T2
Target release: May 2026

[Paste PRD for AI CSAT Scoring feature]
```

---

## Expected Output

A complete messaging framework with all 6 sections populated, formatted as Markdown ready to
paste into a launch brief or Google Doc. Includes a PMM review checklist at the end.

---

## Known Limitations

- External-facing copy (What's New, one-line pitch) must be reviewed by PMM before publishing
- Competitive claims must be sourced from `DP-General-competitive-positioning.md` only
- What's New entry length target is 50–100 words — trim if longer
- Objection handling cannot substitute for live sales enablement training
