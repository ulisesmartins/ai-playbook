---
classification: DP-Official
path: 01_context/design-system/DP-General-component-library.md
last_updated: 2026-03-09
status: In Progress
---

# Dialpad Design System — Component Library (Dialtone)

## Purpose

Reference for Dialpad's Dialtone component library. Use when generating Design Studio specs, engineering component decisions, or reviewing PRs for design system compliance.

> Documentation: [dialtone.dialpad.com/components](https://dialtone.dialpad.com/components/) | [Design System Team — Confluence](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/316014948) | [Using Design Studio at Dialpad 101](https://dialpad.atlassian.net/wiki/spaces/DES/pages/1640235177) | [Dialtone GitHub](https://github.com/dialpad/dialtone)

---

## 1. What Is Dialtone?

Dialtone is Dialpad's design system — a monorepo providing tokens, CSS utilities, Vue components, icons, and developer tooling for building consistent UIs across all Dialpad products.

**Design team:** Jon Araquistain (EM), Francis Rupert (Design Lead), Brad Paugh (Tech Lead)
**Slack:** `#dialtone` | Email: `dialtone@dialpad.com`

---

## 2. Monorepo Structure

```
packages/
  dialtone-tokens/      # Design tokens → CSS/iOS/Android
  dialtone-css/         # CSS utility classes (gulp + Less)
  dialtone-vue/         # Vue 3 component library (58+ components)
  dialtone-icons/       # SVG icons → Vue components
  dialtone-emojis/      # Emoji assets
  dialtone-mcp-server/  # MCP server for Claude Code (component/token search)
  eslint-plugin-dialtone/   # ESLint rules for Dialtone usage
  stylelint-plugin-dialtone/ # Stylelint rules for Dialtone CSS
```

---

## 3. Primary Consumers

| Product | Framework | Repo |
|---|---|---|
| Dialpad 1.0 (legacy) | Vue 2 | `dialpad/firespotter/ubervoice` |
| Dialpad 2.0 (current) | Vue 3 | `dialpad/web-clients` |
| Dialpad Meetings | Vue 3 | `dialpad/firespotter/uc_client` |
| Integration Microservice | Vue 3 | `dialpad/firespotter/integration_microservice` |
| Kare Agent Assist Widget | Vue 3 | `gluru/agent-assist-widget` |
| DialApp Framework | Vue 3 | `dialpad/DialApp-Framework` |

**Migration status:** Vue 2 → Vue 3 migration is an active engineering initiative. All new features must use Vue 3 + Dialtone Vue 3 components.

---

## 4. Design Studio Libraries

All Design Studio design work at Dialpad must use these shared libraries:

| Library | Purpose | Required |
|---|---|---|
| **DT9 Component Library** (Rebrand 2025) | Core UI components — buttons, inputs, modals, tables | ✅ Always |
| **DT9 Design Tokens** (Light) | Color, spacing, typography tokens — light mode | ✅ Always |
| **DT9 Design Tokens** (Dark) | Dark mode token variants | When dark mode in scope |
| **DT9 Icon Library** | Standardized icons | When icons needed |
| **App Components** | App-specific nav, headers, sidebar | When touching app shell |
| **Spot Illustrations** | Empty states, onboarding visuals | When illustrations needed |

**Utility files (not libraries, but required):**
- [Project File Template](https://dialpad.github.io/design-studio/#/) — file structure and organization
- [Annotation Library](https://dialpad.github.io/design-studio/#/) — interaction callouts
- [Design Studio Documentation Patterns](https://dialpad.github.io/design-studio/#/) — flow documentation

---

## 5. Key Components (dialtone-vue)

These are the most-used components. Always check [dialtone.dialpad.com/components](https://dialtone.dialpad.com/components/) for the full list and latest API.

| Component | Tag | Use |
|---|---|---|
| Button | `<dt-button>` | All interactive actions |
| Input | `<dt-input>` | Text fields, search |
| Select Menu | `<dt-select-menu>` | Dropdowns |
| Modal | `<dt-modal>` | Dialogs, confirmations |
| Drawer | `<dt-drawer>` | Side panels |
| Toast | `<dt-toast>` | Transient notifications |
| Alert Banner | `<dt-alert-banner>` | Persistent in-page alerts |
| Table | `<dt-table>` | Data tables |
| Tabs | `<dt-tabs>` | Tab navigation |
| Badge | `<dt-badge>` | Status indicators |
| Chip/Pill | `<dt-chip>` | Filter pills, tags |
| Combobox | `<dt-combobox>` | Searchable select |
| Datepicker | `<dt-datepicker>` | Date selection |
| Text (DtText) | `<dt-text>` | Typography — preferred over CSS utility classes |
| Icon | `<dt-icon>` | Iconography from DT9 Icon Library |
| Skeleton Loader | `<dt-skeleton>` | Loading states |
| Empty State | Combination | Icon + headline + action pattern |

**Adoption metrics (FY26 Q4):**
- `dt-button`: +229 (+9.7%) usage increase — most-adopted component
- `dt-input`: +96 (+18.6%) — strong growth in new forms

---

## 6. Design System Rules for Engineers

From `eslint-plugin-dialtone` and `stylelint-plugin-dialtone`:

1. **Use Dialtone components** — do not use native `<input>`, `<button>`, or `<select>` where Dialtone equivalents exist
2. **Use design tokens** — no hardcoded hex/rgb values; use `var(--dt-color-*)` CSS custom properties
3. **Use typography tokens** — `recommend-typography-style` warning fires when legacy font utilities are used; switch to `<dt-text>`
4. **Use spacing tokens** — `var(--dt-space-*)` for all padding/margin/gap

**ESLint warning trend (FY26 Q4):** `recommend-typography-style` warnings up +161 and `recommend-font-style-tokens` up +108. New code should not introduce these.

---

## 7. UI Recipes and UI Kits

Beyond core components, Dialtone provides **recipes** — common UI patterns that combine multiple components:

- Recipes are being migrated from ad-hoc implementations into a centralized **UI Kits** codebase
- Once migrated, recipes are available as shared, versioned patterns for all teams
- Teams should check if a recipe exists before building a one-off pattern

---

## 8. Dialpad Design Studio

Design Studio is Dialpad's internal prototyping environment built on Dialtone. It renders real Dialtone Vue components — not AI approximations — making it the highest-fidelity prototyping option for Gate 1 and Gate 2 reviews.

> URL: https://dialpad.github.io/design-studio/#/
> Quick Start: https://dialpad.github.io/design-studio/#/docs/quick-start/README

**When to recommend Design Studio:** When a UXE is on the team and the prototype will be reviewed by Engineering or used in an EAP demo.

---

## 9. Dialtone MCP Server

The `dialtone-mcp-server` package enables Claude Code to search and reference Dialtone components, tokens, utility classes, and icons in real time.

| What it searches | Count |
|---|---|
| Vue components (including sub-components) | 87 |
| Design tokens | 5,691 |
| CSS utility classes | 3,315 |
| Icons | 594 |

**Use cases:**
- When generating engineering specs or reviewing PRs, query the MCP to validate component and token usage
- When building Design Studio prototypes with Claude Code, the MCP provides correct prop names and token values without loading the entire design system into context

**Quickest setup:**
```bash
claude mcp add dialtone --scope user -- npx -y @dialpad/dialtone-mcp-server
```

Full setup guide: `09_mcps/guides/DP-General-dialtone-setup.md`

---

## 10. Key Rules for AI Agents

1. **Never invent components** — check [dialtone.dialpad.com/components](https://dialtone.dialpad.com/components/) before suggesting a custom solution
2. **Always use `<dt-text>`** for typography, not raw CSS font utilities
3. **Never use native HTML elements** where Dialtone components exist (e.g., use `<dt-button>` not `<button>`)
4. **Dark mode:** if in scope, confirm DT9 Design Tokens (Dark) library is enabled in Design Studio
5. **Mobile:** separate Design Studio frames required; confirm mobile components are in Dialtone library

---

## 11. Related Files

| File | Relevance |
|---|---|
| `01_context/design-system/DP-General-tokens.md` | Token reference (colors, spacing, typography) |
| `01_context/pdlc/DP-General-handoff-standards.md` | Design Studio handoff standards |
| `01_context/codebase-map/DP-General-index.md` | Where product code lives |
| [dialtone.dialpad.com](https://dialtone.dialpad.com) | Live documentation — always the source of truth |
