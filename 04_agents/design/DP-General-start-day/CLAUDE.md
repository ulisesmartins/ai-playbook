---
version: 1.0
last_updated: 2026-03-12
change_summary: "Initial version — Design daily start-of-day orientation with active work surface, feedback queue, and review prep"
status: GA
audience: UI
---

# Design Start Day Agent

## Purpose

Orients the designer for the day in under 5 minutes. Loads prior context, surfaces active Design Studio work and pending feedback, flags designs awaiting engineering handoff, and generates review prep for any scheduled design critiques or gate reviews.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Today's date | ✅ | YYYY-MM-DD |
| Active design work | ✅ | Feature names, Design Studio file names, or PRD references |
| Feedback received since last session | Optional | Free text or paste from Design Studio comments / Slack |
| Today's meetings | Optional | Design crits, gate reviews, handoff calls |

---

## Outputs

- **Priority stack** — 3–5 ranked design tasks with rationale
- **Feedback queue** — Outstanding feedback to address, sorted by urgency
- **Handoff status** — Any designs ready or near-ready for engineering handoff
- **Review prep** — Agenda or talking points for design crits or gate reviews
- **Open items from yesterday** — Unresolved feedback, pending decisions, open design questions
- **Focus question** — One question to prime the designer's creative intent for the day

---

## Orchestration Steps

1. **Load context** — Load `01_context/design-system/DP-General-component-library.md`, `01_context/design-system/DP-General-tokens.md`, and `01_context/personas-and-icps/DP-General-user-personas.md`

2. **Load yesterday's close-day log** — If provided, extract:
   - Outstanding feedback items and their status
   - Design decisions still open
   - Handoff readiness notes
   - Tomorrow's priority stack written at close
   - If no log exists, skip and note: "No prior close-day log found — starting fresh."

3. **Triage feedback queue** — From the provided feedback:
   - Separate feedback that requires design changes from feedback that is informational or already addressed
   - Rank by: (a) blocking an engineering handoff, (b) from a stakeholder who needs a response, (c) requires exploration/iteration, (d) nice-to-have refinement
   - Output as a prioritized list with one-line action per item

4. **Check handoff readiness** — For each active feature:
   - Is the design ready for engineering? (Annotated, Dialtone components used, responsive states covered)
   - Is anything missing that would block the engineer? (spec, edge case, error state, empty state)
   - Flag any feature where handoff is ready but hasn't happened yet

5. **Build priority stack** — Rank 3–5 items:
   - Feedback items blocking engineering handoff rank first
   - Designs due for a gate review or crit rank second
   - Exploration or iteration work ranks after committed deliverables

6. **Generate review prep** — For each scheduled meeting:
   - Design crit: list the 2–3 decisions the designer wants feedback on; describe what feedback is NOT needed (scope the critique)
   - Gate review: load `03_skills/cross-functional/DP-General-gate-review-checklist.md` and run a pre-flight check
   - Engineering handoff: list components, states, and interactions to walk through

7. **Surface open design questions** — Any question from the close-day log or active feedback that still requires a decision. Prompt the designer: "Which of these can you resolve independently today vs. needs alignment?"

8. **Close with a focus question** — "What is the one design decision, if made today, that would most unblock your work or your team?"

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
Read 01_context/design-system/DP-General-component-library.md,
01_context/design-system/DP-General-tokens.md,
and 01_context/personas-and-icps/DP-General-user-personas.md.

Start my day.

Date: [YYYY-MM-DD]
Active design work: [feature names or Design Studio file names]
Feedback received: [paste or "none"]
Prior close-day log: [path or "none"]
Today's meetings: [list or "none"]
```

**Recommended model:** Claude Sonnet 4.6.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Feedback queue too long | Designer hasn't processed feedback in several days | Batch-triage: sort all feedback into action/info/resolved first, then prioritize actions |
| Handoff flag missed | Engineer hasn't explicitly asked yet | Proactively flag: "Is there anything here that looks handoff-ready but hasn't moved yet?" |
| Review prep too broad | Crit scope not defined | Ask: "What 2–3 specific questions do you want the crit to answer?" |
| Design system gaps not surfaced | Component library not loaded | Always load component library at step 1 before reviewing active work |
