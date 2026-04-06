---
version: 1.0
last_updated: 2026-04-01
change_summary: "Initial Playwright MCP setup guide"
status: GA
audience: Coding, PM, UI
---

# Playwright MCP Setup Guide

## Purpose

Configures the Playwright MCP server so that Claude Code can control a browser — navigate pages, click elements, fill forms, take screenshots, and inspect page content. This is useful for end-to-end testing, UI verification, web scraping, and debugging frontend issues directly from the CLI. The Playwright MCP uses accessibility snapshots by default, providing a structured view of page content without requiring screenshots for most interactions.

---

## Prerequisites

- Claude Code installed
- Node.js 18+ installed (`node --version` to check)

---

## Step 1: Add the Playwright MCP

Run this command in your terminal:

```bash
claude mcp add playwright --launch "npx @playwright/mcp@latest"
```

This tells Claude Code to launch the Playwright MCP server as a local process using `npx`. No API keys or authentication required — it runs entirely on your machine.

---

## Step 2: Verify the Connection

Start a new Claude Code session:

```
/mcp list
```

`playwright` should appear in the list. Then test with a quick browser action:

```
Navigate to https://dialpad.com and take a snapshot of the page
```

Claude should open a browser, navigate to the page, and return a structured snapshot of the page content.

---

## Step 3: Configuration Options

### Headless vs. Headed Mode

By default, Playwright MCP runs in **headed mode** (you can see the browser window). To run headless (no visible browser):

```bash
claude mcp add playwright --launch "npx @playwright/mcp@latest --headless"
```

### Vision Mode

If you want Claude to use screenshots instead of accessibility snapshots (useful for visual verification):

```bash
claude mcp add playwright --launch "npx @playwright/mcp@latest --vision"
```

### Custom Browser

By default it uses Chromium. To use a different browser:

```bash
# Use Firefox
claude mcp add playwright --launch "npx @playwright/mcp@latest --browser firefox"

# Use WebKit (Safari engine)
claude mcp add playwright --launch "npx @playwright/mcp@latest --browser webkit"
```

### Alternative: Configure via `~/.mcp.json`

Instead of the CLI command, you can add Playwright to your `~/.mcp.json`:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

With options:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest", "--headless", "--vision"]
    }
  }
}
```

---

## Common Operations

### Navigate and inspect a page
```
Go to https://app.dialpad.com/settings and take a snapshot — what elements are visible?
```

### Fill out and submit a form
```
Navigate to [URL], fill in the "Email" field with test@example.com, then click the "Submit" button
```

### Take a screenshot for visual review
```
Navigate to [URL] and take a screenshot of the current page
```

### Test a user flow end-to-end
```
Go to [staging URL], log in with test credentials, navigate to the contacts page,
and verify that the search bar is present and functional
```

### Debug a UI issue
```
Navigate to [URL], open the browser console, and check for any JavaScript errors.
Then take a snapshot of the page and describe the layout.
```

### Extract data from a web page
```
Go to [URL] and extract all the pricing plan names and their monthly costs into a table
```

---

## Available Tools

Once connected, Claude Code has access to these Playwright capabilities:

| Tool | What it does |
|---|---|
| `browser_navigate` | Go to a URL |
| `browser_click` | Click an element on the page |
| `browser_fill_form` | Type text into input fields |
| `browser_snapshot` | Get an accessibility snapshot of the page (default mode) |
| `browser_take_screenshot` | Capture a screenshot of the page |
| `browser_press_key` | Press keyboard keys (Enter, Tab, etc.) |
| `browser_select_option` | Select from dropdown menus |
| `browser_hover` | Hover over an element |
| `browser_drag` | Drag and drop elements |
| `browser_file_upload` | Upload files to file inputs |
| `browser_evaluate` | Run JavaScript in the browser console |
| `browser_console_messages` | Read browser console output |
| `browser_network_requests` | Inspect network requests |
| `browser_navigate_back` | Go back to previous page |
| `browser_tabs` | List and switch between browser tabs |
| `browser_resize` | Resize the browser window |
| `browser_handle_dialog` | Accept or dismiss dialogs (alerts, confirms) |
| `browser_wait_for` | Wait for elements or conditions |
| `browser_close` | Close the browser |

---

## Dialpad-Specific Use Cases

### QA Verification on Staging
```
Navigate to https://staging.dialpad.com, log in, go to the Contact Center page,
and verify that the real-time dashboard widgets are rendering correctly
```

### Design Review Against Live UI
```
Navigate to [staging URL for feature X] and take a screenshot.
Compare the layout against the Figma spec at [Figma URL] — flag any visual differences.
```

### Accessibility Audit
```
Navigate to [URL] and take a snapshot. Check all interactive elements for proper
ARIA labels, roles, and keyboard navigability. List any WCAG 2.1 AA violations.
```

---

## Troubleshooting

| Issue | Solution |
|---|---|
| `npx: command not found` | Install Node.js 18+ — `brew install node` on macOS |
| Browser fails to launch | Ensure Chromium dependencies are installed: `npx playwright install chromium` |
| MCP not listed after adding | Restart Claude Code session |
| Page times out | Check VPN connection; some internal apps require VPN |
| "Target closed" error | The browser was closed unexpectedly — start a new interaction |
| Slow performance | Use `--headless` mode for faster execution |
| Cannot interact with element | Use `browser_snapshot` first to find the correct element reference |

---

## Known Limitations

- Runs locally on your machine — browser actions are visible in headed mode (use `--headless` to avoid)
- Cannot persist browser sessions across Claude Code conversations — each session starts fresh
- Sites with aggressive bot detection (CAPTCHAs, Cloudflare challenges) may block automated browsing
- File downloads land in the system's default download directory, not a configurable path
- Maximum one browser instance at a time per MCP server
- Cookie/session state is not preserved between separate Claude Code sessions
