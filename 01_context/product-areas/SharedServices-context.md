---
classification: DP-Official
path: 01_context/product-areas/SharedServices-context.md
last_updated: 2026-03-09
---

# Shared Services Core Area — Grounding Context

> **Shared Services is not a standalone Dialpad product — it is the portfolio's common systems layer for commercial logic, activation flows, and measurement.** It does not own an end-user application surface; instead it provides the foundational capabilities that make all other Dialpad products easier to buy, easier to activate, easier to measure, and easier to operate consistently.

## 1. What Shared Services Is

Shared Services centralizes foundational capabilities that would otherwise be rebuilt independently inside multiple product areas. These capabilities are exposed to other teams through shared services and APIs so feature teams can focus on product-specific workflows while relying on common platform primitives.

This file covers the four Shared Services domains: **Billing, Growth, Pricing, and Analytics**.

**Strategic outcome:** Provide industry-leading supporting services to all other Core Areas.

---

## 2. Why This Area Exists

As Dialpad expanded across multiple products, the same underlying needs kept appearing in different places — especially around purchasing, onboarding, reporting, and shared operational logic. Shared Services exists to:

- Reduce duplicate work across Core Areas
- Improve consistency across products
- Create deep expertise in inherently complex domains (billing logic, experimentation frameworks, data pipelines)

The result is a more scalable product and engineering model where common flows become more reliable, more consistent, and easier for other teams to adopt.

---

## 3. Core Philosophy

> "The core philosophy of Shared Services is to expose services that unblock other teams rather than becoming a gatekeeper for every implementation detail."

In practice: Shared Services provides reusable levers, configuration, and infrastructure so product teams can move with minimal direct involvement from the shared team after the primitives are in place. This model favors standardization where it improves consistency, while preserving enough flexibility for product teams to build differentiated customer experiences on top.

---

## 4. Domain Scope

### 4.1 Billing

Billing is the shared system layer supporting subscriptions, usage-based services, credits, invoicing, purchase changes, renewals, and contract-linked lifecycle mechanics across Dialpad products.

**Key structural concepts:**

