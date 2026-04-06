---
version: 1.0
last_updated: 2026-03-12
status: GA
---

# Component Spec Template — [Component Name]

> **Instructions for AI agents:** Use the Dialtone MCP (`mcp__dialtone__search_components`, `mcp__dialtone__search_tokens`) to verify token names before writing them in. Do not use raw hex values — use `--dt-` tokens. Do not invent component names that don't exist in Dialtone.

---

## Header

| Field | Value |
|---|---|
| Component Name | |
| Dialtone base component | *e.g. DtButton, DtInput, DtModal — or "New" if not extending existing* |
| Designer | |
| Coding | |
| UI Studio link | |
| JIRA ticket | |
| Status | Draft / In Review / Approved |

---

## 1. Overview

*What does this component do? Who uses it? Where does it appear in the product?*

---

## 2. Anatomy

*Label each part of the component. Use the UI Studio link above for visual reference.*

| Part | Required? | Notes |
|---|---|---|
| [Part 1 — e.g. Label] | Yes | |
| [Part 2 — e.g. Icon] | No | |
| [Part 3 — e.g. Helper text] | No | Shown only in error state |

---

## 3. Variants

| Variant | Description | When to use |
|---|---|---|
| Default | | |
| [Variant 2] | | |
| [Variant 3] | | |

---

## 4. States

| State | Visual description | Notes |
|---|---|---|
| Default | | |
| Hover | | |
| Focus | | |
| Active / Pressed | | |
| Disabled | | |
| Loading | | |
| Error | | |
| Empty / Zero state | | |

---

## 5. UI Tokens

*Reference Dialtone tokens using `--dt-` prefix. Use the Dialtone MCP to confirm exact token names.*

| Property | Token | Value (for reference) |
|---|---|---|
| Background (default) | `--dt-color-surface-primary` | |
| Border | `--dt-color-border-default` | |
| Text | `--dt-color-foreground-primary` | |
| Border radius | `--dt-radius-300` | |
| Spacing (padding) | `--dt-space-400` | |
| Focus ring | `--dt-color-border-focus` | |

---

## 6. Accessibility

| Requirement | Implementation |
|---|---|
| ARIA role | |
| Keyboard navigation | |
| Focus management | |
| Screen reader label | |
| Color contrast | Minimum 4.5:1 (WCAG AA) |

---

## 7. Responsive Behavior

*How does the component behave at different breakpoints?*

| Breakpoint | Behavior |
|---|---|
| Mobile (<768px) | |
| Tablet (768–1024px) | |
| Desktop (>1024px) | |

---

## 8. Do / Don't

**Do:**
- 

**Don't:**
- 

---

## 9. Coding Notes

*Optional — for complex components, include notes on implementation considerations, API surface, or performance constraints.*

---

## 10. Open Questions

| # | Question | Owner | Target resolution |
|---|---|---|---|
| Q-1 | | | |
