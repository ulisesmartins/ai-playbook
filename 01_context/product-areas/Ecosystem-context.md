---
classification: DP-Official
path: 01_context/product-areas/Ecosystem-context.md
last_updated: 2026-03-09
---

# Ecosystem Core Area — Grounding Context

> **Ecosystem is not a standalone Dialpad product — it is the connective tissue that links all Dialpad products into the rest of a customer's software environment.** Its strategic purpose is to position Dialpad as a platform rather than a closed application, enabling customers, partners, and developers to extend and adapt Dialpad through integrations, APIs, and AI-connected tooling.

## 1. What the Ecosystem Core Area Is

The Ecosystem core area enables customers to extend and adapt Dialpad through external APIs, integrations, and related tools — so that communications and AI capabilities can plug into the broader software stack they already use.

Ecosystem focuses on two primary dimensions:

- **Integrations:** Opinionated, productized connections between Dialpad and key third-party systems across CRM, helpdesk, productivity, identity, and data platforms.
- **Developer platform:** The APIs, events, webhooks, authentication model, and tooling that allow engineering teams and partners to build custom solutions on top of Dialpad.

**Strategic outcome:** Position Dialpad as a Platform — not a feature on someone else's platform.

---

## 2. Strategic Role in the Product Suite

Ecosystem is a **cross-cutting enabler**: it does not own a standalone application, but rather the connective tissue that links Dialpad into the rest of a customer's environment. Its role is to:

- Make Dialpad interoperable with the systems customers already rely on (CRM, ticketing, collaboration, identity, analytics)
- Provide a coherent, extensible surface for AI and communications capabilities to be embedded into external tools and workflows
- Enable partners and customers to tailor Dialpad to specific industries and use cases through vertical integrations and custom-built solutions

The general rule: **when a feature involves external systems, partner tooling, or programmability, Ecosystem should own or co-own the underlying platform decisions.**

---

## 3. Scope & Sub-areas

### 3.1 Core Integrations Platform

Shared infrastructure for configuring, authenticating, and managing integrations:
- OAuth flows, token storage, connection health, error handling, rate limiting
- Common patterns for mapping external entities (accounts, contacts, cases, opportunities, tickets, conversations) to Dialpad constructs (users, offices, calls, messages, agents, transcripts)

### 3.2 Productized Integrations

First-party integrations with major platforms:
- **CRM & sales systems** (SFDC, HubSpot): Surface Dialpad activity (calls, meetings, messages, summaries) inside the system of record; keep customer context synchronized both ways
- **Support & ticketing:** Log interactions, link conversations to tickets or cases, and enable agents to see relevant context from within Dialpad's agent desktop
- **Productivity & collaboration suites:** Calendar, email, file, and identity integrations that align meetings, contact data, and authentication with the broader productivity stack
- **No-code automation:** Triggers based on Dialpad events + actions that push/pull data to/from external systems without writing code

### 3.3 Developer Platform

For engineering teams and partners:

| Surface | Description |
|---|---|
| **APIs** | Telephony, messaging, users & offices, contact center config, transcripts, analytics, AI/agent actions |
| **Webhooks & events** | Subscription-based model for calls, meetings, messages, AI outputs, and lifecycle changes in near-real time |
| **Patterns & docs** | Blueprints for embedded CTI, provisioning automation, custom BI/analytics, and agent-assist integrations |

The intent: make Dialpad **programmable** — any entity or action that matters to customers should be accessible through stable, well-documented interfaces.

### 3.4 Agentic AI Ecosystem

As Agentic AI matures, Ecosystem increasingly owns the surface where AI connects to external tools:

| Component | Description |
|---|---|
| **Tool & connector registry** | Configuration for which external systems are available to agents, and under which permissions and scopes |
| **Connection management** | Authentication, secrets, rate limiting, and error recovery for tools invoked by AI agents |
| **Execution & observability** | Standard patterns for logging, auditing, and observing tool calls so AI-driven actions remain understandable and governable |

---

## 4. Design & Operating Principles

| Principle | What It Means |
|---|---|
| **Platform-first, application-neutral** | Design capabilities to serve multiple Dialpad products (Connect, Support, Sell, Meetings, Agentic AI), not a single app |
| **Security, privacy, and compliance by default** | Align with company-wide auth, authorization, data residency, and retention standards — integrations must not weaken overall posture |
| **Customer choice and interoperability** | Integrate with the tools customers already use; don't force a single all-in stack |
| **Configurability without fragmentation** | Flexible admin configuration, but consistent underlying data models — no one-off integrations that are hard to support |
| **AI-aware by design** | New integrations, APIs, and events must expose the right structure for AI use cases: high-quality transcripts, conversation metadata, outcomes, and contextual fields agents can safely consume |

---

## 5. Boundaries with Other Core Areas

Ecosystem works horizontally across the other Core Areas:

| Core Area | How Ecosystem Relates |
|---|---|
| **Support & Sell** | Deep CRM, ticketing, and analytics integrations so customer-facing teams see full conversation context inside their tools of record; contact center and sales data flows into external reporting systems |
| **Connect & Meetings** | Calling, messaging, and meetings are made aware of calendar, email, identity, and collaboration context; call/meeting data can be embedded into external applications |
| **Shared Services** | Work together to define uniform cross-product data models and interfaces exposed to third parties — avoiding divergent schema per app |
| **Agentic AI Platform** | Ecosystem owns the external tool surface (tool registry, connection management, observability); Agentic AI Platform owns the orchestration and execution logic |

---

## 6. Out of Scope

Ecosystem does **not** own:
- Core telephony, agent desktops, or end-user application UX (owned by respective product Core Areas)
- Internal-only tooling or one-off integrations not intended for long-term support or GA (unless productized into the shared platform)
- Company-level positioning, pricing, or commercial packaging decisions

---

## 7. Related Context Files

| File | Scope |
|---|---|
| `DP-General-mission-and-strategy.md` | Company-level mission, all Core Areas, FY27 imperatives |
| `DP-General-competitive-positioning.md` | Integration competitive landscape (Genesys, Amazon Connect, Five9, Aircall) |
| `Connect-context.md` | Core app context; Ecosystem provides the external connectivity Connect consumes |
| `Support-context.md` | CCaaS context; Ecosystem owns the CRM/ticketing integrations used in agent workflows |
| `Sell-context.md` | Sales engagement context; Ecosystem owns the CRM integrations Sell depends on |

---

## 8. How to Use This File

- **PRDs:** Load this file when drafting any artifact that touches integrations, external APIs, developer surfaces, webhooks, or AI tool ecosystems.
- **Boundary routing:** Use Section 5 to determine whether a problem or proposal belongs in Ecosystem vs. a product Core Area.
- **Agentic AI work:** Reference Section 3.4 when designing or reviewing features where AI agents interact with external systems.
- **Refresh cadence:** Update after each EPD QBR and after any significant change to the integration platform, developer platform scope, or agentic tool ecosystem.
