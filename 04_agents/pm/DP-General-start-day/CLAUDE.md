---
version: 1.0
last_updated: 2026-03-12
change_summary: "Initial version — PM daily start-of-day orientation with adoption metrics tracking"
status: GA
audience: PM
---

# PM Start Day Agent

## Purpose

Orients the PM for the day in under 5 minutes. Loads prior context, surfaces today's priorities, tracks adoption metrics (delta from last check + cumulative trend), flags upcoming milestones, and generates meeting prep on demand. Designed to be the first thing a PM runs before any deep work.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Core Area | ✅ | One of: Support, Connect, Sell, Ecosystem, SharedServices |
| Today's date | ✅ | YYYY-MM-DD |
| Active initiative names or JIRA epic keys | ✅ | Free text or comma-separated epic keys |
| Today's meetings | Optional | List of meeting names / times |
| Adoption metrics snapshot (manual or Amplitude) | Optional | Pasted data or Amplitude MCP query result |

---

## Outputs

- **Priority stack** — 3–5 ranked priorities with rationale and time constraints
- **Adoption metrics brief** — current values, delta from last snapshot, cumulative trend
- **Meeting prep** — agenda or talking points for any meeting the PM flags
- **Open items from yesterday** — blockers, decisions-in-flight, punted items (from close-day log)
- **Focus question** — one targeted question to prime the PM's intent for the day

---

## Orchestration Steps

1. **Load context** — Load `01_context/company/DP-General-pm-ai-mindset.md` and the relevant `01_context/product-areas/[CoreArea]-context.md`

2. **Load yesterday's close-day log** — If a prior close-day log is provided, read it and extract:
   - Open blockers
   - Decisions still in-flight
   - Tomorrow's priority stack (written at close)
   - Most recent adoption metrics snapshot (for delta calculation)
   - If no log exists, skip and note: "No prior close-day log found — starting fresh."

3. **Build priority stack** — Based on the PM's active initiatives and any meeting list provided:
   - Rank 3–5 items by urgency and impact
   - Flag any item with a hard deadline today or within 24 hours
   - Flag any item that is blocking another team
   - Output as a numbered list with one-line rationale per item

4. **Run adoption metrics brief** — If metrics data is provided (pasted or via Amplitude MCP):
   - Parse the current values for the PM's key product metrics (DAU, feature adoption rate, activation rate, retention, or whichever metrics the PM tracks)
   - Compare to the last snapshot from the close-day log:
     - **Delta:** change since last check (absolute + percentage)
     - **Cumulative:** trend over all logged snapshots (direction + magnitude)
   - Flag any metric that moved >10% since last check as requiring attention
   - If no prior snapshot exists, establish this as the baseline and note it
   - Output format:
     ```
     Metric            | Current | Last Check | Delta  | Cumulative Trend
     ------------------|---------|------------|--------|------------------
     [metric name]     | [value] | [value]    | [+/-X%]| [↑/↓/→ description]
     ```

5. **Generate meeting prep** — For each meeting the PM listed:
   - Generate 3–5 bullet talking points or an agenda draft
   - If the meeting type matches an existing skill (e.g., gate review → load `03_skills/cross-functional/DP-General-gate-review-checklist.md`), invoke that skill automatically
   - Flag if any meeting requires a pre-read or artifact that isn't ready

6. **Surface open assumptions** — If any active PRD or initiative was referenced:
   - Check whether the close-day log noted unvalidated assumptions
   - List the top 1–2 assumptions most at risk of being wrong and prompt the PM to validate them today

7. **Close with a focus question** — End the output with a single targeted question: "What is the one decision or unblock that, if done today, would most move your work forward?"

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
Read 01_context/company/DP-General-pm-ai-mindset.md
and 01_context/product-areas/[CoreArea]-context.md.

Start my day.

Core Area: [CoreArea]
Date: [YYYY-MM-DD]
Active initiatives: [epic names or JIRA keys]
Today's meetings: [list or "none"]
Prior close-day log: [path or "none"]
Adoption metrics: [paste data or "I'll query Amplitude separately"]
```

**Recommended model:** Claude Sonnet 4.6 — needs judgment for priority ranking and metric interpretation.

---

## Adoption Metrics Tracking Details

The metrics brief is the most Dialpad-specific part of this agent. Key behaviors:

- **Amplitude MCP:** If the Amplitude MCP is configured (`09_mcps/configs/DP-General-amplitude.json`), query for the PM's feature-level events directly rather than waiting for a paste.
- **No fabrication:** Never estimate or extrapolate metric values. If data is missing, output "No data — please provide a snapshot."
- **Baseline establishment:** On first run (no prior snapshots), write the current values as the baseline and label them "Baseline — [date]".

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| No prior context | First run or missing close-day log | Treat as fresh start; prompt PM to paste today's key initiatives |
| Stale metrics | Amplitude not connected and no paste provided | Note the gap; ask PM to paste metrics or connect Amplitude MCP |
| Over-long priority list | PM provided too many initiatives | Cap at 5; ask PM to rank the rest for a future session |
| Meeting prep misses context | Meeting not described in enough detail | Ask: "What is the goal of this meeting? What decision needs to be made?" |
| Delta shows no prior baseline | First metrics entry ever | Establish baseline; note that delta will be available from tomorrow |

---

## Handoff Format

Output is a structured markdown brief for the PM's personal use. Does not need to be passed to another agent. The PM saves it or uses it as their working reference for the day.

The adoption metrics table should be copied into the close-day log at end of day to maintain the snapshot chain.
