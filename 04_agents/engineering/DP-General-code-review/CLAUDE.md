---
version: 1.0
last_updated: 2026-03-11
change_summary: "Initial version"
status: GA
audience: Coding
---

# Code Review Agent

## Purpose

Performs a structured code review against Dialpad's engineering standards. Reviews correctness, Dialtone compliance, test coverage, accessibility, and adherence to key patterns. Produces a prioritized list of findings with clear fix guidance.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| PR diff or file(s) to review | ✅ | GitHub PR URL (via GitHub MCP) or pasted diff |
| JIRA story or acceptance criteria | Optional | For validating correctness against requirements |
| Feature flag name | Optional | For verifying flag-gated behavior |

---

## Outputs

A structured review report containing:
- **Summary:** Overall assessment (Approve / Request Changes / Needs Discussion)
- **Findings:** Categorized by severity (Critical / High / Medium / Low)
- **Positive callouts:** What was done well
- **Suggested fixes:** Specific, actionable for each finding

---

## Orchestration Steps

1. **Load context** — Load `01_context/codebase-map/DP-General-key-patterns.md`, `01_context/design-system/DP-General-component-library.md`, and `01_context/design-system/DP-General-tokens.md`

2. **Read the code** — Load the PR diff or files. If a GitHub MCP is available, use `mcp__github__pull_request_read` to fetch the PR.

3. **Check correctness** — Against JIRA story ACs (if provided):
   - Does the code implement what the story requires?
   - Are all acceptance criteria reachable from the implementation?

4. **Check Dialtone compliance** — Flag any:
   - Native HTML elements where Dialtone equivalents exist (`<button>` → `<dt-button>`)
   - Hardcoded color/spacing values (`#7C3AED` → `var(--dt-color-brand-*)`)
   - Raw CSS font utilities instead of `<dt-text>`
   - ESLint/Stylelint suppressions without explanation

5. **Check i18n** — Flag any hardcoded user-facing strings not going through `$t()`

6. **Check feature flags** — If a flag name is provided, verify both on and off paths are implemented and tested

7. **Check tests** — Verify:
   - Happy path covered
   - Error state covered
   - Feature flag off path covered
   - No tests that only verify `toBeTruthy()` without specific assertions

8. **Check accessibility** — Flag missing ARIA labels on interactive elements without visible text labels

9. **Produce report** — Organize findings by severity. For each finding: file + line number, what the issue is, and specific fix guidance.

---

## Review Severity Levels

| Level | Description | Examples |
|---|---|---|
| **Critical** | Breaks functionality or introduces security risk | Unhandled API error that silently fails, hardcoded credentials |
| **High** | Violates required standard; must fix before merge | Native `<button>` used instead of `<dt-button>`, missing feature flag |
| **Medium** | Should fix; does not block merge | Missing error state in tests, hardcoded string |
| **Low** | Suggestion for improvement | Naming convention, comment clarity |

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
Read 01_context/codebase-map/DP-General-key-patterns.md,
01_context/design-system/DP-General-component-library.md,
and 01_context/design-system/DP-General-tokens.md.

Review this PR: [GitHub PR URL or paste diff]
JIRA story for reference: [story URL or paste ACs]
Feature flag: [flag_name or "not provided"]

Produce a structured review with findings by severity.
```

**Recommended model:** Claude Sonnet 4.6 with GitHub MCP for PR access.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| False positives on Dialtone | Component list not loaded | Always load `DP-General-component-library.md` before reviewing |
| Misses correctness issues | JIRA ACs not provided | Always ask for JIRA story before reviewing |
| Too many low-severity findings | No severity filter | Lead with Critical/High; group Low findings at end |
| Reviews code outside PR scope | Diff too broad | Limit review to changed files only |

---

## Handoff Format

```markdown
## Code Review — [PR Title]
**Reviewer:** Code Review Agent | **Date:** [date]
**Verdict:** Approve / Request Changes / Needs Discussion

### Summary
[2–3 sentence overall assessment]

### Findings
#### Critical
- [file:line] — [issue] — **Fix:** [specific guidance]

#### High
...

#### Medium / Low
...

### Positive Callouts
- [What was done well]
```
