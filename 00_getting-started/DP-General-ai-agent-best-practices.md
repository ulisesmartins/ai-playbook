---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version — populated with Dialpad AI agent best practices from Confluence, Vincent Paquet's PM AI doc, and Claude Code setup guide"
status: GA
audience: PM, UI, Coding
---

# AI Agent Best Practices

How to interact with Claude Code and AI agents effectively at Dialpad — covering prompt structure, session management, when to intervene, and how to scale from basic chat to autonomous execution.

---

## The Mindset Shift

Most Professionals today use AI as a **writing assistant** (rewriting emails, generating summaries). The goal of this repository is to move the team toward using AI as an **execution partner** — one that drafts PRDs, generates JIRA tickets, writes tests, and executes multi-step workflows on your behalf.

> _"Think of Claude Code as a highly capable junior team member who never gets tired, doesn't mind rewrites, and has the world's most upbeat attitude. It's designed to augment your workflow, not replace your judgment."_ — Dialpad Claude Code setup guide

The shift requires a change in how you write prompts and structure your work sessions.

---

## Core Principles

### 1. Scope sessions to one workflow step

Each Claude Code session should have **one clear goal**. Don't try to draft a PRD, generate JIRA tickets, and write release notes all in one session.

**Good:** _"Draft a PRD for the Cost Centers feature using the template in `02_templates/pm/DP-General-prd-template.md`."_

**Bad:** _"Draft a PRD, then create JIRA tickets, then write release notes."_

When you finish one step, hand off to the next session using the structured output format defined in the relevant agent's `CLAUDE.md`.

---

### 2. Give context up front — don't make Claude guess

Claude only knows what you give it. The more Dialpad-specific context you provide, the better the output.

**Always reference:**
- The relevant `01_context/` file for your Core Area (e.g., `01_context/product-areas/SharedServices-context.md`)
- The template you want to use (e.g., `02_templates/pm/DP-General-prd-template.md`)
- Any existing JIRA ticket, Confluence doc, or prior output that's relevant

**Example opening prompt:**

```
Read 01_context/product-areas/SharedServices-context.md and 02_templates/pm/DP-General-prd-template.md.
I'm drafting a PRD for Cost Centers — a feature that lets admins tag offices, users, and licenses
with percentage-based cost allocations for internal reporting. The JIRA epic is DP-178000.
Draft the PRD following the template structure. Ask me clarifying questions before starting.
```

---

### 3. Be specific in requests

Vague prompts produce vague outputs. The more precise your instruction, the less back-and-forth you'll need.

| Less effective | More effective |
|---|---|
| "Make the header lighter" | "Change the header background color to `var(--dt-color-foreground-primary)`" |
| "Add acceptance criteria" | "Add acceptance criteria for the billing webhook event — it must fire within 5 seconds of a subscription change" |
| "Summarize this doc" | "Summarize this JIRA ticket in 3 bullet points: what it is, why it matters, and the open questions" |

---

### 4. Ask for explanations — don't just accept output

Claude can explain its reasoning. This is valuable when:
- You're not sure if the output is correct
- You want to learn from the approach
- You're reviewing a code change in a PR

```
Explain why you structured the acceptance criteria this way.
What are the risks you saw in this approach?
What alternatives did you consider?
```

---

### 5. Review everything before shipping

Claude Code is powerful but not infallible. Hallucinations happen — especially for Dialpad-specific product details, JIRA ticket numbers, and API names.

