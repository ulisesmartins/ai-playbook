---
version: 1.1
last_updated: 2026-03-31
change_summary: "Add deprecation notice for archived official package; note community alternatives"
status: GA
audience: PM, UI, Coding
---

# Google Drive MCP Setup Guide

## Deprecation Notice

The official `@modelcontextprotocol/server-gdrive` package exists on npm but is **deprecated and archived**. It still works but will not receive updates.

For a maintained alternative, consider `google-workspace-mcp` or `mcp-gsuite` which cover Drive, Gmail, and Calendar in a single package.

---

## Prerequisites

- Claude Code installed
- A Google Cloud project with the Drive API enabled
- An OAuth 2.0 Client ID (Desktop App type)

---

## Step 1: Create Google Cloud OAuth Credentials

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project (or use an existing one)
3. Enable the **Google Drive API**
4. Go to **Credentials** -> **Create Credentials** -> **OAuth Client ID**
5. Application type: **Desktop App**
6. Download the credentials JSON file
7. Rename it to `gcp-oauth.keys.json` and place it in the server's working directory

---

## Step 2: Add MCP Configuration

Add this config to your `~/.mcp.json` file inside `"mcpServers"`:

```json
"google-drive": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-gdrive"]
}
```

The server looks for `gcp-oauth.keys.json` in its working directory. On first run, it will open your browser for Google OAuth consent and save credentials to `.gdrive-server-credentials.json`.

---

## Step 3: Verify the Connection

```
/mcp list
```

`google-drive` should appear. Then test:

```
Search Google Drive for documents containing "Q2 OKR" updated in the last month.
```

---

## What it enables

- Read and reference Google Docs, Sheets, and Slides
- Search Drive by title, content, or date
- Use documents as context for Claude Code sessions

---

## Troubleshooting

| Issue | Solution |
|---|---|
| OAuth flow fails | Ensure the Drive API is enabled in your Google Cloud project |
| "Access denied" | Re-run the OAuth flow — credentials may have expired |
| MCP not listed | Restart Claude Code after editing config |

---

## Known Limitations

- Package is deprecated — may stop working in the future
- Read-only — cannot create or edit Drive files via MCP
- Requires a Google Cloud project with OAuth configured
- Large files may be truncated
