---
classification: DP-Official
path: 01_context/pdlc/DP-General-handoff-standards.md
last_updated: 2026-03-09
---

# Dialpad — Handoff Standards

## Purpose

Defines the expected artifacts and handoff standards between PM, Design, and Engineering at each PDLC stage. Consistent handoffs reduce rework, prevent scope drift, and make AI-assisted workflows reliably useful.

---

## 1. PM → Design Handoff (Entering Design Sprint)

**Entry condition:** Problem is well-defined; JTBD and personas are confirmed; business priority is clear.

### PM Delivers:

| Artifact | Format | Required For |
|---|---|---|
| Product Spec | Google Doc using PRD template | T1/T2 |
| Product Spec Lite | Short Google Doc | T2 light, T3 |
| JIRA Epic with requirements | JIRA | All tiers |
| Competitive summary | Inline in spec or linked doc | T1/T2 |
| Success metrics with baseline | Inline in spec | T1/T2 |
| Must-have vs. nice-to-have callouts | Inline in spec | T1/T2 |

### PM → Design Handoff Checklist:

- [ ] JTBD and user problem statement written (not just "build X feature")
- [ ] Target personas identified and linked to `01_context/personas-and-icps/`
- [ ] Scope defined: what is in, what is out
- [ ] Success metrics defined with baseline (e.g., "reduce CSAT escalations by 15%")
- [ ] Competitive context included
- [ ] Edge cases and failure modes noted
- [ ] JIRA epic created with acceptance criteria per story

---

## 2. Design → Engineering Handoff (After Gate 1)

**Entry condition:** Gate 1 approved by EPD Staff. Final flows, copy, and edge cases complete.

### Design Delivers:

| Artifact | Format | Required For |
|---|---|---|
| Design Spec | Design Studio file + Confluence doc | T1/T2 |
| Final flows (all states) | Design Studio — happy path + edge cases + error states | T1/T2 |
| Copy (final, not placeholder) | Inline in Design Studio | All tiers |
| Component callouts | Dialtone component names annotated | T1/T2 |
| Interaction notes | Design Studio annotations or Confluence | T1/T2 |
| Accessibility notes | Design Studio annotations | T1/T2 |
| Mobile specs (if in scope) | Separate Design Studio frames | When mobile is in scope |

### Design → Engineering Handoff Checklist:

- [ ] Design Studio file uses DT9 Component Library (not custom components where Dialtone exists)
- [ ] Design Studio file uses DT9 Design Tokens (not hardcoded colors or spacing)
- [ ] All flows include: empty state, loading state, error state, success state
- [ ] Copy is final (no "Lorem ipsum" or "TBD")
- [ ] Responsive breakpoints called out if web
- [ ] Annotation Library used for non-obvious interactions
- [ ] Design Studio file linked in JIRA epic or story

---

## 3. Engineering → QA Handoff

**Entry condition:** Feature is code-complete and passing unit tests. PR merged to staging.

### Engineering Delivers:

| Artifact | Format | Required For |
|---|---|---|
| Engineering Spec | Confluence or JIRA | T1/T2 |
| Engineering Spec Lite | JIRA comment or short doc | T2 light, T3 |
| Test instructions | JIRA acceptance criteria | All |
| Feature flag name | Documented in JIRA | All (if flagged) |
| Known limitations | Inline in JIRA | All |
| Rollback plan | Documented | T1/T2 |

### Engineering → QA Handoff Checklist:

- [ ] JIRA stories have explicit, self-validatable acceptance criteria
- [ ] Feature flag documented and confirmed working
- [ ] Test environment or staging link provided
- [ ] Known edge cases or test limitations called out
- [ ] Dependent stories or services confirmed deployed

---

## 4. AI-Assisted Spec Standards

When Claude Code or another agent produces specs or handoff artifacts:

### For Agent-Generated Specs:

- Load relevant `01_context/product-areas/` file before generating
- Use template from `02_templates/` as the structural skeleton
- Never let the agent invent feature flag names — use actual flags from JIRA or Engineering
- All acceptance criteria must be written so an agent can self-validate (specific, measurable, binary pass/fail)
- Validate persona references against `01_context/personas-and-icps/DP-General-user-personas.md`

### Agent-Executable Ticket Standards:

Each subtask must have:

| Field | Standard |
|---|---|
| **Entry criteria** | What must be true before this task starts |
| **Exit criteria** | What must be true for the task to be "done" — not "implement X" but "X works per acceptance criteria" |
| **Scope** | Scoped to ≤1 agent session (~4 hours of work) |
| **Ambiguity** | No "TBD" or "as discussed" — all decisions resolved before the ticket is written |

---

## 5. Design Studio Standards Reference

All Design Studio files must follow Dialpad standards. Detailed reference: `01_context/design-system/DP-General-component-library.md`

| Standard | Requirement |
|---|---|
| File structure | Use [Project File Template](https://dialpad.github.io/design-studio/#/) |
| Component library | DT9 Component Library (Rebrand 2025) |
| Design tokens | DT9 Design Tokens (Light + Dark if applicable) |
| Annotations | Dialpad Annotation Library |
| Documentation | Design Studio Documentation Patterns |
| Branching | Branch files before major library swaps |

---

## 6. Related Files

| File | Relevance |
|---|---|
| `01_context/pdlc/DP-General-phases-and-gates.md` | Full PDLC phase map and gate requirements |
| `01_context/pdlc/DP-General-design-gate-checklist.md` | Gate 1 detailed checklist |
| `01_context/design-system/DP-General-component-library.md` | Dialtone component reference |
| `02_templates/pm/DP-General-prd-template.md` | PRD structure for agent consumption |
| `02_templates/cross-functional/DP-General-jira-story-template.md` | Agent-executable story format |