**Always verify:**
- Product names and feature flags (don't let Claude invent them)
- JIRA ticket references (confirm they exist in your sprint)
- Architecture claims (validate against `01_context/codebase-map/`)
- Any number or metric Claude cites

If Claude says something that doesn't sound right about Dialpad's product, say _"I'm not sure that's accurate — check the context file or tell me your source."_

---

### 6. Treat prompts like code — iterate and version

A prompt that produces a great output is worth preserving. When you find an approach that works:
- Save it in `05_prompts/` with a descriptive filename
- Add a frontmatter version header and `change_summary`
- Document what made it effective in a comment at the top

When a prompt stops working (because the workflow changed or Claude updated), update it and note what changed. This is the same discipline as maintaining code.

---

### 7. Load context in the right order

For any workflow, load resources in this order before generating output:

1. **Context** (`01_context/`) — Company, product area, personas, codebase-map
2. **Template** (`02_templates/`) — The expected output structure
3. **Skill or Agent** (`03_skills/` or `04_agents/`) — The specific workflow instructions
4. **Examples** (`07_examples/`) — Reference outputs if available
5. **Execute** — Generate the artifact

This ensures Claude has all the grounding it needs before it starts writing.

---

## When to Use What

| Task | Best approach |
|---|---|
| Single-step artifact (one PRD section, one JIRA story) | Direct Claude Code prompt or `/skill` command |
| Multi-step artifact (full PRD → task breakdown → JIRA) | Agent workflow (`04_agents/`) — one step per session |
| Cross-functional review (PM + Design + Eng perspectives) | Cowork plugin (`06_cowork-plugins/`) |

---

## Session Management Tips

- **Always start Claude from the repo root** so it reads `CLAUDE.md` automatically
- **One session per step** — finish cleanly, save the output, then start the next session
- **Name your outputs** — save PRD drafts to a dated file so you can iterate without losing history
- **Don't rely on session memory** — Claude doesn't remember between sessions; re-load context explicitly
- **Use `/` commands** — skills like `/draft-prd`, `/task-breakdown`, and `/gtm-draft` are pre-loaded with the right context and output format

---

## Security & Data Handling

Claude Code is approved at Dialpad for programming use and Dialpad workflows. Follow these rules:

- **Do not paste PII** (customer names, phone numbers, email addresses) into Claude Code prompts
- **Do not paste unpublished financials** or confidential deal details
- Use anonymized or illustrative data for examples
- For data sensitivity questions, check with Legal or the AI Engineering / Ethics Working Group
- Approved for all use cases: Gemini, ChatGPT Enterprise. Approved for programming use: Claude Code, Windsurf

Reference: [AI FAQ — Confluence](https://dialpad.atlassian.net/wiki/spaces/EPD/pages/2045542501)

---

## Approved AI Tools at Dialpad

| Tool | Best for | Access |
|---|---|---|
| **Claude Code** | Agentic coding, PRD drafting, ticket generation, bulk edits | All Dialpad employees via Okta (CLI only) |
| **Windsurf** | In-IDE autocomplete, chat, agentic coding | All engineers via Okta |
| **Gemini Code Assist** | In-IDE autocomplete, code review | All engineers; opt-in trial |
| **GitHub Copilot** | Inline completion, PR workflows, GitHub-native tasks | Dialpad employees only |
| **ChatGPT Enterprise** | General content, research, non-code tasks | License required — see IT |

Reference: [AI-code assistants — Confluence](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/760545312) | [Dialpad AI tools guide](https://dialpad.atlassian.net/wiki/spaces/~557058e1804db5edab4e909c35d7652e6e33fb/pages/2475327523)

---

## Common Failure Modes and How to Fix Them

| Symptom | Likely cause | Fix |
|---|---|---|
| Output ignores Dialpad context | Context files weren't loaded | Explicitly reference `01_context/` files in your prompt |
| Output structure is wrong | Template wasn't specified | Reference `02_templates/` explicitly |
| Claude invents feature names | No grounding context | Load the product area context file; tell Claude "do not guess" |
| Session runs off-track | Too many goals in one session | Scope to one step; start a new session for the next |
| Output quality degrades over time | Prompt wasn't iterated | Treat it like code — update and version your prompts |

---

## Next Steps

- Try your first skill: run `claude` from the repo root and type `/draft-prd`
- Browse `03_skills/pm/` for PM-specific slash commands
- Read the agent instructions in `04_agents/pm/DP-General-prd-generator/CLAUDE.md` to see how a full workflow is structured
- Join `#ai-enablement` on Slack to share what's working and discover others' approaches
