---
version: 1.2
last_updated: 2026-03-31
change_summary: "Switch to remote MCP server (claude mcp add); add --scope user instructions"
status: GA
audience: PM, UI
---

# Monday.com MCP Setup Guide

## Purpose

Configures the Monday.com MCP so Claude Code can read boards, update items, and pull status
summaries from Monday.com directly in agent sessions. Used for project tracking and
cross-functional status updates.

---

## Prerequisites

- Claude Code installed
- Monday.com account with access to Dialpad's Monday workspace

---

## Step 1: Find Your Monday.com User ID

You need your numeric user ID for the `--scope` flag:

1. Log into [monday.com](https://monday.com)
2. Click your **Avatar** (bottom-left) → **My profile**
3. Look at the URL in your browser — it will look like:
   ```
   https://dialpad.monday.com/users/12345678
   ```
4. Copy the number at the end (e.g. `12345678`) — that's your user ID

---

## Step 2: Add the Monday.com MCP

Run this command in your terminal, replacing `USER_ID` with the number from Step 1:

```bash
claude mcp add monday --transport http https://mcp.monday.com/mcp --scope user:USER_ID
```

For example, if your user ID is `12345678`:

```bash
claude mcp add monday --transport http https://mcp.monday.com/mcp --scope user:12345678
```

---

## Step 3: Authenticate

On first use, Claude Code will open your browser for **Monday.com OAuth**. Authorize the app with your Monday.com account that has access to the Dialpad workspace. No API token to create or manage — authentication is handled automatically.

---

## Step 4: Verify the Connection

Start a Claude Code session and run:

```
/mcp list
```

`monday` should appear. Then test:

```
List the boards in my Monday.com workspace.
```

---

## Common Operations

### Get project status
```
Summarize the status of all items on the "Q2 Launch Tracker" board.
```

### Update an item
```
Mark item "CSAT Dashboard v2" as "Done" on the Product Launches board.
```

---

## Troubleshooting

| Issue | Solution |
|---|---|
| "Authentication failed" | Re-authenticate — run `claude mcp add monday --transport http https://mcp.monday.com/mcp --scope user:YOUR_ID` again |
| Board not found | Check the exact board name in Monday.com |
| MCP not listed | Restart Claude Code after adding the MCP |
| Wrong scope error | Verify your user ID from the Monday.com profile URL |

---

## Known Limitations

- Cannot create new boards via MCP — only read and update existing ones
- Rate limited by Monday.com API quotas
