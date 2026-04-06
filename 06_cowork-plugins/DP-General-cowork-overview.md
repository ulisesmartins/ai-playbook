---
version: 2.0
last_updated: 2026-03-16
change_summary: "Corrected Cowork definition to match Anthropic's actual product — autonomous delegated execution, not multi-role prompting"
status: GA
audience: PM, UI, Coding
---

# Cowork Overview — Autonomous Delegated Work with Claude

## What Is Cowork?

Cowork is a Claude feature that lets you delegate complex tasks to Claude and have them executed autonomously. You describe the desired outcome, Claude breaks it into concrete steps, executes them independently — working with files, apps, and data sources — and delivers polished results. You stay in control: grant access only to the files and tools you want, and approve steps as needed.

Cowork is available in Claude's desktop app and works alongside Claude Code. Think of it as handing off a task to a capable colleague — you describe what you need, step away, and come back to completed work.

**Cowork is NOT multi-agent role-playing.** It is a single Claude instance autonomously executing multi-step work on your behalf.

---

## What Cowork Can Do

| Capability | Example |
|---|---|
| Research synthesis | "Research how Five9 and Talkdesk handle AI coaching, summarize findings in a comparison table" |
| Document creation | "Draft a launch brief for the AI Coaching Summary feature using our template and competitive context" |
| Data extraction | "Pull the last 30 days of coaching-related CSAT scores and summarize trends" |
| File organization | "Organize the Q2 sprint retrospective notes into a structured summary" |
| Multi-step workflows | "Review this PRD against our gate checklist, identify gaps, and draft fixes for each" |

---

## When to Use Cowork vs. Claude Code vs. a Prompt

| Use this... | When... |
|---|---|
| **Prompt** (`05_prompts/`) | You need one specific output from one input — copy-paste and go |
| **Skill** (`03_skills/`) | You need a repeatable one-step command (`/draft-prd`, `/ticket-breakdown`) |
| **Claude Code agent** (`04_agents/`) | You need a multi-step coding or technical workflow with tool calls |
| **Cowork** | You need Claude to autonomously execute a complex, multi-step task — especially non-coding work like research, document prep, or cross-functional review |

---

## Cowork Plugins at Dialpad

Cowork plugins in this repo are **pre-defined task descriptions** optimized for delegation to Cowork. Each plugin defines:

- **Objective** — What outcome you want
- **Context to load** — Which `01_context/` files Claude should read first
- **Steps** — The workflow Claude should follow
- **Output format** — What the deliverable should look like
- **Exit condition** — What "done" means

You paste the plugin into Cowork (or Claude Code) as the task description. Claude handles the execution.

### PM Plugins

| Plugin | What you get back |
|---|---|
| `pm/DP-General-prd-review-team.md` | A structured critique of your PRD from PM, Design, and Engineering perspectives |
| `pm/DP-General-spec-breakdown-team.md` | Your PRD broken into sized, agent-executable stories with entry/exit criteria |
| `pm/Support-qa-review-team.md` | A QA assessment of a Support feature release against acceptance criteria |

### Design Plugins

| Plugin | What you get back |
|---|---|
| `design/DP-General-design-review-team.md` | A structured design critique covering UX, Dialtone compliance, and accessibility |
| `design/DP-General-dialtone-audit-team.md` | An audit of a prototype or component against Dialtone token and pattern standards |

### Engineering Plugins

| Plugin | What you get back |
|---|---|
| `engineering/DP-General-code-review-team.md` | A multi-perspective code review (correctness, security, performance) |
| `engineering/DP-General-debug-team.md` | Parallel root-cause analysis with multiple hypotheses tested |
| `engineering/DP-General-test-coverage-team.md` | A full test coverage audit (unit + integration + e2e) with gap recommendations |

### Cross-Functional Plugins

| Plugin | What you get back |
|---|---|
| `cross-functional/DP-General-gtm-team.md` | A complete GTM artifact set — positioning, messaging, release notes |
| `cross-functional/DP-General-gate-review-team.md` | A simulated gate review with readiness assessment across PM, Design, and Engineering |

---

## How to Use a Cowork Plugin

1. **Pick a plugin** from the list above
2. **Open the plugin file** — it contains the full task description with placeholders
3. **Fill in the placeholders** with your actual input (PRD text, epic link, code diff, etc.)
4. **Paste into Cowork or Claude Code** as the task
5. **Review the output** — Claude delivers structured results matching the plugin's output format

---

## Output Quality

Cowork plugins produce high-quality output because they front-load the right context (from `01_context/`) and constrain the output format (matching `02_templates/`). However:

- Cowork output is a **preparation tool**, not a gate approval
- Always review the output with a human before acting on it
- Use the output to prepare for human gate reviews, not to replace them
- Re-run the plugin after fixing gaps — each iteration improves the result

---

## Relationship to Claude Code Agent Teams

Claude Code also supports **agent teams** — multiple Claude Code instances working in parallel on a shared codebase. Agent teams are best for code-heavy tasks (large refactors, parallel feature branches). Cowork plugins in this repo are designed for the broader set of Dialpad tasks — research, document creation, review workflows — that benefit from autonomous execution but don't require parallel coding agents.
