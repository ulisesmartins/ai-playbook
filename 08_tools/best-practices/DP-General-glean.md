---
version: 1.0
last_updated: 2026-03-11
change_summary: "Initial version — sourced from Glean docs, Glean blog, and community research through March 2026"
status: GA
audience: PM, UI, Coding
---

# Glean — Best Practices

## What It Is

Glean is Dialpad's enterprise AI search and work assistant. It indexes 100+ connected apps (Confluence, Jira, Slack, Gmail, Drive, GitHub, Salesforce, Zendesk, Monday) and provides permissions-aware search, a conversational assistant, and configurable AI agents. The third-generation assistant (September 2025) introduced Fast and Thinking modes, Deep Research, and the Enterprise Graph.

**Dialpad default use:** Finding internal context before any workflow — past PRDs, research, competitive intel, prior roadmap decisions. The Glean MCP in `09_mcps/` allows Claude Code to run Glean searches directly inside agent sessions.

---

## Core Best Practices

### 1. Use natural language — not keyword search
Glean's engine understands intent, not just keywords. Write queries as you'd ask a colleague: "What is our policy on customer data retention?" instead of "data retention policy." Full-sentence queries consistently return better results.

### 2. Structure prompts with Role → Task → Format
Glean's assistant responds best to prompts that specify: (1) role ("as a PM"), (2) task ("summarize the last 30 days of Jira activity for Project X"), and (3) format ("in 5 bullet points"). Research shows this structure eliminates ambiguity and dramatically improves first-pass output quality.

### 3. Always specify a time window for trend and activity queries
Anchor queries with an explicit lookback period ("in the last 30 days," "since January 1"). Without a time anchor, Glean surfaces the most popular result, not the most recent.

### 4. Use Advanced Prompts (multi-step) for complex workflows
Glean's Advanced Prompts feature lets you chain sequential retrieval steps — each step builds on the previous. Example: Step 1 — find all open Jiras for a component. Step 2 — read each result in full. Step 3 — synthesize a status summary. More accurate than a single mega-prompt.

### 5. Save high-value prompts to the Prompt Library and share them
If you build an effective prompt — a weekly status report builder, a customer health summary — save it to the Prompt Library and publish it to your team. The library is org-wide discoverable. This turns individual prompt investment into a team asset.

### 6. Use Glean Agents for recurring, structured tasks
Glean Agents (GA February 2025) work best for repeatable workflows: weekly account health summaries, sprint retrospective inputs, onboarding information packs, escalation reviews. Build the agent using the natural language builder, test in draft mode, then schedule once results are stable.

### 7. Always spot-check cited sources
Glean cites the source documents it used. Always click through to verify the source supports the claim — especially for compliance-sensitive queries or externally shared output. This is your primary hallucination check.

### 8. Use Fast vs. Thinking mode intentionally

| Mode | Use for |
|---|---|
| **Fast** | Quick lookups, summaries, routine queries |
| **Thinking** | Complex research, cross-system synthesis, ambiguous questions |

Thinking mode costs more processing time but substantially improves multi-hop reasoning.

### 9. Use Deep Research for cross-system synthesis
Deep Research performs multi-hop reasoning across Atlassian, connected tools, and optionally the web, producing a fully cited, structured report (100 credits per request vs. 10 for standard Chat). Use it for: quarterly business reviews, roadmap inputs, incident retrospectives, competitive analysis. Do not use it for simple lookups.

### 10. Define narrow retrieval scopes for each Agent step
When building agents, filter retrieval at each step: specific Confluence spaces, specific Jira project keys, specific time windows. Broad retrieval produces generic summaries; scoped retrieval produces actionable ones.

### 11. Understand that results are permissions-aware — and differ by user
Glean enforces your existing permissions model — users only see results they are authorized to see. Results differ by user. This can cause confusion when sharing a "search result" with a colleague who doesn't see the same answer. Communicate this to your team.

### 12. Treat Glean answers as a synthesized first draft
Glean's RAG architecture dramatically reduces hallucinations, but it cannot fix foundational data governance problems. If your Confluence has stale pages, Glean will surface stale answers with confidence. For high-stakes decisions (legal, financial, compliance), always go to the source document.

---

## Common Pitfalls

| Pitfall | Fix |
|---|---|
| Keyword-style searches | Use full natural-language queries |
| Ignoring cited sources | Always spot-check; clicking through is your hallucination check |
| Mega-prompts for complex tasks | Use Advanced Prompts with chained, scoped steps |
| No time window on trend queries | Always specify a lookback period |
| Activating agents before testing | Keep in draft mode until results are stable |
| Stale Confluence data | Content hygiene is a prerequisite to AI quality |
| Treating output as a final source | Verify high-stakes answers against the source document |
