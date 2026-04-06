---
version: 1.1
last_updated: 2026-03-31
change_summary: "Switch to remote OAuth MCP server — no API key/secret needed"
status: GA
audience: PM, Coding
---

# Amplitude MCP Setup Guide

## Purpose

Configures the Amplitude MCP so Claude Code can query product analytics — event counts,
funnel conversion, retention, and user property lookups — directly from agent sessions.
Enables data-grounded PRD writing and success metric validation without leaving Claude Code.

---

## Prerequisites

- Claude Code installed
- Amplitude account with access to Dialpad's Amplitude org

---

## Step 1: Add the Amplitude MCP

Run this command in your terminal:

```bash
claude mcp add --transport http amplitude https://mcp.amplitude.com/mcp
```

---

## Step 2: Authenticate

On first use, Claude Code will open your browser for **Amplitude OAuth**. Log in with your Amplitude account. The MCP uses your existing Amplitude user permissions — no API key or secret to manage.

---

## Step 3: Verify the Connection

```
/mcp list
```

`amplitude` should appear. Then test:

```
How many unique users triggered the "call_started" event in the last 7 days?
```

---

## Common Operations

### Check feature adoption after launch
```
What % of Supervisor/Coach users have viewed the CSAT dashboard in the last 30 days?
Event: coaching_dashboard_viewed, user_property: role = "supervisor"
```

### Validate a success metric baseline
```
What is the average number of manual clicks between calls in the Power Dialer flow today?
This is the baseline for the Power Dialer Auto-Advance feature.
```

### Funnel analysis for a user flow
```
Show me the funnel: admin_opens_settings -> feature_enabled -> first_use
For the dp_meeting_transcription_v3 flag cohort, last 14 days.
```

---

## Dialpad Amplitude Conventions

- **Project:** Use `Dialpad Production` for real metrics; `Dialpad Staging` for testing
- **Event naming:** `snake_case`, e.g., `call_started`, `csat_score_viewed`
- **User properties:** `role`, `plan`, `org_id`, `feature_flags` (array)
- **Feature flag cohorts:** Filter by `feature_flags contains "flag_name"` to measure flag impact

---

## Troubleshooting

| Issue | Solution |
|---|---|
| "Unauthorized" | Re-authenticate via browser — the OAuth grant may have expired |
| Event not found | Check event name spelling — Amplitude is case-sensitive |
| No data returned | Confirm date range includes data; staging project has limited data |

---

## Known Limitations

- Read-only — cannot create or modify Amplitude events or dashboards via MCP
- Historical data availability depends on your Amplitude plan's retention window
- Cannot query raw event logs — only aggregated metrics and funnel data
