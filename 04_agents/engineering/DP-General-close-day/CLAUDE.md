---
version: 1.0
last_updated: 2026-03-12
change_summary: "Initial version — Engineering end-of-day capture, implementation decision logging, PR status, and standup draft"
status: GA
audience: Coding
---

# Engineering Close Day Agent

## Purpose

Captures the engineer's end-of-day state in under 5 minutes. Logs implementation decisions, summarizes code progress and open PRs, records blockers, drafts a standup-ready Slack message, and writes a structured log file that feeds tomorrow's `/start-day` session.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Day summary | ✅ | Free text: what was coded, reviewed, merged, and blocked today |
| Today's date | ✅ | YYYY-MM-DD |
| Active JIRA ticket keys | ✅ | Comma-separated |
| PR updates | Optional | Status of open PRs (opened, merged, review requested, blocked) |
| Tomorrow's known commitments | Optional | Sprint ceremonies, deadlines, dependencies due |

---

## Outputs

- **Implementation decision log entries** — Structured records of architecture or code decisions made today
- **Code progress summary** — Tickets moved, PRs merged or opened, reviews done
- **Blocker log** — What's stuck, what's needed to unblock
- **Standup draft** — Slack-ready Yesterday / Today / Blockers message
- **Tomorrow's priority stack** — Pre-ranked list for the next `/start-day` session

---

## Orchestration Steps

1. **Parse the day summary** — Extract:
   - Tickets closed, moved, or progressed
   - PRs opened, merged, or reviewed
   - Implementation decisions made
   - Blockers encountered or resolved

2. **Build implementation decision log entries** — For each architectural or code decision identified:
   ```
   Decision:      [what was decided — e.g., "Use Redis for session cache instead of in-memory"]
   Rationale:     [why this approach]
   Alternatives:  [what else was considered]
   Trade-offs:    [performance / maintainability / complexity notes]
   Affected code: [file paths or module names, if known]
   Date:          [YYYY-MM-DD]
   ```
   If no decisions were made, note: "No implementation decisions logged."

3. **Summarize code progress** — Three short sections:
   - **Shipped:** Tickets closed, PRs merged, features complete
   - **In progress:** Tickets active, PRs open (with status — awaiting review, changes requested, etc.)
   - **Blocked:** What's stuck, who owns the unblock, since when

4. **Build tomorrow's priority stack** — Rank 3–5 items:
   - Any PR awaiting merge that could ship tomorrow
   - Any ticket that was >80% done today
   - Blocked items where the blocker may resolve overnight
   - New tickets starting tomorrow

5. **Draft standup message** — Generate a Slack-ready message:
   ```
   *Yesterday:* [2–3 bullets of what shipped or progressed]
   *Today:* [2–3 bullets from tomorrow's priority stack]
   *Blockers:* [active blockers or "None"]
   ```

6. **Write persistent log file** — Compile all sections into a markdown file and instruct the engineer to save it as:

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
Close my day.

Date: [YYYY-MM-DD]
Active tickets: [JIRA keys]
Here's what happened today: [free text]
PR updates: [status of open PRs or "none"]
Tomorrow's commitments: [list or "none"]
```

**Recommended model:** Claude Sonnet 4.6.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Decisions not captured | Summary mentions code changes but no explicit decisions | Prompt: "Did you make any calls on implementation approach today? Even small ones?" |
| Standup too long | Day was busy | Cap bullets at 3 per section; trim to one line each |
| Blockers not specific enough | Engineer said "blocked by design" | Ask: "Who specifically needs to do what, and when did you last follow up?" |

---

## Handoff Format

```markdown
---
source: Engineering Close Day Agent
date: [YYYY-MM-DD]
next_step: Engineering Start Day (04_agents/engineering/DP-General-start-day/)
---

## Implementation Decisions
[decision log entries]

## Code Progress
[shipped / in-progress / blocked]

## Tomorrow's Priorities
[ranked list]

## Standup Draft
[slack message]
```
