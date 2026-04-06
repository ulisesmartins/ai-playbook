---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version — outcome-oriented epic format with subtask structure and acceptance criteria"
status: GA
---

# JIRA Epic Template

> **Instructions for AI agents:** Use this template when generating JIRA epics from a PRD. Load `01_context/product-areas/[CoreArea]-context.md` and the PRD before generating. Each epic should represent a shippable unit of work — typically one feature or feature phase. Do NOT generate more than one epic per AI session.

---

## Epic: [Feature Name — Core Area]

### Summary (JIRA Title)
`[CoreArea] — [Feature Name]: [One-line outcome description]`

*Example: `Connect — Intelligent Admin: Agentic AI-powered universal settings search`*

---

### Description

#### What this epic delivers
*2–3 sentences. What will users be able to do when this epic is complete? Frame as an outcome, not a task list.*

#### Why we're building it
*1–2 sentences. Business driver or strategic priority. Reference FY27 priority if applicable.*

#### Who it affects
| Persona | Impact |
|---|---|
| [Persona 1] | |
| [Persona 2] | |

---

### Acceptance Criteria (Epic Level)

*High-level criteria that define "done" for the entire epic. Detailed story-level criteria go in each story.*

| # | Criterion |
|---|---|
| E-AC-1 | All stories in this epic are closed and QA-verified |
| E-AC-2 | Feature is behind feature flag and flag is confirmed working |
| E-AC-3 | [Core user flow] works end-to-end for [persona] in staging |
| E-AC-4 | No critical or high-severity bugs open at Gate 2 |
| E-AC-5 | Help Center article drafted and reviewed before GA |

---

### Stories (Subtask Breakdown)

*Each story must be independently executable by one engineer in ≤1 sprint. Do not include stories that cannot start until another is complete — sequence them correctly.*

| # | Story Title | Persona | Priority | Dependencies |
|---|---|---|---|---|
| 1 | [Story: specific unit of work] | | Must / Should / Nice | None |
| 2 | | | | Story 1 |
| 3 | | | | |
| 4 | [Story: error states and edge cases] | | Must | Story 1 |
| 5 | [Story: tests and coverage] | | Must | Stories 1–4 |

*See `02_templates/cross-functional/DP-General-jira-story-template.md` for individual story format.*

---

### Technical Notes

| Field | Value |
|---|---|
| Feature flag name | *Provided by Engineering — do not guess* |
| API changes | Yes / No — [describe if Yes] |
| Data migration required | Yes / No |
| Breaking changes | Yes / No |
| Performance considerations | |

---

### Dependencies

| Dependency | Team | Required by | Status |
|---|---|---|---|
| | | | Confirmed / Pending |

---

### Timeline

| Milestone | Target Date |
|---|---|
| Engineering kickoff | |
| Stories scoped and pointed | |
| Development complete | |
| QA sign-off | |
| Gate 2 (EAP) | |
| GA / Gate 3 | |

---

### Links

| Type | Link |
|---|---|
| PRD | |
| Design Studio | |
| Gate 1 deck | |
| Related epics | |

---

### Labels

*Use standard JIRA labels for the Core Area and quarter, e.g.: `FY27Q1-[core-area]`, `design-required`*

---

> **Agent validation checklist:**
> - [ ] Epic outcome is stated in terms of user capability, not engineering task
> - [ ] All stories are independently scoped (no story blocks another without explicit sequencing)
> - [ ] Feature flag field is not guessed — left for Engineering to fill
> - [ ] Acceptance criteria are binary pass/fail
> - [ ] Dependencies confirmed against `01_context/product-areas/` — no invented teams or systems
