---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
audience: Coding
---

# Test Coverage Team — Full Coverage Audit for Critical Features

## Purpose

Runs a three-layer test coverage audit (unit, integration, end-to-end) on a feature before
GA gate submission. Each layer is reviewed independently, then consolidated into a coverage
gap report with specific test cases to write.

---

## Roles

| Role | Layer | Focus |
|---|---|---|
| Unit Test Reviewer | Component / function level | Vue component behavior, utility functions, computed properties, edge cases |
| Integration Test Reviewer | Service / API level | API contract, service dependency behavior, feature flag integration |
| E2E Test Reviewer | User flow level | Core user journeys, happy path, error paths, accessibility |

---

## Input Required

```
Feature: [FEATURE_NAME]
Core Area: [CORE_AREA]
Feature flag: [FLAG_NAME or "not used"]
JIRA story or AC list: [PASTE]
Existing test files: [list file paths or paste test file content]
Framework: [Vitest / pytest / Playwright]
Coverage target: [80% / 90% / "agent recommends"]
```

---

## Kickoff Prompt

```
Read the following files:
- 01_context/codebase-map/DP-General-key-patterns.md

You are running a test coverage audit for [FEATURE_NAME].

Feature flag: [FLAG_NAME]
Framework: [FRAMEWORK]
Coverage target: [COVERAGE_TARGET]

Acceptance criteria:
[AC_LIST]

Existing tests:
[EXISTING_TEST_CONTENT or "none"]

Three reviewers will independently audit a different test layer.

---

ROLE 1: UNIT TEST REVIEWER
Audit unit test coverage:
1. Is each Vue component tested for all props and emits?
2. Is computed property behavior tested (including edge inputs)?
3. Are utility functions tested for happy path, error, and boundary values?
4. Is the feature flag on/off state tested at the component level?
5. Are all error states (API failure, validation failure, empty state) tested?

For each gap: name the specific test case that is missing.
Format: MISSING TEST | describe block | it() description | what to assert

---

ROLE 2: INTEGRATION TEST REVIEWER
Audit integration test coverage:
1. Is the API contract tested? (Request format, response shape, error codes)
2. Are service dependencies mocked correctly? (No real network calls)
3. Is the feature flag behavior tested at the API level (not just UI)?
4. Is the permission boundary tested? (Admin vs. agent vs. supervisor access)
5. Are data edge cases covered? (Null values, max length, special characters)

For each gap: name the specific test case, the mock setup needed, and the assertion.

---

ROLE 3: E2E TEST REVIEWER
Audit end-to-end test coverage:
1. Is the primary happy path covered as an E2E flow?
2. Is the main error path covered (e.g., API failure during primary action)?
3. Are accessibility requirements verified in E2E? (Tab order, aria labels, keyboard nav)
4. Is the feature flag toggled in at least one E2E test?
5. Are there tests for mobile/tablet viewports if this feature is responsive?

For each gap: name the user story step being tested, the Playwright selector pattern,
and the assertion.

---

CONSOLIDATED COVERAGE REPORT:
1. Coverage summary: estimated % coverage by layer (unit / integration / e2e)
2. Gap table: Layer | Missing test | AC covered | Priority (blocker / high / medium)
3. Test file list: which files need new tests (name them by path convention from DP-General-index.md)
4. Recommended test writing order (highest risk gaps first)
```

---

## Handoff Format

Output of this session:
1. Coverage gap report (share with Coding lead)
2. Specific test cases to write (use with `/test-from-spec` to generate the actual tests)
3. Recommended test writing priority order

---

## Exit Condition

Session is complete when all three layers are audited AND the consolidated report is generated.
The team uses the gap report as input to `/test-from-spec` for test generation.

---

## Coverage Targets by Tier

| Release tier | Unit | Integration | E2E |
|---|---|---|---|
| T1 (complex/multi-quarter) | ≥90% | ≥80% | Core flows only |
| T2 (quarterly) | ≥80% | ≥70% | Happy path + main error |
| T3 (light/≤1 month) | ≥70% | Happy path | Optional |

---

## Known Limitations

- Coverage percentages are estimated from spec review — run `pnpm test --coverage` for actual numbers
- Cannot run existing tests — gap identification is based on spec and existing test structure review
- E2E test implementation requires Playwright setup in the target repo
