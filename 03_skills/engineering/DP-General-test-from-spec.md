---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /test-from-spec
audience: Coding
---

# `/test-from-spec` — Generate Tests from a Spec or Existing Code

## Purpose

Generates Vitest (Vue 3) or pytest (Python) tests from a spec or existing code. Covers happy path, error states, and feature flag behavior. Output feeds directly into the engineering review workflow.

## Required Inputs

```
/test-from-spec

[Paste code or file path to test]
Acceptance criteria: [paste from JIRA story or describe]
Feature flag: [flag_name or "not used"]
Framework: [vitest / pytest — default: vitest for .vue/.ts files]
```

## Expected Output

A complete test file with:
- Describe/it structure
- Mocked API calls (no real network requests)
- Happy path tests
- Error state tests (API failure, network error, validation)
- Feature flag on/off tests (if flag provided)
- Coverage: ≥80% on new code

## Skill Body (Prompt)

```
Read the following files:
- 01_context/codebase-map/DP-General-key-patterns.md

Here is the code/spec to test:

[USER_INPUT — code or spec]

Acceptance criteria:
[USER_INPUT — or "derive from code behavior"]

Feature flag: [USER_INPUT]
Framework: [USER_INPUT]

Before writing tests:
1. List all test cases you plan to write (happy path, error, flag states, edge cases).
2. Wait for confirmation before generating code.

When writing tests:
- Use vi.mock() to mock all API calls — no real network requests
- Test observable behavior (rendered output, emitted events) not internal state
- Every expect() must use a specific matcher (toBe, toEqual, toContain) — not just toBeTruthy()
- Cover: happy path, API failure, loading state, empty state, feature flag on, feature flag off
- Add a comment explaining what each describe block tests
```

## Known Limitations

- Cannot run tests directly — output requires `pnpm test [path]` to execute
- Cannot guarantee 100% coverage without seeing the full component — request specific coverage targets
- Python pytest output requires knowing the testing framework conventions of the specific service
