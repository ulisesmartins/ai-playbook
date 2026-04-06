---
version: 1.0
last_updated: 2026-03-12
change_summary: "Initial version — Coding daily start-of-day orientation with ticket, PR, and CI health check"
status: GA
audience: Coding
---

# Coding Start Day Agent

## Purpose

Orients the engineer for the day in under 5 minutes. Loads prior context from yesterday's close-day log, surfaces in-progress tickets and open PRs, checks for CI/CD or test failures, ranks today's priorities, surfaces blocked dependencies, and generates meeting prep on demand.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Today's date | ✅ | YYYY-MM-DD |
| Active JIRA ticket keys | ✅ | Comma-separated (e.g., DIAL-1234, DIAL-5678) |
| Open PR numbers or links | Optional | GitHub PR URLs or numbers |
| CI/CD status | Optional | Paste of build/test output or GitHub Actions summary |
| Today's meetings | Optional | List of meeting names / times |

---

## Outputs

- **Priority stack** — 3–5 ranked items for the day with rationale
- **PR and ticket status** — In-progress work snapshot with blockers highlighted
- **CI/CD health flag** — Any failing builds or test suites that need attention first
- **Dependency check** — What's blocking the engineer and what the engineer is blocking
- **Meeting prep** — Agenda or talking points for any flagged meeting
- **Focus question** — One question to prime the engineer's intent for the day

---

## Orchestration Steps

1. **Load context** — Load `01_context/codebase-map/DP-General-index.md` and `01_context/codebase-map/DP-General-key-patterns.md`

2. **Load yesterday's close-day log** — If provided, extract:
   - Open blockers and their current state
   - PRs in review or awaiting merge
   - Implementation decisions still open
   - Tomorrow's priority stack written at close
   - If no log exists, skip and note: "No prior close-day log found — starting fresh."

3. **Assess CI/CD health** — If CI/CD status is provided:
   - Identify any failing builds, flaky tests, or deployment issues
   - If failures exist, surface them as **Priority 0** — they must be addressed before new work begins
   - If clean, confirm: "CI/CD healthy — proceed with planned work."

4. **Review PR and ticket status** — For each provided PR and ticket:
   - State current status (in progress / in review / blocked / merged / closed)
   - Flag any PR awaiting review for more than 1 business day
   - Flag any ticket blocked on an external dependency
   - Note which tickets are closest to completion and could be closed today

5. **Build priority stack** — Rank 3–5 items:
   - CI/CD failures always rank first if present
   - PRs closest to merge rank above new code work
   - Tickets that are blocking teammates rank above solo work
   - Output as a numbered list with one-line rationale

6. **Dependency check** — Based on active tickets:
   - What is the engineer waiting on from others (API contract, design spec, code review)?
   - What are others waiting on from this engineer (PR review, backend endpoint, shared module)?
   - Flag any dependency unblock that could happen today

7. **Generate meeting prep** — For each flagged meeting:
   - Tech sync or standup: generate a 3-bullet status update (what's in progress, what's blocked, what ships today)
   - Code review or architecture review: list the key questions or decisions the engineer needs the meeting to resolve
   - Sprint planning: surface ticket estimates and any scope concerns

8. **Close with a focus question** — "What is the one ticket or PR that, if shipped or unblocked today, would have the most impact on the team?"

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
Read 01_context/codebase-map/DP-General-index.md
and 01_context/codebase-map/DP-General-key-patterns.md.

Start my day.

Date: [YYYY-MM-DD]
Active tickets: [JIRA keys]
Open PRs: [PR links or numbers, or "none"]
CI/CD status: [paste or "clean"]
Prior close-day log: [path or "none"]
Today's meetings: [list or "none"]
```

**Recommended model:** Claude Sonnet 4.6.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Priority stack ignores CI failures | CI status not provided | Always include CI/CD status — even "clean" is useful context |
| Missing dependency context | Tickets too high-level | Ask: "Who else is depending on your work today?" |
| Over-long priority list | Engineer listed everything in-flight | Cap at 5; remaining items go to tomorrow's stack |
| Meeting prep too generic | Meeting type not specified | Ask: "What decision needs to come out of this meeting?" |
