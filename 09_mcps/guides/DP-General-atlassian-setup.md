---
version: 1.2
last_updated: 2026-03-31
change_summary: "Switch to remote OAuth MCP server — no API token needed"
status: GA
audience: PM, Coding
---

# Atlassian MCP Setup Guide

## Purpose

Configures the Atlassian MCP so Claude Code can create, read, and update JIRA tickets and
Confluence pages directly from agent sessions. Covers both JIRA (ticket management) and
Confluence (documentation). Required for `/ticket-breakdown`, `/generate-jira-epic`, and
`04_agents/cross-functional/DP-General-jira-sync/` workflows.

---

## Prerequisites

- Claude Code installed
- Atlassian account with access to `dialpad.atlassian.net`

---

## Step 1: Add the Atlassian MCP

Run this command in your terminal:

```bash
claude mcp add --transport http atlassian https://mcp.atlassian.com/v1/mcp
```

---

## Step 2: Authenticate

On first use, Claude Code will open your browser for **Atlassian OAuth**. Log in with your Dialpad Okta SSO credentials. No API token to create or manage — authentication is handled automatically.

---

## Step 3: Verify the Connection

```
/mcp list
```

`atlassian` should appear. Then test:

```
List the open issues in JIRA project DP assigned to me.
```

---

## Step 4: Dialpad JIRA Project Structure

**Important:** Almost all product work lives in a single JIRA project — `DP` (Dialpad).
Teams are differentiated by the **`teamdp`** label field and by **Jira Components** within DP.
The table below maps Core Areas and teams to their correct JQL filters and components.

| Additional Jira Project | Key | Purpose |
|---|---|---|
| Dialpad (main) | `DP` | All product work — Support, Connect, Sell, Ecosystem, SharedServices |
| Data Analytics Team | `DATA` | Data/BI engineering work |
| GCP Operations | `GCPOPS` | GCP configuration requests (Infrastructure) |
| BT Integrations | `BTIN` | Business Technology / IT integrations |
| Dialpad Design | `DDT` | Design team collaboration and ops |

To query a team in JQL use:
```
project = DP AND component = "Billing" AND sprint in openSprints()
```
or with team label:
```
project = DP AND "Team[Dropdown]" = "Billing"
```

---

## Dialpad Teams — Jira Boards, Components & Confluence Pages

### Support Core Area

**Team: Support Core**
- Confluence: https://dialpad.atlassian.net/wiki/spaces/ENG/pages/15140287
- Jira project: `DP` · Team label: `Support Core`
- Jira components: `Support Core`, `Support Core | CSAT | Analytics`
- Sprint board: https://dialpad.atlassian.net/jira/software/c/projects/DP/boards/337
- Agent experience board: https://dialpad.atlassian.net/jira/software/c/projects/DP/boards/579
- Bug dashboard: https://dialpad.atlassian.net/jira/dashboards/14399
- Email: `support-eng@dialpad.com`

---

### Connect Core Area

**Core Area page:** https://dialpad.atlassian.net/wiki/spaces/ENG/pages/368640073
- Engineering lead: Arnaud Budkiewicz · Product lead: Peter Nees
- Email: `connect-eng@dialpad.com`
- All Connect teams share the `DP` project; sprint boards are per sub-team

| Sub-team | Sprint Board |
|---|---|
| Calling | https://dialpad.atlassian.net/jira/software/c/projects/DP/boards/457 |
| Messaging | DP project, `teamdp = Messaging` |
| Meetings | DP project, `teamdp = Meetings` |
| Core App & Admin | DP project, `teamdp = Core App` |
| Hardware / Devices | DP project, `teamdp = Hardware` |

Key Confluence pages:
- Connect Core Area: https://dialpad.atlassian.net/wiki/spaces/ENG/pages/368640073
- Stay Informed / Release History: https://dialpad.atlassian.net/wiki/spaces/TSO/pages/1711636758

---

### Sell Core Area

**Core Area page:** https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1978270341
- Engineering lead: Jason Chiu · Product lead: Dave Skiba
- Email: `sell-eng@dialpad.com`

**Team: Sell Core**
- Confluence: https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1979613185
- Jira project: `DP` · Team label: `Sell`
- Jira components: `Sell | Account Hub`, `Sell | Coaching Hub`, `Sell | Coaching Team`, `Sell | Launchpad`, `Sell | Live Coach cards`, `Sell | Local presence`, `Sell | Playbooks`, `Sell | Playlists`

