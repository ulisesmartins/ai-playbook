---
version: 1.2
last_updated: 2026-03-31
change_summary: "Switch to remote OAuth MCP server; keep gh CLI alternative section"
status: GA
audience: Coding
---

# GitHub MCP Setup Guide

## Purpose

Configures the GitHub MCP server so that Claude Code can read PR diffs, check CI status,
list issues, and post code review comments directly from agent sessions. Required for the
`04_agents/engineering/DP-General-code-review/` workflow.

---

## Prerequisites

- Claude Code installed
- GitHub account with access to Dialpad's GitHub organization (`github.com/dialpad`)

---

## Step 1: Add the GitHub MCP

Run this command in your terminal:

```bash
claude mcp add --transport http github https://api.githubcopilot.com/mcp/
```

---

## Step 2: Authenticate

On first use, Claude Code will open your browser for **GitHub OAuth**. Authorize the app with your GitHub account that has access to the `dialpad` org. No Personal Access Token to create or manage.

---

## Step 3: Verify the Connection

Start a Claude Code session and run:

```
/mcp list
```

You should see `github` listed. Then test:

```
List the open PRs in dialpad/web-clients assigned to me.
```

---

## Step 4: Key Dialpad Repositories

| Repository | Contents | Common use |
|---|---|---|
| `dialpad/web-clients` | Dialpad 2.0 frontend (Vue 3) | Code review, component generation |
| `dialpad/firespotter` | Dialpad 1.0 frontend + Python backend | Legacy code context |
| `dialpad/dialtone` | Dialtone design system monorepo | Component library reference |
| `dialpad/ubervoice` | Core telephony backend | Backend service context |

---

## Common Operations

### Read a PR diff for code review
```
Read the diff for PR #4521 in dialpad/web-clients and run a code review
using the standards in 01_context/codebase-map/DP-General-key-patterns.md
```

### Post a review comment
```
Post the following review comment on line 42 of src/components/CsatCard.vue in PR #4521:
[paste comment]
```

### Check CI status
```
What is the CI status for PR #4521 in dialpad/web-clients?
```

### List open issues for triage
```
List open issues labeled "on-call" in dialpad/web-clients created in the last 24 hours.
```

---

## Troubleshooting

| Issue | Solution |
|---|---|
| "Not authorized" | Re-authenticate via browser — the OAuth grant may have expired |
| Cannot see Dialpad repos | Confirm you've been granted org access via Okta → GitHub app |
| MCP not listed | Restart Claude Code after adding the MCP |

---

## Alternative: Use the `gh` CLI Directly

For most day-to-day GitHub operations, the **GitHub CLI (`gh`)** is a lighter-weight alternative that requires no MCP configuration. Claude Code can run `gh` commands natively in the terminal — just authenticate once with `gh auth login`. This covers PRs, issues, CI checks, code search, and more without managing PATs or MCP config files. See the full comparison and examples in [Claude Code Best Practices](../../08_tools/best-practices/DP-General-claude-code.md#use-the-gh-cli-directly--skip-the-mcp-when-you-can).

The MCP remains useful when you need structured JSON responses for programmatic processing or when skills/agents are already wired to use MCP tools.

---

## Known Limitations

- Cannot approve or merge PRs directly — requires human approval per Dialpad's branch protection rules
- Cannot run CI pipelines — only read status
- Rate limited to 5,000 API requests/hour
- Does not access private Design Studio links in PR descriptions
