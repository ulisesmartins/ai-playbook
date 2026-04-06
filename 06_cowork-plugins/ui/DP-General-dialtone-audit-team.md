---
version: 1.0
last_updated: 2026-03-13
change_summary: "Initial version"
status: GA
audience: UI, Coding
---

# Dialtone Audit Team — Component & Screen Token Compliance Audit

## Purpose

Audits a component or screen for Dialtone design system compliance across three dimensions:
token usage, accessibility standards, and component pattern consistency. Output is an
actionable audit report with specific violations and remediation steps.

---

## Roles

| Role | Perspective | Focus |
|---|---|---|
| Token Auditor | UI token compliance | Color, spacing, typography, shadow tokens; no hardcoded values |
| Accessibility Auditor | WCAG 2.1 AA | Contrast ratios, keyboard nav, screen reader labels, focus states |
| Pattern Auditor | Component consistency | Correct Dialtone component usage, variant selection, pattern reuse vs. one-offs |

---

## Input Required

```
Scope: [Component name / Screen name / Feature name]
Core Area: [CORE_AREA]
[Component code snippet, Figma description, or screen paste]
```

---

## Kickoff Prompt

```
Read the following files:
- 01_context/design-system/DP-General-tokens.md
- 01_context/design-system/DP-General-component-library.md

You are running a multi-role Dialtone compliance audit.

Scope: [SCOPE]
Core Area: [CORE_AREA]
Input: [CODE_OR_DESCRIPTION]

Run three parallel audits. Each audit is independent — do not reference the other audits
while writing. After all three are complete, produce a consolidated report.

---

ROLE 1: TOKEN AUDITOR
Audit for design token compliance:
1. Are all color values from --dt-color-* tokens? Flag any hardcoded hex, rgb, or oklch values.
2. Are all spacing values from --dt-space-* tokens? Flag any hardcoded px/rem values outside the scale.
3. Are typography values (size, weight, line-height) from --dt-font-* tokens?
4. Are box shadows using --dt-shadow-* tokens rather than custom box-shadow values?
5. Are border radii using --dt-radius-* tokens?

Output format:
- Violations (token path | current value | correct token | severity)
- Passed checks (brief evidence)
- Recommended remediation steps

---

ROLE 2: ACCESSIBILITY AUDITOR
Audit for WCAG 2.1 AA compliance:
1. Do all text/background color pairs meet 4.5:1 contrast (3:1 for large text)?
2. Are interactive elements keyboard-accessible and visible on focus?
3. Do interactive elements have accessible labels (aria-label, aria-labelledby, or visible text)?
4. Are error states communicated beyond color alone (icon + text)?
5. Are form inputs associated with labels?

Output format:
- Violations (element | issue | WCAG criterion | severity)
- Passed checks (brief evidence)
- Recommended remediation steps

---

ROLE 3: PATTERN AUDITOR
Audit for Dialtone component pattern consistency:
1. Are standard Dialtone components used where available (no custom re-implementations)?
2. Are component variants correct for the use case (e.g., primary vs. outlined button)?
3. Are any patterns proposed that duplicate existing Dialtone patterns?
4. Are loading and empty states using Dialtone skeleton / empty-state components?
5. Are any new patterns introduced? If so, is there a proposal to add them to Dialtone?

Output format:
- Violations (component | issue | correct pattern | severity)
- Passed checks (brief evidence)
- Recommended remediation steps

---

CONSOLIDATED REPORT:
After all three audits, produce:
1. Overall compliance status: Compliant / Minor Issues / Violations Found
2. Violation summary (table: Violation | Role | Severity | Remediation)
3. Top 3 priority fixes before this can ship
4. Any patterns flagged for a Dialtone contribution proposal
```

---

## Handoff Format

The output of this session is a compliance audit report. Designer and/or Engineer takes the report and:
1. Fixes token violations in the design file (Figma) and/or code (CSS/Vue)
2. Opens a Dialtone contribution issue for any new patterns identified
3. Shares accessibility violations with Coding for implementation review

---

## Exit Condition

Session is complete when all three role audits are done AND the consolidated report is produced.
A "Compliant" status does not mean zero notes — minor suggestions may remain.

---

## Known Limitations

- Token audit is based on the input provided — cannot crawl a full codebase or live Figma file
- Contrast ratios are calculated from described values; use a live contrast checker to verify
- Pattern audit reflects the Dialtone component library as documented in this repo — check dialtone.dialpad.com for the latest additions