**Team: Power Dialer**
- Confluence: https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1302822916
- Jira project: `DP` · Team label: `Power Dialer`
- Jira components: `Power Dialer | Campaign definition`, `Power Dialer | Contacts`, `Power Dialer | Compliance`, `Power Dialer | Workflows`
- Sprint backlog: https://dialpad.atlassian.net/jira/software/c/projects/DP/boards/968/backlog

---

### Ecosystem Core Area

**Platform Engineering page:** https://dialpad.atlassian.net/wiki/spaces/ENG/pages/321847303
(Ecosystem + Shared Services both live under Platform Engineering)

**Team: Developer Platform (Dev Platform)**
- Confluence: https://dialpad.atlassian.net/wiki/spaces/ENG (search "Developer Platform Team")
- Jira project: `DP` · Team label: `Dev Platform`
- Jira components: `Dev Platform | API`, `Dev Platform | Auth`, `Dev Platform | Integrations`, `Dev Platform | Dialpad MCP`, `Dev Platform | SAML`, `Dev Platform | SCIM`, `Dev Platform | SDKs`, `Dev Platform | GraphQL`
- Sprint board: https://dialpad.atlassian.net/jira/software/c/projects/DP/boards/467
- Email: `dev-platform-eng@dialpad.com`

**Team: Agentic Ecosystem** (Daart / AI Agent integrations)
- Jira project: `DP` · Components: `Agentic Ecosystem`, `Agentic Ecosystem | MCP`, `Agentic Execute`
- Bi-weekly status: https://dialpad.atlassian.net/wiki/spaces/EPD/pages/2187296797

---

### Shared Services Core Area

**Core Area page:** https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1917681691
- Engineering lead: Andrew Paugh · Product lead: Sara Jew-Lim
- Email: `shared-services@dialpad.com`

**Team: Billing**
- Confluence: https://dialpad.atlassian.net/wiki/spaces/ENG/pages/15140327
- Jira project: `DP` · Team label: `Billing`
- Jira components: `Billing`, `Billing | Reseller`, `Billing | Pricing`, `Billing | Payments`, `Billing | Invoices`
- Sprint board: https://dialpad.atlassian.net/jira/software/c/projects/DP/boards/349
- Email: `billing-epd@dialpad.com`

**Team: Growth**
- Confluence: https://dialpad.atlassian.net/wiki/spaces/ENG/pages/15140276
- Jira project: `DP` · Team label: `Growth`
- Jira components: `Growth`, `Billing | Growth`
- Sprint board: https://dialpad.atlassian.net/jira/software/c/projects/DP/boards/411
- Email: `growth-eng@dialpad.com`

**Team: Analytics Platform**
- Confluence: https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1962934347
- Jira project: `DP` · Team label: `Platform Analytics`
- Jira components: `Platform Analytics`, `Platform Analytics | Business Intelligence Infra`, `Platform Analytics | Data Pipelines`, `Platform Analytics | Live Dashboard Infra`, `Platform Analytics | Public Stats API`, `Platform Analytics | Conversation History Infra`
- Scrum board: https://dialpad.atlassian.net/jira/software/c/projects/DP/boards/2324
- Bug dashboard: https://dialpad.atlassian.net/jira/dashboards/16377
- Email: `analytics-platform-eng@dialpad.com`

**Team: Data Analytics (Data team)**
- Jira project: `DATA`
- Sprint: `Data Sprint YYYY-MM-DD` (bi-weekly)

---

## Confluence Spaces at a Glance

