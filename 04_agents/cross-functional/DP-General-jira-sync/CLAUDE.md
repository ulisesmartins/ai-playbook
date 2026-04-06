---
version: 1.2
last_updated: 2026-03-12
change_summary: "Updated template paths to reflect role-based subfolder reorganization"
status: GA
audience: PM, Coding
---

# JIRA Sync Agent

## Purpose

Converts a task breakdown document into JIRA epics and stories, and optionally syncs status to Monday.com. Eliminates manual JIRA entry from the PM/Engineering workflow.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Task breakdown document | ✅ | Output from Task Breakdown agent |
| JIRA project key | ✅ | e.g., `DP`, `MOB`, `DATA` |
| JIRA labels | Optional | e.g., `FY27Q1-support`, `design-required` |
| Monday.com board ID | Optional | For syncing epic status to Monday |

---

## Outputs

- Created JIRA epic with all fields populated
- Created JIRA stories linked to the epic
- Story sequence encoded via JIRA blocking/blocked-by links
- Monday.com sync (if board ID provided): epic appears as a Monday item with JIRA link

---

## Orchestration Steps

1. **Load inputs** — Load the task breakdown document and `02_templates/cross-functional/DP-General-jira-epic-template.md`

2. **Create epic** — Using the JIRA MCP (`09_mcps/configs/DP-General-atlassian.json`):
   - Map epic summary, description, and outcome from task breakdown
   - Set labels per the Core Area and quarter
   - Leave feature flag field blank (Engineering fills this)

3. **Create stories** — For each story in the breakdown:
   - Create a JIRA story linked to the epic
   - Map all fields: summary, description, entry/exit criteria, ACs, persona, effort
   - Set dependency links (blocks / is blocked by) based on the sequencing map

4. **Verify** — Confirm all stories are visible in JIRA and linked correctly. Share the epic link with the user.

5. **Monday sync (optional)** — If a Monday board ID is provided, create or update the corresponding Monday item with:
   - Feature name
   - JIRA epic link
   - Target Gate 1 / GA dates (from the PRD header)
   - Status: "Not Started"

6. **Hand off** — "JIRA epic and stories created. Share the epic link with your Engineering team. When development starts, update story status in JIRA."

---

## MCP Requirements

This agent requires the Atlassian MCP to be configured. Setup guide: `09_mcps/guides/DP-General-atlassian-setup.md`

Verify before running:
```
claude mcp list
# Should show: jira-mcp
```

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
I have a task breakdown ready for JIRA entry.
JIRA project key: [project key]
JIRA labels: [labels]

Here is the task breakdown:
[paste task breakdown document]

Create the JIRA epic and all stories.
Use the JIRA MCP to create them directly.
Show me the epic URL when done.
```

**Recommended model:** Claude Sonnet 4.6 with JIRA MCP connected.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Stories created without epic link | Epic creation failed silently | Verify epic exists before creating stories |
| Wrong JIRA project | Project key not specified | Always confirm project key before creating |
| Duplicate stories | Re-running after partial failure | Search for existing stories before creating new ones |
| Monday sync fails | Board ID wrong or permissions issue | Verify Monday MCP config; skip sync and note for manual follow-up |
| Field mapping errors | JIRA field names differ by project | Check project-specific required fields before running |

---

## Handoff Format

Deliver to user:
1. JIRA epic URL
2. List of story URLs (one per story)
3. Summary: "N stories created across X sprints. Sequencing encoded via blocking links."
4. Optional: Monday item URL if sync was run
