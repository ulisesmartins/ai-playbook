---
classification: DP-Official
path: 01_context/design-system/DP-General-tokens.md
last_updated: 2026-03-09
status: In Progress
---

# Dialpad Design System — Design Tokens (Dialtone)

## Purpose

Reference for Dialpad's design token system (Dialtone). Use when generating Design Studio specs, reviewing designs, or ensuring code implements correct token values. Load when any design or front-end engineering task requires color, spacing, or typography decisions.

> Documentation: [dialtone.dialpad.com/tokens](https://dialtone.dialpad.com/tokens/) | [Dialtone GitHub](https://github.com/dialpad/dialtone) | [Dialtone Tokens Guide — Confluence](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/952172556)

---

## 1. What Are Design Tokens?

Design tokens are named values that represent all the visual decisions in the design system: colors, spacing, typography, shadows, border radius, and more. They are the single source of truth shared between Design Studio and code.

**Why tokens matter:**
- Consistent visual language across all Dialpad products (1.0, 2.0, Meetings)
- Theme support: Light mode, Dark mode, and Expressive mode
- Platform-agnostic: tokens are published as CSS variables, iOS, and Android formats
- Theming: swap tokens to retheme a product without changing component code

---

## 2. Token Categories

### Color Tokens

Dialpad color tokens follow a **two-tier system**: base tokens → semantic tokens.

| Tier | Purpose | Example |
|---|---|---|
| Base tokens | Raw color stops (not used directly in UI) | `color/purple/400` |
| Semantic tokens | Contextual meaning (use these in UI) | `dt-color-foreground-primary` |

**Color semantic categories:**

| Category | Token Prefix | Use |
|---|---|---|
| Foreground | `dt-color-foreground-*` | Text, icons |
| Background | `dt-color-background-*` | Surfaces, containers |
| Border | `dt-color-border-*` | Input borders, dividers |
| Brand | `dt-color-brand-*` | Dialpad purple, accent colors |
| Feedback | `dt-color-feedback-*` | Success, warning, error, info states |
| AI | `dt-color-ai-*` | AI-specific accent colors (purple gradient) |

**Key rule:** Always use semantic tokens, not base color tokens. Replace any `color/purple/400` raw references with their semantic equivalent.

---

### Spacing Tokens

| Token Prefix | Use |
|---|---|
| `dt-space-*` | Padding, margin, gap values |
| `dt-size-*` | Component dimensions (height, width) |

Spacing follows a consistent scale. Do not hardcode pixel values — always reference a spacing token.

---

### Typography Tokens

Dialpad's typography system was refreshed in FY26 Q4 (Dialtone Next). New standard:

| Component | Token |
|---|---|
| Text styling | `DtText` Vue component (preferred over raw CSS utility classes) |
| Font families | Defined in `dt-font-family-*` tokens |
| Font sizes | Defined in `dt-font-size-*` tokens |
| Font weights | Defined in `dt-font-weight-*` tokens |
| Line heights | Defined in `dt-line-height-*` tokens |

**Migration note:** Legacy `recommend-typography-style` ESLint warnings indicate code using old font tokens. New code must use the updated typography token system.

---

### Shadow Tokens

| Token | Use |
|---|---|
| `dt-shadow-*` | Box shadows for cards, modals, dropdowns |

---

### Border Radius Tokens

| Token | Use |
|---|---|
| `dt-radius-*` | Component corner rounding |

Note: Border radius variables in Design Studio require custom build via the Design Studio REST API. Always confirm current token values in [dialtone.dialpad.com/tokens](https://dialtone.dialpad.com/tokens/).

---

## 3. Design Studio Token Libraries

| Library | Purpose | Link |
|---|---|---|
| DT9 Design Tokens (Light) | Core tokens — light mode | Enable in Design Studio Libraries panel |
| DT9 Design Tokens (Dark) | Dark mode token variants | Enable in Design Studio Libraries panel |
| DT9 Design Tokens (Expressive) | Expressive/vibrant theme | Enable in Design Studio Libraries panel |

**How to use in Design Studio:**
1. Open Assets panel → Libraries tab
2. Enable the relevant DT9 Design Tokens libraries
3. After enabling, remap any existing raw color values to semantic tokens
4. Use "Selection Colors" in the Properties Panel to audit and remap raw values

**Rebrand 2025 migration:** If working on a file using pre-2025 tokens, follow the [Design Studio Rebrand 2025 guide](https://dialpad.atlassian.net/wiki/spaces/DES/pages/1651343498) before handoff.

---

## 4. Code Distribution

Tokens are published via the `dialtone-tokens` package in the Dialtone monorepo:

```
packages/dialtone-tokens/    # Source
  dist/
    css/     → CSS custom properties (--dt-color-foreground-primary: ...)
    json/    → Platform-agnostic JSON
    ios/     → Swift/Obj-C constants
    android/ → XML resources
```

In CSS/Vue code:
```css
/* Use CSS custom properties */
color: var(--dt-color-foreground-primary);
padding: var(--dt-space-400);
```

In Vue components, Dialtone Vue components handle token application automatically via the component's built-in styles. Only apply raw tokens for custom layouts or one-off styling.

---

## 5. Token Adoption Status (as of FY26 Q4)

| Metric | Status |
|---|---|
| Overall token adoption | ~35% of codebase |
| Typography token adoption | ~2% (98% still on legacy font tokens) |
| ESLint warnings (`recommend-typography-style`) | High — actively increasing |
| Primary adoption blocker | Legacy font utility classes still being used in new code |

**Goal:** 100% token adoption across all Dialpad products. Migrations tracked in Dialtone OKRs.

---

## 6. Key Rules for AI Agents

When generating design specs, CSS, or reviewing Design Studio work:

1. **Always use semantic tokens** — never use base color tokens (`color/purple/400`) directly in UI specs
2. **Never hardcode hex/rgb values** — reference a token instead
3. **Typography:** Use `DtText` component for text styling; avoid raw CSS font utilities
4. **Dark mode:** If the feature has a dark mode requirement, confirm DT9 Design Tokens (Dark) library is enabled
5. **Validation:** Flag any code that uses hardcoded values where tokens exist

---

## 7. Related Files

| File | Relevance |
|---|---|
| `01_context/design-system/DP-General-component-library.md` | Dialtone Vue component reference |
| `01_context/pdlc/DP-General-handoff-standards.md` | Design Studio handoff standards including token requirements |
| [dialtone.dialpad.com](https://dialtone.dialpad.com) | Live documentation — always the source of truth for token values |
