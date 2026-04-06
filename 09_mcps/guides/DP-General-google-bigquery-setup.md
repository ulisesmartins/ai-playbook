---
version: 1.1
last_updated: 2026-03-31
change_summary: "Switch to Google remote OAuth MCP server — no service account key needed"
status: GA
audience: Coding, PM
---

# Google BigQuery MCP Setup Guide

## Purpose

Configures the Google BigQuery MCP so Claude Code can run SQL queries against Dialpad's
analytics data warehouse directly from agent sessions. Enables data-grounded PRD writing,
success metric baselining, and on-call log analysis without needing a separate BI tool.

---

## Prerequisites

- Claude Code installed
- Access to Dialpad's BigQuery project (request via IT or your Analytics team)
- IAM roles: **BigQuery Job User** and **BigQuery Data Viewer** (request via IT if you don't have them)

---

## Step 1: Add the BigQuery MCP

Run this command in your terminal:

```bash
claude mcp add --transport http google-bigquery https://bigquery.googleapis.com/mcp
```

---

## Step 2: Authenticate

On first use, Claude Code will open your browser for **Google OAuth**. Log in with your `@dialpad.com` Google Workspace account. The MCP uses your existing IAM permissions — no service account key to manage.

---

## Step 3: Verify the Connection

```
/mcp list
```

`google-bigquery` should appear. Then test:

```
List the datasets available in the dialpad-analytics BigQuery project.
```

---

## Dialpad BigQuery Key Datasets

Contact your Analytics team for the current dataset names. Common areas:

| Dataset area | What it contains |
|---|---|
| Call data | Call records, duration, outcome, MOS scores |
| User activity | Feature usage events, login activity |
| AI features | Transcription accuracy, CSAT scores, coaching data |
| Billing | Subscription data, plan changes, revenue metrics |
| Product analytics | Funnel data, feature adoption, retention cohorts |

**Always query staging/non-PII datasets for development work.** Production datasets with PII
require additional data governance approval.

---

## Common Operations

### Baseline a success metric before a feature launch
```
Write a BigQuery SQL query to find the average number of manual clicks
between calls in the Power Dialer flow, grouped by week, for the last 90 days.
Dataset: [ask Analytics team for the correct dataset name]
```

### Pull call quality distribution for on-call triage
```
Query BigQuery for the distribution of MOS scores in the last 24 hours.
Flag any regions with MOS < 3.5.
```

### Validate feature flag adoption
```
How many unique orgs have had the dp_coaching_csat_v2 feature flag enabled
in the last 30 days? Break down by plan tier.
```

---

## Data Governance Rules

- Do not query tables containing customer PII without explicit approval from Legal/Privacy
- Do not export raw query results to shared documents — aggregate before sharing
- Use parameterized queries when possible to avoid SQL injection
- Always include date-range filters to avoid scanning entire tables (cost control)

---

## Troubleshooting

| Issue | Solution |
|---|---|
| "Permission denied" | Verify you have BigQuery Job User and Data Viewer IAM roles — request via IT |
| "Project not found" | Use `dialpad-analytics` as the project ID |
| OAuth expired | Re-authenticate via browser — restart Claude Code to trigger OAuth flow |
| MCP not listed | Restart Claude Code after adding the MCP |

---

## Known Limitations

- Read-only — cannot create tables or modify data via MCP
- Complex queries may timeout — add date-range filters and LIMIT clauses
- Service does not support all BigQuery features (e.g., DML, DDL operations)
- Query costs are tracked per user — be mindful of full-table scans
