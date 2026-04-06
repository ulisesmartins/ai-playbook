---
version: 1.1
last_updated: 2026-03-16
change_summary: "Add official Glean Slack channels"
status: GA
audience: PM, UI, Coding
---

# Tools & Landscape — Why These Tools, Why Now

> Before you set up your environment, it helps to understand *what* the core tools are, *why* we picked them, and how to think about a landscape that won't sit still.

---

## What Is Git (and Why Does It Matter to You)?

If you're an engineer, you already know Git. If you're a PM or Designer, here's the short version:

**Git is a version-control system.** It tracks every change ever made to a set of files — who changed what, when, and why. Think of it as "unlimited undo + a full audit trail" for any text-based content.

**GitHub is where we host our Git repositories.** A repository (repo) is just a folder of files tracked by Git. This playbook, for example, lives in a GitHub repo. When you edit a file and "commit" it, Git records that change. When you "push," it goes to GitHub so everyone can see it.

Why this matters for non-engineers:

- **Everything in this playbook is version-controlled.** You can always see what changed, roll back mistakes, and contribute without fear of breaking things.
- **Git enables collaboration at scale.** Multiple people can work on the same content without overwriting each other.
- **You don't need to be a Git expert.** The [`Terminal Basics`](./DP-General-terminal-basics.md) and [`GitHub Overview`](./DP-General-github-overview.md) guides cover the handful of commands you actually need.

---

## Why These Tools?

Dialpad evaluated dozens of AI tools across coding, search, analytics, design, and productivity. The tools in this playbook were selected based on three criteria:

1. **Enterprise readiness** — The tool meets Dialpad's security, compliance, and data-governance requirements.
2. **Cross-role value** — It delivers meaningful productivity gains for PMs, Designers, *and* Engineers — not just one discipline.
3. **Integration depth** — It connects to the systems we already use (JIRA, Confluence, Figma, Google Workspace, GitHub) rather than requiring us to change how we work.

Here's why the primary tools made the cut:

### Claude Code

Our primary AI agent. Claude Code runs in the terminal and can read files, search codebases, call APIs, and execute multi-step workflows — all through natural-language conversation. Dialpad has an enterprise license that gives every employee access.

**Why Claude Code over alternatives?** It's the most capable agentic coding tool available today, it supports MCP integrations (so it can talk to JIRA, Confluence, Glean, etc. natively), and it works across all three disciplines — not just engineering.

### Glean

Our enterprise search layer. Glean indexes Confluence, Google Drive, Slack, JIRA, and other internal sources into a single search interface. When connected to Claude Code via MCP, it lets your AI agent search all of Dialpad's internal knowledge.

**Why Glean?** No other tool gives Claude Code the ability to search across *all* of our internal systems in one query. It's the bridge between AI and institutional knowledge.

**Official Slack channels for Glean:**

- `#glean-support` — for setup issues, access requests, and troubleshooting
- `#glean-tips-and-tricks` — for power-user tips, workflow ideas, and community Q&A

### Atlassian (JIRA + Confluence)

Our project management and documentation backbone. The Atlassian MCP gives Claude Code direct access to read and write JIRA tickets, query epics, and reference Confluence pages — without leaving the terminal.

### GitHub

Where our code and this playbook live. The GitHub MCP lets Claude Code search code, read PRs, create issues, and manage branches across any repo in the Dialpad org.

### The Rest of the Stack

The full set of supported MCPs — Amplitude, Google Drive, Gmail, Google Calendar, BigQuery, Monday.com, Design Studio, Dialtone, Figma — each solve a specific workflow need. You don't need all of them. Pick the ones relevant to your role and add more as your workflows demand it. See [`09_mcps/guides/`](../../09_mcps/guides/) for setup instructions for each one.

---

## This Will Change — And That's the Point

The AI landscape is moving faster than any technology cycle most of us have lived through. The tools, configurations, and recommendations in this playbook reflect the best choices available **right now** — not permanent decisions.

Here's what you should expect:

- **Tool recommendations will evolve.** A tool that's best-in-class today may be surpassed in 3–6 months. When that happens, we'll update the playbook. Don't over-invest in any single tool's specific UX.
- **MCP configurations will change.** Servers get updated, new integrations ship, auth flows improve. Check back on the [`09_mcps/guides/`](../../09_mcps/guides/) page periodically — it's always current.
- **New categories will emerge.** Six months ago, "design system MCPs" weren't a thing. Now Dialtone has one. Expect new integrations to appear as the ecosystem matures.
- **Your feedback drives updates.** If a tool isn't working for your workflow, or you've found something better, say something in `#ai-enablement` or `#epd-ai`. This playbook is a living document — it improves when people contribute.

The goal isn't to chase every new tool. It's to stay calibrated: know what's available, use what works, and be ready to switch when something meaningfully better arrives.

---

## Next Steps

- Proceed to [`Dev Environment Setup`](./DP-General-dev-environment-setup.md) to install Claude Code and configure your MCP servers
- Bookmark [`08_tools/`](../../08_tools/best-practices/) for your role's current recommended stack
- Read [`AI Mindset`](./DP-General-ai-mindset.md) if you haven't already — it covers the mental model behind all of this