| Concept | Description |
|---|---|
| **SKU vs. Pricing** | SKUs define *what* the customer is buying; Pricing defines *how much* they pay based on currency, billing cycle, office context, payment method, and negotiated terms |
| **The office as billing unit** | Each office has exactly one plan; billing happens at the office level even when multiple offices belong to the same company |
| **Independent vs. unified billing** | Offices can bill independently (own cycles, currencies, terms) or be unified under the main office (all follow main office's billing rules) |
| **Service models** | Pay-as-you-go (no reset), monthly pooled entitlements/fair-use bundles, pre-purchased commitments renewing monthly or per billing cycle |
| **Metering** | Billing interprets metering units (minutes, pages, messages, sessions, conversations), applies reset logic, and determines how overages or downstream consumption are handled |

**Credits:**
- Usage-based charges deduct from a customer credit balance
- Recurring credit packages function like commitments that renew with the billing cycle and provide discounted usage across eligible services
- Current direction: moving from office-isolated credit behavior toward **company-level credit consumption**, where entitlements remain office-specific but credits are managed centrally at the company/primary-office level

**Contract billing:**
- Contracted customers are often managed in NetSuite with offices grouped for billing purposes — internal groupings not always visible in the product admin experience

The billing situation is a coordination problem across catalog structure, pricing rules, office hierarchy, credit logic, metering, invoicing, and contract systems. The area stays tightly coupled to quote-to-bill consistency, invoice visibility, usage transparency, and reducing manual intervention caused by fragmented configuration or mismatched system behavior.

---

### 4.2 Growth

Growth is the reusable product layer for onboarding, discovery, signup, experimentation, upsell, cross-sell, fraud controls, and buying flow infrastructure.

Its job: give product teams common frameworks for user activation and in-product commercial moments without requiring each team to rebuild those systems from scratch.

**Operating direction:** Shift from one-off feature ownership toward reusable platform services — onboarding frameworks, sign-up flows, experimentation infrastructure, and feature flagging support.

---

### 4.3 Pricing

Pricing, in the Shared Services context, is the architecture that connects packaging, value metrics, quoting logic, usage rules, and invoice outcomes into a coherent model. It sits close to Billing because the platform must support different pricing models, tiers, credits, proration rules, and usage semantics without forcing every product launch to reinvent the commercial logic.

**Recurring theme:** Pricing simplification — fewer mismatches between quoting, provisioning, billing, and invoicing, with a stronger connection between packaging decisions and the underlying platform rules.

---

### 4.4 Analytics

Analytics is the shared reporting and insight foundation for the product portfolio. Its role:

- Provide standardized data models and trusted reporting foundations
- Maintain a consistent visual language and common platform for customer-facing analytics across products
- Make analytics easier for feature teams to adopt while keeping definitions, APIs, and reporting experiences consistent across surfaces

---

## 5. How the Four Domains Fit Together

Billing, Pricing, Growth, and Analytics are tightly connected because they shape the full customer arc — from discovery to purchase to activation to usage to understanding outcomes.

```
Growth      →  creates reusable entry and activation flows
Pricing     →  defines the commercial structure
Billing     →  executes entitlement and charge mechanics
Analytics   →  explains what happened through trustworthy reporting
```

This is especially important for products with **usage-based behavior, self-service flows, credits, or cross-product upgrades** — where customer understanding depends on all four layers behaving consistently.

---

## 6. Design Principles

| Principle | What It Means |
|---|---|
| **Consistency over local reinvention** | Core flows (purchasing, onboarding, reporting, discovery) should feel consistent across products, not rebuilt differently in each area |
| **Platform first, not project first** | Build reusable services and frameworks many teams can adopt, rather than solving the same problem repeatedly as a one-off |
| **Domain logic belongs close to the platform** | Complex logic (billing rules, experimentation systems, analytics data models) benefits from centralized ownership — correctness and consistency matter as much as feature speed |
| **Trust matters** | Shared Services is a trust layer: customers and internal teams depend on it for accurate billing, understandable pricing, reliable analytics, and predictable purchase flows |

---

## 7. Common Tensions

The central tension in Shared Services is **standardization vs. team autonomy**:

- Too centralized → product teams get blocked on dependencies and coordination overhead
- Too loosely governed → teams recreate their own billing logic, onboarding patterns, pricing rules, or reporting definitions → inconsistency and duplication

The intended balance: **shared infrastructure with enough flexibility for product teams to configure and move independently.**

---

## 8. Boundaries with Other Core Areas

| Core Area | How Shared Services Relates |
|---|---|
| **Support** | Billing supports CCaaS tiers and add-ons; Analytics provides unified reporting across voice, digital, and AI |
| **Connect** | Growth supports UCaaS onboarding and activation flows; Billing handles Connect plan and add-on mechanics |
| **Sell** | Billing handles Power Dialer and sales engagement packaging; Analytics surfaces Sell performance data |
| **Ecosystem** | Pricing and Billing define the commercial constructs Ecosystem exposes through APIs and partner portals |
| **Agentic AI** | Billing enables usage-based billing for Agentic sessions; Growth supports self-service Agentic activation flows |

---

## 9. Related Context Files

| File | Scope |
|---|---|
| `DP-General-mission-and-strategy.md` | Company-level mission, all Core Areas, FY27 imperatives including Shared Services philosophy |
| `Support-context.md` | CCaaS packaging tiers and add-ons that Billing must support |

---

## 10. How to Use This File

- **PRDs:** Load this file when drafting any artifact that touches billing, pricing, onboarding, self-service flows, experimentation, or analytics infrastructure.
- **Billing design:** Reference Section 4.1 for the full mental model of office hierarchy, credit mechanics, and service model types before writing billing-related requirements.
- **Boundary routing:** Use Section 8 to determine whether a problem belongs in Shared Services vs. a product Core Area.
- **Refresh cadence:** Update after each EPD QBR and after any significant change to billing architecture, pricing model, or analytics platform scope.
