---
version: 1.0
last_updated: 2026-03-11
change_summary: "Initial version"
status: GA
slash_command: /postmortem-draft
audience: Coding
---

# `/postmortem-draft` — Draft a Blameless Postmortem from Incident Data

## Purpose

Drafts a blameless postmortem document from incident timeline, alert data, and remediation notes. Structures the narrative, surfaces contributing factors, and generates action items with owners. Output is ready for async review and Confluence publish.

## Required Inputs

```
/postmortem-draft

Incident title: [short description of what happened]
Severity: [P0 / P1 / P2]
Date/time of onset: [timestamp or approximate]
Date/time of resolution: [timestamp or approximate]
Services affected: [list]
User impact: [number of users / "unknown" / description of impact]

[Paste incident timeline, alert text, Slack thread summary, or on-call notes]
```

## Expected Output

A complete postmortem document with:
1. **Incident summary** — what happened, when, and impact
2. **Timeline** — structured sequence of events (detection → response → resolution)
3. **Root cause** — specific technical contributing factors (not people)
4. **Contributing factors** — systemic conditions that made the incident possible
5. **What went well** — effective detection, response, or communication
6. **What could be improved** — gaps in monitoring, runbooks, or process
7. **Action items** — specific, ownable follow-up tasks with suggested owners and priority

## Skill Body (Prompt)

```
Read the following files:
- 01_context/codebase-map/DP-General-index.md

Here is the incident data:
Incident title: [USER_INPUT]
Severity: [USER_INPUT]
Date/time of onset: [USER_INPUT]
Date/time of resolution: [USER_INPUT]
Services affected: [USER_INPUT]
User impact: [USER_INPUT]

Incident notes / timeline:
[USER_INPUT]

Draft a blameless postmortem. Rules:

BLAMELESS STANDARD:
- Never name individuals as causes. Root causes are systems, processes, and conditions — not people.
- Do not use language like "X failed to", "Y forgot to", or "Z didn't notice".
- Do use: "The monitoring threshold was set too high to catch...", "The runbook did not cover...", "The deploy process lacked..."

INCIDENT SUMMARY (3–5 sentences):
- What failed, when it was detected, how long it lasted, and how many users were affected
- State the severity classification and the final resolution method

TIMELINE:
- Format: [HH:MM UTC] — [what happened or what action was taken]
- Include: first alert, detection method, key investigation steps, mitigation actions, resolution confirmation, all-clear
- Mark each entry as: 🔴 Impact event | 🟡 Response action | 🟢 Resolution step
- If timeline data is sparse, mark gaps with [TIMELINE GAP — confirm with on-call engineer]

ROOT CAUSE:
- State the specific technical root cause in one sentence
- Then explain the causal chain: what made the root cause possible, how it manifested, and why it wasn't caught earlier

CONTRIBUTING FACTORS (bulleted list):
- What systemic conditions allowed this to happen?
- Examples: missing alert coverage, runbook gap, recent deploy without rollback plan, dependency without circuit breaker

WHAT WENT WELL (bulleted list):
- Detection speed, communication clarity, effective rollback, runbook accuracy, team coordination

WHAT COULD BE IMPROVED (bulleted list):
- Be specific — not "improve monitoring" but "add alert for X metric when it exceeds Y threshold for Z minutes"

ACTION ITEMS:
| Priority | Action | Owner (role, not name) | Due |
|---|---|---|---|
| P1 | [specific, verifiable action] | [e.g., On-call Engineer] | [e.g., Next sprint] |

Rules for action items:
- Each action must be specific enough that a JIRA ticket can be written from it directly
- Do not create action items for things that were already fixed during the incident
- Mark any action item that requires a team decision as [NEEDS TEAM DISCUSSION]
- Suggest 3–6 action items — fewer if the incident was simple, more only if warranted

If critical information is missing (e.g., no timeline provided), ask before generating.
```

## Known Limitations

- Cannot access Datadog, PagerDuty, or Grafana logs directly — paste relevant log excerpts or alert text
- Timeline accuracy depends on input quality — sparse notes produce gap-marked timelines
- Action item owners are listed by role, not name — assign to specific engineers during team review
- Does not replace the team sync / postmortem meeting — this is a draft for async review only
- P0 incidents may require additional review by Coding leadership before publishing
