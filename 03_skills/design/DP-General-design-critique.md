---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /design-critique
audience: UI
---

# `/design-critique` — Structured Critique of a Design or Prototype

## Purpose

Provides a structured, prioritized critique of a Design Studio design or prototype against Dialpad's design standards, accessibility requirements, and the JTBD/persona context from the PRD.

## Required Inputs

```
/design-critique

Design Studio link or prototype URL: [link]
PRD or feature description: [paste or describe]
Target personas: [list]
Gate target: [Gate 1 / Gate 2 / General review]
```

## Expected Output

A critique report with:
1. **Summary verdict:** Gate-ready / Needs work / Blocked
2. **Critical issues:** Must fix before Gate 1
3. **Important gaps:** Should fix; won't block Gate 1 but will cause feedback
4. **Suggestions:** Optional improvements
5. **Positive callouts:** What's working well

## Skill Body (Prompt)

```
Read the following files:
- 01_context/design-system/DP-General-component-library.md
- 01_context/design-system/DP-General-tokens.md
- 01_context/pdlc/DP-General-design-gate-checklist.md
- 01_context/personas-and-icps/DP-General-user-personas.md

Review the following design:
[USER_INPUT — Design Studio link or screenshot description]

PRD/feature context: [USER_INPUT]
Target personas: [USER_INPUT]
Gate target: [USER_INPUT]

Evaluate against:
1. Does it solve the JTBD stated in the PRD?
2. Are all required states present? (empty, loading, error, success)
3. Is copy final? (no Lorem ipsum or TBD)
4. Are Dialtone components used where they exist?
5. Are design tokens used? (no hardcoded colors or spacing)
6. Accessibility: ARIA labels on interactive elements without visible text?
7. Does it match the Gate 1 checklist from DP-General-design-gate-checklist.md?

Produce a structured report: Critical / Important / Suggestions / Positives
```

## Known Limitations

- Cannot see Design Studio files directly without Design Studio MCP configured (see `09_mcps/guides/DP-General-design-studio-setup.md`)
- Cannot verify Dialtone token usage in Design Studio without accessing the file — rely on screenshots for visual review
- Does not assess code quality — use `/spec-to-code-context` for engineering review
