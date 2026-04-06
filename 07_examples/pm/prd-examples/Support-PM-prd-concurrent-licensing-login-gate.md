---
version: 1.0
last_updated: 2026-03-31
status: Draft
core_area: Support
skill_used: /draft-prd
reviewer: Senior PM, Support
---

# Example PRD: Concurrent License Enforcement — Agent Login Gate

> **How to use this example:** This is an annotated AI-assisted PRD prototype. Callout boxes marked **AI note** explain what the agent did; boxes marked **PM edit** explain where human judgment is needed. The scenario: a CC agent tries to log in but the customer account has exhausted its purchased concurrent license seats. Use this as a calibration reference for concurrent licensing enforcement work under the agent login/logout GA milestone.

---

## Prompt Used

```
/draft-prd

Feature: Enforce concurrent license seat limits at agent login. When a customer
account has reached its purchased concurrent seat capacity, block additional
agent logins with a clear error state and provide admins real-time visibility
into utilization and the ability to reclaim idle seats.

Core Area: Support
Target personas: CC Agent, Supervisor, Admin
Constraint: Agent login/logout project must reach GA; concurrent licensing
gap is a top enterprise deal-loss reason.
```

**Context loaded:**
- `01_context/company/DP-General-mission-and-strategy.md`
- `01_context/product-areas/Support-context.md`
- `01_context/personas-and-icps/DP-General-user-personas.md`
- `02_templates/pm/DP-General-prd-template.md`

---

## Header

| Field | Value |
|---|---|
| Feature Name | Concurrent License Enforcement — Agent Login Gate |
| Core Area | Support |
| PM | *[your name]* |
| Design | *TBD* |
| Engineering Lead | *TBD* |
| JIRA Epic | *Not yet created* |
| Design Studio | *Not yet created* |
| Status | Draft |
| Target Gate 1 | Q2 FY27 |
| Target GA | Q3 FY27 |

> **AI note:** GA target is tied to the agent login/logout project milestone. This PRD assumes that project ships first and that session tracking infrastructure is available. If the login/logout project slips, this feature's GA date moves with it.

---

## 1. Product Abstract

Concurrent License Enforcement adds a seat-check gate to the agent login flow in Dialpad Support. When an agent attempts to go On Duty and the account has reached its purchased concurrent seat limit, the system blocks the login, presents a clear error message to the agent, and surfaces a real-time utilization view to supervisors and admins — including the ability to reclaim idle or stuck sessions. This feature is a prerequisite for selling concurrent licensing as a commercial construct and directly addresses the top product-controllable reason Dialpad loses enterprise Contact Center deals.

> **AI note:** The abstract intentionally scopes to the login-gate enforcement scenario, not the full concurrent licensing billing model. Licensing tiers, overage billing, and contract terms are out of scope and owned by the pricing/packaging team.

---

## 2. Context & Problem

### What is changing?

Today, Dialpad does not enforce concurrent seat limits at the agent login layer. There is no system check when an agent clicks "Go On Duty" to verify whether a free seat is available on the account. This means:

1. Dialpad cannot credibly sell concurrent licensing — the contract promise cannot be enforced technically.
2. Enterprise customers evaluating Dialpad ask directly: "How do you enforce concurrent seats?" and the honest answer today is: "We don't."
3. Competitors (Genesys, NICE, Five9) enforce concurrent licensing and it is a standard enterprise procurement requirement.

### Why does this matter right now?

Concurrent licensing is explicitly listed in `Support-context.md` as a top product-controllable enterprise deal-loss reason. The agent login/logout project (reaching GA) provides the session-state infrastructure — login events, logout events, and session tracking — that makes enforcement technically feasible for the first time. This is the right moment to close the gap.

### The "Why" (Drivers)

- **User Pain Point:** Admins have no visibility into how many agents are logged in simultaneously, making license reconciliation impossible and support escalations hard to investigate.
- **Business Driver:** Concurrent licensing is a blocker in enterprise deals. Without enforcement, Dialpad cannot package or sell concurrent seats as a commercial offer, locking it out of accounts that require this model (BPOs, enterprise contact centers with shift-based staffing).
- **Constraint or Risk:** If enforcement is not built before concurrent licensing is sold commercially, Dialpad risks over-provisioning with no ability to remediate, and exposes the company to contract disputes.

### Desired Outcome

