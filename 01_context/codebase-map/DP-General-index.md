---
classification: DP-Official
path: 01_context/codebase-map/DP-General-index.md
last_updated: 2026-03-09
status: In Progress
---

# Dialpad Codebase Map — Structural Index

## Purpose

Structural index of Dialpad's codebase for use by AI agents navigating engineering work. Load this file before any code review, test writing, ticket breakdown, or spec-to-code task to orient the agent to where things live.

> Source: [Design System Team — Confluence](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/316014948) | [Dialtone GitHub](https://github.com/dialpad/dialtone) | [Contributing with code as a designer](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/2438299852)

---

## 1. Primary Repositories

| Repository | Framework | Purpose |
|---|---|---|
| `dialpad/web-clients` | Vue 3 | Dialpad 2.0 — main web application (current platform) |
| `dialpad/firespotter` | Vue 2 (migrating) | Dialpad 1.0 monorepo — legacy app + telephony services |
| `dialpad/dialtone` | Vue 3 + Less | Design system monorepo (Dialtone) |
| `dialpad/DialApp-Framework` | Vue 3 | Partner/embedded app framework |
| `gluru/agent-assist-widget` | Vue 3 | Kare Agent Assist Widget |

---

## 2. Key Paths (dialpad/web-clients — Dialpad 2.0)

This is the primary front-end codebase for all new feature development.

```
src/
  components/        # Reusable UI components (use Dialtone first)
  views/             # Page-level components
  store/             # Vuex/Pinia state management
  services/          # API calls and business logic
  router/            # Vue Router configuration
  utils/             # Shared utility functions
  assets/            # Static assets
  i18n/              # Internationalization strings
```

**Key product areas in web-clients:**

| Area | Notes |
|---|---|
| Contact Center | CC Agent desktop, Monitor All, Supervisor tools |
| Admin Portal | Web settings, user management, routing config |
| Billing | Credits, invoices, usage dashboard |
| Messaging | In-app messaging and notifications |
| Meetings | Video conference integration |
| AI Features | RTA, Playbooks, Scorecards, Transcription, Summaries |

---

## 3. Key Paths (dialpad/firespotter — Dialpad 1.0)

Legacy monorepo. Still active for telephony services and some contact center surfaces.

```
ubervoice/          # Dialpad 1.0 web client (Vue 2 — being migrated)
uc_client/          # Dialpad Meetings client (Vue 3)
integration_microservice/  # Integration surfaces (Salesforce, HubSpot, etc.)
backend/            # Python services for telephony, routing, signaling
```

**Important:** New features should NOT be built in `ubervoice` (Dialpad 1.0 / Vue 2) unless specifically required as a bridge for Power Dialer or other migration dependencies.

---

## 4. Design System (dialpad/dialtone)

```
packages/
  dialtone-tokens/      # Source of truth for design tokens
  dialtone-css/         # CSS utility classes
  dialtone-vue/         # Vue 3 components (use these, not native HTML elements)
  dialtone-icons/       # SVG icons → Vue components
  dialtone-emojis/      # Emoji assets
  dialtone-mcp-server/  # MCP server for Claude Code integration
apps/
  dialtone-documentation/  # VuePress docs site → dialtone.dialpad.com
```

---

## 5. Backend Services

Dialpad's backend is primarily Python, running in the `firespotter` monorepo and separate microservices.

| Service Area | Technology | Notes |
|---|---|---|
| Telephony / SIP | Python | Core call routing, signaling |
| API Gateway | Python (Flask/Django) | REST APIs used by web clients |
| AI Pipeline | Python + LLM orchestration | Transcription, summaries, RTA |
| Analytics | Python + Elasticsearch/Pinot | Real-time and historical analytics |
| Billing | Python + CSR + NetSuite integration | Subscription management, invoicing |
| WFM | Python | Forecasting, scheduling, adherence |

**Python library packaging:** A cross-cutting initiative is underway to standardize how Python libraries are shared between the monorepo and other repos. Ask Engineering before assuming a library is importable across repos.

---

## 6. Key External Systems

| System | Role | Integration Method |
|---|---|---|
| Salesforce (SFDC) | CRM — primary sales system | REST API, SFDC embedded app |
| HubSpot | CRM — alternative to SFDC | REST API |
| NetSuite | ERP — invoicing and finance | Event-driven sync |
| Stripe | Payment processing (under evaluation) | REST API |
| Twilio | SMS/messaging fallback | REST API |
| PolyAI / CCAI | SIP trunking partners | SIP |
| Elasticsearch | Search and analytics backend | ES8 (upgrading from ES7) |
| Pinot | Real-time analytics (replacing some ES use cases) | JDBC/REST |

---

## 7. Feature Flags

All new features should be gated by a **feature flag** in CSR (Dialpad's internal provisioning system). Feature flags:
- Follow a consistent naming convention (ask Engineering for the team-specific pattern)
- Are documented in the JIRA story before engineering starts
- Must be set correctly before QA testing can begin
- CSR is Dialpad's internal product catalog and configuration system

**Never invent feature flag names.** Always ask Engineering or reference the JIRA story for the actual flag name.

---

## 8. Testing

| Layer | Framework | Notes |
|---|---|---|
| Unit tests (Vue) | Vitest / Jest | Component and utility function tests |
| Integration tests | Playwright / Cypress | End-to-end user flows |
| Visual regression | Automated visual testing | Part of Dialtone CI/CD for component library |
| QA | Manual + automation | QA sign-off required before Gate 2 |

---

## 9. CI/CD

- **Platform:** GitHub Actions + GitHub Pages
- **Deployment:** Feature branches → staging → production
- **Release cadence:** First Thursday of every month (production releases)
- **Dialtone:** Versioned and published via `semantic-release-bot`
- **Feature flags:** New features deployed to production behind flags; flag turned on for EAP, then GA

---

## 10. How to Use This File

- **Before code review:** Load to understand which repo and path is relevant to the PR
- **Before test writing:** Load to identify the correct test framework and path for the feature
- **Before ticket breakdown:** Load to correctly scope front-end vs. back-end work
- **Validation:** Do not guess file paths or repo names. If unsure, flag for Engineering confirmation.
- **Always pair with:** `DP-General-key-patterns.md` for coding conventions.
