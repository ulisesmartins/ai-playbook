---
classification: DP-Official
path: 01_context/personas-and-icps/DP-General-user-personas.md
last_updated: 2026-03-09
---

# Dialpad — End-User Personas

## Purpose

Defines the end-user personas who interact with Dialpad products daily. Use when defining JTBD, scoping features, validating Gate 1 presentations, and grounding PRD requirements in real user needs.

> Source: [Dialpad Supervisor Research Summary](https://dialpad.atlassian.net/wiki/spaces/MAR/pages/1626177555) | [Design Tenets Framework](https://dialpad.atlassian.net/wiki/spaces/DES/pages/2354610325)

---

## 1. Contact Center Agent (CC Agent)

**Also called:** Agent, Trainee, User/Agent

**Product context:** Dialpad Support, Dialpad Sell (Contact Center Add-On)

**Day in the life:**
- Handles inbound/outbound customer calls and digital interactions (chat, email, SMS)
- Manages on-duty/off-duty status, wrap-up time, and dispositions after each call
- Receives real-time coaching from AI (RTA cards, Playbooks, custom moments)
- Views live transcription and AI suggestions during calls
- May be part of multiple contact centers with different skill assignments

**Core needs:**
- Know which queues they're assigned to and monitor queue health
- Fast, reliable call connection with minimal friction
- AI coaching that helps — not distracts — during live calls
- Clear status management (Available, On Duty, Off Duty, Wrap-Up, RNA/Rejected)
- Visibility into their own performance metrics

**Pain points today:**
- Status management confusion: agents miss calls due to unclear on/off-duty transitions
- AI features overwhelming when poorly configured (too many RTA cards)
- Difficulty finding relevant Dialpad University training modules
- Multiple contact center memberships create complex left-panel navigation

**Key interactions:**
- Agent desktop (in-app) during calls
- Live transcript panel during interactions
- Post-call wrap-up with dispositions
- In-app CC Launchpad (real-time metrics for assigned CCs)

---

## 2. Contact Center Supervisor / Coach

**Also called:** Supervisor, CC Admin (may have both roles), Coach

**Product context:** Dialpad Support, Dialpad Sell (Contact Center Add-On)

**Day in the life:**
- Monitors live calls across all assigned contact centers (Monitor All view)
- Coaches agents via barge/whisper during live calls
- Reviews AI Scorecards, AI CSAT, and Playbooks adherence post-call
- Manages agent groups, queue health, and live dashboards (wallboards)
- Configures routing rules, skills, and hold queue settings
- May also be an agent in some contact centers (fluid persona)

**Core needs:**
- Single unified view of all contact centers they supervise (Monitor All)
- Agent group management to filter performance by subset (not all CC agents)
- Ability to manage agent state (move agents from RNA to Available)
- Real-time queue metrics: SLA, wait time, abandon rate, agent status
- QA at scale: AI Scorecards that auto-score 100% of calls, not 3–5%

**Pain points today:**
- Contact center explosion: managing 20+ CCs because skills-based routing is primitive
- Cannot easily filter analytics to just their team of agents (agent groups)
- RNA/Rejected state not visible in agent status views (needs improvement)
- Advanced features (agent off-duty timer, agent groups) not discoverable in UI

**Key interactions:**
- Monitor All Contact Centers view (live dashboard)
- Agent Leaderboard and agent status pie chart
- AI Scorecards and CSAT review workflows
- CC management settings in Admin portal

---

## 3. Company / Office Admin

**Also called:** Admin, IT Admin, Company Admin, Office Admin

**Product context:** Dialpad Connect, Dialpad Support, Dialpad Sell (all products)

**Day in the life:**
- Provisions and manages users, licenses, offices, and phone numbers
- Configures IVR, routing rules, voicemail, call handling
- Manages integrations (SFDC, HubSpot, Microsoft Teams)
- Reviews account-level analytics and usage reports
- Handles billing, credit management, and invoice review (shared with Finance)

**Core needs:**
- Bulk operations: add/remove users, assign licenses, update routing at scale
- Universal search for settings (Intelligent Admin vision in FY27)
- RBAC: delegate specific admin functions without granting full admin access
- Reliable provisioning: changes take effect immediately, no sync lag
- Clear, auditable billing: credits, usage, invoices all in one place

**Pain points today:**
- No universal search for settings — must navigate to specific pages
- Bulk operations limited; enterprise accounts with 500+ users feel the gap
- RBAC is binary (full admin vs. no admin) — cannot delegate specific functions
- Invoice complexity: nested add-ons hard to reconcile per user or department

**Key interactions:**
- Admin portal (web settings)
- User management, license assignment
- Number management (provisioning, porting)
- Billing and credits portal

---

## 4. Knowledge Worker / Operator

**Also called:** User, Knowledge Worker, Operator, Dialpad Connect User

**Product context:** Dialpad Connect (UCaaS)

**Day in the life:**
- Uses Dialpad for internal and external calls, voicemail, and messaging
- Participates in Meetings for video conferencing
- May use AI Recaps, transcriptions, and action items from calls
- Manages their own call handling (forwarding, DND, voicemail)

**Core needs:**
- Reliable call quality — no dropped calls, low latency
- Easy voicemail and transcription access
- Simple contact management and call history
- Deep Summaries and AI action items after calls
- Messaging integrated with calling (not a separate app)

**Pain points today:**
- Deep Summaries not yet GA across all call types
- Contact management needs improvement (duplicate contacts, search gaps)
- Auto DND behavior during calendar events not customizable enough

---

## 5. Billing Administrator / Finance Manager

**Also called:** Billing Admin, Finance Manager, AP Manager

**Product context:** All products — primarily interacts with admin billing portal

**Day in the life:**
- Reviews monthly invoices for accuracy before AP entry
- Manages credit balance, auto-recharge settings, and usage wallets
- Downloads usage reports for department cost allocation
- Reconciles Dialpad charges against ERP (NetSuite, SAP)
- Files support tickets when invoice discrepancies arise

**Core needs:**
- Invoice clarity: Parent-Child relationship between licenses and add-ons visible
- Separate credit pools: Calling Credits vs. AI Agent Credits vs. Dialpad Credits
- Natural language usage queries: "How much did AI agents cost last month?"
- Discrepancy resolution: portal and email PDF match always
- Cost center tagging: office/department-level cost attribution

**Pain points today:**
- Legacy invoices are flat — no hierarchy between license and nested add-ons
- Single credit pool makes AI vs. telephony cost attribution impossible
- NetSuite invoice edits don't sync back to customer portal (ghost data)

---

## 6. Persona Usage Map

| Persona | Primary Product | Gate 1 Reference | Key AI Features |
|---|---|---|---|
| CC Agent | Support, Sell | Required | RTA, Playbooks, Live Transcription, Custom Moments |
| Supervisor / Coach | Support, Sell | Required | AI CSAT, Scorecards, Live Coaching, Monitor All |
| Company / Office Admin | All | Required if feature touches admin | Intelligent Admin, Bulk ops, RBAC |
| Knowledge Worker | Connect | Required for Connect features | Deep Summaries, AI Recaps, Transcription |
| Billing Admin / Finance | All (billing) | Required for billing features | Credit dashboards, AI Usage Queries |

---

## 7. Multi-Persona Support

Dialpad's system supports fluid persona movement. A single user may be:
- Supervisor in one contact center AND agent in another
- Admin at the company level AND knowledge worker for daily calling
- Billing admin AND office admin

Design must account for fluid persona transitions without requiring separate logins or app contexts. Reference: [Design Tenets Framework](https://dialpad.atlassian.net/wiki/spaces/DES/pages/2354610325)

---

## 8. How to Use This File

- **PRDs:** Always specify which personas are in scope in the Target Personas section. Link to this file.
- **Gate 1:** Persona confirmation is a required checklist item. Use this file to confirm alignment.
- **Agents:** Load this file when generating acceptance criteria or user stories to ensure they are framed from the correct user's perspective.
