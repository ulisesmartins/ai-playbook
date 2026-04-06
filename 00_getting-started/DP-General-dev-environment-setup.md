---
version: 1.2
last_updated: 2026-03-31
change_summary: "Fix MCP configs: correct package names, auth methods (OAuth/remote where applicable), remove fictional packages, fix help channels"
status: GA
audience: PM, UI, Coding
---

# Dev Environment Setup

This guide gets any Dialpad employee (PM, Designer, or Engineer) up and running with Claude Code and the tools needed to use this repository. You do **not** need to be an engineer to complete this setup.

> **Note:** Dialpad has an enterprise license for **Claude Code CLI only** — not the Claude Desktop app or Claude.ai web. Use the CLI as described below.

---

## Prerequisites

- A Dialpad-issued Mac laptop (standard for FTE)
- Dialpad Google Workspace account (`yourname@dialpad.com`)
- Access to [Okta](https://dialpad.okta.com/) (for SSO)
- GitHub account added to the `dialpad` org (confirm via Okta → GitHub app)

If you're missing any of these, contact IT at `it@dialpad.com` or post in `#it-helpdesk`.

---

## Step 1 — Install Claude Code

Claude Code is Dialpad's primary AI coding assistant. All Dialpad employees have access.

1. Open your terminal (Applications → Terminal, or use Spotlight: `Cmd+Space` → "Terminal")
2. Follow the official setup guide: [https://docs.claude.com/en/docs/claude-code/setup](https://docs.claude.com/en/docs/claude-code/setup)
3. When prompted to choose a login method, select **Anthropic Console** (type "Console" exactly)
4. Authenticate with your **Okta SSO** (`yourname@dialpad.com`) — your API key is generated automatically

> **Troubleshooting:** If account creation is blocked, it usually means you did not select "Anthropic Console." Restart the setup and type "Console" when prompted.
>
> For access requests, email `it@dialpad.com` with your team and use case.

Full setup reference: [Claude Code Setup — Confluence](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1974862081)

---

## Step 2 — Configure MCP Servers

MCP (Model Context Protocol) servers extend Claude Code with integrations to Dialpad's internal systems. MCP servers come in two flavours: **remote** (hosted by the vendor — authenticate via OAuth in browser, no tokens to manage) and **local** (an npm package that runs on your machine).

### Remote MCP Servers (OAuth — no tokens needed)

Most modern MCP servers are remote — you add them with a single command and authenticate via your browser. Run each command you need:

```bash
# Atlassian (JIRA + Confluence) — OAuth via browser
claude mcp add --transport http atlassian https://mcp.atlassian.com/v1/mcp

# GitHub — OAuth via browser
claude mcp add --transport http github https://api.githubcopilot.com/mcp/

# Figma (Design Studio) — OAuth via browser
claude mcp add --transport http figma https://mcp.figma.com/mcp

# Amplitude — OAuth via browser
claude mcp add --transport http amplitude https://mcp.amplitude.com/mcp

# Google BigQuery — OAuth via browser (requires BigQuery IAM roles)
claude mcp add --transport http google-bigquery https://bigquery.googleapis.com/mcp

# Monday.com — OAuth via browser (replace USER_ID with your numeric ID from monday.com profile URL)
claude mcp add monday --transport http https://mcp.monday.com/mcp --scope user:USER_ID
```

After adding each, Claude Code will prompt you to authenticate in your browser on first use. Use your Dialpad/Okta credentials where applicable.

### Local MCP Servers (npm packages)

Some servers run locally. Add these to your `~/.mcp.json` file:

```bash
touch ~/.mcp.json
```

Paste the configuration below, keeping only the servers relevant to your role:

```json
{
  "mcpServers": {
    "glean": {
      "command": "npx",
      "args": ["-y", "@gleanwork/local-mcp-server"],
      "env": {
        "GLEAN_SERVER_URL": "https://dialpad-be.glean.com"
      }
    },
    "dialtone": {
      "command": "npx",
      "args": ["-y", "@dialpad/dialtone-mcp-server"]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"]
    }
  }
}
```

> **Glean note:** The Glean local server uses OAuth 2.1 by default — it will open your browser for authentication on first use. No API token is needed. The `GLEAN_SERVER_URL` tells it which Glean instance to connect to.
>
> **Monday.com note:** Monday.com is now a remote MCP server (listed above). Find your user ID at monday.com → Avatar → My profile → copy the number from the URL.
>
> **Dialtone note:** No authentication required — it serves Dialtone design system docs, components, and tokens.
>
> **Playwright note:** No authentication required — runs a local browser on your machine. Add `"--headless"` to the args array to run without a visible browser window. See the [Playwright setup guide](../09_mcps/guides/DP-General-playwright-setup.md) for all configuration options.

### Google Workspace (Drive, Gmail, Calendar)

There is no single official MCP package for Gmail or Google Calendar. For Google Workspace integrations, use a community package like `google-workspace-mcp` or `mcp-gsuite`. See the setup guides in [`09_mcps/guides/`](../../09_mcps/guides/) for detailed instructions. Google Drive has an archived official package (`@modelcontextprotocol/server-gdrive`) that requires a Google Cloud OAuth client — see its README if needed.

### What each server enables

| MCP Server | What it enables |
|---|---|
| **Atlassian** | Summarize JIRA tickets, create stories, read Confluence pages |
| **GitHub** | Read PRs, create issues, search code, manage branches |
| **Figma** | Read design context, extract tokens, analyze components |
| **Glean** | Enterprise search — surface internal docs, people, meetings |
| **Amplitude** | Query product analytics charts, funnels, and cohorts |
| **Google BigQuery** | SQL query generation, data exploration, results summarization |
| **Monday.com** | Project tracking, board updates, status summaries |
| **Dialtone** | Live design-system token, icon, and component lookups |
| **Playwright** | Browser automation — navigate pages, click, fill forms, take screenshots, run E2E tests |

Once configured, you can ask Claude things like:

- _"Summarize JIRA ticket DP-178427"_
- _"What does the PDLC say about Design Gate criteria?"_
- _"Show me last week's Amplitude funnel for onboarding"_

---

## Step 3 — Set Up GitHub Access

GitHub access is managed via Okta. If you haven't joined the Dialpad org yet:

1. Go to [Okta](https://dialpad.okta.com/) and find the GitHub app
2. Accept the GitHub organization invitation in your Dialpad email
3. The `github-team-sync` bot will automatically add you to the right teams

For non-engineers: you only need GitHub to clone this repository and pull updates — no coding required.

```bash
# Clone this shared AI knowledge base
git clone git@github.com:dialpad/ai-playbook.git
```

Reference: [GitHub Setup — Confluence](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/667713537)

---

## Verify Your Setup

Run Claude Code and test your MCP integrations:

```bash
# Start Claude Code in the AI Playbook repo
cd ~/path/to/DPAIPlaybook
claude

# Test JIRA integration (authenticate with Okta when prompted)
# > Summarize Jira work item DP-178427
```

If Claude can read the JIRA ticket, your setup is complete.

---

## Getting Help

| Problem | Where to go |
|---|---|
| Can't install Claude Code | [Claude Code Setup guide](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1974862081) |
| GitHub access issues | Post in `#it-helpdesk` |
| MCP not connecting | Confirm VPN is on for Google Workspace; re-authenticate via OAuth |
| General AI tooling questions | Post in `#ai-coding` |
| Claude Code access requests | Email `it@dialpad.com` |

---

## Next Steps

Once your environment is set up:

1. Read [`DP-General-terminal-basics.md`](./DP-General-terminal-basics.md) — essential CLI commands for PMs and Designers
2. Read [`DP-General-github-overview.md`](./DP-General-github-overview.md) — how to navigate GitHub and this repo
3. Read [`DP-General-ai-agent-best-practices.md`](./DP-General-ai-agent-best-practices.md) — how to get the most out of Claude Code agents
