---
version: 1.2
last_updated: 2026-03-31
change_summary: "Fix package name to @gleanwork/local-mcp-server; OAuth by default, no API token needed"
status: GA
audience: PM, UI, Coding
---

# Glean MCP Setup Guide

## Purpose

Configures the Glean MCP so Claude Code can search Dialpad's internal knowledge base —
Confluence docs, past PRDs, research summaries, customer data, and competitive intel —
directly from agent sessions. Already pre-configured for this repository via the Glean
Claude Code integration.

---

## Prerequisites

- Claude Code installed
- Dialpad Glean account (all Dialpad employees have access via SSO)

---

## Step 1: Add MCP Configuration

Add this config to your `~/.mcp.json` file inside `"mcpServers"`:

```json
"glean": {
  "command": "npx",
  "args": ["-y", "@gleanwork/local-mcp-server"],
  "env": {
    "GLEAN_SERVER_URL": "https://dialpad-be.glean.com"
  }
}
```

The Glean MCP uses **OAuth 2.1** by default — on first use it will open your browser for Okta SSO authentication. No API token to create or manage.

**Note:** The Glean MCP is already active in this repository via the `mcp__glean_claude-code`
integration. If you are working within `DPAIPlaybook`, you can use Glean search without
additional setup.

---

## Step 2: Verify the Connection

```
/mcp list
```

`glean` or `glean_claude-code` should appear. Then test:

```
Search Glean for recent PRDs about AI CSAT in the Support core area.
```

---

## Glean Search Best Practices

Getting the most out of Glean — whether through the web UI, Slack, or the Claude Code MCP — comes down to knowing the right search techniques. These tips are sourced from the [official Glean docs](https://docs.glean.com/user-guide/basics/how-to-search-in-glean).

### Search Operators

| Operator | What it does | Example |
|---|---|---|
| `"term"` | Requires the exact word in results | `"featureY"` |
| `"exact phrase"` | Requires words appear adjacent, in order | `"coaching summary"` |
| `"word1" "word2"` | Requires both words anywhere in doc | `"CSAT" "Support"` |
| `updated:` | Filters by modification date | `updated:yesterday`, `updated:past_week`, `updated:past_month` |
| `from:` | Filters by person (owner, contributor, assignee, commenter) | `from:jane.doe`, `from:me` |
| `type:` | Filters by document type | `type:presentation`, `type:bug` |
| `app:` | Filters by source application | `app:confluence`, `app:jira`, `app:google-drive` |
| `my:history` | Restricts to docs you've visited in the last 6 months | `my:history power dialer` |

### Tips for Better Results

- **Use natural language or keywords** — Glean supports both. `"How does billing handle refunds?"` and `billing refund process` both work.
- **Search content, not just titles** — Glean indexes full document content, so you can find docs even if you don't know the title.
- **Append file types** — Add `pptx`, `pdf`, or `doc` to filter by format (e.g., `competitive analysis pptx`).
- **Use autocomplete** — Start typing a document title you've visited before and Glean will suggest it.
- **Combine operators** — Stack filters for precision: `from:me updated:past_week type:presentation`.

### Advanced Features

- **Custom field filters** — For complex apps like JIRA, Salesforce, or Zendesk, you can filter by custom fields. Click the info icon in the search box to see available fields for the current result set.
- **App exclusion** — Use the sidebar filter toggles to hide irrelevant apps from results.
- **Zoom transcripts** — Meeting recordings and their transcripts surface automatically when relevant.
- **Advanced query example:** `status:"closed won" vertical:"enterprise" feature name`

### Glean in Slack

Use the `/glean` command in any Slack channel to search inline — results are visible only to you unless you share them. This is handy for quick lookups during conversations.

### Browser Extension Shortcuts

| Platform | Shortcut |
|---|---|
| Mac | `Cmd+J` opens the Glean sidebar |
| Windows | `Alt+J` opens the Glean sidebar |
| Firefox | `Control+J` opens the Glean sidebar |

### Sharing Searches

You can copy a Glean search URL and share it with teammates. Results are always personalized and permission-filtered per viewer — the same link may return different results depending on what each person has access to.

---

## Common Operations

### Find prior art before writing a PRD
```
Search Glean for any PRDs or specs related to "power dialer auto-advance" in Sell.
Include documents from the last 2 years.
```

### Pull competitive intel
```
Search Glean for the latest Genesys competitive analysis or battle card.
```

### Find a person or team
```
Who owns the billing infrastructure at Dialpad? Who is the PM for SharedServices?
```

### Check past decisions
```
Search Glean for the decision log or ADR for how Dialpad handles feature flag rollouts.
```

---

## What Glean Indexes at Dialpad

| Source | Contents |
|---|---|
| Confluence | PDLC docs, engineering ADRs, team wikis, meeting notes |
| Google Drive | PRDs, design briefs, research decks, OKR docs |
| JIRA | Epics, stories, bug reports (searchable by label/project) |
| Slack | Public channel history (select channels) |
| Highspot | Sales enablement, competitive intel, pricing guides |
| GitHub | PR descriptions and README files |

---

## Troubleshooting

| Issue | Solution |
|---|---|
| Authentication failed | Re-authenticate via browser — restart Claude Code to trigger OAuth flow |
| "No results" | Try broader search terms; Glean uses semantic search |
| Can't find a specific doc | Use `from:name` or `updated:past_month` filters |

---

## Known Limitations

- Results are permission-filtered — if you cannot access a doc in Glean's UI, the MCP will not return it
- Indexing is not real-time — newly created docs may take 24-48 hours to appear
- Cannot create or edit documents via the Glean MCP
