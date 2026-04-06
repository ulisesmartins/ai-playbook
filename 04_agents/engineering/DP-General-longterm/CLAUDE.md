---
version: 1.0
last_updated: 2026-03-12
change_summary: "Initial version — Engineering strategic tracker for tech debt, ADRs, incident patterns, and reliability baselines"
status: GA
audience: Coding
---

# Engineering Longterm Agent

## Purpose

Maintains a living technical tracker for the engineer or engineering team. Tracks tech debt, records architecture decisions (ADRs), surfaces recurring incident patterns, monitors reliability baselines, and maps cross-team integration dependencies. Updated on a sprint or milestone cadence — not daily. Designed to hold strategic technical context that doesn't fit in a ticket but must not get lost.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Mode | ✅ | `read` (surface what needs attention) or `update` (add/revise entries) |
| Update content | If mode=update | Free text: new tech debt item, ADR, incident pattern, or baseline update |

---

## Outputs

- **In `read` mode:** Attention brief — what's growing in severity, what was supposed to be fixed, what patterns are repeating
- **In `update` mode:** Updated longterm file with the new entry added, dated, and categorized

---

## Orchestration Steps

### On every run

1. **Load context** — Load `01_context/codebase-map/DP-General-index.md` and `01_context/codebase-map/DP-General-key-patterns.md`

2. **Read the longterm file** — Load the file at the provided path. If it does not exist, create it with the standard structure (see Handoff Format) and note: "Longterm file initialized."

3. **Determine mode** — Proceed to the `read` or `update` flow

---

### `read` mode

4. **Scan for escalating tech debt** — Flag items:
   - Marked as High severity and not updated in 4+ weeks
   - Referenced in recent close-day logs as blockers or workarounds
   - Approaching a deadline or a point where remediation cost increases significantly

5. **Surface repeating incident patterns** — Look for:
   - The same service or component appearing in multiple incident entries
   - The same root cause class (e.g., memory leak, auth timeout, cache miss) across incidents
   - Flag for systematic fix if a pattern repeats 3+ times

6. **Check reliability baselines** — Compare current baseline values (if provided in recent close-day logs) against the recorded targets. Flag any metric tracking below target.

7. **Surface stale ADRs** — Flag any Architecture Decision Record that:
   - Was marked "Under Review" and has not been resolved in 2+ weeks
   - References a component that has since been significantly changed

8. **Generate attention brief** — Output:
   - **Needs action this sprint:** tech debt or incidents requiring a dedicated ticket
   - **Patterns to address:** recurring issues that should become a project
   - **Healthy:** what's stable and on track

---

### `update` mode

4. **Categorize the input** — Determine the correct section:
   - New tech debt → Tech Debt Tracker
   - Architecture or implementation decision → ADR Log
   - Incident observation → Incident Pattern Log
   - Reliability metric update → Reliability Baselines
   - Cross-team integration dependency → Dependency Map

5. **Write the entry** — Format and add it to the correct section with today's date

6. **Check for cascading implications** — Flag any other sections affected by this update

---

## Best Prompt/Agent Combination

**Best opening prompt (read):**

```
Read 01_context/codebase-map/DP-General-index.md,
01_context/codebase-map/DP-General-key-patterns.md,

Mode: read
Surface what needs engineering attention this sprint.
```

**Recommended model:** Claude Opus 4.6 — requires reasoning over a large persistent technical document.

---

## Longterm File Structure

### 1. Tech Debt Tracker
```
| Item | Severity (High/Med/Low) | Affected area | Created | Last updated | Status |
|---|---|---|---|---|---|
```

### 2. ADR Log
```
### ADR-[N]: [Decision title]
- Status: [Proposed / Accepted / Deprecated / Superseded by ADR-X]
- Date: [YYYY-MM-DD]
- Context: [why this decision was needed]
- Decision: [what was decided]
- Consequences: [trade-offs accepted]
```

### 3. Incident Pattern Log
```
| Pattern | Services involved | Occurrences | Root cause class | Systematic fix | Status |
|---|---|---|---|---|---|
```

### 4. Reliability Baselines
```
| Metric | Target | Current | Last updated | Trend |
|---|---|---|---|---|
| p99 latency | <200ms | [value] | [date] | ↑/↓/→ |
| Error rate | <0.1% | [value] | [date] | ↑/↓/→ |
```

### 5. Dependency Map
```
| Our service/component | Depends on | Team | Contract | Status | Last sync |
|---|---|---|---|---|---|
```

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Tech debt never actioned | Items added but not prioritized | In read mode, flag High severity items older than 4 weeks for immediate triage |
| ADR decisions re-litigated | ADR not referenced during code review | Reference the ADR log in the code review agent (`04_agents/engineering/DP-General-code-review/`) |
| Incident patterns missed | Incidents logged separately without cross-referencing | Run read mode after every 3rd incident to check for patterns |
| Reliability baselines stale | Engineer doesn't update at close of day | Add a baseline update prompt to close-day log template |
