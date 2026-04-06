---
version: 1.0
last_updated: 2026-03-12
status: GA
author: Design team
---

# Design Handoff Notes Prompt

## Purpose

Generate structured engineering handoff notes from an annotated Design Studio spec or component description. Covers component names, props, accessibility attributes, and interaction behavior — ready to paste into Confluence or a JIRA ticket.

## When to Use

- Gate 2 handoff to Engineering
- When annotating a new component for DT9 contribution
- When writing a ticket description for a frontend implementation task

## Prompt

```
You are generating engineering handoff notes for a Dialpad frontend engineer.

Design input:
[PASTE Design Studio screen annotations, component spec, or visual description here]

For each screen or component described, produce handoff notes in the following format:

## [Screen / Component Name]

### Dialtone Components Used
| Component | Dialtone name | Variant / Props |
|---|---|---|
| Primary button | `DtButton` | `variant="primary" size="md"` |

### Accessibility Requirements
| Element | aria attribute | Value |
|---|---|---|
| Close button | `aria-label` | "Close [panel name]" |

### Interaction Behavior
| Trigger | Action | Result |
|---|---|---|
| Click "Save" button | POST /api/endpoint | Show success toast; dismiss modal |

### Feature Flag
`[feature_flag_name]` — this screen only renders when flag is ON.

### States
- Default: [describe]
- Loading: Show `DtSkeleton` while data loads
- Empty: [describe empty state]
- Error: Show `DtBanner` with error message

### Notes for Engineering
[Any implementation notes, known constraints, or questions for the engineer]
```

## Tips

- Always specify the feature flag name — Engineering needs this to scope their work
- If a required Dialtone component doesn't exist, flag it rather than suggesting a custom implementation
