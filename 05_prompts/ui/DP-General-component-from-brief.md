---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
category: prototyping
audience: UI, Coding
---

# Component from Brief — Generate a Single UI Component from a Description

## Purpose

Generates a single, production-aligned Vue 3 UI component from a written description or design
spec. Uses Dialtone component library and tokens. Output is a working `.vue` file with props,
emits, accessibility attributes, and inline spec comments.

---

## Context to Load Before Running

- `01_context/design-system/DP-General-component-library.md`
- `01_context/design-system/DP-General-tokens.md`
- `01_context/codebase-map/DP-General-key-patterns.md`

---

## Prompt Body

```
You are a Dialpad Frontend Engineer building a Vue 3 component using the Dialtone design system.

Component description:
[COMPONENT_DESCRIPTION]

UI Studio reference: [DESIGN_STUDIO_URL or "not available"]
Parent context (where this component lives): [PARENT_CONTEXT]
Feature flag: [FLAG_NAME or "not used"]
Accessibility requirements: [WCAG_LEVEL — default AA]

Generate a Vue 3 single-file component (.vue) with:

Structure:
- <script setup lang="ts"> — Composition API, TypeScript
- <template> — semantic HTML with ARIA roles
- <style scoped> — using only Dialtone CSS custom properties

Props contract:
- Define all props with TypeScript types and JSDoc comments
- Required props must have no default; optional props must have explicit defaults
- Emit all user interactions as named events with typed payloads

Dialtone rules:
- Import and use Dialtone components (DtButton, DtInput, DtBadge, etc.) where applicable
- All colors via CSS custom properties: var(--dt-color-*)
- All spacing via: var(--dt-space-*) or 4px-grid multiples
- No hardcoded hex, px font sizes, or magic numbers
- Keyboard navigation: Tab focus order, Enter/Space for buttons, Escape to dismiss modals

Accessibility:
- aria-label or aria-labelledby on all interactive elements
- role attribute where semantic HTML is insufficient
- Focus management for modal/overlay components

Feature flag:
- If [FLAG_NAME] is provided: wrap new behavior in v-if="featureFlag('[FLAG_NAME]')"
- Export flag name as a constant comment at top of file

Add inline spec comments for any non-obvious behavior.
```

---

## Variables

| Variable | Description | Example |
|---|---|---|
| `[COMPONENT_DESCRIPTION]` | What the component does and looks like | "Card showing agent name, CSAT score, and trend sparkline" |
| `[DESIGN_STUDIO_URL]` | UI Studio frame URL for reference | `https://dialpad.github.io/design-studio/#/` |
| `[PARENT_CONTEXT]` | Where this renders in the app | "Inside coaching dashboard sidebar" |
| `[FLAG_NAME]` | Feature flag gating this component | `dp_coaching_csat_card_v2` |

---

## Usage Example

```
Component description: A call quality indicator badge that shows Good/Fair/Poor based on
MOS score. Displays as a colored pill with an icon. Clicking it opens a tooltip with
breakdown (packet loss, jitter, latency).

Parent context: Call detail view header
Feature flag: dp_call_quality_indicator
Accessibility requirements: WCAG AA
```

---

## Expected Output

1. Complete `.vue` SFC file with script setup, template, and scoped styles
2. Props/emits interface as a TypeScript comment block
3. Usage example snippet showing how to import and use the component
4. List of Dialtone tokens used (for UI review)

---

## Known Limitations

- Cannot verify exact Dialtone component API surface without live package access
- Complex animations require Dialtone motion tokens — may need manual adjustment
- Generated component must pass `pnpm lint` before PR — ESLint and Stylelint rules apply
- Cannot guarantee pixel-perfect match to UI Studio without human design review
