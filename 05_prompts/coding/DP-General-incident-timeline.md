---
version: 1.0
last_updated: 2026-03-12
status: GA
author: Coding team
---

# Incident Timeline Prompt

## Purpose

Construct a structured incident timeline from raw on-call notes, PagerDuty alerts, Slack threads, or verbal incident summaries. Outputs a clean timeline suitable for a postmortem or incident report.

## When to Use

- During or immediately after an incident, while details are fresh
- As input to the `/postmortem-draft` skill
- When filing a P1/P2 incident report for leadership

## Prompt

```
You are constructing a Dialpad incident timeline for a postmortem or incident report.

Raw input (paste any of the following):
- On-call notes
- PagerDuty alert timeline
- Slack thread excerpts (with timestamps)
- Verbal description of the incident sequence

[PASTE INPUT HERE]

Produce a structured incident timeline in the following format:

# Incident Timeline — [Short incident title]

**Date:** YYYY-MM-DD  
**Incident ID / PagerDuty link:** [link or "not tracked"]  
**Severity:** P1 / P2 / P3  
**Duration:** [start time] → [end time] ([total duration])  
**Affected services:** [list]  
**Estimated customer impact:** [number of customers or "unknown"]  

## Timeline

| Time (UTC) | Event | Actor |
|---|---|---|
| HH:MM | [What happened — be specific about system state, alerts, or actions taken] | [System / On-call engineer / Automated] |
| HH:MM | Alert fired: [alert name] | PagerDuty |
| HH:MM | [Engineer] acknowledged page | [name] |
| HH:MM | Identified root cause: [description] | [name] |
| HH:MM | Mitigation applied: [what was done] | [name] |
| HH:MM | Service restored / alert resolved | [name] |

## Detection

**How was this detected?** [Alert / Customer report / Internal monitoring]  
**Time to detection:** [duration from first symptom to detection]  
**Time to acknowledgment:** [duration from page to ack]  
**Time to mitigation:** [duration from ack to service restoration]  

## Impact Summary

[2–3 sentences: what was affected, for how long, and how many customers/requests were impacted]

## Root Cause (preliminary)

[1–2 sentences. This is a preliminary assessment — the full RCA belongs in the postmortem.]
```

## Tips

- Fill in this template DURING the incident for maximum accuracy
- Use UTC timestamps consistently — avoid mixing timezones
- Paste this timeline as the starting input for `/postmortem-draft`
