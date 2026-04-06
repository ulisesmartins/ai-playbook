---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version — populated with Dialpad GitHub structure and navigation context from Confluence"
status: GA
audience: PM, UI, Coding
---

# GitHub Overview

How to access Dialpad's GitHub organization, navigate key repositories, understand the branching workflow, and contribute to this shared repository.

---

## Getting Access

GitHub access at Dialpad is managed through Okta SSO.

1. Go to [Okta](https://dialpad.okta.com/) and find the **GitHub** app
2. Accept the GitHub organization invitation that arrives in your Dialpad email
3. Log into GitHub and confirm you are authenticated via **SSO** (look for "Authenticate with Dialpad" prompt)
4. Enable **two-factor authentication** in your [GitHub security settings](https://github.com/settings/security) — this is required
5. The `github-team-sync` bot automatically adds you to the right teams based on your role

If you don't see GitHub in Okta, email `it@dialpad.com` requesting access. Engineers should also be added to the [Dialpad Design team](https://github.com/orgs/dialpad/teams/design) if they need design repo access.

Reference: [GitHub Setup — Confluence](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/667713537)

---

## Key Repositories

| Repository | What it contains | Who uses it |
|---|---|---|
| `dialpad/firespotter` | Main Dialpad monorepo — Dialpad app (ubervoice), Dialpad Meetings (uberconf), Telephony (fst) | Engineering |
| `dialpad/web-clients` | Web client packages including Power Dialer | Engineering, Design |
| `dialpad/servers` | Infrastructure and server configurations | Infra/Telephony Eng |
| `dialpad/claude-code-plugins` | Shared Claude Code skills, agents, and tools | All Dialpad |
| `dialpad/ai-playbook` | This repository — shared AI prompts, agents, templates | All Dialpad |

**Firespotter structure:**
- `ubervoice/` — Dialpad product (Python backend + Vue.js frontend)
- `uberconf/` — Dialpad Meetings (Python backend + Vue.js frontend)
- `fst/` — Telephony platform
- `test/` — Test suite

---

## How to Navigate GitHub

### Finding a Repository

1. Go to [github.com/dialpad](https://github.com/dialpad)
2. Use the search bar to find repos by name
3. Or navigate directly: `github.com/dialpad/[repo-name]`

### Reading Code Without Cloning

- Press `.` (period) on any GitHub page to open the repo in a browser-based VS Code editor
- Use GitHub's file browser to navigate: click folders and files
- Use `Ctrl+K` (or `Cmd+K`) on GitHub to open the quick file search

### Understanding a Pull Request (PR)

PRs are how engineers propose code changes. As a PM or Designer, you may be asked to review or comment on a PR.

- **Files changed** tab — see what code was modified (green = added, red = removed)
- **Commits** tab — see the history of changes in this PR
- **Checks** tab — automated test results (must be green to merge)
- **Comments** — discussions about specific lines of code

Claude Code is integrated with Dialpad's GitHub org. You can tag `@claude` in any PR comment to get an AI review:

```
@claude, please review this code change for potential security vulnerabilities
```

---

## Branching Workflow

Dialpad uses a **feature branch workflow**. Every change goes through a branch, never directly to `master` or `main`.

### Branch naming convention

```
DP-[TICKET-NUMBER]-[short-description]
```

Examples:
- `DP-178427-epd-ai-enablement`
- `DP-169041-agentic-action-fix`

### The release cycle (product engineering)

- A new `uv-beta` branch is cut from `master` every **Monday ~10am**
- A second cut happens on **Tuesday**, released on **Friday**
- To get code into beta after the branch is cut: submit a **cherry pick**
- Track builds: [GitHub Actions](https://github.com/dialpad/firespotter/actions) or the internal [commit dashboard](http://dialpadhq.com/githubstatus)

---

## Cloning This Repository

To work with files locally (recommended for Claude Code):

```bash
# Set up SSH key first if you haven't (one-time)
ssh-keygen -t ed25519 -C "yourname@dialpad.com"
# Add the key to GitHub: Settings → SSH and GPG keys

# Clone the repo
git clone git@github.com:dialpad/ai-playbook.git
cd ai-playbook
```

If you prefer HTTPS (no SSH key needed):

```bash
git clone https://github.com/dialpad/ai-playbook.git
```

---

## Contributing to This Repository

1. Create a branch: `git checkout -b DP-XXXXX-description`
2. Make your changes (add a prompt, update a template, etc.)
3. Stage and commit: `git add [file]` → `git commit -m "describe what you did"`
4. Push: `git push -u origin DP-XXXXX-description`
5. Open a Pull Request on GitHub against `main`
6. Tag a reviewer (your team lead or any Dialpad employee familiar with the change)

For non-code contributions (adding a prompt or template), the review bar is low — just make sure your file follows the naming convention and includes a frontmatter version header.

---

## Useful Links

| Resource | Link |
|---|---|
| Dialpad GitHub org | [github.com/dialpad](https://github.com/dialpad) |
| EPD Divisions & Mapping Matrix | [Confluence](https://dialpad.atlassian.net/wiki/spaces/EPD/pages/315654145) |
| GitHub setup guide | [Confluence](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/667713537) |
| Designer's guide to GitHub | [Confluence](https://dialpad.atlassian.net/wiki/spaces/DES/pages/671187169) |
| Git reference cheatsheet | [Confluence](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1690206258) |
| Claude Code on GitHub (tag `@claude` in PRs) | Via GitHub PR comments |
