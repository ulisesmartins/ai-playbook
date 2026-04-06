---
version: 1.2
last_updated: 2026-03-12
change_summary: "Updated agent paths to reflect role-based subfolder reorganization"
status: GA
audience: PM, UI
---

# Prototype Builder Agent

## Purpose

Takes a PRD, design brief, or feature description and produces a working UI prototype — functional enough to demo the core user flow and pass Gate 1 review.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| PRD or design brief | ✅ | Markdown file from PRD Generator, or free text |
| Core user flow to prototype | ✅ | 2–5 steps describing the flow |
| Core Area | ✅ | One of: Support, Connect, Sell, Ecosystem, SharedServices |
| Target personas | ✅ | From `01_context/personas-and-icps/DP-General-user-personas.md` |
| Prototype tool preference | Optional | Design Studio (https://dialpad.github.io/design-studio/#/) |

---

## Outputs

A working prototype that:
- Demonstrates the primary user flow end-to-end
- Uses Dialpad's visual design language (Dialtone colors, typography conventions)
- Is shareable via URL for Gate 1 review
- Has an annotation explaining what is and is not functional

---

## Orchestration Steps

1. **Load context** — Load `01_context/design-system/DP-General-component-library.md`, `01_context/design-system/DP-General-tokens.md`, and the relevant `01_context/product-areas/[CoreArea]-context.md`

2. **Identify the core flow** — Confirm with the user: what is the single most important user flow this prototype must demonstrate? Limit to 3–5 steps.

3. **Generate prototype prompt** — Write a detailed prompt for the target prototyping tool including:
   - Dialpad design language (colors, components, typography)
   - Flow steps with specific screen descriptions
   - Persona and context (who uses this, where in the app)

4. **Iterate on output** — Review the generated prototype against the PRD. Flag any flows that are wrong or missing. Iterate max 3 times before escalating to human.

5. **Annotate** — Produce a plain-language annotation of:
   - What is functional in the prototype
   - What is mocked/static
   - What still needs Design polish before Gate 1

6. **Hand off** — "Prototype is ready. Use this for Gate 1 validation. To generate JIRA tickets from this prototype, start a new session with `04_agents/cross-functional/DP-General-jira-sync/CLAUDE.md`."

---

## Prototyping Tool Guidance

Use **Design Studio** for all prototyping at Dialpad.

> URL: https://dialpad.github.io/design-studio/#/
> Quick Start: https://dialpad.github.io/design-studio/#/docs/quick-start/README
> Requires a UXE or engineer on the team.


**Dialpad design prompt fragment (include in every Claude Code prompt for Design Studio):**
```
Design language: Clean, modern, business-focused.
Use real Dialtone Vue components (DtButton, DtInput, DtModal, etc.).
All colors must use var(--dt-color-*) tokens — no hex values.
All spacing must use var(--dt-space-*) tokens — no hardcoded px values.
Font: <dt-text> for all typography — not raw CSS font utilities.
Tone: Professional, not playful.
```

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
Read 01_context/design-system/DP-General-component-library.md and
01_context/product-areas/[CoreArea]-context.md.

I need a Design Studio prototype for: [feature name and core flow]
Target persona: [persona name]
Primary flow: [steps 1–5]

Generate the prototype using Dialpad Design Studio (https://dialpad.github.io/design-studio/#/)
with real Dialtone Vue components and tokens.
```

**Recommended model:** Claude Sonnet 4.6 — needs design judgment and UI pattern awareness.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Generic UI that doesn't look like Dialpad | Missing design language context | Always include Dialpad design prompt fragment |
| Prototype covers too many flows | Scope too broad | Limit to one core flow per prototype session |
| Prototype has wrong persona context | Persona not specified | Always specify persona and their starting point in the app |
| Tool output doesn't match PRD | PRD not loaded | Load PRD before generating prototype prompt |

---

## Handoff Format

Deliver to the user:

1. The prototype URL or file
2. A brief annotation (3–5 bullets): what works, what is mocked, what needs design polish
3. Instruction: "Validate this against your PRD acceptance criteria. If gaps exist, note them and iterate. When ready, use `04_agents/pm/DP-General-task-breakdown/` to break the PRD into engineering tasks."
