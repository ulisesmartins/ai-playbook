---
version: 1.0
last_updated: 2026-03-16
change_summary: "Initial version — 17 key terms covering tools, concepts, and repo structure"
status: GA
audience: PM, UI, Coding
---

# Glossary

Quick reference for every major term, tool, and concept used in this playbook. Terms are defined as they apply within Dialpad.

---

## Agent

A self-contained, multi-step AI workflow run in Claude Code. Each agent lives in its own subdirectory under `04_agents/` with a dedicated `CLAUDE.md` that describes inputs, outputs, orchestration steps, and known failure modes. Use an agent when the task requires multiple steps, iteration, or tool calls across more than one system. For single-step tasks, use a [Skill](#skill) instead.

**Where to find them:** `04_agents/pm/`, `04_agents/design/`, `04_agents/engineering/`, `04_agents/cross-functional/`

---

## CLAUDE.md

A markdown file placed at the root of a repository (or inside each agent subdirectory) that provides standing instructions to Claude Code. The root `CLAUDE.md` defines the resolution order for generating output (Context → Template → Skill/Agent → Examples → Execute), file-naming conventions, Core Area prefixes, and behavioral guardrails.

**Where to find it:** Root of the repository

---

## Claude Code

Dialpad's primary AI agent tool. Claude Code runs in the terminal and can read files, search codebases, call APIs, and execute multi-step workflows through natural-language conversation. It supports MCP integrations (JIRA, Confluence, Glean, GitHub, and more) and works across Product Management, UI, and Coding roles. Dialpad has an enterprise license for every employee.

**Where to learn more:** `00_getting-started/DP-General-dev-environment-setup.md`, `08_tools/best-practices/DP-General-claude-code.md`

---

## Context

Dialpad-specific grounding documents — company strategy, product-area details, PDLC definitions, personas, design system tokens, and codebase-map indexes. Context files are loaded first in the resolution order so that every agent, prompt, and skill produces Dialpad-relevant output instead of generic content. Never modify context files unless explicitly asked.

**Where to find them:** `01_context/company/`, `01_context/product-areas/`, `01_context/pdlc/`, `01_context/personas-and-icps/`, `01_context/design-system/`, `01_context/codebase-map/`

---

## Core Areas

One of Dialpad's five organizational divisions. Each Core Area has a file-name prefix used to scope file lookups and output context:

| Prefix | Core Area | Focus |
|---|---|---|
| `Support-` | Support | Contact center, AI CSAT, QM, WFM |
| `Connect-` | Connect | Cloud communications, Daart, Meetings |
| `Sell-` | Sell | Power dialer, Playbooks, Performance management |
| `Ecosystem-` | Ecosystem | Integrations, Developer Platform |
| `SharedServices-` | SharedServices | Billing, Growth, Pricing, Analytics |
| `DP-General-` | Cross-functional | Applies across all Core Areas |

---

## Cowork

A Claude feature that lets you delegate complex tasks and have them executed autonomously. You describe the desired outcome, Claude breaks it into steps, executes them independently — working with files, apps, and data sources — and delivers polished results. Available in Claude's desktop app. Cowork is a single Claude instance doing autonomous multi-step work on your behalf — it is NOT multi-agent role-playing.

Cowork plugins in this repo (`06_cowork-plugins/`) are pre-defined task descriptions optimized for delegation to Cowork — they specify what context to load, what steps to follow, and what the output should look like.

**Where to find them:** `06_cowork-plugins/pm/`, `06_cowork-plugins/design/`, `06_cowork-plugins/engineering/`, `06_cowork-plugins/cross-functional/`

---
A pre-configured multi-agent session where multiple specialized Claude Code instances work together on a shared task — each playing a defined role (e.g., Researcher, Writer, Critic, Coder) and passing structured outputs to one another. Use Cowork when a task requires handoffs across PM, Design, and Engineering perspectives. Use a single agent for tasks within one discipline.

## Dialtone

Our Dialpad's design system. Includes design tokens (colors, spacing, typography), a Vue component library, and usage guidelines. Dialtone has a dedicated MCP server that provides live token, icon, and component lookups so Claude Code can reference design-system elements directly.

**Where to learn more:** `01_context/design-system/`, `09_mcps/guides/DP-General-dialtone-setup.md`

---

## EPD

**Engineering, Product, and Design** — a legacy term for the three disciplines that make up Dialpad's product development organization. Now referred to by role: Product Management, UI, and Coding. This playbook serves all three roles with shared context, templates, skills, and agent workflows.

---

## Glean

Dialpad's enterprise search layer. Glean indexes Confluence, Google Drive, Slack, JIRA, and other internal sources into a single search interface. When connected to Claude Code via MCP, it lets your AI agent search all of Dialpad's internal knowledge in one query.

**Slack channels:** `#glean-support` (setup help), `#glean-tips-and-tricks` (power-user tips)

**Where to learn more:** `08_tools/best-practices/DP-General-glean.md`, `09_mcps/guides/DP-General-glean-setup.md`

---

## Hook

A shell script that fires automatically in response to a Claude Code event — before or after a tool call, on notification, or when a session ends. Hooks automate repetitive actions that happen around the agent's work (saving artifacts, running linters, pushing to JIRA, notifying Slack). Configure hooks in `~/.claude/settings.json` (global) or `.claude/settings.json` (project-local).

**Where to find them:** `10_hooks/pm/`, `10_hooks/design/`, `10_hooks/engineering/`, `10_hooks/cross-functional/`

---

## MCP (Model Context Protocol)

A protocol that extends Claude Code with integrations to external systems. MCP servers connect Claude Code to JIRA, Confluence, GitHub, Glean, Amplitude, Google Drive, Gmail, Google Calendar, BigQuery, Monday.com, Figma, Dialtone, and others. Drop-in JSON config files live in `09_mcps/configs/`, and step-by-step setup guides live in `09_mcps/guides/`.

**Where to learn more:** `09_mcps/guides/`

---

## MkDocs

The static-site generator that publishes this playbook as a website. Uses the MkDocs Material theme for card grids, tabs, search, dark mode, and admonitions. Content is authored in Markdown on the `master` branch and automatically built and deployed to GitHub Pages on every push.

---

## PDLC (Product Development Life Cycle)

Dialpad's framework for moving a feature from idea to launch. The PDLC defines phases and gates — including the Design Gate (Gate 1) and Build Gate (Gate 2) — that the EPD trio (PM + Design + Engineering) must pass before proceeding. Several playbook workflows (gate-review checklists, PRD templates, handoff standards) map directly to PDLC stages.

**Where to learn more:** `01_context/pdlc/DP-General-phases-and-gates.md`, `01_context/pdlc/DP-General-design-gate-checklist.md`

---

## Prompt

A standalone, reusable natural-language instruction for a specific task. Unlike skills (which are slash commands) or agents (which are multi-step workflows), prompts are copy-paste instructions organized by role. Prompts are treated as code — version-controlled with YAML frontmatter and iterated based on output quality.

**Where to find them:** `05_prompts/pm/`, `05_prompts/design/`, `05_prompts/engineering/`

---

## Skill

A Markdown file that registers as a Claude Code slash command (`/skill-name`). Skills are for single-step, bounded tasks — one input, one output. Each file includes the purpose, required inputs, expected output format, prompt body, and known limitations. Install by copying the `.md` file into `~/.claude/commands/` (global) or `.claude/commands/` (project-local).

**Where to find them:** `03_skills/pm/`, `03_skills/design/`, `03_skills/engineering/`, `03_skills/cross-functional/`

---

## Template

A structural skeleton that defines the expected format for an output artifact — PRDs, design briefs, JIRA epics, launch briefs, and more. Templates are loaded second in the resolution order (after context) and ensure consistency across AI-generated and human-written documents.

**Where to find them:** `02_templates/pm/`, `02_templates/design/`, `02_templates/cross-functional/`