| Outcome Type | Description | How we'll know we got there |
|---|---|---|
| **User outcome** | Agents receive a clear, actionable error when blocked at login; admins can see utilization and reclaim seats without a support ticket | Zero "why can't I log in?" support escalations attributable to silent license enforcement failures |
| **Business outcome** | Concurrent licensing becomes a sellable, enforceable commercial construct | Concurrent licensing included in ≥10 enterprise contract negotiations within 2 quarters of GA |
| **Product outcome** | Login gate + session tracking establishes the enforcement foundation for future overage billing and entitlement management | Downstream billing/entitlement features can consume the session API without new infrastructure work |

---

## 3. Target ICP & Persona

### Ideal Customer Profile

| Attribute | Value |
|---|---|
| Segment | Mid-market / Enterprise |
| Industry | BPO, financial services, healthcare, retail |
| Company size | 100–2,000+ seats |
| Current state / competing solution | Evaluating vs. Genesys, NICE, Five9; or actively churning from one of these |
| Decision trigger | RFP requires concurrent licensing; shift-based staffing model; cost optimization (fewer licenses than headcount) |

### Target User Personas

| Persona | Role in this feature | In scope? |
|---|---|---|
| CC Agent | Attempts login; receives blocked state when capacity is reached | **Yes — primary (blocked flow)** |
| Supervisor / Coach | Sees real-time seat utilization on their live dashboard | **Yes — secondary (visibility)** |
| Company / Office Admin | Manages license capacity, reclaims idle/stuck sessions, receives utilization alerts | **Yes — primary (enforcement management)** |
| Knowledge Worker | N/A | No |
| Billing Admin | Views license utilization for reconciliation; out of scope for enforcement logic | No — future phase |

---

## 4. Proposed Solution

### What we're building

A seat-availability check injected into the agent On Duty flow. On every login attempt, the system queries the current concurrent session count against the account's purchased seat limit. If a seat is available, login proceeds normally. If the account is at capacity, login is blocked and the agent receives an explicit error state. Admins and supervisors receive a real-time utilization view with one-click seat reclaim for idle or disconnected sessions.

### User Experience: The Three Flows

#### Flow 1 — Agent Login (Seat Available) — Happy Path

> This is the unchanged baseline. Documenting it here as the reference state so any regression is immediately visible.

1. Agent clicks **Go On Duty** in the Dialpad app.
2. System checks: `active_sessions < purchased_concurrent_seats`.
3. Check passes. Login completes normally. Agent enters Available status.
4. Concurrent seat count increments by 1.

No UI change. No user-visible difference from today.

---

#### Flow 2 — Agent Login (No Seats Available) — Blocked State

> **This is the core prototype scenario.** The agent tries to log in. The account is at concurrent seat capacity.

1. Agent clicks **Go On Duty**.
2. System checks: `active_sessions >= purchased_concurrent_seats`.
3. Check fails. Login is **blocked**.
4. Agent sees the following error state in the Dialpad app:

---

**[PROTOTYPE: Agent Error Screen]**

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│   ⚠  You can't go On Duty right now                        │
│                                                             │
│   Your team has reached its maximum number of agents        │
│   logged in at the same time.                               │
│                                                             │
│   What to do:                                               │
│   • Ask your supervisor or admin to free up a seat          │
│   • Try again in a few minutes                              │
│                                                             │
│   Current capacity: ██ / ██ seats in use                    │
│   (visible to admins only — not shown to agents)            │
│                                                             │
│   [Try Again]           [Contact your admin ↗]              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

> **PM edit required:** Exact copy ("can't go On Duty") needs review against Dialpad's status terminology. "On Duty" is the correct CC agent status term per user personas. Confirm with Design that this modal pattern is consistent with other Dialpad error states.

> **AI note:** The prototype deliberately shows the seat count to admins only, not to agents. Surfacing exact utilization numbers to agents could create gaming behavior (e.g., agents waiting to see a seat open rather than notifying a supervisor). PM should validate this with CS/Support on whether agents should see any utilization signal.

---

#### Flow 3 — Admin: Seat Utilization & Reclaim

> The admin needs real-time visibility and a self-serve way to reclaim stuck sessions — critical for shift changeovers and crash-recovery scenarios.

**Admin Portal — Contact Center Settings — Concurrent Seats panel:**

