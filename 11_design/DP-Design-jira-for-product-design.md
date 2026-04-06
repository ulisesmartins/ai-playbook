---
title: Jira for Product Design
---

# Jira for Product Design

Starting April 2023, we decided to use Jira as our main tool for project management. The goal is to:

- Eliminate effort duplication for Designers
- Adopt practices that allow us to have updated information in real time
- Have a single source of truth for the Design Team to have a bird-eye view on all in-flight and backlog projects

This source of truth empowers Designers to prioritize, unblock, optimize, and communicate their workflow better.

**Kanban boards:**

- [Product Designer view](https://dialpad.atlassian.net/jira/software/c/projects/DP/boards/530)
- [Epic view](https://dialpad.atlassian.net/jira/software/c/projects/DP/boards/572)

## Board Details

### Card Definitions

| Card | Description | Jira Statuses |
|------|-------------|---------------|
| :construction: TO DO | Tickets in the Designer's backlog | TO DO, NEEDS DEFINITION |
| :no_entry: BLOCKED | Assigned but waiting on dependencies | BLOCKED |
| :runner: ACTIVE WORK | Currently being worked on | IN PROGRESS, CODE REVIEW |
| :face_with_monocle: DESIGN REVIEW | Needs review / being reviewed | DESIGN REVIEW |
| :test_tube: QA | Designer assigned for QA | READY FOR TESTING |
| :white_check_mark: DONE | Work completed | DONE, CLOSED, READY FOR PRODUCTION, NOT DOING |

### Status Definitions

| Status | Description | Requirements |
|--------|-------------|--------------|
| NEEDS TRIAGE | Vague definition and unclear scope | Brief description, Priority |
| BACKLOG | Scope is clear, ready to be worked on | Complete description with acceptance criteria, Priority, `design-required` label, Story point estimation |
| TO DO | Prioritized for current sprint | All BACKLOG requirements + Assignee |
| BLOCKED | Clear scope but dependency not resolved | Brief description, Linked blocking issue |
| IN PROGRESS | Work in progress | All BACKLOG requirements + Assignee |
| DESIGN REVIEW | Being reviewed by another designer | All BACKLOG requirements + Assignee |
| CLOSED | Acceptance criteria achieved | All requirements + `design-complete` label |

### Filter Used

```sql
project IN (Dialpad, "Dialpad Meetings", "Mobile", "Dialtone", "Dialpad Design")
AND ((assignee IN (membersOf("Product Design")) OR labels IN (design-required)))
AND issuetype != Epic
```

## Jira Issue Types

| Issue Type | Description | Scope | Length |
|------------|-------------|-------|--------|
| **Initiative / Plan** | Large project spanning several quarters | Not necessarily defined | Undefined |
| **Epic** | Part of an initiative, collection of stories | Defined | <= Quarter |
| **Story / Design Story** | Small portion of work | Defined | <= Sprint |
| **Spike** | Timeboxed investigation to gather info | Defined | <= Sprint |
| **Bug** | Reflects an existing error | Defined | Undefined |
| **Sub task** | Portion of a story | Defined | <= Sprint |

!!! tip "Key rules"

    - All tickets you create and work on must belong to an epic
    - Use the `design-required` label for active design work
    - Switch to `design-done` label when design work is complete
    - Epics should not be assigned to individual designers

---

!!! info "Source"

    This content is sourced from [Jira for Product Design](https://dialpad.atlassian.net/wiki/spaces/DES/pages/656801793) on Confluence.
