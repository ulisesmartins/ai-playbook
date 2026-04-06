---
version: 1.0
last_updated: 2026-03-16
change_summary: "Initial version"
status: New
audience: PM
---

# `/brainstorm` — Iterate on an Idea

## Purpose

Takes a rough idea, assumption, or open question and runs structured iteration rounds to sharpen it into something actionable. Each round challenges the idea from a different angle — feasibility, user value, competitive differentiation, and scope — so you walk away with a stronger version of what you started with, not just validation.

## Required Inputs

Provide at least one of the following:

- **Idea or hypothesis** (free text) — the thing you want to stress-test
- **Core Area** — Support / Connect / Sell / Ecosystem / SharedServices (loads relevant product context)
- **Constraint** (optional) — timeline, headcount, technical limitation, or strategic constraint to work within

## How to Use

```
/brainstorm
Idea: [describe the idea, feature concept, or open question in 1–5 sentences]
Core Area: [CoreArea]
Constraint: [any known constraints, or "none"]
```

## Expected Output

A structured brainstorm document with **3 iteration rounds**, each building on the last:

1. **Round 1 — Expand** — Generate 5 variations of the idea. Push scope wider, explore adjacent opportunities, consider different user segments.
2. **Round 2 — Challenge** — For the 2 strongest variations, identify the biggest risk, the weakest assumption, and what would need to be true for it to succeed.
3. **Round 3 — Converge** — Synthesize into a single sharpened version of the idea with: one-line pitch, target persona, key differentiator, biggest open question, and suggested next step.

## Skill Body (Prompt)

```
Read the following files before starting:
- 01_context/company/DP-General-mission-and-strategy.md
- 01_context/product-areas/[CORE_AREA]-context.md
- 01_context/company/DP-General-competitive-positioning.md
- 01_context/personas-and-icps/DP-General-user-personas.md

You are acting as a brainstorm partner for a PM at Dialpad. Your job is
to help sharpen a rough idea into something worth writing a brief about.

The user will provide an idea, a Core Area, and optionally a constraint.

Run three rounds:

**Round 1 — Expand**
Generate 5 meaningfully different variations of the idea. Do not
restate the same idea with different words. Each variation should
change at least one of: target persona, scope, delivery mechanism,
or value proposition. Present as a numbered list with a one-sentence
pitch per variation.

**Round 2 — Challenge**
Pick the 2 strongest variations (explain why you picked them).
For each, answer:
- What is the biggest risk?
- What assumption is this most dependent on?
- What would need to be true for this to succeed at Dialpad specifically?
- How would a competitor respond?

**Round 3 — Converge**
Synthesize into one sharpened idea. Output:
- **One-line pitch** (≤15 words)
- **Target persona** (from DP-General-user-personas.md)
- **Key differentiator** (why Dialpad wins here)
- **Biggest open question** (what you still don't know)
- **Suggested next step** (specific action — not "do more research")

Do not fabricate Dialpad product names, feature flags, or roadmap items.
If the idea conflicts with known strategy in the loaded context files,
say so directly.
```

## Known Limitations

- Does not access JIRA, Confluence, or external data — works only from loaded context files and the user's input
- The 5 variations in Round 1 may overlap if the initial idea is already very narrow — provide more context to get better spread
- Cannot validate technical feasibility — flag ideas that need engineering input as an open question in Round 3
