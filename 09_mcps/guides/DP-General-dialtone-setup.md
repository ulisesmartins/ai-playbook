---
version: 1.1
last_updated: 2026-03-31
change_summary: "Clarify no authentication needed; remove unnecessary env var"
status: GA
audience: UI, Coding
---

# Dialtone MCP Setup Guide

## Purpose

Configures the Dialtone MCP for live design-system lookups — tokens, icons, components, and
usage guidelines — directly from Claude Code sessions. Useful for design critique, component
generation, and ensuring code matches the design system.

---

## Prerequisites

- Claude Code installed

No authentication is required — the Dialtone MCP serves public design system documentation.

---

## Step 1: Add MCP Configuration

Add this config to your `~/.mcp.json` file inside `"mcpServers"`:

```json
"dialtone": {
  "command": "npx",
  "args": ["-y", "@dialpad/dialtone-mcp-server"]
}
```

No API token or env vars needed.

---

## Step 2: Verify the Connection

```
/mcp list
```

`dialtone` should appear. Then test:

```
What color tokens are available in Dialtone for status indicators?
```

---

## Common Operations

### Look up a component
```
Show me the props and usage guidelines for the DtButton component.
```

### Check available icons
```
List all icons in Dialtone that relate to "phone" or "call".
```

### Validate token usage
```
What is the correct Dialtone spacing token for 16px gaps between elements?
```

---

## Troubleshooting

| Issue | Solution |
|---|---|
| MCP not listed | Restart Claude Code after editing config |
| Stale data | Run `npx @dialpad/dialtone-mcp-server@latest` to force a fresh install |

---

## Known Limitations

- Read-only — cannot modify design system tokens or components
- Component documentation quality depends on upstream Dialtone docs
