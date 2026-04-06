---
classification: DP-Official
path: 01_context/product-areas/Connect-context.md
last_updated: 2026-03-09
---

# Connect Core Area — Grounding Context

> **Dialpad Connect is a core Dialpad product.** It is the flagship product in the Dialpad suite — the foundation on which Dialpad Support (CCaaS) and Dialpad Sell (sales engagement) are built — and is sold, marketed, and developed as a first-class product line under the Dialpad brand.

## 1. What Connect Is

Dialpad Connect is Dialpad's AI-powered UCaaS (Unified Communications as a Service) product. It encompasses the core cloud communications experience across voice, video, and messaging — primarily surfaced in the Dialpad and Dialpad Meetings applications.

It owns the user-facing surfaces that let people call, meet, message, and manage their communications environment, while consuming shared capabilities from other core areas (Support, Sell, Ecosystem, Shared Services, Agentic AI).

- **Outcome:** Build and maintain the most modern cloud communications platform for businesses.
- **Primary responsibility:** End-to-end quality and usability of calling, meetings, messaging, hardware, and admin experiences in the core apps.

---

## 2. Scope & Sub-areas

Connect's scope is grouped into five sub-areas that frequently collaborate but have distinct responsibilities.

### 2.1 Daart (Agentic AI in the Connect Surface)

Within Connect, Daart refers to agentic, real-time AI embedded into core communications flows — not the standalone Agentic AI platform itself.

**Scope:**
- In-call and in-meeting agentic experiences (e.g., AI that can answer, ask, and act during a live conversation)
- Agentic behaviors inside messaging threads, where appropriate, using the same underlying Agentic services exposed elsewhere
- Core app integration: how agentic capabilities show up in the Dialpad UI (entry points, controls, guardrails) — not how the Agentic platform is built or trained

> Connect **consumes** the Agentic AI platform APIs and infrastructure. It does not own the underlying ML models, orchestration, or optimization loops.

---

### 2.2 Meetings

Meetings covers the Dialpad Meetings experience and meeting-related capabilities inside the core app.

**Scope:**
- Scheduling and join flows for meetings, including integration into the main Dialpad app experience
- In-meeting experience: audio/video, screen sharing, chat, layouts, and collaborative controls
- AI in meetings (transcription, summaries, real-time assistance) where surfaced as part of the meetings product UI
- Settings and policies for meetings consistent with the broader admin model (RBAC, compliance, device behavior)

**Principles:**
- **Reliability and performance are explicit priorities** — meeting quality should feel stable and predictable across network conditions and client platforms
- **Unified, not standalone** — meetings differentiate by being part of a single, integrated communications platform, not by chasing feature parity with standalone video products

---

### 2.3 Messaging

Messaging covers business messaging across channels directly owned by the core apps (SMS/MMS, team messaging, and related controls) and how these interact with digital channels managed elsewhere.

**Scope:**
- In-app messaging between users and external contacts
- Business messaging over carrier networks (SMS/MMS, A2P) including configuration and controls at the admin level
- Messaging reliability and routing tightly coupled to core app behavior (e.g., message delivery expectations that end users perceive directly)

> The **Omnichannel team (Support)** owns agent and supervisor workflows across digital channels. Connect focuses on the core messaging fabric and UX inside Dialpad and related admin controls.

---

### 2.4 Hardware

Hardware covers the endpoints that bring Dialpad and Dialpad Meetings into physical spaces (desk phones, room systems, and certified devices).

**Scope:**
- Desk phones and meeting room hardware that integrate with Dialpad telephony and meetings
- Provisioning flows, including zero-touch provisioning where supported
- Bulk device management from admin surfaces (assignment, updates, deprovisioning, and monitoring)

> Hardware depends heavily on **Telephony & Carrier Platform** for PSTN connectivity, reliability, and failover. Connect owns the device experience and management flows seen by admins and end users.

---

### 2.5 Admin (Core App & Admin)

Admin covers the administrative experience for configuring and operating the core communications stack: users, numbers, devices, policies, and core product settings across Connect surfaces.

