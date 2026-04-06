---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
category: prototyping
audience: PM, UI
---

# UI from PRD — Generate a Working UI Prototype from a PRD or Spec

## Purpose

Converts a PRD (or selected sections) into a working UI prototype suitable for Gate 1 demo and
stakeholder review. Default tool is Design Studio — the agent selects the appropriate tool based on
complexity. The prototype must reflect Dialpad's design language (Dialtone tokens, component
patterns).

---

## Context to Load Before Running

- `01_context/design-system/DP-General-component-library.md`
- `01_context/design-system/DP-General-tokens.md`
- `01_context/personas-and-icps/DP-General-user-personas.md`
- The approved PRD for this feature

---

## Prompt Body

```
You are a Dialpad Design Engineer building a prototype for Gate 1 review.

Here is the PRD:
[PRD_CONTENT]

Core user flow to prototype: [PRIMARY_FLOW]
Primary persona: [PERSONA_NAME]
Prototype tool: [Design Studio / Bolt / v0.dev / "agent chooses"]
Fidelity: [Low / Mid / High]

Build a working prototype of [PRIMARY_FLOW]:

Design constraints:
- Use Dialtone design tokens for all colors: var(--dt-color-surface-primary),
  var(--dt-color-foreground-primary), etc.
- Use Dialtone component patterns: DtButton, DtInput, DtModal, DtBadge, DtAvatar
- Typography: font-size scale from Dialtone (--dt-font-size-200 through --dt-font-size-600)
- Corner radius: --dt-size-radius-300 for cards, --dt-size-radius-pill for chips/badges
- Spacing: 4px base grid (4, 8, 12, 16, 24, 32, 48px)
- Color: Never use hardcoded hex values — map to the nearest Dialtone semantic token

Screen requirements:
1. Happy path: The primary flow end-to-end with no errors
2. Empty state: What the screen looks like before any data exists
3. Error state: What happens when the primary action fails
4. Loading state: Skeleton or spinner while data loads

Label all interactive elements. Add a brief annotation explaining each screen's purpose.

If using Design Studio: Output as a Design Studio prompt block ready to paste.
If using Bolt: Output as a component tree with file structure.
If using v0.dev: Output as a v0 prompt block ready to paste.
```

---

## Variables

| Variable | Description | Example |
|---|---|---|
| `[PRD_CONTENT]` | Full PRD or relevant sections | Paste PRD text |
| `[PRIMARY_FLOW]` | The core user journey to demonstrate | "Coach reviewing AI CSAT score" |
| `[PERSONA_NAME]` | Primary persona from user-personas.md | "Supervisor/Coach" |
| `[FIDELITY]` | Low (wireframe), Mid (styled), High (pixel-perfect) | `Mid` |
| `[TOOL]` | Prototype tool | `Design Studio` |

---

## Usage Example

```
Core user flow to prototype: Supervisor views AI CSAT scores per agent in coaching dashboard
Primary persona: Supervisor/Coach
Prototype tool: Design Studio
Fidelity: Mid

[Paste PRD Section 4: Proposed Solution]
```

---

## Expected Output

1. Prototype code or prompt block (tool-specific format)
2. Screen annotation list (screen name + purpose + key interactions)
3. Design decisions log (any Dialtone token mappings or component choices that require PM/Design review)

---

## Known Limitations

- Generated prototypes are not production-ready — requires Design review before sharing externally
- Dialtone component availability varies by tool — some components may be approximated
- Cannot access live Design Studio — hand off to Design for high-fidelity Design Studio translation
- Prototype does not connect to real APIs — all data is mocked
