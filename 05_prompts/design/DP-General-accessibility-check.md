---
version: 1.0
last_updated: 2026-03-12
status: GA
author: Design team
---

# Accessibility Check Prompt

## Purpose

Check a UI design or component spec against WCAG 2.1 AA requirements and Dialpad accessibility standards. Outputs a prioritized list of issues with remediation guidance.

## When to Use

- Before submitting screens for Gate 1 or Gate 2 review
- When implementing a new component or pattern
- When a design is flagged in accessibility review

## Prompt

```
You are an accessibility expert reviewing a Dialpad UI design against WCAG 2.1 AA requirements.

Design input:
[PASTE design description, component spec, or screen annotation here]

Context:
- Product: Dialpad [Connect / Support / Sell / Admin Portal]
- Primary personas: [list from 01_context/personas-and-icps/DP-General-user-personas.md]
- Assistive technology scope: screen readers (NVDA, JAWS, VoiceOver), keyboard-only navigation, 200% zoom

Review the design for the following WCAG 2.1 AA criteria:
1. Color contrast (1.4.3): All text ≥4.5:1 contrast ratio; large text ≥3:1
2. Non-text contrast (1.4.11): UI components and graphics ≥3:1 against adjacent colors
3. Keyboard accessibility (2.1.1): All functionality operable via keyboard
4. Focus visible (2.4.7): Keyboard focus is always visible
5. Focus order (2.4.3): Focus order preserves meaning and operability
6. Name, Role, Value (4.1.2): All UI components have accessible names, roles, and states
7. Error identification (3.3.1): Errors are identified in text, not color alone
8. Labels or instructions (3.3.2): Form inputs have text labels
9. Resize text (1.4.4): Text resizes to 200% without loss of content or functionality
10. Images of text (1.4.5): Text is not presented as images

For each issue found:
- State the WCAG criterion violated (with number)
- Describe the specific element with the issue
- Rate severity: Critical (blocks task completion), Major (significant friction), Minor (annoyance)
- Provide specific remediation guidance using Dialtone DT9 tokens or components where applicable

End with a summary table of all issues sorted by severity.
```

## Expected Output

A structured accessibility audit with:
- Issue count by severity
- Per-issue description with WCAG criterion, element, and remediation
- Summary table sorted by severity
- Overall pass/fail for Gate 1 submission
