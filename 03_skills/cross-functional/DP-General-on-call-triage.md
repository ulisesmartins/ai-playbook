---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
slash_command: /on-call-triage
audience: Coding
---

# `/on-call-triage` — First-Pass Triage of an On-Call Incident

## Purpose

Performs first-pass triage of an on-call incident. Classifies severity, identifies root cause hypothesis, proposes remediation steps, and determines whether to resolve autonomously or escalate.

## Required Inputs

```
/on-call-triage

[Paste alert, error message, stack trace, or incident description]
User impact: [estimated number of users affected / "unknown"]
Service/area affected: [if known]
Time of onset: [if known]
```

## Expected Output

1. **Severity classification:** P0 / P1 / P2 / P3 with rationale
2. **Root cause hypothesis:** Most likely cause based on the error signature
3. **Affected systems:** Which services/components are involved
4. **Remediation steps:** Ordered list of actions to take
5. **Escalation decision:** Resolve autonomously / Escalate now / Investigate further

## Skill Body (Prompt)

```
Read the following files:
- 01_context/codebase-map/DP-General-index.md

Here is the incident:
[USER_INPUT]

User impact: [USER_INPUT]
Service affected: [USER_INPUT]
Time of onset: [USER_INPUT]

Triage this incident:

1. Classify severity (P0/P1/P2/P3) based on escalation rules
2. State root cause hypothesis — be specific about what likely caused this
3. List affected services based on the error and codebase-map
4. Propose remediation steps in order — safest first
5. State escalation decision: will you resolve autonomously or page on-call?

ESCALATION TRIGGERS (always escalate if ANY of these apply):
- P0 or P1 severity
- Data integrity concern
- Runbook step fails unexpectedly
- Irreversible action required
- Uncertain about blast radius

Wait for my approval before executing any remediation step.
```

## Known Limitations

- Cannot execute remediation directly without authorization from on-call engineer
- Cannot access PagerDuty, Datadog, or Grafana without MCP configured
