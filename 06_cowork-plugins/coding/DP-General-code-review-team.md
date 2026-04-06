---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
audience: Coding
---

# Code Review Team — Multi-Reviewer Code Review Session

## Purpose

Runs a multi-role code review on a PR diff from two parallel perspectives: correctness and
maintainability (senior engineer) and security and data handling (security reviewer). Produces
a consolidated review report with severity-classified findings.

---

## Roles

| Role | Perspective | Focus |
|---|---|---|
| Senior Engineer Reviewer | Code quality | Correctness, patterns, test coverage, Dialtone compliance, performance |
| Security Reviewer | Security posture | Auth, input validation, data handling, API security, feature flag safety |

---

## Input Required

```
PR: [PR_NUMBER or URL]
JIRA story: [STORY_ID]
Core Area: [CORE_AREA]
Feature flag: [FLAG_NAME or "not used"]
[PR DIFF — paste or provide via GitHub MCP]
```

---

## Kickoff Prompt

```
Read the following files:
- 01_context/codebase-map/DP-General-key-patterns.md
- 01_context/codebase-map/DP-General-index.md
- 01_context/design-system/DP-General-component-library.md

You are running a multi-role code review.

PR: [PR_NUMBER]
JIRA: [STORY_ID]
Feature flag: [FLAG_NAME]

Here is the PR diff:
[PR_DIFF]

ROLE 1: SENIOR ENGINEER REVIEWER
Review for correctness and code quality:

1. CORRECTNESS
   - Does the code implement the JIRA ACs correctly?
   - Are edge cases handled (empty state, error state, permission boundary)?
   - Are TypeScript types correct? (No `any`, no implicit casts)
   - Are Vue 3 reactivity patterns used correctly? (computed vs. watch vs. ref)

2. PATTERNS
   - Does the code follow patterns in DP-General-key-patterns.md?
   - Are Dialtone components used instead of custom one-offs?
   - Are Dialtone tokens used for all colors/spacing? (No hardcoded values)
   - Is the feature flag pattern applied correctly?

3. TESTS
   - Are tests present for all ACs?
   - Are API calls mocked with vi.mock()?
   - Are happy path, error, empty, and flag states tested?

4. PERFORMANCE
   - Any obvious N+1 queries or unnecessary re-renders?
   - Large data sets handled with pagination or virtualization?

Output per finding: File | Line | Severity | Finding | Suggested fix
Severity: Critical / High / Medium / Low / Nitpick

---

ROLE 2: SECURITY REVIEWER
Review for security posture:

1. AUTHENTICATION & AUTHORIZATION
   - Is every API endpoint protected by auth middleware?
   - Are permission checks at the route level AND the data layer?
   - Can a user access another org's data through this code?

2. INPUT VALIDATION
   - Is user input validated and sanitized before use?
   - Are there SQL injection, XSS, or command injection risks?
   - Are file upload limits and type checks in place (if applicable)?

3. DATA HANDLING
   - Is PII logged? (Names, emails, phone numbers should not appear in logs)
   - Are API responses filtered to exclude fields the caller should not see?
   - Is sensitive config (API keys, secrets) coming from environment variables only?

4. FEATURE FLAG SAFETY
   - Does the feature flag correctly gate ALL new behavior (not just the UI)?
   - Can the flag be toggled without a restart (runtime-safe)?

Output: same format as Role 1

---

CONSOLIDATED REVIEW REPORT:
1. Summary: Approve / Request Changes / Block (Critical finding)
2. Finding table (all findings from both roles, sorted by severity)
3. Must-fix before merge (Critical + High)
4. Should-fix before merge (Medium)
5. Can-fix in follow-up (Low + Nitpick)
```

---

## Handoff Format

Output of this session:
1. Consolidated review report (post to GitHub PR as review comment)
2. Critical/High findings as individual line comments (via GitHub MCP if configured)

---

## Exit Condition

Session complete when both roles produce findings AND the consolidated report is generated.
The PR author must address Critical and High findings before merge.

---

## Severity Definitions

| Severity | Definition | Must fix before merge? |
|---|---|---|
| Critical | Security vulnerability, data integrity risk, production breakage | Yes — blocks merge |
| High | Incorrect AC implementation, missing auth check, no test coverage | Yes — blocks merge |
| Medium | Pattern violation, test gap, performance risk | Should — merge at author's discretion |
| Low | Style, naming, minor code quality | No — follow-up ticket acceptable |
| Nitpick | Preference, not a defect | No — comment only |
