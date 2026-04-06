---
version: 1.2
last_updated: 2026-03-12
change_summary: "Added Dialpad Design Studio as the highest-fidelity prototyping option for UXEs; updated tool selection guide to distinguish Design Studio (real Dialtone components) from Design Studio (AI-generated approximation)"
status: GA
audience: UI
---

# Recommended AI Tools for Designers at Dialpad

## Overview

This guide lists the AI tools Dialpad Designers use across the design lifecycle —
from brief intake through handoff. Each entry covers the recommended use case, Dialtone
alignment notes, and how it connects to the AI Playbook.

**Daily baseline:** Most designers default to **Glean + Gemini** for everyday work.
Design Studio + Claude Code layer on for structured design workflows.

---

## Primary Tools by Workflow

### 1. Glean
**Best for:** Finding internal context — prior design explorations, past briefs, research
artifacts, competitive references, and cross-app search across Drive, Confluence, and Jira.

Use Glean before starting a new design to check for existing explorations and avoid
duplicating prior work.

---

### 2. Gemini
**Best for:** Everyday writing — summarizing research notes, drafting design rationale,
writing handoff annotations, generating alt text. Gemini is built into Gmail, Docs, Sheets,
and Drive so no context switching is required.

Not recommended for Dialpad-specific component specs or design critiques — use Claude Code
for those.

---

### 3. Claude Code (claude.ai/code)
**Best for:** Design brief generation, component spec drafting, design critique, Gate 1 prep

Claude Code runs the skills in `03_skills/design/` as slash commands. Key design skills:

| Workflow | Skill |
|---|---|
| Generate a design brief from PRD | `/design-brief` |
| Critique a design against Dialtone | `/design-critique` |
| Write a component spec | `/component-spec` |
| Check Gate 1 readiness | `/gate-review-checklist` |
| Convert spec to code context | `/spec-to-code-context` |

**Setup:** Install Claude Code CLI, open `DPAIPlaybook` as your working directory.
Load `01_context/design-system/` files when running design-related skills.

---

### 4. Dialpad Design Studio
**Best for:** High-fidelity interactive prototypes using real Dialtone Vue components — the highest-fidelity prototyping option available at Dialpad

> URL: https://dialpad.github.io/design-studio/#/
> Quick Start: https://dialpad.github.io/design-studio/#/docs/quick-start/README
> **Requires:** UXE or engineer on the team

Design Studio prototypes render actual Dialtone components (`DtButton`, `DtInput`, `DtModal`, etc.) with real tokens and interactions. Unlike Design Studio or v0.dev, there is no AI approximation — the output looks and behaves exactly like the production product.

**When to use Design Studio:**
- Gate 1 or Gate 2 reviews where Engineering will build directly from the prototype
- EAP demos where customers interact with the UI
- Any prototype that must demonstrate real component behavior (validation states, focus management, accessibility)

**When NOT to use:** Quick internal alignment or early-stage concepts where no UXE is available.


---

### 5. Design Studio (with AI plugins)
**Best for:** High-fidelity UI design, component work in Dialtone, prototype annotation,
and AI-powered layout assistance

Design Studio is Dialpad's primary design tool. Key AI-assisted workflows:

- **Design Studio AI plugins** — Auto-layout suggestions, content generation, accessibility checks.

**Dialtone Design Studio Libraries to enable (DT9):**
- `DT9 Component Library Rebrand 2025`
- `DT9 Design Tokens`
- `DT9 Icon Library`

---

### 5. Maze / UserTesting
**Best for:** Unmoderated usability testing on Design Studio prototypes

Run usability tests after Gate 1 feedback and before Gate 2. Export results as a research
summary to include in the PRD Appendix for gate review evidence.

---

### 6. Dialtone MCP Server (dialtone-mcp-server)
**Best for:** Querying the Dialtone component library from within Claude Code

When configured, the `dialtone-mcp-server` gives Claude Code live access to Dialtone
component API surface, token values, and usage examples. This improves accuracy when using
`/component-spec` and `/spec-to-code-context`.

See `09_mcps/` for setup information.

---

## Tool Selection Guide

| I need to... | Use this |
|---|---|
| Find prior design explorations or research | Glean |
| Summarize research notes or draft handoff copy | Gemini (in Docs / Gmail) |
| Generate a design brief | Claude Code + `/design-brief` |
| Create a prototype (Gate 0.5, Gate 1, Gate 2) | **Design Studio** (UXE required) — https://dialpad.github.io/design-studio/#/ |
| Build high-fidelity screens | Design Studio + Dialtone DT9 libraries |
| Critique a design against Dialtone | Claude Code + `/design-critique` |
| Write component spec for Engineering | Claude Code + `/component-spec` |
| Look up Dialtone component props or tokens | Dialtone MCP (via Claude Code) |
| Run usability testing | Maze or UserTesting |
| Check Gate 1 readiness | Claude Code + `/gate-review-checklist` |

---

## Dialtone Design Rules (Always Active)

1. Every color must map to a Dialtone semantic token — never use hardcoded hex
2. Use DT9 components from the Design Studio library — do not create one-offs that duplicate existing components
3. All interactive elements require accessible names (WCAG AA minimum)
4. Annotate designs with Dialtone component names before Engineering handoff
5. Run contrast check on all foreground/background pairs before submitting to Gate 1

---

## Getting Started

1. Install Claude Code and open `DPAIPlaybook`
2. Enable Dialtone DT9 libraries in your Design Studio team
3. Set up the Dialtone MCP server: `09_mcps/guides/DP-General-dialtone-setup.md`
5. Run `/design-brief` after receiving a PRD from PM
6. For high-fidelity prototypes, contact your UXE to set up Design Studio: https://dialpad.github.io/design-studio/#/
