---
version: 1.0
last_updated: 2026-03-12
change_summary: "Initial version — Design end-of-day capture, design decision logging, feedback status, and handoff state"
status: GA
audience: UI
---

# Design Close Day Agent

## Purpose

Captures the designer's end-of-day state in under 5 minutes. Logs design decisions and their rationale, records outstanding feedback, tracks handoff readiness, drafts a standup-ready Slack message, and writes a structured log file that feeds tomorrow's `/start-day` session.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Day summary | ✅ | Free text: what was designed, reviewed, decided, or received feedback on |
| Today's date | ✅ | YYYY-MM-DD |
| Active feature names | ✅ | The features in active design work |
| Feedback status | Optional | What feedback was addressed, what's still open |
| Tomorrow's known commitments | Optional | Crits, gate reviews, handoff deadlines |

---

## Outputs

- **Design decision log entries** — Structured records for each design decision made today
- **Feedback log** — What was addressed, what's still open, what needs follow-up
- **Handoff status** — Which features moved closer to or reached handoff-ready state
- **Standup draft** — Slack-ready Yesterday / Today / Blockers message
- **Tomorrow's priority stack** — Pre-ranked list for the next `/start-day` session

---

## Orchestration Steps

1. **Parse the day summary** — Extract:
   - Design work progressed (explorations, iterations, final specs)
   - Decisions made on direction, component choice, interaction pattern
   - Feedback received and addressed
   - Handoff state changes
   - Blockers encountered

2. **Build design decision log entries** — For each design decision identified:
   ```
   Decision:        [what was decided — e.g., "Use modal for confirmation flow, not inline"]
   Rationale:       [why this approach — user need, constraint, pattern alignment]
   Alternatives:    [what else was explored]
   Trade-offs:      [accessibility, implementation complexity, pattern consistency]
   Design Studio reference: [file name / frame name, if applicable]
   Date:            [YYYY-MM-DD]
   ```
   If no decisions were made, note: "No design decisions logged."

3. **Log feedback status** — For each feedback item from today:
   - **Addressed:** What was changed and why
   - **Deferred:** What wasn't changed and why (with rationale, not just "skipped")
   - **Open:** What still needs a response or further exploration

4. **Update handoff readiness** — For each active feature, note:
   - Not ready: what's still missing
   - Near ready: what's the last thing needed
   - Ready: annotated and waiting for engineering to pick up

5. **Build tomorrow's priority stack** — Rank 3–5 items based on:
   - Handoff blockers that can be resolved tomorrow
   - Feedback that needs a design change
   - Upcoming gate review or crit prep

6. **Draft standup message** — Generate Slack-ready:
   ```
   *Yesterday:* [2–3 bullets of what was designed or reviewed]
   *Today:* [2–3 bullets from tomorrow's priority stack]
   *Blockers:* [active blockers or "None"]
   ```

7. **Write persistent log file** — Compile all sections into a markdown file and instruct the designer to save it as:

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
Close my day.

Date: [YYYY-MM-DD]
Active features: [feature names]
Here's what happened today: [free text]
Feedback status: [what was addressed and what's still open, or "none"]
Tomorrow's commitments: [list or "none"]
```

**Recommended model:** Claude Sonnet 4.6.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Decisions not captured | Summary focused on "what was done" not "what was decided" | Prompt: "Did you make any calls on pattern, component, or interaction approach today?" |
| Deferred feedback not logged | Designer said "handled" without specifics | Ask: "For each piece of feedback — was it implemented, or deliberately not? If not, why?" |
| Handoff state unclear | Feature is "almost ready" indefinitely | Ask: "What is the one thing preventing you from marking this handoff-ready right now?" |

---

## Handoff Format

```markdown
---
source: Design Close Day Agent
date: [YYYY-MM-DD]
next_step: Design Start Day (04_agents/design/DP-General-start-day/)
---

## Design Decisions
[decision log entries]

## Feedback Log
[addressed / deferred / open]

## Handoff Status
[per feature: not ready / near ready / ready]

## Tomorrow's Priorities
[ranked list]

## Standup Draft
[slack message]
```
