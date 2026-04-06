---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /spec-to-code-context
audience: Coding, PM
---

# `/spec-to-code-context` — Generate In-Code Context from a Spec

## Purpose

Converts a PRD section or feature spec into in-code context comments (TSDoc/JSDoc) that engineers and downstream agents can use to understand the business intent of a module without reading the full PRD. This is the primary handoff mechanism from PM/Design spec to Engineering agent workflows.

## Required Inputs

```
/spec-to-code-context

[Paste the PRD section, acceptance criteria, or feature spec]
Target file or module: [file path or module description]
```

## Expected Output

TypeScript/JavaScript TSDoc comments ready to insert at the top of the relevant file or component, containing:
- Business context: what this component/module does and why
- Target personas: who uses this
- Acceptance criteria reference (abbreviated)
- Feature flag name (if known)
- Links to PRD and Design Studio

## Skill Body (Prompt)

```
Read the following files:
- 01_context/codebase-map/DP-General-key-patterns.md

Here is the spec to convert to in-code context:

[USER_INPUT — PRD section or feature spec]

Target file/module: [USER_INPUT]

Generate TSDoc/JSDoc comments to insert at the top of the file:

/**
 * @module [ModuleName]
 * @description [What this module/component does — from the PRD]
 *
 * @businessContext
 * [Why this exists — from the PRD "Context & Problem" section]
 *
 * @targetPersonas
 * [List personas from DP-General-user-personas.md]
 *
 * @acceptanceCriteria
 * - AC-1: [key criterion]
 * - AC-2: [key criterion]
 *
 * @featureFlag [flag_name or "See Engineering"]
 *
 * @references
 * PRD: [link if provided]
 * Design Studio: [link if provided]
 */

Keep descriptions accurate to the spec — do not add functionality not in the spec.
```

## Known Limitations

- Feature flag name must come from Engineering — never generate
- PRD links and Design Studio links must be provided by the user — cannot retrieve them
- This produces comments only — does not modify the actual code
