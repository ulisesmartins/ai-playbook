---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /component-spec
audience: UI, Coding
---

# `/component-spec` — Produce a Component Spec from a Design Studio Frame or Description

## Purpose

Produces an engineering-ready component specification from a Design Studio frame description or screenshot. Spec includes component anatomy, props/variants, interaction states, accessibility requirements, and Dialtone component references.

## Required Inputs

```
/component-spec

Component name: [name]
Description: [what this component does and where it lives in the UI]
Design Studio frame: [URL or paste description of what you see]
Dialtone base component (if known): [e.g., dt-button, dt-input, or "custom"]
```

## Expected Output

A component spec containing:
1. Component anatomy (parts and their names)
2. Props and variants
3. All interaction states (default, hover, focus, active, disabled, loading, error)
4. Accessibility requirements (ARIA roles, keyboard nav, screen reader)
5. Dialtone components to use (from `01_context/design-system/DP-General-component-library.md`)
6. Design token references (from `01_context/design-system/DP-General-tokens.md`)
7. i18n considerations

## Skill Body (Prompt)

```
Read the following files:
- 01_context/design-system/DP-General-component-library.md
- 01_context/design-system/DP-General-tokens.md

Here is the component to spec:

Component name: [USER_INPUT]
Description: [USER_INPUT]
Design Studio/visual description: [USER_INPUT]
Dialtone base: [USER_INPUT]

Produce a component spec with:
1. Anatomy: list every named part of the component
2. Props/variants: all configurable properties (type, default, required)
3. States: default, hover, focus, active, disabled, loading, error, empty
4. Accessibility: ARIA role, keyboard nav, focus indicator, screen reader text
5. Dialtone references: which dt- components to use; do NOT use native HTML equivalents
6. Design tokens: specific CSS custom properties for colors, spacing, typography
7. i18n: list all user-facing strings that need translation keys

Do not invent component names. Check dialtone.dialpad.com/components first.
```

## Known Limitations

- Cannot see actual Design Studio files without Design Studio MCP configured
- Cannot guarantee Dialtone component availability — always verify at [dialtone.dialpad.com/components](https://dialtone.dialpad.com/components/)
- Token values may change — always validate against live docs at [dialtone.dialpad.com/tokens](https://dialtone.dialpad.com/tokens/)
