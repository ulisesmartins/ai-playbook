# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is the Dialpad AI Playbook — a shared knowledge repository for Dialpad employees, with a primary focus on Product Managers, to standardize and accelerate AI adoption. It is **not a software project** — it contains prompts, skills, hooks, agent workflows, Cowork plugins, context documents, and templates used by PMs and all Dialpad employees when working with AI tools like Claude Code.

---

## Agent Instructions

- Always load `01_context/` files relevant to the user's Core Area before generating any output.
- For any PM-facing workflow, load `01_context/company/DP-General-pm-ai-mindset.md` to ground tone and expectations in Dialpad's PM operating standard.
- Use `02_templates/` as the structural skeleton for all artifacts (PRDs, JIRA tickets, design briefs, etc.).
- Validate output against `07_examples/` when a reference example exists for the artifact type. If no example exists yet, skip this step.
- Keep each agent session scoped to one workflow step; hand off using the format defined in the agent's own `CLAUDE.md`.
- When unsure about Dialpad product specifics, say so — do not guess or fabricate details.
- If the user's Core Area is known, prioritize files with the matching prefix (e.g., `Sell-` for Sell features).
- **Always update `whats-new.md`** when adding, removing, or meaningfully changing any file in this repo. Prepend a new entry at the top of the list with today's date, a short description of the change, and a relative link to the affected file. Follow the existing entry format. Also update `directory.md` if a file was added or removed.

### Resolution Order

When executing any workflow, load resources in this order:

1. **Context** — Load relevant files from `01_context/` (company, product area, personas, codebase-map)
2. **Template** — Load the applicable output template from `02_templates/`
3. **Skill / Agent** — Load the skill (`03_skills/`) or agent `CLAUDE.md` (`04_agents/`) for the specific workflow
4. **Examples** — Reference `07_examples/` for quality benchmarks if examples are present (directory may be empty)
5. **Execute** — Generate the output

### Do NOT

- Modify files in `01_context/` or `02_templates/` unless explicitly asked by the user.
- Assume codebase structure — always use `01_context/codebase-map/` indexes to navigate Dialpad's codebase.
- Combine multiple agent workflows into a single session. Complete one, hand off, then start the next.
- Fabricate Dialpad-specific product names, feature flags, API endpoints, or architecture details.
- Skip acceptance criteria validation when generating JIRA tickets or task breakdowns.

---

## File Naming Convention

Every file must begin with one of these prefixes:

```
DP-General-<name>         # Cross-functional or role-agnostic content
Support-<name>            # Specific to the Support Core Area
Connect-<name>            # Specific to the Connect Core Area
Sell-<name>               # Specific to the Sell Core Area
Ecosystem-<name>          # Specific to the Ecosystem Core Area
SharedServices-<name>     # Specific to the Shared Services Core Area
```

Use `DP-General` when in doubt. Rename to a Core Area prefix when the content is clearly area-specific.

---

## Core Areas

Dialpad's five Core Areas and their outcomes. Use the prefix to scope file lookups and output context.

| Prefix | Outcome | Key Sub-areas | Primary Workflows |
|---|---|---|---|
| `Support` | Strong alternative to Nice, Genesys, Five9 | Core contact center, AI CSAT/languages/PII, Coaching & QM, Omnichannel, WFM | PRD drafting, Prototype generation, GTM artifacts |
| `Connect` | Most modern Cloud Communications platform | Daart (Agentic AI), Meetings, Messaging, e911/SIP/Hardware, Quality & Reliability, Admin | PRD drafting, Prototype generation, JIRA generation, Code review |
| `Sell` | Credible alternative to Gong | Power dialer, Playbooks/RTA → Daart, Performance management | PRD drafting, JIRA generation, GTM artifacts |
| `Ecosystem` | Position Dialpad as a Platform | SFDC/HubSpot, Vertical integrations (Healthcare, Recruiting, Retail), Developer Platform | PRD drafting, Prototype generation, Test writing |
| `SharedServices` | Industry-leading supporting services | Billing, Growth, Pricing, Analytics platform | PRD drafting, JIRA generation, Task breakdown |

---

## Repository Structure

```
00_getting-started/   # Onboarding for AI-novice PMs and UI practitioners (dev env, terminal, GitHub, agent best practices, AI mindset)
01_context/           # Dialpad-specific grounding context (company, product areas, PDLC, personas, codebase-map)
02_templates/         # Output templates organized by role subfolder (pm/, ui/, cross-functional/)
03_skills/            # Claude Code slash commands (/skill-name), organized by role subfolder (pm/, ui/, coding/, cross-functional/)
04_agents/            # Full agent workflows organized by role subfolder (pm/, ui/, coding/, cross-functional/); each agent is a self-contained subdirectory with its own CLAUDE.md
05_prompts/           # Standalone reusable prompts organized by role subfolder (pm/, ui/, coding/, cross-functional/)
06_cowork-plugins/    # Pre-configured multi-agent Cowork session definitions, organized by role subfolder (pm/, ui/, coding/, cross-functional/)
07_examples/          # Annotated reference outputs organized by role subfolder (pm/, ui/, coding/, cross-functional/)
08_tools/             # Recommended AI tools by role (pm/, ui/, coding/, cross-functional/) with per-tool best practices in best-practices/
09_mcps/              # MCP server configs (configs/) and setup guides (guides/) for JIRA, GitHub, UI Studio, Slack, Monday
10_hooks/             # Shell scripts triggered automatically by Claude events, organized by role subfolder
```