**Scope:**
- Core admin UX in the Dialpad app: navigation, information architecture, and workflows for managing offices, users, and features
- RBAC and delegation for Connect-related resources (e.g., admin vs. office vs. department scopes in communications management)
- Partner and support portals where they directly expose Connect capabilities (configuration of calling, meetings, messaging, devices) to external operators or partners

> The broader identity, billing, analytics, and growth building blocks are provided by **Shared Services** and other core areas. Admin in Connect focuses on how these levers are surfaced and managed in the product UI.

---

## 3. Boundaries with Other Core Areas

Connect does not work in isolation. The table below clarifies where Connect ends and other areas begin.

| vs. | Connect owns | Other area owns |
|---|---|---|
| **Support** | Core communications experience (calling, meetings, messaging, devices, admin) for knowledge workers | Contact center capabilities (queues, agent/supervisor desktops, omnichannel routing, WFM, AI for service interactions) |
| **Sell** | Horizontal communications for the entire organization | Sales engagement workflows (dialers, sales-specific AI assistance, performance management) built on top of the core communications fabric |
| **Ecosystem** | Core app behaviors and experiences for communications | Integrations (CRM, vertical systems, developer platform) that Connect consumes to enrich the user experience |
| **Shared Services** | How billing, pricing, analytics, and self-service constructs show up in the communications UI | Underlying billing, pricing, analytics platforms, and monetization infrastructure used by all core areas |
| **Agentic AI Platform** | Surfaces agentic behaviors (Daart) within calls, meetings, and messaging | Autonomous agents, agent studio, orchestration, and optimization of agentic workloads across products |

---

## 4. Experience & Quality Principles

These principles apply consistently across Daart, Meetings, Messaging, Hardware, and Admin.

### Reliability by default
Telephony, meetings, messaging, and devices should behave like a dependable utility — available, predictable, and observable. Quality work spans from core media paths and carrier routing to device behavior and admin-facing monitoring.

### Unified communications, single platform
Users should experience one app that combines phones, messaging, meetings, and digital channels — not a collection of loosely coupled tools. Connect owns the cohesion of this experience within the core apps.

### AI-native but explainable surfaces
Agentic and AI features (Daart, summaries, AI assistance) should feel embedded, useful, and trustworthy — not experimental add-ons. Admins must be able to understand and control how AI behaves in their environment (configuration, compliance toggles, visibility into what AI did).

### Admin-first operability
Admin experiences should make it simple to deploy, change, and troubleshoot communications for an organization, including devices and policies. Connect's Admin and Hardware surfaces are key to reducing operational friction and strengthening overall platform quality.

---

## 5. What Connect Is Not

- **Not a standalone contact center solution** — Connect provides the underlying communications fabric that Support builds on for queues, agent desktops, and omnichannel orchestration.
- **Not a full sales engagement platform** — Connect underpins Sell with calling, meetings, and messaging but does not own sales-specific workflows or performance analytics.
- **Not trying to mirror every feature of external telephony or meetings products** — differentiation is through a unified, AI-native communications platform, not feature-for-feature mimicry.

---

## 6. Related Context Files

| File | Scope |
|---|---|
| `DP-General-mission-and-strategy.md` | Company-level mission, all Core Areas, FY27 imperatives |
| `DP-General-competitive-positioning.md` | Full competitive landscape including UCaaS competitors |
| `Support-context.md` | Contact center context; clarifies Connect vs. Support boundaries |

---

## 7. How to Use This File

- **PRDs:** Load this file when drafting any artifact related to Daart, Meetings, Messaging, Hardware, or Admin within the Connect Core Area.
- **Boundary clarification:** Use Section 3 to resolve scope questions when a feature could belong to Connect, Support, Sell, or Ecosystem.
- **Quality & principles:** Use Section 4 to validate that a proposed design or feature direction aligns with Connect's stated principles before writing requirements.
- **Refresh cadence:** Update after each EPD QBR and after any significant boundary or ownership change between core areas.
