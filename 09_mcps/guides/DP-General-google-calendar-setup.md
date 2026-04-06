---
version: 1.1
last_updated: 2026-03-31
change_summary: "Note that official package does not exist; recommend community alternatives"
status: GA
audience: PM, UI, Coding
---

# Google Calendar MCP Setup Guide

## Important Notice

There is **no official `@modelcontextprotocol/server-google-calendar` package** — the package name previously documented here does not exist on npm.

For Google Calendar integration with Claude Code, use one of these community alternatives:

| Package | What it covers | Install |
|---|---|---|
| `google-workspace-mcp` | Gmail + Calendar + Drive | `npx google-workspace-mcp` |
| `mcp-gsuite` (by MarkusPfundstein) | Gmail + Calendar + Drive | `npx mcp-gsuite` |

Both require a Google Cloud OAuth 2.0 client and a one-time browser authentication flow.

---

## Setup (using google-workspace-mcp)

1. Create a Google Cloud project and enable the Google Calendar API
2. Create an OAuth 2.0 Client ID (Desktop App type)
3. Download the client credentials JSON file
4. Add to your `~/.mcp.json`:

```json
"google-calendar": {
  "command": "npx",
  "args": ["-y", "google-workspace-mcp"],
  "env": {
    "GOOGLE_OAUTH_CREDENTIALS": "/path/to/client-credentials.json"
  }
}
```

5. On first use, the MCP will open your browser for Google OAuth consent

Refer to the package's README for the latest configuration details.

---

## What it enables

- Meeting context and scheduling awareness
- Agenda drafting
- Calendar search (find meetings by topic, attendee, or date)

---

## Known Limitations

- Community-maintained — not officially supported by Google or Anthropic
- Requires a Google Cloud project with OAuth configured
- Cannot create or modify calendar events via some packages — check the README
