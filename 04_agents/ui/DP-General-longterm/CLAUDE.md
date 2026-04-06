---
version: 1.0
last_updated: 2026-03-12
change_summary: "Initial version — UI strategic tracker for design system contributions, research insights, and pattern library"
status: GA
audience: UI
---

# UI Longterm Agent

## Purpose

Maintains a living strategic tracker for the designer or design team. Tracks design system contributions, archives research insights and usability findings, records patterns and anti-patterns discovered in shipped work, and maps cross-discipline dependencies. Updated on a milestone or quarterly cadence — not daily.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Mode | ✅ | `read` (surface what needs attention) or `update` (add/revise entries) |
| Update content | If mode=update | Free text: new research insight, pattern, design system contribution, or dependency |

---

## Outputs

- **In `read` mode:** Attention brief — stale research, unresolved patterns, design system gaps
- **In `update` mode:** Updated longterm file with new entry added, dated, and categorized

---

## Orchestration Steps

### On every run

1. **Load context** — Load `01_context/design-system/DP-General-component-library.md`, `01_context/design-system/DP-General-tokens.md`, and `01_context/personas-and-icps/DP-General-user-personas.md`

2. **Read the longterm file** — Load the file at the provided path. If it does not exist, create it with the standard structure (see Handoff Format) and note: "Longterm file initialized."

3. **Determine mode** — Proceed to the `read` or `update` flow

---

### `read` mode

4. **Scan for stale research** — Flag any research insight that:
   - Is older than 2 quarters and has not been referenced in a recent PRD or design decision
   - Was flagged as needing follow-up validation and has no update

5. **Surface unresolved patterns** — Flag any pattern entry marked as "Under discussion" or "Inconsistent across product" with no resolution in 4+ weeks

6. **Check design system contribution status** — Flag:
   - Components proposed for the design system that have not been submitted or reviewed
   - Token or style decisions made locally that should be standardized

7. **Surface cross-discipline dependency gaps** — Any design that has been ready for engineering handoff for 2+ weeks without being picked up

8. **Generate attention brief** — Output:
   - **Needs action this sprint:** unresolved patterns, stale design system contributions
   - **Research to revisit:** insights that may inform current or upcoming work
   - **Healthy:** stable patterns, shipped components, active research

---

### `update` mode

4. **Categorize the input** — Determine the correct section:
   - Research finding or usability observation → Research Insights
   - Pattern that worked or failed → Pattern Library
   - New or proposed component → UI System Contributions
   - Cross-discipline handoff or dependency → Dependency Map

5. **Write the entry** — Format and add it to the correct section with today's date

6. **Check for cascading implications** — Flag any other patterns or components affected by this update

---

## Best Prompt/Agent Combination

**Best opening prompt (read):**

```
Read 01_context/design-system/DP-General-component-library.md,
01_context/design-system/DP-General-tokens.md,

Mode: read
Surface what needs design attention this sprint.
```

**Recommended model:** Claude Opus 4.6.

---

## Longterm File Structure

### 1. Research Insights
```
| Insight | Source | Date | Personas affected | Referenced in | Status |
|---|---|---|---|---|---|
| [finding] | [study / interview / analytics] | [YYYY-MM-DD] | [persona names] | [PRD or feature] | Active / Stale |
```

### 2. Pattern Library
```
### [Pattern name]
- Status: [Established / Under discussion / Deprecated]
- When to use: [context]
- When NOT to use: [counter-examples]
- Dialtone component: [component name or "None — custom"]
- Last updated: [YYYY-MM-DD]
```

### 3. UI System Contributions
```
| Component / Token | Proposal status | Submitted to | Date | Outcome |
|---|---|---|---|---|
| [name] | [Proposed / In review / Accepted / Rejected] | [design system team] | [YYYY-MM-DD] | [result or "Pending"] |
```

### 4. Dependency Map
```
| Feature | Waiting on | Team / Person | Since | Status |
|---|---|---|---|---|
| [feature] | [design spec / research / eng capacity] | [name] | [YYYY-MM-DD] | [Active / Resolved] |
```

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Research insights never revisited | Added once, forgotten | Run read mode at the start of each quarter or before PRD drafting for a related feature |
| Pattern library has contradictions | Multiple designers adding patterns independently | Review in read mode before each major design initiative; reconcile conflicting entries |
| UI system contributions stall | No follow-up after proposing | Flag in read mode after 4 weeks with no update; escalate to design system team |
