# Dialpad AI Knowledge Base

A shared repository for Product Managers and all Dialpad employees to standardize AI tooling, workflows, and knowledge — accelerating how the team builds, specifies, and ships product.

---

## Why This Exists

Most professionals are stuck at basic AI interactions. This repository is the connective tissue: a living library of agents, prompts, skills, hooks, context, and templates that any Dialpad employee can pick up and use — or contribute to.

The north star is shifting the team from *AI as a writing assistant* to *AI as an execution partner* across the full PDLC.

---

## Core Areas

Dialpad is organized into five Core Areas. Files in this repo that are specific to one area are prefixed with the area name. Files that apply broadly across the organization are prefixed with `DP-General`.

---

### `DP-General` — Cross-functional
Applies across all Core Areas. Use this prefix for tooling, workflows, onboarding guides, and shared context that any Dialpad employee in any area would use.

---

### `Support` — Dialpad Support
**Outcome:** Build Dialpad Support into a strong alternative to Nice, Genesys, and Five9.

| Sub-area | Description |
|---|---|
| Core contact center | Foundational CCaaS capabilities (routing, queues, agent desktop) |
| AI Support features | AI CSAT, AI languages, PII redaction, and related AI-native support capabilities |
| Coaching & Quality Management | Supervisor tools, scorecards, call evaluation, and agent coaching workflows |
| Omnichannel | Unified handling of voice, chat, email, and digital channels |
| WFM | Workforce Management: scheduling, forecasting, adherence |

---

### `Connect` — Dialpad Connect
**Outcome:** Build Connect as the most modern Cloud Communications platform for businesses.

| Sub-area | Description |
|---|---|
| Daart | Dialpad Agentic AI in Real Time — agentic capabilities embedded in real-time communications |
| Meetings | Video and audio meetings product |
| Messaging | Team and customer messaging |
| Infrastructure & Hardware | e911, RedSky, A2P, SIP trunking (PolyAI, CCAI), deskphones, and meetings hardware |
| Quality & Reliability | Platform stability, call quality, and reliability across all Connect surfaces |
| Partner & Support Portals | Partner-facing and support-facing portal experiences |
| Core App & Admin | Main Dialpad app and admin console experience |

---

### `Sell` — Dialpad Sell
**Outcome:** Build Dialpad Sell into a credible alternative to Gong.

| Sub-area | Description |
|---|---|
| Outbound & Power Dialer | Outbound calling workflows and power dialer capabilities |
| AI Sell features | Playbooks, Real-Time Assist (RTA), and the evolution toward Daart agentic selling |
| Performance Management | Rep and team performance tracking, coaching, and reporting |

---

### `Ecosystem` — Dialpad Ecosystem
**Outcome:** Build the ecosystem that positions Dialpad as a Platform, not just a feature on someone else's platform.

| Sub-area | Description |
|---|---|
| CRM Integrations | Salesforce (SFDC) and HubSpot integrations |
| Vertical Integrations | Healthcare (Epic, Athena), Recruiting (Bullhorn, Greenhouse), Retail & WFM (Verint) |
| Business App Integrations | Zoho, ServiceNow, Dynamics, FreshDesk, FreshService, Copper |
| Developer Platform | APIs, webhooks, and developer tooling for building on Dialpad |

---

### `SharedServices` — Shared Services
**Outcome:** Provide industry-leading supporting services to all other Core Areas.

| Sub-area | Description |
|---|---|
| Billing | Subscription management, invoicing, and payment infrastructure |
| Growth | Acquisition, activation, and expansion motions |
| Pricing | Packaging, pricing strategy, and monetization |
| Analytics Platform | Shared analytics infrastructure and reporting capabilities across all Core Areas |

### File Naming Convention

Every file in this repo must begin with one of the prefixes above:

```
DP-General-<name>         # Cross-functional or role-agnostic content
Support-<name>            # Specific to the Support Core Area
Connect-<name>            # Specific to the Connect Core Area
Sell-<name>               # Specific to the Sell Core Area
Ecosystem-<name>          # Specific to the Ecosystem Core Area
SharedServices-<name>     # Specific to the Shared Services Core Area
```

