---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
audience: Coding
---

# Debug Team — Parallel Debugging Session for Stubborn Bugs

## Purpose

Runs three parallel debugging hypotheses on a reported bug. Each hypothesis agent follows
a different diagnostic path simultaneously. The fastest hypothesis to produce a testable
root cause wins — all findings are consolidated for the engineer to act on.

Use for bugs that are:
- Intermittent (not reliably reproducible)
- Cross-service (spans frontend and backend)
- Time-sensitive (P2 with customer impact)
- Have been investigated for >30 minutes without a root cause

---

## Roles

| Role | Hypothesis path | Focus |
|---|---|---|
| Frontend Debugger | UI/component layer | Vue reactivity, Dialtone interactions, state management, browser-specific issues |
| Backend Debugger | Service/API layer | API errors, data model issues, service dependencies, race conditions |
| Infrastructure Debugger | Platform/infra layer | Redis, DB connections, deployment timing, feature flag state, CDN |

---

## Input Required

```
Bug description: [DESCRIPTION]
Error message / stack trace: [ERROR_TEXT]
Service affected: [SERVICE_NAME]
Time of onset: [TIMESTAMP]
Reproducibility: [Always / Intermittent / One customer only]
Recent changes: [List of recent deploys or config changes, or "unknown"]
Logs: [Paste relevant log lines or indicate Datadog query]
```

---

## Kickoff Prompt

```
Read the following files:
- 01_context/codebase-map/DP-General-index.md
- 01_context/codebase-map/DP-General-key-patterns.md

You are running a parallel debugging session on a production bug.

Bug: [BUG_DESCRIPTION]
Error: [ERROR_TEXT]
Service: [SERVICE_NAME]
Onset: [TIMESTAMP]
Reproducibility: [REPRODUCIBILITY]
Recent changes: [RECENT_CHANGES]
Logs: [LOG_LINES]

Three agents will independently investigate from different angles.
Each agent produces a root cause hypothesis with evidence and a test to confirm it.

---

AGENT 1: FRONTEND DEBUGGER
Investigate from the Vue 3 / browser layer:
1. Could this be a Vue reactivity issue? (Stale ref, computed not updating, watch not firing)
2. Could this be a Pinia store state issue? (State not reset, wrong store scope)
3. Could this be a Dialtone component interaction? (Known DT9 bugs or usage errors)
4. Could this be browser-specific? (Safari, Chrome, iframe embedding)
5. Could this be a network timing issue on the frontend? (Race condition in API calls)

Output:
- Root cause hypothesis (specific, one sentence)
- Evidence from the bug/logs that supports this hypothesis
- Confirmation test: exactly what to check or reproduce to confirm

---

AGENT 2: BACKEND DEBUGGER
Investigate from the API / service layer:
1. Could this be a bad API response? (Wrong status code, malformed payload, missing field)
2. Could this be a data model issue? (NULL handling, type mismatch, unexpected data shape)
3. Could this be a service dependency failure? (Downstream API returning error, timeout)
4. Could this be a race condition? (Concurrent writes, eventual consistency lag)
5. Could this be a permission/auth issue? (Token expired mid-session, org scope mismatch)

Output: same format as Agent 1

---

AGENT 3: INFRASTRUCTURE DEBUGGER
Investigate from the platform/infra layer:
1. Could this be a Redis cache issue? (Stale cache, eviction, connection pool exhaustion)
2. Could this be a DB connection issue? (Pool exhaustion, slow query, lock contention)
3. Could this be deployment-related? (Config change, env var missing, canary rollout issue)
4. Could this be a feature flag issue? (Flag state incorrect for affected org/plan)
5. Could this be a CDN or network routing issue? (Asset not updated, region-specific)

Output: same format as Agent 1

---

CONSOLIDATED DEBUG REPORT:
1. Rank the three hypotheses by evidence strength (most likely → least likely)
2. Recommended first test (what to check right now to eliminate the most likely hypothesis)
3. If first test is positive: recommended remediation steps
4. If first test is negative: recommended second test
```

---

## Handoff Format

Output of this session goes directly to the on-call engineer:
1. Ranked hypothesis list with confirmation tests
2. First recommended action
3. If unresolved after confirmation tests: escalation trigger

---

## Exit Condition

Session is complete when all three agents produce hypotheses AND the consolidated report ranks
them with a recommended first test. The engineer then runs the test and reports back.

---

## Known Limitations

- Hypotheses are based on patterns and available evidence — they are not guaranteed root causes
- Cannot execute tests directly — the engineer runs the confirmation tests
- Infrastructure hypotheses require access to Datadog and deployment logs — provide these if available
