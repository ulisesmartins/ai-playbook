---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /gtm-draft
audience: PM, PMM
---

# `/gtm-draft` — Draft GTM Artifact Set from a PRD and Prototype

## Purpose

Drafts the core GTM artifact set — What's New entry, messaging framework, and CX checklist — from a PRD and prototype. Uses Dialpad brand voice and competitive context for accurate, on-brand output.

## Required Inputs

```
/gtm-draft

[Paste PRD content or feature description]
Release tier: [T1 / T2 / T3]
Core Area: [CoreArea]
Target release date: [First Thursday date]
Prototype URL: [if available]
```

## Expected Output

1. What's New entry (50–100 words, customer-facing)
2. Messaging framework (problem → what changed → benefit by persona)
3. Release notes (for changelog/engineering format)
4. CX readiness checklist (pre-filled)
5. Channel plan (from `02_templates/pm/DP-General-launch-brief-template.md`)

## Skill Body (Prompt)

```
Read the following files:
- 01_context/company/DP-General-brand-voice.md
- 01_context/company/DP-General-competitive-positioning.md
- 01_context/product-areas/[CORE_AREA]-context.md
- 01_context/personas-and-icps/DP-General-user-personas.md
- 02_templates/pm/DP-General-launch-brief-template.md

Here is the feature:
[USER_INPUT — PRD or description]

Release tier: [USER_INPUT]
Target release date: [USER_INPUT]

Generate the GTM artifact set:

1. What's New entry — 50-100 words, customer-facing, benefit-first, plain language
   - Lead with what changed and what the customer can do now
   - Follow brand voice: confident, human, direct
   - Do NOT use: "simply", "easy", "quickly", "users"

2. Messaging framework:
   - Problem we're solving (1 sentence)
   - What changed (3 bullet points)
   - Benefit by persona (1 sentence each for personas in scope)

3. Release notes — for engineering/changelog (technical, concise)

4. CX readiness checklist — pre-filled based on release tier

Do NOT invent competitor claims. Only use facts from DP-General-competitive-positioning.md.
```

## Known Limitations

- External-facing copy must be reviewed by PMM before publishing
- Competitive claims must be sourced from `DP-General-competitive-positioning.md` only
- What's New entry length: target 50–100 words — trim if longer
