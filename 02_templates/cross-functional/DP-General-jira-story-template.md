---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version — story format sized for single-agent-session execution with explicit entry/exit criteria"
status: GA
---

# JIRA Story Template

> **Instructions for AI agents:** Use this template when breaking an epic into stories. Each story must be completable in a single engineering session (≤1 sprint, typically ≤3 days of work). If a story requires more, split it. Every acceptance criterion must be self-validatable by an agent or QA engineer — no ambiguity.

---

## Story: [Feature] — [Specific behavior or component]

### Summary (JIRA Title)
`[Verb]: [specific, scoped outcome]`

*Examples:*
- `Implement: Agent on-duty toggle with RNA state tracking`
- `Build: Credit balance API endpoint with isolated wallet support`
- `Fix: Monitor All view not reflecting agent RNA state in real time`

---

### Description

#### User Story
> As a **[persona]**, I want to **[specific action or capability]**, so that **[outcome / value]**.

#### Context
*1–2 sentences. Why this story exists. Which epic does it belong to? What comes before or after it?*

#### Scope
**In scope:**
- Specific behavior 1
- Specific behavior 2

**Out of scope (explicitly excluded):**
- Item 1 — deferred to [story #] or [later phase]

---

### Entry Criteria

*What must be true BEFORE this story can start. All must be met — no exceptions.*

- [ ] [Prerequisite story] is merged and deployed to staging
- [ ] Feature flag `[flag_name]` exists and is confirmed in CSR
- [ ] Design Studio spec for this component is approved and linked
- [ ] [Any required API or service] is available in staging

---

### Acceptance Criteria

*Each criterion must be binary: pass or fail. No "as expected" or "works correctly" — state exactly what is expected.*

| # | Criterion | Pass condition |
|---|---|---|
| AC-1 | [Component/element] renders when [condition] | Visible for [persona]; hidden for [other persona] |
| AC-2 | [Action] triggers [outcome] | [Specific behavior — e.g., "API call returns 200 within 500ms"] |
| AC-3 | Error state displays when [failure condition] | Specific error message: "[exact text]" |
| AC-4 | Feature is NOT accessible without feature flag enabled | Returns 404 / UI element absent when flag is off |
| AC-5 | Unit tests cover: happy path, error state, flag-off state | Test suite passes with ≥80% coverage on new code |

---

### Exit Criteria

*What must be true for this story to be marked "Done". All must be met.*

- [ ] All acceptance criteria above pass in staging
- [ ] Unit tests written and passing (happy path + error state + flag-off)
- [ ] Code reviewed and approved by at least one other engineer
- [ ] No critical/high-severity bugs open against this story
- [ ] Feature flag tested: both on and off paths verified
- [ ] QA sign-off from QA engineer

---

### Technical Notes

| Field | Value |
|---|---|
| Feature flag | |
| API endpoint(s) affected | |
| Components modified | |
| State management changes | |
| i18n strings needed | Yes / No |
| Accessibility requirements | |

---

### Design Reference

| Field | Value |
|---|---|
| Design Studio file | [link] |
| Specific frame/screen | [frame name or link] |
| Component(s) to use | [Dialtone component names — e.g., dt-button, dt-input] |

---

### Dependencies

| Dependency | Type | Status |
|---|---|---|
| | Story / API / Service / Design | Confirmed / Blocked |

---

### Story Points

*Estimated by Engineering during sprint planning. Leave blank until pointed.*

**Points:** ___

---

### Labels

*Standard labels, e.g.: `FY27Q1-support`, `design-required`, `feature-flag-required`*

---

> **Agent validation checklist:**
> - [ ] Story fits in ≤1 engineering sprint (3–5 days max)
> - [ ] Entry criteria list all blockers (no "implied" dependencies)
> - [ ] Every acceptance criterion has a specific, measurable pass condition
> - [ ] Exit criteria include unit tests AND QA sign-off
> - [ ] Feature flag field present — not guessed, left for Engineering
> - [ ] Dialtone component names used in design reference (not generic "dropdown" or "button")
