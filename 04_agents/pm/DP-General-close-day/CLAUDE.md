---
version: 1.0
last_updated: 2026-03-12
change_summary: "Initial version — PM end-of-day capture, decision logging, standup draft, and adoption metrics snapshot"
status: GA
audience: PM
---

# PM Close Day Agent

## Purpose

Captures the PM's end-of-day state in under 5 minutes. Logs decisions made, summarizes accomplishments and blockers, snapshots adoption metrics, drafts a standup-ready Slack message, flags upcoming milestones, and writes a structured log file that feeds tomorrow's `/start-day` session. The output file is the primary mechanism for maintaining continuity across Claude sessions.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Day summary | ✅ | Free text: "what happened today" — decisions, meetings, progress, blockers |
| Core Area | ✅ | One of: Support, Connect, Sell, Ecosystem, SharedServices |
| Today's date | ✅ | YYYY-MM-DD |
| Adoption metrics snapshot | Optional | Current metric values to store for tomorrow's delta |
| Tomorrow's known commitments | Optional | Meetings, deadlines, or dependencies due |

---

## Outputs

- **Decision log entries** — Structured records for each product decision made today
- **Accomplishments + blockers** — What moved, what's stuck, what was deprioritized
- **Adoption metrics snapshot** — Current values stored for tomorrow's delta calculation
- **Tomorrow's priority stack** — Pre-ranked list for the next `/start-day` session
- **Standup draft** — Slack-ready Yesterday / Today / Blockers message
- **Milestone flag** — Alert if a Gate, release, or customer commitment is within 3 business days

---

## Orchestration Steps

1. **Load context** — Load `01_context/company/DP-General-pm-ai-mindset.md`

2. **Parse the day summary** — Extract from the PM's free-text input:
   - Decisions made (look for "we decided", "agreed to", "resolved", "going with")
   - Work that moved forward
   - Blockers encountered
   - Items deprioritized and why

3. **Build decision log entries** — For each decision identified:
   ```
   Decision:          [what was decided]
   Rationale:         [why this option over others]
   Alternatives:      [what else was considered]
   Stakeholders:      [who was involved or informed]
   Date:              [YYYY-MM-DD]
   Next action:       [what this decision unlocks or requires]
   ```
   If no decisions were made today, note: "No product decisions logged."

4. **Write accomplishments + blockers** — Produce three short sections:
   - **Moved:** What advanced today (tickets, conversations, reviews, approvals)
   - **Stuck:** What's blocked, by whom or what, since when
   - **Deprioritized:** What was deliberately deferred and why (important for future context)

5. **Snapshot adoption metrics** — If metrics data is provided:
   - Record current values with today's date
   - Format as the standard metrics table used by `/start-day`:
     ```
     Metric            | Current | Date
     ------------------|---------|----------
     [metric name]     | [value] | [YYYY-MM-DD]
     ```
   - If not provided, note: "No metrics snapshot — provide data to enable tomorrow's delta."

6. **Build tomorrow's priority stack** — Based on today's open items and any known commitments:
   - Rank 3–5 items for tomorrow
   - Flag any hard deadline or dependency unblock required
   - This list becomes the starting input for tomorrow's `/start-day`

7. **Draft standup message** — Generate a Slack-ready message:
   ```
   *Yesterday:* [2–3 bullet summary of what moved]
   *Today:* [2–3 bullet summary of tomorrow's priority stack]
   *Blockers:* [any active blockers, or "None"]
   ```
   Keep each bullet to one line. No jargon. Written as if posting to the team channel.

8. **Check for upcoming milestones** — If the PM's initiatives include any of the following within the next 3 business days, flag it:
   - Gate 1 or Gate 2 submission
   - Planned release or deployment
   - Customer commitment or demo
   - Dependency handoff to Engineering or Design
   - If flagged: prompt the PM to run `/gate-review-checklist` or review the relevant context

9. **Write persistent log file** — Compile all sections above into a single markdown file and instruct the PM to save it as:
   This file is the direct input for tomorrow's `/start-day` session.

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
Read 01_context/company/DP-General-pm-ai-mindset.md.

Close my day.

Core Area: [CoreArea]
Date: [YYYY-MM-DD]
Here's what happened today: [free text summary]
Adoption metrics today: [paste values or "skipping"]
Tomorrow's known commitments: [list or "none"]
```

**Recommended model:** Claude Sonnet 4.6.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Decisions not extracted | Summary too vague | Prompt: "Walk me through each conversation or review you had today. What was decided?" |
| Metrics snapshot missing | PM skipped it | Note the gap; tomorrow's delta will be unavailable until a snapshot is provided |
| Standup too long | Summary input too detailed | Cap standup bullets at 3 per section; trim to one line each |
| Milestone flag missed | PM didn't mention upcoming deadline | Prompt: "Are there any gates, releases, or customer calls in the next 3 days?" |

---

## Handoff Format

The persistent log file written at end of step 9 is the handoff. Structure:

```markdown
---
source: PM Close Day Agent
date: [YYYY-MM-DD]
core_area: [CoreArea]
next_step: PM Start Day (04_agents/pm/DP-General-start-day/)
---

## Decisions
[decision log entries]

## Accomplishments + Blockers
[moved / stuck / deprioritized]

## Adoption Metrics Snapshot
[metrics table]

## Tomorrow's Priorities
[ranked list]

## Standup Draft
[slack message]

## Milestone Flags
[flags or "None"]
```

Pass this file path to the next `/start-day` session as the `prior close-day log` input.