| Space | Key | URL | Primary audience |
|---|---|---|---|
| Engineering | `ENG` | https://dialpad.atlassian.net/wiki/spaces/ENG | All engineers |
| EPD (cross-functional) | `EPD` | https://dialpad.atlassian.net/wiki/spaces/EPD | PM, Design, Eng |
| Product Management | `PM` | https://dialpad.atlassian.net/wiki/spaces/PM | PMs |
| Design | `DES` | https://dialpad.atlassian.net/wiki/spaces/DES | Designers |
| Customer Service | `CS` | https://dialpad.atlassian.net/wiki/spaces/CS | CX / Support ops |
| Technical Support Ops | `TSO` | https://dialpad.atlassian.net/wiki/spaces/TSO | CX / Release info |
| Sales Engineering | `SE` | https://dialpad.atlassian.net/wiki/spaces/SE | Sales Engineers |
| Marketing | `MAR` | https://dialpad.atlassian.net/wiki/spaces/MAR | Marketing / Web Eng |
| Dialpedia | `Dialpedia` | https://dialpad.atlassian.net/wiki/spaces/Dialpedia | Company-wide reference |
| WFM (Surfboard) | *(internal key)* | Search "Surfboard Featured Databases" in Confluence | WFM / Support |
| Business Technology | `BT` | https://dialpad.atlassian.net/wiki/display/BT | IT / BizTech |

---

## Key Confluence Pages (Top Reference Pages)

| Page | URL | Why it matters |
|---|---|---|
| Engineering Home | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/14254883 | Links to all Eng resources, events, OKRs |
| Org Structure & Starter Resources | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/15140715 | EPD org chart and division map |
| AI Code Assistants (Windsurf + Claude) | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/760545312 | Official Dialpad AI tool policy for engineers |
| Product Management Home | https://dialpad.atlassian.net/wiki/spaces/PM/pages/13271890 | PM team directory, launch calendar, key links |
| Product Team Chart | https://dialpad.atlassian.net/wiki/spaces/PM/pages/123371669 | PM ownership per team |
| EPD Product Portfolio | https://dialpad.atlassian.net/wiki/spaces/EPD/pages/1060601873 | Team roadmaps, Monday boards, Jira boards |
| Sprint Boards by Team | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/481525761 | All team sprint boards in one page |
| Product Engineering Metrics | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/782401805 | On-call dashboards per team |
| Connect Core Area | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/368640073 | Connect team roster and contacts |
| Sell Core Area | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1978270341 | Sell team roster and sub-teams |
| Support Core Team | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/15140287 | Support CC team roster and Jira boards |
| Shared Services Core Area | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1917681691 | Billing, Growth, Analytics Platform, Identity |
| Platform Engineering | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/321847303 | Ecosystem + Shared Services overview |
| Infrastructure Engineering | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/294354949 | Infra team, common platforms |
| Stay Informed (Release History 2025) | https://dialpad.atlassian.net/wiki/spaces/TSO/pages/1711636758 | Monthly GA release notes for all teams |
| Billing Team | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/15140327 | Billing team roster, on-call, dashboards |
| Growth Team | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/15140276 | Growth team roster and boards |
| Analytics Platform Team | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1962934347 | Analytics infra team, Jira board, onboarding |
| Power Dialer Team | https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1302822916 | Power Dialer roster and sprint backlog |

---

## Common Operations

### Create a JIRA epic (Sell example)
```
Create a JIRA epic in project DP for team Sell with the following description:
[paste output from /generate-jira-epic]
Add components: Sell | Coaching Hub
```

### Create child stories under an epic
```
Create the following stories under epic DP-1234:
[paste output from /ticket-breakdown]
```

### Read a Confluence page
```
Read the Confluence page at https://dialpad.atlassian.net/wiki/spaces/ENG/pages/15140715
and summarize the Engineering org structure.
```

### Query open tickets for a team
```
List open epics in project DP where team = "Billing" in the current sprint.
```

### Update a story with acceptance criteria
```
Update story DP-12345: add these acceptance criteria to the description:
[paste ACs]
```

---

## Troubleshooting

| Issue | Solution |
|---|---|
| "Authentication failed" | Re-authenticate via browser — run `claude mcp add --transport http atlassian https://mcp.atlassian.com/v1/mcp` again |
| "Project key not found" | Use `DP` — nearly all product work is in the Dialpad project |
| Cannot access Confluence | Verify your Atlassian account has Confluence access |
| MCP not listed | Restart Claude Code after adding the MCP |
| Wrong team's tickets returned | Add `AND "Team[Dropdown]" = "TeamName"` to JQL |

---

## Known Limitations

- Cannot bulk-create more than 50 stories in a single session (API rate limit)
- Story point field ID varies by project — confirm with Engineering
- Attachments cannot be added via MCP — attach manually in JIRA UI
- Confluence write access may require additional permissions