**Examples:**
- `DP-General-prd-template.md` — PRD template usable by any PM across any area
- `Support-ai-csat-prd.md` — PRD specific to the AI CSAT feature in the Support area
- `Sell-playbook-agent.md` — Agent workflow for Sell's Playbooks feature
- `Connect-daart-context.md` — Grounding context for the Daart agentic platform

Use `DP-General` when in doubt. Rename to a Core Area prefix when the content becomes clearly area-specific.

---

## Status Legend

| Badge | Meaning |
|---|---|
| `DP-Official` | Sourced from or validated by Dialpad's official materials (brand, strategy, PDLC, etc.) |
| `GA` | Generally available — stable, tested, ready for team-wide use |
| `In Progress` | Actively being built or refined |
| `New` | Placeholder or just scaffolded — not yet ready for use |

Status applies to individual files. Update this README when a file's status changes.

---

## Repository Structure

| Folder | Purpose | Why it exists |
|---|---|---|
| `00_getting-started/` | AI onboarding for Dialpad employees | Most PMs and Designers have no baseline dev environment or CLI familiarity. Without this, every other folder in this repo is inaccessible to them. |
| `08_tools/` | Recommended AI tools by role | The AI tooling landscape is noisy. This folder gives each role a curated, opinionated starting point — reducing decision fatigue and preventing tool sprawl. |
| `09_mcps/` | MCP server configs and setup guides | MCP servers are the integration layer between Claude and external systems (JIRA, GitHub, Design Studio, Slack). Without pre-built configs, every team member has to figure out setup independently. |
| `05_prompts/` | Reusable single-purpose prompts | Most AI interactions start with a prompt. This folder is the shared library — so good prompts aren't lost in someone's personal notes and bad prompts don't keep getting reused. |
| `03_skills/` | Claude Code slash commands | Skills turn frequently-used prompts into one-keystroke commands (`/draft-prd`). This lowers the barrier to using AI consistently across the team. |
| `10_hooks/` | Automated Claude event hooks | Hooks eliminate the manual steps that happen *after* an AI output is generated (saving, pushing to JIRA, notifying Slack). Once built, they run silently for everyone. |
| `04_agents/` | Full multi-step agent workflows | Some tasks are too complex for a single prompt. Agents orchestrate multiple steps, tools, and decisions. This folder is the library of reusable, documented agent workflows. |
| `01_context/` | Dialpad-specific grounding context | AI outputs are only as accurate as the context they're given. This folder stores the company knowledge — strategy, product areas, PDLC, personas — that makes every agent and prompt produce Dialpad-relevant outputs instead of generic ones. |
| `02_templates/` | Standardized output templates | Consistency in PRDs, briefs, and JIRA tickets reduces review friction and makes AI-generated drafts immediately usable. Templates define what "done" looks like before the agent starts. |
| `07_examples/` | Reference outputs | People learn by example. Before producing their first AI-assisted PRD or GTM artifact, team members need to see what a good one looks like. Annotated examples also document what prompt/approach produced them. |
| `06_cowork-plugins/` | Pre-configured multi-agent Cowork sessions | Complex tasks benefit from multiple specialized agents working together. Cowork plugins are "teams in a box" — pre-defined task descriptions optimized for delegation to Cowork. |

---

### `00_getting-started/` — AI Onboarding for Dialpad Employees

The entry point for any Dialpad employee who is new to using AI tools beyond basic chat. Covers the minimum viable setup to be productive with Claude Code and related tools.

| File | Description | Status |
|---|---|---|
| `DP-General-dev-environment-setup.md` | Step-by-step guide to setting up a local dev environment (Node, Git, Claude Code CLI) | `New` |
| `DP-General-terminal-basics.md` | Essential terminal commands for PMs and Designers who don't work in the CLI regularly | `New` |
| `DP-General-github-overview.md` | How to navigate GitHub, clone repos, and understand the codebase structure | `New` |
| `DP-General-ai-agent-best-practices.md` | How to interact with AI agents effectively: prompt structure, iteration patterns, knowing when to intervene | `New` |

---

### `08_tools/` — Recommended Tools by Role

A curated, opinionated list of AI tools organized by role and use case. Avoids tool sprawl by documenting *why* each tool is recommended and when to use it over alternatives.

