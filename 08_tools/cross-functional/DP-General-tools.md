---
version: 1.1
last_updated: 2026-03-11
change_summary: "Updated to reflect Dialpad's current AI tools stack: added Gemini (org-wide), Windsurf (Dialpad default), Atlassian Rovo, n8n, Design Studio, monday.com AI; replaced v0.dev/Bolt/Lovable with Design Studio; clarified ChatGPT as limited-license secondary model; added tool-tier framing"
status: GA
audience: PM, UI, Coding
---

# Recommended AI Tools — Cross-Functional Reference

## Overview

This guide covers AI tools that apply across PM, Design, and Engineering roles at Dialpad.
Use this as a quick-reference when choosing between tools for a cross-functional workflow,
or when onboarding a team member who is new to the AI Playbook.

---

## Tool Tiers

Understanding which tools are defaults vs. opt-in prevents duplication and ensures everyone
starts from the same baseline.

| Tier | Tools | Who |
|---|---|---|
| **Org-wide default** | Glean, Gemini | Everyone |
| **Dialpad default** | Windsurf, Claude Code, GitHub Copilot | Product Management, UI, Coding |
| **Departmental / team-specific** | Atlassian Rovo, Secoda, Writer, Harvey, Claude (claude.ai + Cowork) | Teams with configured access |
| **Automation & prototyping** | n8n, Design Studio, Gemini Canvas, monday.com AI | Per workflow |
| **Limited-license / secondary** | ChatGPT | Limited seats; second-model use only |

---

## The Dialpad AI Toolstack at a Glance

| Tool | Primary Use | Roles |
|---|---|---|
| Glean | Internal knowledge search, cross-app work assistant (Gmail, Drive, Jira, Confluence, Salesforce, Zendesk, Monday, GitHub) | PM, Design, Engineering |
| Gemini | Built into Gmail, Docs, Sheets, Slides, Drive; also Gemini app + Canvas for drafting, summarizing, analysis, formulas, slides, image generation | PM, Design, Engineering |
| Windsurf | Primary AI IDE/agent for large codebase work and refactors | Engineering |
| Claude Code | CLI coding agent for multi-file edits, architectural work, skill/agent execution | PM, Design, Engineering |
| GitHub Copilot | Inline completion and PR workflows in GitHub-native contexts | Engineering |
| Atlassian Rovo | AI inside Jira/Confluence — Q&A, ticket creation/updates, automations | PM, Engineering |
| Design Studio | AI prototyping inside Design Studio | Design, PM |
| Gemini Canvas | Co-editing workspace for docs, scripts, and lightweight tools | PM, Design |
| monday.com AI | AI agents and sidekick inside the PM platform | PM |
| n8n | Event-driven automations and AI workflows across APIs | Cross-functional |
| JIRA MCP | Ticket creation from Claude Code output | PM, Engineering |
| GitHub MCP | PR review, code context retrieval | Engineering |
| Design Studio MCP | Live Design Studio access within Claude Code | Design, Engineering |
| Glean MCP | Internal knowledge search from within Claude Code sessions | PM, Design, Engineering |

---

## Cross-Functional Workflows

### PRD → Prototype → JIRA (Full pipeline)
1. PM: `Claude Code + /draft-prd` → approved PRD
2. PM/Design: `Claude Code + /prototype-brief` or `v0.dev` → Gate 1 prototype
3. Design: Design Studio for high-fidelity screens after Gate 1
4. PM: `Claude Code + /generate-jira-epic` → epic + stories
5. Engineering: `Claude Code + /ticket-breakdown` → agent-executable stories
6. Engineering: JIRA MCP → push stories to board

### Gate Review Prep
All roles: `Claude Code + /gate-review-checklist` → readiness report with gap list

### GTM Artifact Generation
PM + PMM: `Claude Code + /gtm-draft` → What's New, messaging framework, CX checklist

### On-Call Response
Engineering: `Claude Code + /on-call-triage` → severity classification + remediation + escalation decision

---

## Cowork (Multi-Agent)

For workflows that require PM + Design + Engineering perspectives simultaneously, use
the Cowork plugins in `06_cowork-plugins/`. Cowork runs multiple specialized agents
in parallel, each with a defined role, handoff format, and exit condition.

**When to use Cowork vs. a single agent:**
- Single agent: isolated task within one discipline (code review, test writing, PRD draft)
- Cowork: tasks that require handoffs across roles (PRD review, gate review, GTM launch)

See `06_cowork-plugins/DP-General-cowork-overview.md` to get started.

---

## MCP Servers Available

| MCP | What it enables | Setup guide |
|---|---|---|
| JIRA MCP | Create/update tickets from Claude Code | `09_mcps/guides/DP-General-atlassian-setup.md` |
| GitHub MCP | Read PRs, post comments, check CI | `09_mcps/guides/DP-General-github-setup.md` |
| Design Studio MCP | Read Design Studio designs, extract component data | `09_mcps/guides/DP-General-design-studio-setup.md` |
| Glean MCP | Search internal knowledge from Claude Code | Pre-configured in this repo |
| Dialtone MCP | Query Dialtone component API from Claude Code | See `01_context/design-system/` |

---

## Tool Anti-Patterns to Avoid

| Anti-pattern | Why it fails | Better approach |
|---|---|---|
| Using ChatGPT for gate-quality PRDs | Limited seats; no Dialpad context; outputs need heavy correction | Claude Code + this repo |
| Generating code without loading codebase-map | Hallucinated file paths, wrong patterns | Load `01_context/codebase-map/` first |
| Running prototypes without Dialtone tokens | Fails Design review; requires redesign | Use Design Studio + Dialtone libraries or `05_prompts/design/DP-General-ui-from-prd.md` |
| Creating JIRA tickets manually from AI output | Error-prone; JIRA MCP or Rovo does this automatically | Configure JIRA MCP or use Atlassian Rovo |
| Combining multiple agent workflows in one session | Context drift; quality degrades | One workflow per session |
| Using Gemini or Glean for Dialpad-specific code patterns | No codebase context; produces generic outputs | Claude Code + codebase-map context |
| Using ChatGPT as a first-choice tool | Limited seats; prefer Gemini or Glean for everyday use | Gemini (org-wide default) or Glean |

---

## Getting Started

New to the AI Playbook? Start here:
1. `00_getting-started/` — Onboarding guide for your role
2. `03_skills/` — All available slash commands
3. `01_context/` — Dialpad-specific context loaded into every session
4. `06_cowork-plugins/DP-General-cowork-getting-started.md` — Multi-agent sessions