---

## Key Conventions

### Skills (`03_skills/`)
Markdown files that become Claude Code slash commands. Each file must include:
- Purpose
- Required inputs
- Expected output format
- Known limitations

**When to use a skill vs. an agent:** Use a skill for single-step, bounded tasks that take one input and return one output (e.g., generate a prototype brief, run a ticket breakdown on a known epic). Use an agent (`04_agents/`) when the task requires multiple orchestration steps, iterative review, or tool use across more than one system.

### Hooks (`10_hooks/`)
Shell scripts that fire on Claude events. Each file must include a comment header with:
- Trigger event
- What it does
- Dependencies
- How to register it in Claude settings

### Agents (`04_agents/`)
Self-contained subdirectories, each with their own `CLAUDE.md` describing:
- Inputs and outputs
- Orchestration steps
- The best prompt/agent combination observed in practice
- Known failure modes

**When to use an agent vs. a skill:** Use an agent when the workflow has multiple steps, requires iteration, or involves tool calls (JIRA MCP, GitHub MCP). Use a skill when the task is single-shot and bounded.

### Context Files (`01_context/`)
Ground every agent, prompt, and skill in Dialpad-specific knowledge. Reference them explicitly in prompts when domain accuracy matters. `01_context/codebase-map/` contains structural indexes to help agents navigate Dialpad's codebase without full context loading.

### Cowork Plugins (`06_cowork-plugins/`)
Define Cowork task definitions. Each plugin file must specify:
- **Roles** — name, responsibility, input/output contract
- **Kickoff prompt** — initializes the session and assigns roles
- **Handoff format** — how each agent passes structured output to the next
- **Exit condition** — what "done" looks like and how to recognize it

**When to use Cowork vs. a single agent:**
- Use Cowork when the task requires handoffs across PM, UI, and Coding perspectives (e.g., PRD → prototype → JIRA epic pipeline).
- Use a single agent for isolated tasks within one discipline (e.g., code review, test writing, a standalone PRD draft).

- Network access is restricted to approved endpoints defined in the runbook.
- Results must be exported via the runbook's output contract before feeding back into main workflows.

---

## Primary Workflows

### Daily Rhythms (all roles)
- **Start day** — load prior context, surface priorities, track adoption metrics (PM), review CI/PR status (Coding), triage feedback queue (UI); agents in `04_agents/[role]/DP-General-start-day/`
- **Close day** — log decisions, capture blockers, draft standup, write persistent log for next session; agents in `04_agents/[role]/DP-General-close-day/`

### PM / UI
1. **PRD drafting** — feature brief → structured PRD
2. **PRD → agent-ready task breakdown** — PRD → scoped subtasks for coding agents; this is the primary handoff format
3. **Prototype generation** — PRD or brief → working prototype
4. **JIRA epic/story generation** — prototype + task breakdown → structured JIRA tickets
5. **GTM artifact generation** — prototype + PRD + training materials → messaging, release notes, positioning
6. **UI Gate Review prep** — validates EPD trio readiness across gate criteria

### Coding
7. **Ticket breakdown** — JIRA epic → scoped, agent-executable subtasks
8. **Code review** — structured review against defined coding standards
9. **Test writing** — spec or existing code → tests; outputs feed back into agent workflow
10. **On-call first responder** — error triage, log analysis, runbook execution, remediation, escalation; decisions logged for improvement

---

## Writing Tickets for Agent Execution

- Describe the **desired outcome**, not just the steps
- Each subtask has explicit **entry and exit criteria**
- Subtasks are small enough for a single agent session
- Acceptance criteria are written so an agent can self-validate

---

## Output Quality Signals

Use these benchmarks to evaluate whether generated output is ready:

| Artifact | Quality Bar |
|---|---|
| PRD | Matches the structure in `07_examples/`, covers all sections from `02_templates/`, and passes the gate criteria defined in workflow #6 |
| JIRA ticket | Scoped to ≤1 agent session, has self-validatable acceptance criteria, and follows the template in `02_templates/` |
| Task breakdown | Each subtask has explicit entry/exit criteria and is independently executable |
| Prototype | Functional enough to demo the core user flow described in the PRD |
| GTM artifact | Aligns with positioning in `01_context/` and covers all sections in the GTM template |
| Code review | Covers correctness, readability, test coverage, and adherence to coding standards |

---

## Versioning & Changelog

Every prompt, skill, and agent should track meaningful changes using YAML frontmatter at the top of the file:

```yaml
---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
---
```

Increment `version` and update `last_updated` and `change_summary` whenever the file is meaningfully revised. Review version histories during retrospectives to identify patterns in prompt iteration.

---

## Prompt & Agent Library Maintenance

- Document which agent/prompt combination works best in the agent's `CLAUDE.md`
- Treat prompts as code — iterate based on output quality and update the frontmatter `change_summary` when you do
- Feed test results back into agent workflows; do not let the feedback loop go stale
