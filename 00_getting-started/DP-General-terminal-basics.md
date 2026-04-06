---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version — populated with Dialpad-specific terminal commands and context from Confluence"
status: GA
audience: PM, UI
---

# Terminal Basics

This guide covers the minimum terminal (CLI) knowledge needed to use Claude Code and navigate this repository. Designed for PMs and Designers who don't work in the terminal regularly.

> **You can do this.** The terminal is just a text interface to your computer. You won't break anything by reading files or navigating directories.

---

## Opening the Terminal

- **Mac:** `Cmd + Space` → type "Terminal" → press Enter
- **Alternatively:** Use **iTerm2** (download at iterm2.com) for a better experience with tabs, search, and colors
- Most engineers and designers also use the terminal built into VS Code or Windsurf

---

## The Most Important Commands

### Navigation

| Command | What it does | Example |
|---|---|---|
| `pwd` | Print current directory (where you are) | `pwd` → `/Users/ulises.martins` |
| `ls` | List files in the current directory | `ls` |
| `ls -la` | List all files including hidden ones | `ls -la` |
| `cd [folder]` | Move into a folder | `cd Desktop` |
| `cd ..` | Go up one folder | `cd ..` |
| `cd ~` | Go to your home directory | `cd ~` |
| `cd ~/src/firespotter` | Go directly to a path | `cd ~/src/firespotter` |

**Tip:** Press `Tab` to auto-complete file and folder names. Press `↑` to cycle through previous commands.

---

### Files

| Command | What it does | Example |
|---|---|---|
| `cat [file]` | Print file contents to screen | `cat CLAUDE.md` |
| `open [file]` | Open file in default Mac app | `open CLAUDE.md` |
| `open .` | Open current folder in Finder | `open .` |
| `cp [source] [dest]` | Copy a file | `cp file.md copy.md` |
| `mv [source] [dest]` | Move or rename a file | `mv old.md new.md` |
| `mkdir [name]` | Create a new folder | `mkdir my-folder` |
| `rm [file]` | Delete a file — **no undo!** | `rm old.md` |

---

### Git — The Most Important Part

Git is the version control system Dialpad uses. All code and files in this repo are managed with Git.

| Command | What it does |
|---|---|
| `git status` | See what's changed in the repo |
| `git pull` | Pull the latest changes from GitHub |
| `git log --oneline` | See recent commit history |
| `git checkout -b DP-12345-my-feature` | Create a new branch (use your JIRA ticket number) |
| `git add [file]` | Stage a file for commit |
| `git commit -m "your message"` | Save your changes locally |
| `git push` | Push your changes to GitHub |
| `git branch` | See all local branches |
| `git checkout main` | Switch back to the main branch |

**Dialpad branch naming convention:** `DP-XXXXX-description` (e.g., `DP-178427-epd-ai-enablement`)

Reference: [Git reference — Confluence](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1690206258)

---

### Claude Code

| Command | What it does |
|---|---|
| `claude` | Start a Claude Code session in the current directory |
| `claude --help` | See all available options |
| `claude mcp add ...` | Add a new MCP server |
| `claude plugin install jira-cli@dialpad-tools` | Install the Dialpad JIRA CLI plugin |
| `claude plugin update jira-cli@dialpad-tools` | Update a plugin |

**Start every Claude session from the repo root** so it has access to `CLAUDE.md` and the full context:

```bash
cd ~/path/to/DPAIPlaybook
claude
```

---

### JIRA CLI (via Claude Code plugin)

Once you've installed `jira-cli@dialpad-tools` (see [Setup guide](./DP-General-dev-environment-setup.md)), you can manage JIRA from the terminal:

```bash
# View a ticket
jira issue view DP-178427 --plain

# List your current sprint issues
jira sprint list --current -pDP --plain --no-truncate

# Move a ticket to "In Progress"
jira issue move DP-12345 "Start work"

# View the ticket for your current git branch
TICKET=$(git branch --show-current | grep -oE '[A-Z]+-[0-9]+') && jira issue view "$TICKET" --plain
```

Reference: [Use JIRA CLI with Claude Code — Confluence](https://dialpad.atlassian.net/wiki/spaces/ENG/pages/2437382409)

---

## Common Workflows for PMs

### Pull the latest repo updates

```bash
cd ~/path/to/DPAIPlaybook
git pull
```

### Start a Claude session for PRD drafting

```bash
cd ~/path/to/DPAIPlaybook
claude
# Then type: /draft-prd
```

### Check what files changed recently

```bash
git log --oneline -10
```

### Open a file in your text editor

```bash
open -a "Visual Studio Code" 02_templates/pm/DP-General-prd-template.md
```

---

## Reading Terminal Output

- `$` or `%` at the start of a line = the prompt (terminal waiting for input)
- Lines **without** a prompt = output from the last command
- `~` = shorthand for your home directory (`/Users/yourname`)
- `.` = current directory; `..` = one directory up

---

## Keyboard Shortcuts

| Shortcut | What it does |
|---|---|
| `Ctrl + C` | Stop the current running command |
| `Ctrl + L` | Clear the terminal screen |
| `Cmd + T` | New terminal tab (iTerm2 / Terminal app) |
| `Tab` | Auto-complete file/folder names |
| `↑` / `↓` | Cycle through command history |

---

## Getting Help

- Run `[command] --help` (e.g., `git --help`, `claude --help`)
- Post in `#ai-enablement` with questions
- Ask Claude Code directly: _"How do I [thing] in the terminal?"_
- Dialpad Design guide (also written for non-engineers): [Setting up Dialpad locally for Designers — Confluence](https://dialpad.atlassian.net/wiki/spaces/DES/pages/671187169)
