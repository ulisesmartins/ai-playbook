---
version: 1.0
last_updated: 2026-03-11
change_summary: "Initial version — sourced from Design Studio blog, Design Studio Developer Docs, UX Planet, and community research through March 2026"
status: GA
audience: PM, UI
---

# Design Studio — Best Practices

## What It Is

Design Studio is Dialpad's prompt-to-prototype AI capability, powered by Claude Sonnet under the hood. It converts natural-language descriptions and existing Design Studio frames into interactive, functional prototypes — including real data connections and React code output. It is not just a mockup tool; it produces working interfaces usable for stakeholder reviews and usability tests.

**Dialpad default use:** Rapid prototype generation for Gate 1 demos and concept validation. The default tool in `04_agents/pm/DP-General-prototype-builder/` and `03_skills/pm/DP-General-prototype-brief.md`.

---

## Setup

- Available on all paid Design Studio plans (AI credits included)
- Link your Dialtone design system: import color palette, typography, and token guidelines from your Design Studio library at minimum; publish a full npm package for full component fidelity (see below)
- Point context at `01_context/design-system/DP-General-component-library.md` and `01_context/design-system/DP-General-tokens.md` before generating Dialpad-specific prototypes

---

## Core Best Practices

### 1. Front-load all essential context in your first prompt
Design Studio performs far better when the initial prompt covers five dimensions:
- **Context** — who is the user, what is the goal
- **Description** — what the UI should do
- **Platform** — web, mobile, tablet
- **Visual Style** — minimal, enterprise, professional
- **UI Components** — tabs, cards, data tables, modals, sidebars

Treat the first prompt like a design brief.

### 2. Use scenario framing for complex or multi-screen flows
Start prompts with "Imagine you're a [role]..." or "Act as if you're building a [product] for [user type]..." This gives the underlying model a persistent persona and reduces drift across a long iterative session.

### 3. Break follow-up requests into small, scoped steps
Target one element at a time after the initial generation. "Move the CTA button below the form, make it full-width, and change the label to 'Continue'" in a single prompt produces cleaner results than asking for five changes simultaneously.

### 4. Clean your Design Studio file before importing frames
Frames you bring into Design Studio should have: Auto Layout applied, properly named layers, no orphaned components. Messy files produce misinterpreted output — Design Studio faithfully reconstructs what it reads, including structural mistakes.

### 5. Use Auto Layout correctly — it is the single most important input parameter
Every container intended for a prototype must have Auto Layout set, with correct fill/hug/fixed behaviors on child elements. Frames without Auto Layout lose responsiveness and structural logic in translation. Critical for responsive layouts targeting multiple breakpoints.

### 6. Import Dialtone styling tokens as a minimum — publish an npm package for full fidelity
At minimum: import Dialpad's color palette, type scales, and usage guidelines from the Design Studio library. For full fidelity, publish the Dialtone component library as a private npm package and link it to Design Studio. Without this, Design Studio generates generic UI that does not reflect Dialpad's design language.

When using the skills and agents in this repo, the Dialpad design prompt fragment is automatically included:
```
Design language: Clean, modern, business-focused.
Primary color: Dialpad purple (#7C3AED or similar brand purple).
Font: System sans-serif, clean hierarchy.
Components: Cards, tables, modals, sidebars, action buttons.
Tone: Professional, not playful.
```

### 7. Use Design Studio as a PRD validator, not just a visual generator
Paste key user flows from a PRD as prompts and see if Design Studio can render them without ambiguity. If it cannot, the requirement was under-specified. Use it to pressure-test feature definitions before engineering engagement.

### 8. Connect Supabase for demos that require real data
Design Studio's Supabase integration allows you to wire a prototype to a live or test backend. For features that depend on dynamic data (CRM contact lists, call queues, analytics dashboards), this is the difference between a mockup and a credible demo.

### 9. Use "create code from design" for frames already designed in Design Studio
For frames that exist in a polished design file, select the frame and use "create code from design" in Design Studio. Faster than re-prompting from scratch and preserves visual fidelity of completed design work.

### 10. Prompt edge cases explicitly
Design Studio will not invent empty states, error states, or truncated content unless asked.
- "Show what the card looks like when the contact name is missing"
- "Show the error state if the API call fails"
- "Show the empty state before any data is loaded"

### 11. Scope each Design Studio session to a single user flow
Import screens one logical flow at a time. Trying to load an entire product's screen inventory into one session creates noise and reduces Design Studio's ability to understand intent. One journey per session.

### 12. Publish configured Design Studio files as team templates
Once your Dialtone context is set up in a Design Studio file, publish it as a template. Team members start new prototypes from this pre-configured baseline rather than rebuilding context each time.

### 13. Treat Design Studio output as a demo artifact — not a developer handoff artifact
Design Studio's export limitations mean you cannot cleanly push generated output back into a structured design file for handoff. Plan your workflow so Design Studio produces a demo-ready prototype, while final developer handoff files are maintained separately in your core Design Studio workspace.

---

## Common Pitfalls

| Pitfall | Fix |
|---|---|
| Vague first prompt | Treat first prompt as a design brief; cover all five dimensions |
| Importing frames without Auto Layout | Apply Auto Layout to all containers before importing |
| No design system tokens | Import Dialtone tokens at minimum; full npm package for production fidelity |
| Over-scoping a single session | One logical flow per Design Studio session |
| Expecting Design Studio output as a handoff artifact | Design Studio is for prototyping; handoff files stay in core Design Studio |
| Not specifying edge cases | Always prompt for empty, error, and loading states explicitly |
