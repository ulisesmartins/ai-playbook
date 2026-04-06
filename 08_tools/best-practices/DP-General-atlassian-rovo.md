---
version: 1.0
last_updated: 2026-03-11
change_summary: "Initial version — sourced from Atlassian Support, Atlassian Blog, Atlassian Community, and eesel research through March 2026"
status: GA
audience: PM, Coding
---

# Atlassian Rovo — Best Practices

## What It Is

Atlassian Rovo is Atlassian's enterprise AI platform spanning Search, Chat, and Agents across Jira and Confluence. It is a layered system: a cross-product semantic search engine, a conversational assistant with organizational memory, and a configurable agent platform that can create tickets, update pages, and run automations. Included with Atlassian Cloud plans at varying credit tiers (standard Chat: 10 credits/request; Deep Research: 100 credits/request).

**Dialpad default use:** AI assistance inside Jira and Confluence for Q&A, ticket creation/updates, backlog organization, and release note generation. For Dialpad's Jira project structure, see `09_mcps/guides/DP-General-atlassian-setup.md`.

---

## Core Best Practices

### 1. Curate your Confluence spaces before enabling Rovo — content hygiene first
Rovo's quality is directly bounded by the quality of your indexed content. Before activating Rovo Search or Agents:
- Archive outdated pages
- Resolve conflicting documentation
- Ensure pages have accurate metadata and ownership

Rovo will surface stale, contradictory, or incomplete content with the same confidence as accurate content. Content hygiene is a prerequisite, not an afterthought.

### 2. Configure Individual Memory for every user on day one
Rovo has three memory layers:
- **Individual** — persistent user profile memory (role, team, preferences)
- **Conversation** — 30-day chat history
- **Organizational** — the Teamwork Graph (relationships between people and content)

Individual Memory allows Rovo to learn your context so you never re-establish it. Configure this in your profile settings on day one.

### 3. Use Rovo Chat for cross-product synthesis — not single-tool lookup
Rovo Chat's primary value over native Jira/Confluence search is cross-product synthesis. Use it for questions like: "What is the current status of the Daart initiative, and are there any open Jira blockers?" rather than switching between tools manually.

### 4. Use Deep Research selectively — it costs 100 credits per request
Deep Research performs multi-hop reasoning across Atlassian apps, connected tools, and optionally the web, producing a fully cited report. Reserve it for:
- Competitive analysis
- Retrospective summaries
- Incident postmortems
- Pre-planning research

Do not use it for simple lookups.

### 5. Use the `/Rovo` shortcut inline — not just in standalone Chat
Rovo is accessible via the `/Rovo` or `/ai` shortcut while editing a Jira issue or Confluence page. Use it to:
- Draft acceptance criteria directly in a ticket
- Summarize long comment threads in an issue
- Expand a bullet outline into a full Confluence section

In-context access is significantly faster than switching to a Chat tab.

### 6. Assign Rovo Agents to recurring, well-defined tasks
Pre-built agents (Backlog Organizer, Release Notes Generator, JIRA Theme Analyzer) work best for scoped, repeatable workflows:
- Sprint backlog cleanup
- Weekly release note drafting
- Epic summaries
- Meeting note distribution

Do not assign agents to ambiguous, multi-stakeholder decisions.

### 7. Use the Product Requirements Agent to keep Jira and Confluence in sync
The Product Requirements Agent auto-generates a corresponding Confluence page when a PM enters requirements in Jira, and updates that page when scope changes. Set this up as standard procedure for every epic — it eliminates the dual-maintenance burden.

### 8. Use Rovo Studio for custom agents — escalate to Forge only when necessary
Rovo Studio is the low-code visual builder for custom agents. It handles the majority of PM and Designer use cases: drafting documents, creating Jira issues, querying Confluence, triggering automations. Only use Atlassian Forge (JavaScript/TypeScript) when you need external API integrations or complex custom field behaviors.

### 9. Use Scenarios to build multi-pathway agents for complex workflows
Rovo Agents support Scenarios — branching an agent into multiple focused pathways based on input conditions. Build Scenarios for agents that handle meaningfully different cases, rather than trying to handle all cases in a single flat agent instruction.

### 10. Scope agents to tight knowledge sources
Configure each agent with the narrowest possible knowledge scope — a Support agent should only index Support-area Confluence spaces, not the entire company wiki. Scoped retrieval produces more precise answers and reduces hallucination risk.

### 11. Validate all Rovo-generated content before publishing
Rovo can hallucinate, especially when source content is sparse or contradictory. Establish a team norm: Rovo output is always reviewed before it is published to Confluence or acted upon in Jira. Build review into the workflow by default.

### 12. Stage your rollout — pilot with one team first
There is no native A/B testing or staged rollout mechanism. Pilot Rovo with one team, document what works and does not, publish internal how-to guides, and then expand. Track usage metrics before scaling.

### 13. Review data permissions carefully before enabling third-party connectors
Rovo can connect to Google Drive, Slack, GitHub, Design Studio, Amplitude, and others via native connectors and MCP. Before enabling any connector, confirm the data it surfaces is appropriate for all Rovo users. Involve your security and legal teams for sensitive content.

---

## Common Pitfalls

| Pitfall | Fix |
|---|---|
| Activating Rovo on messy Confluence content | Audit and clean content before enabling |
| Using Deep Research for trivial queries | 100 credits/request — reserve for high-value synthesis |
| Treating Rovo output as final without review | Always review before publishing or acting on AI output |
| Ignoring Individual Memory setup | Configure on day one; every skipped user loses personalization |
| Over-broad agent knowledge sources | Scope agents to the tightest relevant Confluence space or Jira project |
| Enabling Rovo org-wide without piloting | No staging mechanism — untested behavior at scale erodes trust |
| Assigning agents to ambiguous decisions | Agents are executors of well-defined tasks, not decision-makers |

---

## Recent Capabilities to Know (2025–2026)

| Feature | What it does |
|---|---|
| **Agents in Jira** (Feb 2026 beta) | AI agents assigned as Jira issue assignees; iterate via issue comments |
| **Rovo as default Jira search** (rolling out 2026) | Cross-product context, ticket type suggestions, Teamwork Graph results |
| **Rovo Dev** (Oct 2025) | Dedicated agent for engineering: code planning, generation, review |
| **Slack integration** | Rovo Agents accessible natively in Slack |
| **MCP connectors** | Design Studio, Amplitude, Canva accessible from Rovo workflows |
