---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /prototype-brief
audience: PM
---

# `/prototype-brief` — Generate a Prototype Brief from a PRD

## Purpose

Produces a detailed prototype brief from a PRD or feature description. The brief is optimized for passing to the Prototype Builder agent or a designer as the starting point for prototype creation.

## Required Inputs

```
/prototype-brief

[Paste PRD content or describe the feature]
Core Area: [CoreArea]
Primary user flow to demonstrate: [describe in 2–5 steps]
Tool preference: [Design Studio / Bolt / v0.dev — or leave blank for recommendation]
```

## Expected Output

A prototype brief containing:
1. Core user flow (step-by-step, specific)
2. Screens/states required (list each screen with key elements)
3. What the prototype must demonstrate to pass Gate 1
4. What can be mocked/static
5. A ready-to-use prompt for the specified prototyping tool

## Skill Body (Prompt)

```
Read the following files:
- 01_context/design-system/DP-General-component-library.md
- 01_context/design-system/DP-General-tokens.md
- 01_context/product-areas/[CORE_AREA]-context.md
- 01_context/personas-and-icps/DP-General-user-personas.md

Here is the feature to prototype:

[USER_INPUT]

Produce a prototype brief with:
1. The core user flow (numbered steps — specific, not vague)
2. Screens required: list each screen with the key UI elements visible
3. Gate 1 validation: what must this prototype demonstrate to satisfy Gate 1 reviewers?
4. What is OK to mock: list flows that do NOT need to be functional
5. Tool prompt: a ready-to-use prompt for [TOOL_PREFERENCE or recommended tool]

Include this in every tool prompt:
Design language: Dialpad purple as primary color, clean business UI,
system sans-serif font, professional card/table/modal patterns.
```

## Known Limitations

- Prototype quality depends on the tool used — Design Studio is recommended as the default tool
- Does not generate the prototype itself — produces the brief and tool prompt only
- Use `04_agents/pm/DP-General-prototype-builder/` for the full prototype generation workflow