| File | Description | Status |
|---|---|---|
| `pm/DP-General-tools.md` | Tools for PRD drafting, prototyping, JIRA generation, GTM | `New` |
| `ui/DP-General-tools.md` | Tools for design generation, critique, prototyping, Design Studio AI workflows | `New` |
| `coding/DP-General-tools.md` | Tools for code generation, review, test writing, on-call triage | `New` |
| `cross-functional/DP-General-tools.md` | Tools used across roles (e.g., Claude Code, Notion AI, shared MCPs) | `New` |

---

### `09_mcps/` — MCP Server Configurations

Model Context Protocol (MCP) servers extend Claude Code with integrations to external systems (JIRA, GitHub, Design Studio, Slack, etc.). This folder provides ready-to-use configs and setup guides so team members don't have to figure out configuration from scratch.

Key integrations to prioritize: JIRA, GitHub, Design Studio, Slack, Monday.com.

| File | Description | Status |
|---|---|---|
| `configs/DP-General-atlassian.json` | Drop-in MCP config for JIRA (Atlassian) | `New` |
| `configs/DP-General-github.json` | Drop-in MCP config for GitHub | `New` |
| `configs/DP-General-figma.json` | Drop-in MCP config for Design Studio | `New` |
| `configs/DP-General-monday.json` | Drop-in MCP config for Monday.com | `New` |
| `configs/DP-General-glean.json` | Drop-in MCP config for Glean | `New` |
| `configs/DP-General-google-drive.json` | Drop-in MCP config for Google Drive | `New` |
| `configs/DP-General-gmail.json` | Drop-in MCP config for Gmail | `New` |
| `configs/DP-General-google-calendar.json` | Drop-in MCP config for Google Calendar | `New` |
| `configs/DP-General-google-bigquery.json` | Drop-in MCP config for Google BigQuery | `New` |
| `configs/DP-General-amplitude.json` | Drop-in MCP config for Amplitude | `New` |
| `configs/DP-General-dialtone.json` | Drop-in MCP config for Dialtone design system | `New` |
| `guides/DP-General-atlassian-setup.md` | Step-by-step setup, auth, and troubleshooting for JIRA MCP | `New` |
| `guides/DP-General-github-setup.md` | Step-by-step setup, auth, and troubleshooting for GitHub MCP | `New` |
| `guides/DP-General-figma-setup.md` | Step-by-step setup, auth, and troubleshooting for Design Studio MCP | `New` |
| `guides/DP-General-glean-setup.md` | Step-by-step setup, auth, and troubleshooting for Glean MCP | `New` |

---

### `05_prompts/` — Reusable Prompt Library

Standalone prompts organized by workflow. Unlike agents (which orchestrate multi-step processes), these are single-purpose prompts that can be copy-pasted or referenced directly. Treat prompts as code: iterate based on output quality and document what works.

| File | Description | Status |
|---|---|---|
| `pm/DP-General-prd-from-brief.md` | Generate a structured PRD from a feature brief | `New` |
| `pm/DP-General-prd-section-expander.md` | Expand a specific PRD section with more depth | `New` |
| `pm/DP-General-messaging-from-prd.md` | Draft product messaging from a PRD | `In Progress` |
| `pm/DP-General-dp-release-notes.md` | Generate release notes from a feature summary | `In Progress` |
| `pm/DP-General-positioning-doc.md` | Draft positioning from PRD and competitive context | `New` |
| `pm/DP-General-epic-from-prd.md` | Turn a PRD into a structured JIRA epic | `New` |
| `ui/DP-General-ui-from-prd.md` | Generate a UI prototype from a PRD or spec | `New` |
| `ui/DP-General-component-from-brief.md` | Generate a single UI component from a description | `New` |
| `coding/DP-General-stories-from-epic.md` | Break an epic into agent-executable stories | `New` |
| `coding/DP-General-spec-to-inline-comments.md` | Generate in-code specification comments from a PRD section | `New` |

---

### `03_skills/` — Claude Code Slash Commands

Skills are Markdown files that register as Claude Code slash commands (`/skill-name`). Any Dialpad employee with Claude Code installed can invoke these directly in their session. Each file contains a prompt body optimized for its specific task.

Each skill file must include: purpose, required inputs, expected output format, and known limitations.

