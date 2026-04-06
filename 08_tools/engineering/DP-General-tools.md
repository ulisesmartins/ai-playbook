---
version: 1.2
last_updated: 2026-03-11
change_summary: "Promoted Claude Code to #1; Windsurf moved to #2"
status: GA
audience: Coding
---

# Recommended AI Tools for Engineers at Dialpad

## Overview

This guide lists the AI tools Dialpad Engineers use across the development lifecycle —
from ticket intake through code review and on-call response. Each entry covers the recommended
use case, Dialpad codebase alignment, and how it connects to the AI Playbook.

**Default stack:** Claude Code (CLI agent) + Windsurf (AI IDE) + GitHub Copilot
(inline completion). All three are provisioned for Dialpad employees; start with this trio before adding
other tools.

---

## Primary Tools by Workflow

### 1. Claude Code (claude.ai/code)
**Best for:** Multi-file edits, architectural work, ticket breakdown, test writing, code
review, on-call triage, and any task where skills/agents in this repository apply

Claude Code is the CLI-based coding agent. It runs skills in `03_skills/engineering/` as
slash commands and connects to Dialpad's codebase context via `01_context/codebase-map/`.

| Workflow | Skill / Agent |
|---|---|
| Break epic into stories | `/ticket-breakdown` |
| Generate tests from spec | `/test-from-spec` |
| Triage an on-call incident | `/on-call-triage` |
| Draft a postmortem | `/postmortem-draft` |
| Scaffold an RFC or Eng Spec | `/rfc-scaffold` |
| Annotate code with spec comments | Use `05_prompts/engineering/DP-General-spec-to-inline-comments.md` |
| Full code review | `04_agents/engineering/DP-General-code-review/` |
| Full test writing session | `04_agents/engineering/DP-General-test-writer/` |

**Codebase context:** Always load `01_context/codebase-map/DP-General-index.md` and
`DP-General-key-patterns.md` before generating code. These prevent hallucinated file paths
and ensure pattern compliance.

---

### 2. Windsurf
**Best for:** Large codebase work, multi-file refactors, feature implementations that span
many files, and agentic tasks that require deep codebase awareness inside an IDE

When working across the `dialpad/web-clients` or `dialpad/firespotter` repos, use Windsurf
for file-level work. Point Windsurf's context at key files from `01_context/codebase-map/`
to improve accuracy on Dialpad-specific patterns.

---

### 3. GitHub Copilot
**Best for:** Inline autocomplete, single-function generation, and PR workflows in
GitHub-native contexts

Use Copilot for line-by-line completions and quick helper functions. For larger tasks
(full component, test file, feature implementation), use Claude Code or Windsurf with
this repo's context — they understand Dialpad's patterns and Dialtone.

**GitHub MCP:** With the GitHub MCP configured (`09_mcps/guides/DP-General-github-setup.md`),
Claude Code can read PR diffs, check CI status, and post review comments directly.

---

### 4. Pilot Shell (Claude Code Enhancement)
**Best for:** Spec-driven development, TDD-enforced quality, persistent memory, and structured project workflows inside Claude Code

Pilot Shell is a professional dev environment that wraps Claude Code with opinionated guardrails — enforcing TDD, spec-driven development, quality hooks, and persistent memory. It adds structured commands on top of Claude Code's CLI agent capabilities.

| Command | What it does |
|---|---|
| `/spec` | Generate or refine a specification before writing code |
| `/setup-rules` | Generate project-specific CLAUDE.md rules from codebase analysis |
| `/create-skill` | Create a reusable Claude Code skill from a workflow |

Additional features include smart model routing, a local Pilot Shell Console dashboard, and Dialpad-specific integration guidance for `web-clients` and `firespotter` repos.

**Best practices:** See `08_tools/best-practices/DP-General-pilot-shell.md`

---

### 5. Gemini
**Best for:** Everyday writing — summarizing incident retrospectives, drafting PR descriptions,
writing engineering RFC summaries, spreadsheet formulas. Gemini is built into Gmail, Docs,
and Sheets so no context switching is required.

Not recommended for Dialpad codebase work — use Windsurf or Claude Code for that.

---

### 6. Atlassian Rovo
**Best for:** AI assistance inside Jira — Q&A on existing tickets, automated story updates,
Confluence doc generation without leaving the Atlassian suite.

---

### 7. JIRA MCP (via Claude Code)
**Best for:** Creating stories directly from ticket breakdown output

After running `/ticket-breakdown`, use the JIRA MCP to push stories directly to the board
without copy-paste. See `09_mcps/guides/DP-General-atlassian-setup.md`.

---

### 8. Datadog / PagerDuty (referenced by on-call agent)
**Best for:** Log retrieval and alert routing during on-call incidents

The on-call triage agent (`/on-call-triage`) references Datadog log queries and PagerDuty
escalation paths. With MCP integration, the agent can query logs directly. Without MCP,
paste relevant log lines into the agent session manually.

---

## Tool Selection Guide

| I need to... | Use this |
|---|---|
| Break an epic into stories | Claude Code + `/ticket-breakdown` |
| Write code across multiple files | Windsurf |
| Write tests from ACs | Claude Code + `/test-from-spec` |
| Triage an on-call alert | Claude Code + `/on-call-triage` |
| Draft a postmortem | Claude Code + `/postmortem-draft` |
| Scaffold an RFC or Eng Spec | Claude Code + `/rfc-scaffold` |
| Annotate code with spec comments | `05_prompts/engineering/DP-General-spec-to-inline-comments.md` |
| Generate a Vue 3 component | Claude Code + `05_prompts/design/DP-General-component-from-brief.md` |
| Do a full code review | `04_agents/engineering/DP-General-code-review/` |
| Spec-driven dev with TDD enforcement | Pilot Shell + `/spec` |
| Inline autocomplete in IDE | GitHub Copilot |
| Summarize a retro or draft a PR description | Gemini (in Docs / Gmail) |
| Create JIRA tickets from output | JIRA MCP or Atlassian Rovo |

---

## Code Generation Rules (Always Active)

1. Always load `01_context/codebase-map/DP-General-key-patterns.md` before generating Vue 3 code
2. Use Dialtone components and tokens — never hardcode colors or create custom components for existing patterns
3. Every generated component must include `vi.mock()` tests — no raw API calls in tests
4. Feature flags wrap ALL new behavior: `v-if="featureFlag('[FLAG_NAME]')"`
5. All TypeScript props must have explicit types — no `any`

---

## Getting Started

1. Install Claude Code: `npm install -g @anthropic-ai/claude-code`
2. Install Windsurf (see `00_getting-started/DP-General-dev-environment-setup.md`)
3. Open `DPAIPlaybook` as your Claude Code working directory
4. Load codebase-map context at the start of each session
5. Configure JIRA and GitHub MCPs (see `09_mcps/guides/`)
6. Run `/ticket-breakdown` on your next epic

---

## Best Practices

Detailed best practices for each tool are in `08_tools/best-practices/`:

| Tool | Best Practices File |
|---|---|
| Claude Code | `08_tools/best-practices/DP-General-claude-code.md` |
| Windsurf | `08_tools/best-practices/DP-General-windsurf.md` |
| GitHub Copilot | `08_tools/best-practices/DP-General-github-copilot.md` |
| Glean | `08_tools/best-practices/DP-General-glean.md` |
| Pilot Shell | `08_tools/best-practices/DP-General-pilot-shell.md` |
| n8n | `08_tools/best-practices/DP-General-n8n.md` |
