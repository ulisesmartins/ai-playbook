---
classification: DP-Official
path: 01_context/personas-and-icps/DP-General-icp.md
last_updated: 2026-03-09
---

# Dialpad — Ideal Customer Profile (ICP)

## Purpose

Defines Dialpad's Ideal Customer Profiles by product line and segment. Use when drafting PRDs (Target ICP section), GTM positioning docs, pricing and packaging rationale, and sales enablement content.

> Source: [Dialpad Upmarket ICP & Buyer Personas](https://docs.google.com/presentation/d/17yd71_HIrVtLnoKNpCZc1kbhwSrKZWRMNuSoC7oZdzo) | [Understanding Our Buyers — Highspot](https://dialpad.highspot.com/items/65fb4a1dda2e8b21ae079e56) | [GTM Strategy — Agentic AI](https://docs.google.com/document/d/1FhG4NRcya4U_yCswr5vLxVf3Sx3iPCyOA7vhZNmRyrU)

---

## 1. General ICP Definition

Dialpad's ideal customer is a **business that communicates with customers at scale** and is ready to use AI to improve those interactions. The common thread across all ICPs:

- Uses voice (and increasingly digital) for customer-facing interactions
- Has a defined customer support, sales, or operations team
- Needs UCaaS + CCaaS in a unified platform OR is evaluating consolidation from two vendors
- Values AI-native capabilities (not AI as an add-on)
- Has IT or operations staff who manage the platform

---

## 2. ICP by Product Line

### Dialpad Support (CCaaS)

**Primary ICP:**

| Attribute | Requirement |
|---|---|
| Industry | Any, with preference for: Finance, Healthcare, Retail, Technology, BPO |
| Company size | 50–5,000 employees; enterprise deals typically 200+ seats |
| Current state | On Genesys, NICE, Five9, Talkdesk, or legacy on-prem CC |
| Pain point | AI as an add-on (token-based, expensive), slow QA, high AHT |
| Decision trigger | Contact center platform renewal or consolidation from UCaaS + CCaaS |
| Win condition | Faster deployment, AI included in base, unified platform |

**Competitive ICP sweet spot:** Companies that have evaluated Genesys/NICE and are sticker-shocked on pricing or implementation time. Dialpad wins on: 2-month deployment vs. 12 months, AI included vs. token-based, unified UCaaS+CCaaS.

**Revenue signal:** [Win condition] Customers who see better quality and efficiency outcomes are stickier and expand more. Enterprise lost deals are 2–3x the size of won deals — enterprise feature gap is real.

---

### Dialpad Sell (Sales Engagement)

**Primary ICP:**

| Attribute | Requirement |
|---|---|
| Industry | SaaS, Financial Services, Insurance, Real Estate, Healthcare |
| Company size | 20–500 seat sales teams |
| Current state | Using Gong + separate dialer (Outreach, SalesLoft, or manual calling) |
| Pain point | No real-time AI coaching during live calls; fragmented outbound stack |
| Decision trigger | Outbound motion formalization, new head of sales, or dialer consolidation |
| Win condition | Real-time AI coaching + Power Dialer in one platform |

**Not the ICP:** Companies who primarily need contact database (ZoomInfo) or multi-channel cadence automation (Outreach/SalesLoft as primary). Dialpad owns the communication layer and integrates with the rest of the stack.

---

### Dialpad Connect (UCaaS)

**Primary ICP:**

| Attribute | Requirement |
|---|---|
| Industry | Technology, Professional Services, Healthcare, Finance |
| Company size | 50–5,000 employees |
| Current state | On RingCentral, 8x8, Zoom Phone, or legacy on-prem PBX |
| Pain point | Bolted-on AI, poor mobile experience, complex admin |
| Decision trigger | Platform consolidation, office moves, Microsoft Teams integration need |
| Win condition | Unified UC + CC + AI in one app; Forrester "Customer Favorite" 2025 |

---

### Agentic AI Platform

**Primary ICP:**

| Attribute | Requirement |
|---|---|
| Minimum spend | $100K initial ARR |
| Industry | Contact center-heavy: Healthcare, Financial Services, Retail, Travel |
| Use case | Automate inbound support, handle routine inquiries at scale |
| Current state | Large human agent teams with high volume of repetitive inbound calls |
| Decision trigger | Cost reduction mandate, labor shortage, digital transformation initiative |
| Win condition | Autonomous voice + chat agents that deflect 40–60% of volume; human transfer as trust feature |

**Differentiator:** Agentic AI + full CCaaS stack in one platform. Startups lack CCaaS; Genesys/NICE have CCaaS but immature agentic. Dialpad uniquely covers both.

---

### Shared Services / Billing

**ICP for billing features:**

| Attribute | Requirement |
|---|---|
| Company size | Mid-market to Enterprise |
| Volume | High-volume calling OR high Agentic AI session volume |
| Finance complexity | Multi-office, multi-currency, or multi-license configurations |
| Pain point | Manual invoice reconciliation, billing anxiety, budget attribution |
| Win condition | Isolated credit pools, structured invoices, natural language usage queries |

---

## 3. Market Segments

| Segment | Employee Count | Seat Count Typical | Sales Motion |
|---|---|---|---|
| VSB (Very Small Business) | 1–50 | 1–25 | Self-serve, PLG |
| SMB | 50–250 | 25–150 | Inside sales, partner-led |
| Mid-Market | 250–2,500 | 150–1,000 | Field sales, CSM-led |
| Enterprise | 2,500+ | 1,000+ | Named accounts, PS-assisted |

---

## 4. Anti-ICP (Who Dialpad is NOT For)

| Anti-ICP | Reason |
|---|---|
| Companies that need a full CRM or marketing automation platform | Dialpad is not Salesforce or HubSpot — integrate, don't replace |
| Companies where Microsoft Teams is the primary communications layer and they want Teams-native everything | Integration exists but Dialpad won't replace Teams for enterprise-committed M365 shops |
| BPOs requiring multi-tenant agent management at scale | Gap exists today (concurrent licensing, multi-tenancy) — in evaluation |
| Companies primarily needing contact database or intent data | Not competing with ZoomInfo; integrate instead |

---

## 5. How to Use This File

- **PRD Target ICP section:** Copy the relevant ICP table from Section 2 and adapt to the specific feature's audience.
- **GTM positioning:** Load alongside `DP-General-buyer-personas.md` and `DP-General-competitive-positioning.md`.
- **Pricing decisions:** Reference segment table (Section 3) when defining which tier or add-on a feature belongs to.
- **Validation:** Do not fabricate ICP attributes. If a new product area has a distinct ICP, flag for PM review before including in output.