| File | Slash Command | Description | Status |
|---|---|---|---|
| `pm/DP-General-draft-prd.md` | `/draft-prd` | Draft a structured PRD from a feature brief | `New` |
| `pm/DP-General-generate-jira-epic.md` | `/generate-jira-epic` | Convert a PRD into a JIRA epic with stories | `New` |
| `pm/DP-General-prototype-brief.md` | `/prototype-brief` | Generate a prototype brief from a PRD | `New` |
| `pm/DP-General-task-breakdown.md` | `/task-breakdown` | Transform a PRD into agent-executable subtasks | `New` |
| `ui/DP-General-design-critique.md` | `/design-critique` | Structured critique of a design or prototype | `New` |
| `ui/DP-General-design-brief.md` | `/design-brief` | Generate a design brief from a feature request | `New` |
| `ui/DP-General-component-spec.md` | `/component-spec` | Produce a component spec from a Design Studio frame or description | `New` |
| `coding/DP-General-spec-to-code-context.md` | `/spec-to-code-context` | Generate in-code context from a spec for downstream agents | `New` |
| `coding/DP-General-ticket-breakdown.md` | `/ticket-breakdown` | Break a JIRA epic into scoped, agent-sized stories | `New` |
| `coding/DP-General-test-from-spec.md` | `/test-from-spec` | Generate tests from a spec or existing code | `New` |
| `cross-functional/DP-General-gate-review-checklist.md` | `/gate-review-checklist` | Validate team readiness for Design or Build gate | `New` |
| `cross-functional/DP-General-gtm-draft.md` | `/gtm-draft` | Draft GTM artifact set from a PRD and prototype | `New` |
| `cross-functional/DP-General-on-call-triage.md` | `/on-call-triage` | First-pass triage of an on-call incident | `New` |

---

### `10_hooks/` — Automated Claude Event Hooks

Shell scripts that fire automatically in response to Claude Code events (tool use, session end, file edit, etc.). Hooks are the automation layer — they reduce manual steps after AI outputs are generated. Set up once by a technical PM or engineer; benefit is shared by the whole team.

Each hook file must include a comment header with: trigger event, what it does, dependencies, and how to register it in Claude settings.

| File | Trigger | Description | Status |
|---|---|---|---|
| `pm/DP-General-auto-save-prd.sh` | Session end | Saves the latest PRD artifact to a shared output folder | `New` |
| `pm/DP-General-jira-push.sh` | Tool use (post-output) | Pushes structured JIRA output to the project board | `New` |
| `ui/DP-General-figma-export.sh` | Session end | Exports prototype assets on completion | `New` |
| `coding/DP-General-lint-on-edit.sh` | File edit | Runs linter after agent modifies a source file | `New` |
| `coding/DP-General-test-feedback.sh` | Tool use (post-test) | Pipes test results back into the agent workflow | `New` |
| `cross-functional/DP-General-notify-slack.sh` | Session end | Pings a Slack channel when a PRD or spec is ready for review | `New` |

---

### `04_agents/` — Full Agent Workflows

Self-contained agent workflows for recurring, multi-step tasks. Each agent lives in its own subdirectory with a dedicated `CLAUDE.md` describing inputs, outputs, orchestration steps, and the best prompt/agent combination observed in practice.

| Agent Folder | Description | Status |
|---|---|---|
| `DP-General-prd-generator/` | Takes a feature brief → produces a structured, agent-ready PRD | `New` |
| `DP-General-prototype-builder/` | Takes a PRD or brief → produces a working UI prototype | `New` |
| `DP-General-task-breakdown/` | Transforms a PRD into scoped, agent-executable subtasks with entry/exit criteria | `New` |
| `DP-General-jira-sync/` | Converts task breakdown into JIRA epics and stories; syncs status to Monday.com | `New` |
| `DP-General-gtm-generator/` | Takes prototype + PRD + training materials → drafts messaging, release notes, positioning | `In Progress` |
| `DP-General-code-review/` | Structured code review agent against defined engineering standards | `New` |
| `DP-General-test-writer/` | Generates tests from spec or existing code; outputs feed back into agent workflow | `New` |
| `DP-General-on-call-responder/` | Triages errors, analyzes logs, executes runbooks, proposes remediation, escalates per defined rules; logs decisions for continuous improvement | `New` |

---

### `01_context/` — Dialpad-Specific Grounding Context

