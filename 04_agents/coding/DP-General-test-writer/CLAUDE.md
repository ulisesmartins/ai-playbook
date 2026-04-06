---
version: 1.0
last_updated: 2026-03-11
change_summary: "Initial version"
status: GA
audience: Coding
---

# Test Writer Agent

## Purpose

Generates tests from a spec or existing code. Produces unit tests that cover happy path, error states, and feature flag states. Outputs feed back into the engineering workflow for QA validation.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Component or function to test | ✅ | File path(s) or pasted code |
| Acceptance criteria | Optional (strongly recommended) | From JIRA story |
| Feature flag name | Optional | For testing both flag-on and flag-off paths |
| Test framework | Optional | Vitest (default for Vue 3), Jest, pytest |

---

## Outputs

Test file(s) that:
- Cover the happy path (expected behavior when everything works)
- Cover error states (API failures, invalid input, permission denied)
- Cover feature flag behavior (both enabled and disabled)
- Follow Dialpad's testing patterns from `01_context/codebase-map/DP-General-key-patterns.md`

---

## Orchestration Steps

1. **Load context** — Load `01_context/codebase-map/DP-General-key-patterns.md` and `01_context/codebase-map/DP-General-index.md`

2. **Read the code** — Load the file(s) to test. Identify:
   - What the component/function does
   - Its props, emits, and side effects (Vue) or parameters and return values (Python)
   - API calls made
   - Feature flags checked

3. **Clarify ACs** — If acceptance criteria are provided, map each AC to a test case. If not provided, generate tests from the code's observable behavior.

4. **Generate test cases list** — Before writing code, list the test cases:
   - Happy path test cases (1+ per main behavior)
   - Error state test cases (API failure, network error, validation error)
   - Edge case test cases (empty data, max values, permission boundaries)
   - Feature flag test cases (flag on → expected behavior; flag off → fallback or hidden)

5. **Write tests** — Follow Vue 3 + Vitest patterns (or specified framework):
   - Use `mount` from `@vue/test-utils` for Vue components
   - Mock API calls with `vi.mock()` — never make real network requests
   - Use `describe` / `it` / `expect` structure
   - Test behavior, not implementation (what the user sees, not internal state)

6. **Validate** — Run a self-check:
   - Each test has a clear assertion (`expect(x).toBe(y)`, not just `expect(x).toBeTruthy()`)
   - No tests that could never fail
   - No real API calls
   - Feature flag paths both covered

7. **Hand off** — Deliver test file(s) with placement instructions: "Save this file as `[component].test.ts` alongside the component. Run `pnpm test` to verify."

---

## Test Coverage Targets

| Coverage Type | Target |
|---|---|
| Happy path | 100% of main user flows |
| Error states | All API calls have at least one failure test |
| Feature flag | Both on and off tested for any flagged behavior |
| Edge cases | Empty state, max values, boundary conditions |
| Overall line coverage | ≥80% on new code |

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
Read 01_context/codebase-map/DP-General-key-patterns.md.

Here is the component/function to test:
[paste code or file path]

Acceptance criteria from JIRA:
[paste ACs or "not provided"]

Feature flag: [flag_name or "not used"]

1. List all test cases you plan to write before writing any code.
2. Wait for my approval.
3. Then write the full test file.
```

**Recommended model:** Claude Sonnet 4.6 — needs to understand Dialpad coding patterns to generate idiomatic tests.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Tests that test implementation not behavior | Accessing internal component state | Test via rendered output and emitted events, not `wrapper.vm.internalMethod()` |
| Tests that always pass | Weak assertions | Require specific `toBe()` / `toEqual()` assertions, not just `toBeTruthy()` |
| Missing error state tests | Only happy path generated | Explicitly prompt: "Write at least one test for the API failure case" |
| Wrong test framework | Framework not specified | Default to Vitest for Vue 3; confirm before generating |
| Real API calls in tests | Mock not applied | Always mock all `fetch`, `axios`, or service calls |

---

## Handoff Format

Deliver:
1. Test file with full path (`src/components/[name].test.ts`)
2. Summary: "N tests written — [X] happy path, [Y] error states, [Z] flag cases"
3. Run command: `pnpm test [path]`
4. Note any edge cases NOT covered and why: "These scenarios were not tested because [reason] — flagged for manual QA."
