---
version: 1.0
last_updated: 2026-04-02
change_summary: "Initial version — security clearance policy for self-hosted MCP servers"
status: GA
audience: PM, UI, Coding
---

# MCP Security Clearance Policy

## Overview

Before adopting or recommending any **self-hosted MCP server that requires API keys, tokens, or stored credentials**, the recommendation must be **cleared with the Security team**.

This policy applies to any MCP server where:

- You must generate and store an API key or token locally (e.g., in environment variables or config files)
- The server runs as a local process on your machine via `npx`, `uvx`, or similar
- The server is a community/third-party package (not an official vendor-hosted remote MCP)

---

## Why This Matters

Self-hosted MCP servers that require API keys introduce risks that vendor-hosted OAuth servers do not:

- **Credential exposure** — API keys stored in config files (`~/.mcp.json`, `.env`) can be accidentally committed, leaked, or accessed by other processes
- **Supply chain risk** — Community npm/PyPI packages may not have the same security review as vendor-hosted services
- **Scope creep** — API keys may grant broader permissions than the MCP server actually needs
- **No centralized revocation** — Unlike OAuth tokens managed by IT, personal API keys are harder to audit and revoke

---

## What Requires Clearance

| Requires Security clearance | Does NOT require clearance |
|---|---|
| Community npm packages (e.g., `google-workspace-mcp`, `mcp-gsuite`) | Vendor-hosted remote OAuth MCPs (Atlassian, GitHub, Figma, Amplitude, BigQuery, Monday.com) |
| Any MCP needing a `GOOGLE_OAUTH_CREDENTIALS` file or similar | MCPs with no authentication (Dialtone, Playwright) |
| Self-hosted servers requiring API tokens in env vars | MCPs where you authenticate via browser and no keys are stored locally |
| Deprecated/archived official packages (e.g., `@modelcontextprotocol/server-gdrive`) | |

---

## Current Status of MCP Guides

The following guides in this playbook recommend servers that fall under this policy:

| Guide | Package(s) | Status |
|---|---|---|
| [Gmail](DP-General-gmail-setup.md) | `google-workspace-mcp`, `mcp-gsuite` | :material-alert-circle: Pending Security review |
| [Google Calendar](DP-General-google-calendar-setup.md) | `google-workspace-mcp`, `mcp-gsuite` | :material-alert-circle: Pending Security review |
| [Google Drive](DP-General-google-drive-setup.md) | `@modelcontextprotocol/server-gdrive` (deprecated) | :material-alert-circle: Pending Security review |

All other MCP guides in this playbook use vendor-hosted remote OAuth or require no authentication.

---

## How to Request Clearance for a New MCP

Before adding a new MCP recommendation to this playbook:

1. **Identify the MCP server's GitHub repository** — include the link in your request
2. **Review the MCP's GitHub page** for:
    - Open issues and security-related discussions
    - Maintenance activity (last commit date, release cadence)
    - Dependency footprint and known vulnerabilities
    - Permissions/scopes the server requests
3. **Submit a Security review request** including:
    - MCP server name and GitHub repo URL
    - What credentials/keys are required
    - What scopes/permissions the server needs
    - The business use case (why this MCP is needed)
    - Whether there is a vendor-hosted OAuth alternative
4. **Wait for Security approval** before adding the guide to this playbook

---

## Preferred: Vendor-Hosted Remote OAuth

Whenever possible, prefer MCP servers that use **remote OAuth authentication** via `claude mcp add --transport http`. These servers:

- Are hosted and maintained by the vendor
- Authenticate via browser (no keys stored locally)
- Have tokens managed centrally and revocable by IT
- Are listed as :material-shield-check: **OAuth — no tokens needed** in our [MCP index](index.md)

---

## Questions?

Reach out in **#ai-coding** on Slack or contact **it@dialpad.com** for Security review requests.
