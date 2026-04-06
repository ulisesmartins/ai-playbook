---
version: 1.0
last_updated: 2026-03-12
change_summary: "Initial version — PM strategic tracking, assumption validation, OKR health, and launch learnings"
status: GA
audience: PM
---

# PM Longterm Agent

## Purpose

Maintains a living strategic tracker for the PM. Surfaces multi-quarter bets that need attention, validates assumptions from past PRDs, tracks OKR progress, maps cross-team dependencies, and archives launch learnings. Updated on a weekly or milestone cadence — not daily. Designed to hold the strategic context that doesn't fit in a sprint but must not get lost.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Core Area | ✅ | One of: Support, Connect, Sell, Ecosystem, SharedServices |
| Mode | ✅ | `read` (surface what needs attention) or `update` (add/revise entries) |
| Update content | If mode=update | Free text: new initiative, assumption result, OKR update, dependency change, or launch learning |

---

## Outputs

- **In `read` mode:** A structured attention brief — what's stale, what's at risk, what needs a decision
- **In `update` mode:** Updated longterm file with the new entry added, dated, and categorized
- **In both modes:** A prompt for the PM's next strategic action

---

## Orchestration Steps

### On every run

1. **Load context** — Load `01_context/company/DP-General-mission-and-strategy.md`, the relevant `01_context/product-areas/[CoreArea]-context.md`, and `01_context/company/DP-General-pm-ai-mindset.md`


3. **Determine mode** — Proceed to the `read` or `update` flow below

---

### `read` mode

4. **Scan for staleness** — For each section of the longterm file, flag entries that:
   - Have not been updated in more than 3 weeks
   - Reference a target date that has passed without a resolution
   - Reference a dependency or assumption that now appears resolved or invalidated based on recent close-day logs

5. **Surface at-risk items** — Across all sections, identify:
   - OKRs with less than 4 weeks to quarter end that are behind target
   - Strategic initiatives with no recent movement
   - Assumptions that have been open more than 2 sprints without validation
   - Cross-team dependencies with no update in 2+ weeks

6. **Generate attention brief** — Output:
   - **Needs decision this week:** items requiring a PM call to action
   - **At risk:** items that may slip without intervention
   - **Stale:** items with no update in 3+ weeks that should be closed or updated
   - **Healthy:** brief list of items tracking well (for PM confidence)

7. **Prompt next action** — Suggest the single most important strategic action the PM should take this week, with a rationale grounded in the longterm file content

---

### `update` mode

4. **Categorize the input** — Determine which section of the longterm file the new content belongs to:
   - New initiative → Strategic Initiatives
   - Assumption result (validated / invalidated) → Assumption Validation Log
   - OKR change or progress update → OKR Tracker
   - Dependency resolved or added → Cross-Team Dependencies
   - Post-launch reflection → Launch Learnings
   - Product principle or definitional decision → Product Definitions

5. **Write the entry** — Format and add it to the correct section with today's date. Standard entry formats per section are defined in the Handoff Format below.

6. **Check for cascading implications** — After adding the entry, scan for:
   - Other assumptions or initiatives affected by this update
   - OKRs impacted by a new dependency or launch result
   - Flag any detected cascading impacts for the PM's review

7. **Confirm and summarize** — Output: "Added [entry type] to [section]. [Any cascading impacts flagged]."

---

## Best Prompt/Agent Combination

**Best opening prompt (read):**

```
Read 01_context/company/DP-General-mission-and-strategy.md,
01_context/product-areas/[CoreArea]-context.md,

Mode: read
Core Area: [CoreArea]
Recent close-day logs: [paths or "none"]

Surface what needs my attention this week.
```

**Best opening prompt (update):**

```
Read 01_context/company/DP-General-mission-and-strategy.md,
01_context/product-areas/[CoreArea]-context.md,

Mode: update
Core Area: [CoreArea]
Update: [free text description of what to add — launch learning, OKR update, assumption result, etc.]
```

**Recommended model:** Claude Opus 4.6 — requires sustained reasoning across a large persistent document and strategic judgment.

---

## Longterm File Structure


### 1. Strategic Initiatives
Multi-quarter bets currently in flight. Each entry:
```
### [Initiative Name]
- Status: [Active / On Hold / Complete / Cancelled]
- Quarter target: [e.g., Q2 FY27]
- Last updated: [YYYY-MM-DD]
- Current state: [one paragraph]
- What's needed to advance: [bullets]
- Blockers: [bullets or "None"]
```

### 2. Assumption Validation Log
Assumptions from past PRDs — validated, invalidated, or still open.
```
| Assumption | Source PRD | Status | Evidence | Implication | Date |
|---|---|---|---|---|---|
| [text] | [PRD name] | Open / Validated / Invalidated | [data or observation] | [impact on current work] | [YYYY-MM-DD] |
```

### 3. Product Definitions
Durable product decisions and principles that should not be re-litigated without deliberate intent.
```
| Definition | Rationale | Date set | Owner |
|---|---|---|---|
| [e.g., "We don't build X because Y"] | [reasoning] | [YYYY-MM-DD] | [PM name] |
```

### 4. OKR Tracker
Current quarter's OKRs, progress state, and risks.
```
### [Objective]
- KR1: [text] — [current value] / [target] — [On Track / At Risk / Behind]
- KR2: [text] — [current value] / [target] — [On Track / At Risk / Behind]
- Risks: [bullets]
- Levers available: [what could move these KRs in the next sprint]
```

### 5. Cross-Team Dependencies
What the PM is blocking on and what they're blocking others on.
```
| Initiative | Blocked on | Team | Since | Status | Last contact |
|---|---|---|---|---|---|
| [feature] | [what's needed] | [team name] | [YYYY-MM-DD] | [Active / Resolved] | [YYYY-MM-DD] |
```

### 6. Launch Learnings
Post-launch reflections for each shipped feature.
```
| Feature | Launch date | Outcome vs. expectation | Surprise | What we'd do differently | Assumption validated/invalidated | Roadmap implication |
|---|---|---|---|---|---|---|
```

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| File grows too large to reason over | Longterm file not pruned | Archive completed/cancelled initiatives annually; keep active sections focused |
| Stale entries never flagged | Read mode not run regularly | Run in read mode at the start of each week or before quarterly planning |
| Assumptions never closed | No one validates them | In read mode, flag any assumption open >2 sprints as requiring an explicit validation decision |
| OKR section disconnected from work | Updated manually only | Cross-reference with close-day logs; surface alignment gaps |
| Launch learnings not captured | PM skips update after launch | Add a `/longterm update` to the post-launch checklist in `03_skills/cross-functional/DP-General-gtm-draft.md` |

---

## Handoff Format

The longterm file is self-contained and persistent. It does not feed into a next-agent handoff — it is a reference artifact the PM owns and updates over time. When running in `read` mode, the attention brief can optionally be referenced at the start of a `/start-day` session for strategic grounding.