The highest-leverage folder in the repo. AI outputs are only as good as the context they're given. These documents ground every agent, prompt, and skill in Dialpad's actual strategy, product structure, customers, and processes. Reference these explicitly in prompts when domain accuracy matters.

| File | Description | Status |
|---|---|---|
| `company/DP-General-mission-and-strategy.md` | Dialpad mission, strategic priorities, and direction | `GA` `DP-Official` |
| `company/DP-General-brand-voice.md` | Brand tone, voice guidelines, and writing style | `GA` `DP-Official` |
| `company/DP-General-competitive-positioning.md` | How Dialpad is positioned against key competitors | `GA` `DP-Official` |
| `company/DP-General-core-values.md` | Dialpad's four core values with AI-specific guidance notes | `GA` `DP-Official` |
| `product-areas/Support-context.md` | Grounding context for the Support Core Area (contact center, AI features, QM, Omnichannel, WFM) | `GA` `DP-Official` |
| `product-areas/Connect-context.md` | Grounding context for the Connect Core Area (Daart, Meetings, Messaging, Hardware, Admin) | `GA` `DP-Official` |
| `product-areas/Sell-context.md` | Grounding context for the Sell Core Area (Power dialer, Playbooks, RTA, Performance mgmt) | `GA` `DP-Official` |
| `product-areas/Ecosystem-context.md` | Grounding context for the Ecosystem Core Area (Integrations, Developer Platform) | `GA` `DP-Official` |
| `product-areas/SharedServices-context.md` | Grounding context for Shared Services (Billing, Growth, Pricing, Analytics) | `GA` `DP-Official` |
| `pdlc/DP-General-phases-and-gates.md` | PDLC phases, Design Gate criteria, Build Gate criteria | `DP-Official` |
| `pdlc/DP-General-design-gate-checklist.md` | What the team must produce to pass the Design Gate | `DP-Official` |
| `pdlc/DP-General-handoff-standards.md` | Spec and handoff standards between PM, UI, and Coding | `DP-Official` |
| `personas-and-icps/DP-General-buyer-personas.md` | Buyer personas and decision-maker profiles | `DP-Official` |
| `personas-and-icps/DP-General-user-personas.md` | End-user personas across product areas | `DP-Official` |
| `personas-and-icps/DP-General-icp.md` | Ideal Customer Profile definitions | `DP-Official` |
| `design-system/DP-General-tokens.md` | Design token reference (colors, spacing, typography) | `In Progress` |
| `design-system/DP-General-component-library.md` | Component library overview and usage guidelines | `In Progress` |
| `codebase-map/DP-General-index.md` | Structural index of the Dialpad codebase for agent context loading | `New` |
| `codebase-map/DP-General-key-patterns.md` | Key architectural and coding patterns agents should be aware of | `New` |

---

### `02_templates/` — Output Templates

Standardized templates for the artifacts teams produce. These define the expected output shape for agents and humans alike — ensuring consistency across PRDs, tickets, briefs, and launch materials.

| File | Description | Status |
|---|---|---|
| `DP-General-prd-template.md` | Structured PRD format optimized for both human readability and agent consumption | `New` |
| `DP-General-design-brief-template.md` | Input brief for kicking off design or prototype work | `New` |
| `DP-General-launch-brief-template.md` | GTM brief covering messaging, audience, channels, and timing | `New` |
| `DP-General-jira-epic-template.md` | Epic format with outcome-oriented description, subtask structure, and acceptance criteria | `New` |
| `DP-General-jira-story-template.md` | Story format sized for single-agent-session execution with explicit entry/exit criteria | `New` |

---


Design-specific AI tooling, workflows, and references. Focuses on accelerating the Design & Specification phase of the PDLC and standardizing what Designers produce before the Build gate.

| File | Description | Status |
|---|---|---|
| `figma-ai-workflows/DP-General-plugin-guide.md` | Guide to AI plugins available in Design Studio and when to use each | `New` |
| `figma-ai-workflows/DP-General-generation-workflow.md` | End-to-end workflow for generating and iterating on frames with AI | `New` |
| `prototyping-tools/DP-General-tool-comparison.md` | Comparison of AI prototyping tools (v0, Bolt, Lovable, etc.) with recommendation | `New` |
| `prototyping-tools/DP-General-prototype-to-prd.md` | How to use a prototype as input for PRD and spec generation | `New` |