```
┌─────────────────────────────────────────────────────────────────────────┐
│  Concurrent Seat Utilization                                            │
│                                                                         │
│  Purchased seats:   50                                                  │
│  In use right now:  50  ████████████████████  ← AT CAPACITY             │
│  Available:          0                                                  │
│                                                                         │
│  [View active sessions ↓]                         [Set utilization alert] │
│                                                                         │
│  Active Sessions                                                        │
│  ─────────────────────────────────────────────────────────────────────  │
│  Agent Name           Status        Login Time    Last Activity         │
│  ─────────────────────────────────────────────────────────────────────  │
│  Jordan Kim           Available     8:02 AM       8 min ago             │
│  Alex Rivera          Wrap-Up       8:15 AM       2 min ago             │
│  Sam Patel            Available     7:58 AM       47 min ago  ← IDLE ⚠  │
│  Casey Wong           Available     7:45 AM       1h 12m ago  ← IDLE ⚠  │
│  Morgan Lee           Disconnected  8:20 AM       —           ← STUCK ⚠ │
│  [... 45 more]                                                           │
│                                                                         │
│  ⚠ 2 idle sessions (>30 min inactive) · 1 disconnected session          │
│                                                                         │
│  [Reclaim idle sessions (2)]   [Reclaim disconnected (1)]   [Reclaim all ⚠] │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

> **PM edit required:** Define "idle" threshold. The prototype uses 30 minutes, but the right value depends on the customer's wrap-up time configuration. Consider making this a configurable admin setting (e.g., "Mark session idle after X minutes of inactivity"). Default suggested: 30 min.

> **PM edit required:** "Reclaim all" is a destructive action — it logs out active agents. Confirm whether this needs a confirmation dialog and an audit log entry. Recommend: confirmation dialog + audit log.

> **AI note:** The prototype flags "Disconnected" as a separate state from "Idle." A disconnected session is one where the Dialpad client lost its heartbeat (browser closed, network drop) but the session was never formally terminated. This distinction is important for the login/logout infrastructure team — these are two different reclaim paths.

---

### Supervisor: Live Dashboard Addition

On the **Monitor All Contact Centers** view, add a new utilization indicator to the header bar:

```
┌──────────────────────────────────────────────────────────────┐
│  Monitor All Contact Centers                                 │
│                                                              │
│  Agents on duty: 47 / 50 seats  [▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░]  │
│  ← new indicator, visible to supervisors                     │
└──────────────────────────────────────────────────────────────┘
```

Supervisors can see utilization at a glance but cannot reclaim sessions — that action is Admin-only.

---

### Scope

**In scope (must-have for GA):**
- Concurrent seat check at agent On Duty login
- Blocked login error state (agent-facing)
- Real-time utilization panel in Admin portal
- Idle session detection and one-click reclaim (admin)
- Disconnected session detection and one-click reclaim (admin)
- Utilization indicator in Supervisor Monitor All view
- Configurable utilization alert threshold (admin email alert at X% capacity)
- Audit log for all reclaim actions

**Out of scope (explicitly deferred):**
- Overage billing / soft-allow with automatic charge — post-GA
- Agent-facing queue / "you're #2 in line" experience — post-GA
- License purchase flow within the product — owned by billing/growth
- Predictive seat forecasting (WFM integration) — FY28
- API access to session utilization for third-party integrations — post-GA

---

## 5. Acceptance Criteria

| # | Criterion | Persona | Priority |
|---|---|---|---|
| AC-1 | When `active_sessions >= purchased_concurrent_seats`, an agent attempting to go On Duty is blocked and shown the error state described in Flow 2 | CC Agent | Must |
| AC-2 | When a seat becomes available (another agent logs out), a blocked agent can successfully go On Duty without any admin action | CC Agent | Must |
| AC-3 | The Admin portal displays real-time concurrent seat utilization (count in use, count purchased, count available) refreshing within 30 seconds of a login or logout event | Admin | Must |
| AC-4 | Admin can see the full list of active sessions with: agent name, status, login time, and last activity timestamp | Admin | Must |
| AC-5 | Admin can reclaim an idle session (inactive ≥ configured threshold); the session terminates, the seat count decrements, and the action is written to the audit log | Admin | Must |
| AC-6 | Admin can reclaim a disconnected session (no heartbeat for ≥5 min); same behavior as AC-5 | Admin | Must |
| AC-7 | Supervisor Monitor All view shows a utilization indicator (seats in use / total) in the view header, updating within 30 seconds | Supervisor | Should |
| AC-8 | Admin can configure a utilization alert; an email is sent when utilization exceeds the configured threshold (default: 90%) | Admin | Should |
| AC-9 | All reclaim actions are written to a tamper-evident audit log with: timestamp, admin user, session reclaimed, reclaim type (idle/disconnected/manual) | Admin | Must |
| AC-10 | The login gate check adds ≤200ms to the On Duty login flow under p99 load conditions | System | Must |

> **AI note:** AC-10 is a latency SLA. The seat check must not meaningfully degrade the login UX. PM should work with engineering to determine whether this is a synchronous check (blocks login until confirmed) or optimistic (allows login, reconciles async). Synchronous is safer for enforcement accuracy; optimistic is safer for UX. Recommend synchronous with aggressive caching of the seat count.

---

## 6. Success Metrics

| Metric | Baseline | Target | Measurement Method |
|---|---|---|---|
| Support escalations: "agent can't log in" due to silent license failure | Unknown (no enforcement exists today) | 0 attributable to license enforcement errors post-GA | CS ticket tagging in Salesforce |
| Admin utilization panel weekly active usage | N/A (new feature) | ≥70% of eligible admins view panel at least once per week | Amplitude: concurrent_seat_panel_viewed |
| Idle/disconnected seat reclaim actions per week | N/A | >0 (validates the reclaim flow is discoverable and used) | Amplitude: seat_reclaim_action_taken |
| Concurrent licensing included in enterprise contract negotiations | 0 (not sellable today) | ≥10 deals within 2 quarters of GA | Salesforce opportunity tagging |
| Login gate p99 latency | N/A | ≤200ms | DataDog: on_duty_login_gate_latency_p99 |

---

## 7. Competitive Context

| Competitor | Their approach | Dialpad position |
|---|---|---|
| Genesys | Hard enforcement, configurable grace period, self-serve seat management in admin | Genesys is the benchmark — match hard enforcement; differentiate on admin UX simplicity |
| NICE CXone | Concurrent + named seat hybrid; complex license management portal | Dialpad should be simpler: one enforcement model, one clear admin view |
| Five9 | Enforces concurrent seats; blockers shown to agents; admin has seat reclaim | Feature parity on core enforcement; match Five9's reclaim UX |
| Zoom CC | Does not have strong concurrent enforcement; weak admin tooling | Table-stakes differentiation — Dialpad should exceed Zoom here |

---

## 8. Open Questions

| # | Question | Owner | Status |
|---|---|---|---|
| OQ-1 | Should agents see the utilization number (e.g., "50/50 seats in use") or just the blocked message? Risk: gaming behavior vs. transparency. | PM + CS | Open |
| OQ-2 | What is the right idle timeout threshold? 30 min default, but highly workflow-dependent. Should it be configurable per contact center or globally per account? | PM + Engineering | Open |
| OQ-3 | Synchronous vs. optimistic seat check at login — which is the right tradeoff for enforcement accuracy vs. login latency? | Engineering | Open |
| OQ-4 | How does this interact with agents who are members of multiple contact centers? Does one login consume one seat regardless of CC membership count? | Engineering + PM | Open |
| OQ-5 | Does a supervisor who is also an agent consume a concurrent seat when they go On Duty? | PM + Legal/Contracts | Open |
| OQ-6 | What happens during a network partition — if the seat-check service is unreachable, does login fail open (allow) or fail closed (block)? | Engineering | Open — recommend fail open with alerting to avoid service disruption |

---

## Appendix: Error State Copy Reference

| State | Agent-facing message | Tone |
|---|---|---|
| Blocked at login | "You can't go On Duty right now. Your team has reached its maximum number of agents logged in at the same time. Ask your supervisor or admin to free up a seat." | Informative, not alarming |
| Retry success | *(No message needed — normal login flow resumes)* | — |
| Admin reclaim confirmation | "This will log out [Agent Name] and free their seat. They will need to log back in. Continue?" | Cautious, explicit |
| Utilization alert email | "Your Dialpad contact center has reached [X]% of your concurrent seat limit ([Y]/[Z] seats in use). Log in to manage active sessions." | Actionable |