---

### `07_examples/` — Reference Outputs

Real or illustrative examples of high-quality outputs from Dialpad AI workflows. The primary resource for someone learning what "good" looks like before they produce their own. Examples should be annotated to explain what made them effective.

Files here follow the same `DP-General-` or Core Area prefix convention. Name examples after the feature and area they represent (e.g., `Support-ai-csat-prd.md`, `Sell-power-dialer-gtm.md`).

| Folder | Description | Status |
|---|---|---|
| `prd-examples/` | Agent-ready PRDs with task breakdowns — add files as they're produced | `New` |
| `prototype-examples/` | Working prototypes produced by or with AI assistance | `New` |
| `gtm-examples/` | Completed GTM artifact sets (messaging + release notes + positioning) | `New` |

---



| File | Description | Status |
|---|---|---|
| `setup/DP-General-environment.md` | Environment configuration and isolation approach | `New` |
| `DP-General-task-queue-format.md` | How to structure tasks for overnight agent execution | `New` |
| `DP-General-escalation-rules.md` | Defines what agents handle autonomously vs. what triggers a human page | `New` |
| `decision-log/README.md` | How to read and contribute to the decision log | `New` |
| `runbooks/DP-General-error-triage.md` | Runbook for common error triage scenarios | `New` |
| `runbooks/DP-General-log-analysis.md` | Runbook for log analysis patterns | `New` |

---

### `06_cowork-plugins/` — Cowork Plugins

Cowork is a Claude feature that lets you delegate complex tasks to be executed autonomously — Claude breaks the task into steps, executes independently, and delivers structured results.

Think of a Cowork plugin as a "task in a box": define the objective, context, steps, and output format once — then reuse it across similar tasks.

| File | Description | Status |
|---|---|---|
| `DP-General-cowork-overview.md` | What Cowork is, how autonomous task delegation works, and when to use Cowork vs. a single agent | `New` |
| `DP-General-cowork-getting-started.md` | How to launch a Cowork session, assign roles, and structure the first prompt | `New` |
| `pm/DP-General-prd-review-team.md` | Cowork plugin: PM drafts PRD → Critic agent reviews for gaps → Writer agent refines → output is a reviewed, polished PRD | `New` |
| `pm/DP-General-spec-breakdown-team.md` | Cowork plugin: Analyst agent reads PRD → Planner agent produces task breakdown → Estimator agent sizes each task | `New` |
| `pm/Support-qa-review-team.md` | Cowork plugin: Support-area QA workflow — agent reviews test coverage against a Support feature spec | `New` |
| `coding/DP-General-code-review-team.md` | Cowork plugin: Coder agent writes implementation → Reviewer agent critiques against standards → Fixer agent applies changes | `New` |
| `coding/DP-General-debug-team.md` | Cowork plugin: Investigator agent analyzes logs/errors → Hypothesizer agent proposes root causes → Coder agent implements fix | `New` |
| `coding/DP-General-test-coverage-team.md` | Cowork plugin: Analyst reads code → Test Writer generates tests → Critic checks coverage gaps | `New` |
| `cross-functional/DP-General-gtm-team.md` | Cowork plugin: Strategist drafts positioning → Copywriter produces messaging → Editor refines tone and consistency | `New` |
| `cross-functional/DP-General-gate-review-team.md` | Cowork plugin: Three agents each take a gate criterion category (PM, Design, Eng readiness) and produce a readiness report | `New` |

**Plugin file format:** Each Cowork plugin file must define:
1. **Roles** — list of agents, each with a name, responsibility, and input/output contract
2. **Kickoff prompt** — the opening message that initializes the session and assigns roles
3. **Handoff format** — how each agent passes structured output to the next
4. **Exit condition** — what "done" looks like and how to recognize it

---

## Contributing

- Add new prompts, skills, or agents in the appropriate folder following the conventions in `CLAUDE.md`
- When a file moves status (e.g., `New` → `In Progress` → `GA`), update its row in this README
- Before adding a new tool to `08_tools/`, document *why* it's better than existing alternatives for that use case
- Prompts and agents are living artifacts — update them when you find a better approach and note what changed

---
