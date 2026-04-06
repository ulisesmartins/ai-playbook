---
version: 1.0
last_updated: 2026-03-18
change_summary: "Initial version — adapted from hynes-dialpad daily workflow gist"
status: GA
slash_command: /day-start, /day-wrap, /wrap, /snippet, /reflect
audience: All Roles
source: https://gist.github.com/hynes-dialpad/c92af436741c6beccd5f586edf25c060
---

# Claude Code Daily Workflow

A system for managing your workday inside Claude Code — automatic session notes, structured morning briefings, end-of-day wraps, and weekly snippets. Built to track commitments, surface context, and prevent things from slipping through the cracks.

## Purpose

Keeps you on top of a large team's worth of conversations, meetings, and commitments by making daily bookkeeping automatic. Progress is tracked as you work, open items surface each morning, and meeting prep assembles itself.

## Components

| Part | What it does |
|------|-------------|
| **Notes system** | Hooks that automatically maintain session notes as you work — no manual logging required |
| **Commands** | Structured prompts for briefings, wrap-ups, and learning |
| **Integrations** | External tools and services that feed data into the commands |

## Commands

| Command | When | What it does |
|---------|------|-------------|
| `/day-start` | Morning | Briefing: calendar, email, open PRs, Jira, carry-forwards from yesterday |
| `/day-wrap` | End of day | Wrap: what you shipped, meetings, PRs, Jira. Updates notes and action items |
| `/wrap` | End of any session | Updates session notes: decisions, progress, next steps |
| `/snippet` | End of week | Drafts the weekly snippet from session notes, shipped work, and music picks |
| `/reflect` | Periodically | Reviews the conversation for patterns, corrections, and preferences. Offers to persist findings to memory or improve commands |

## Required Inputs

- **Claude Code** — required (`claude` in your terminal)
- **`jq`** — used by hooks to parse payloads (`brew install jq` on macOS)
- **`python3`** — used by the Stop hook (pre-installed on macOS)

## Optional Integrations

| Integration | Used for | Status |
|------------|---------|--------|
| **Glean MCP** | Calendar, email, meeting notes | Recommended |
| **Dialpad MCP** | Messaging (channels, DMs) + CSR (call lookups, status page) | Recommended |
| **GitHub CLI (`gh`)** | Open PRs and review requests | Optional |
| **Jira CLI (`jira`)** | Active tickets and daily activity | Optional |

All integrations are optional. Commands skip sections gracefully if a tool isn't available.

## How It Works

```
Morning             /day-start
                    → Briefing: meetings, email, PRs, Jira, Dialpad channels
                    → Reconcile yesterday's carry-forwards
                    → Ask: what do you want to accomplish?

Coding sessions     Notes update automatically via hooks
                    /wrap  (end of each focused work block)
                    → Notes updated: decisions + next steps

End of day          /day-wrap
                    → What did you actually accomplish?
                    → Any blockers for tomorrow?
                    → Action items for people?
                    → Writes session notes + action-items.md

End of week         /snippet
                    → Pulls from session notes + Jira
                    → Asks for the week's theme and music picks
                    → Drafts the weekly snippet

Periodically        /reflect  (after sessions with corrections or pivots)
                    → Memory candidates surfaced
                    → Command improvements proposed
```

---

## Setup

Install in this order:

### 1. Notes System

Three hooks maintain session notes automatically:

- **`SessionStart` hook** (`session-notes-init.sh`) — Creates daily note files, detects git worktrees, applies project aliases, injects context from previous sessions.
- **`PreCompact` hook** (`pre-compact-preserve.sh`) — Warns before context compression and flushes notes to disk.
- **`Stop` hook** (`session-notes-nudge.sh`) — Monitors note staleness (>15 min) and prompts updates after substantive work.

Notes are stored in `~/notes/sessions/YYYY-MM-DD/` with optional `shaping/` subdirectories for design docs and breadboards.

**Install prompt** — paste into a Claude Code session:

```
Set up a session notes system for me. Before creating any files, use AskUserQuestion to ask me:

1. **Where should session notes be stored?** Provide the full path. Default is `~/notes/` (your home directory). Common alternative: `~/Documents/notes/`. I'll refer to this as `NOTES_ROOT`.
2. **Should I scan a directory for projects that share the same git remote and automatically set up aliases?** If yes, which directory should I scan?

Wait for my answers, then proceed.

Create the following, using `NOTES_ROOT` as the notes location:

**`~/.claude/hooks/session-notes-init.sh`** — A `SessionStart` hook that:
- Determines the project name from `$CLAUDE_PROJECT_DIR` or the current working directory. Detects git worktrees via `git rev-parse --git-common-dir` and uses the main repo's name instead of the worktree directory name.
- Reads `~/.claude/hooks/project-aliases.conf` to map directory names to logical group names (format: `dir-name=Group Name`). If no alias exists, the group name equals the directory name.
- Checks for previous session notes from the past 2 days for the same project and injects a "Previous session:" link if found
- Injects a protocol into Claude's context telling it to maintain notes at that path, with this template:
  - Header fields: Date, Project (from alias), Impact (high/medium/low), Last Updated
  - Sections: Current Objective, Progress (high-level outcomes — not file lists), Decisions Made, Open Questions, Next Steps, Session Log
  - Instructions that notes should tell the story of the work, not log technical details; shaping docs and breadboards go in a `shaping/` subfolder
- If notes already exist for today, inject their current contents

**`~/.claude/hooks/pre-compact-preserve.sh`** — A `PreCompact` hook that:
- Outputs a loud "CRITICAL: Update your session notes NOW" instruction before compaction
- Outputs the current notes file contents so the compaction summarizer preserves them
- Appends a compaction log entry to the notes file

**`~/.claude/hooks/session-notes-nudge.sh`** — A `Stop` hook that:
- Skips if `stop_hook_active` is true (prevents conflicts with other Stop hooks)
- Skips if the turn involved no substantive work (no Edit/Write/Bash in `transcript_summary`)
- Checks the notes file modification time — if >15 minutes since last update, outputs a staleness reminder
- If no notes file exists yet, prompts to create one

**`~/.claude/hooks/project-aliases.conf`** — An empty config file with format documentation in comments.

**`~/.claude/commands/wrap.md`** — A `/wrap` command that tells Claude to write a final session summary: update all sections to reflect final state, set the Impact field, write high-level Progress (not file lists), add a "Session wrapped" log entry.

Make all `.sh` files executable. Register all three hooks in `~/.claude/settings.json` under their respective hook types (SessionStart with matcher "startup|resume|compact", PreCompact with matcher "auto|manual", Stop with no matcher). Merge into existing hook arrays — don't replace them.

Create `NOTES_ROOT/sessions/` and `NOTES_ROOT/research/` directories.

If I asked you to scan a directory for aliases: scan it now, find any git repos that share the same remote URL, group them, confirm the group names with me using AskUserQuestion, then write the aliases to `~/.claude/hooks/project-aliases.conf`. Do not modify anything other than `~/.claude/` config files and the notes directories.
```

After install, start a new session for hooks to take effect.

#### Add `$CURRENT_DATE` injection

The `/day-start` command reads today's date from your Claude auto-memory file. Paste this into a Claude Code session:

```
Update my session notes hook to inject today's date into my auto-memory file on every session start.

1. Find my auto-memory file by listing `~/.claude/projects/*/memory/MEMORY.md`
2. Find `~/.claude/hooks/session-notes-init.sh`
3. Append a block at the end of session-notes-init.sh that:
   - Finds the MEMORY.md file path using the same glob
   - Gets today's date with `date "+%Y-%m-%d"`
   - If a `# currentDate` section already exists in MEMORY.md, updates the date line in place
   - If it doesn't exist, appends a `# currentDate` section with today's date
   - Handles both macOS (`sed -i ''`) and Linux (`sed -i`) sed syntax
4. Also add today's date to MEMORY.md right now so it takes effect immediately
```

### 2. Integrations

Set these up **before** installing the daily commands so the install prompt can tailor output accordingly.

#### Glean MCP

Add to `~/.claude.json`:

```json
{
  "mcpServers": {
    "glean": {
      "type": "http",
      "url": "https://dialpad-prod-be.glean.com/mcp/default"
    }
  }
}
```

Complete OAuth via `/mcp` in a new session. Verify: ask "What meetings do I have today?"

#### GitHub CLI

```bash
brew install gh
gh auth login
```

#### Jira CLI

```bash
brew install ankitpokhrel/jira-cli/jira
```

Create an API token at https://id.atlassian.com/manage-profile/security/api-tokens, add `export JIRA_API_TOKEN="your-token"` to `~/.zshrc`, then run `jira init` (Cloud, `https://dialpad.atlassian.net`, basic auth).

#### Dialpad MCP

```bash
bash <(curl -sL -H "Authorization: token $(gh auth token)" -H "Accept: application/vnd.github.v3.raw" \
  "https://api.github.com/repos/dialpad/firespotter/contents/tools/mcp/install.sh?ref=NO-JIRA-dialpad-messaging-mcp")
```

### 3. Daily Commands

Install **globally** in `~/.claude/commands/` (not project-level). Paste this install prompt:

```text
Set up my daily workflow commands globally. Before creating any files, use AskUserQuestion to ask me:

1. "Which integrations do you have configured?" (multiSelect: Glean MCP, Dialpad Messaging MCP, GitHub CLI, Jira CLI)
2. "What is your timezone?" (e.g. EST/EDT, PST/PDT, GMT+1 — used to convert calendar times in your morning briefing)
3. "Where are your session notes stored?" (default: ~/notes — used to find yesterday's carry-forwards)
4. "Do you write a weekly update or snippet for your team?" (yes/no)

Wait for my answers, then:

Install the following as global commands in ~/.claude/commands/ (create the directory if needed):
- /day-start — morning briefing
- /day-wrap — end-of-day wrap
- /reflect — learning extraction from conversation history
- /wrap — session summary (skip if already installed by the notes system setup)

For each command, remove integration steps that don't apply based on my answer to question 1.
Update the timezone reference in /day-start to match my answer to question 2.
Update all session notes path references to match my answer to question 3.

Also create an empty action-items.md file at the session notes root from question 3 if one doesn't already exist.

If I answered yes to weekly snippets (question 4): install /snippet and ask one follow-up:
"Briefly describe your snippet format — who reads it, what sections it has, and what tone it should take."
Use that description to customize /snippet for my format.

If I answered no: skip /snippet.
```

---

## Session Note Format

```markdown
# Session Notes: project-name
**Date:** YYYY-MM-DD
**Project:** Logical Group Name
**Impact:** high | medium | low
**Last Updated:** HH:MM

## Current Objective
## Progress
## Decisions Made
## Open Questions
## Next Steps
## Session Log
```

**Progress is outcomes, not activity.** "Shipped auth fix" not "modified 7 files in src/auth/".

**Session Log is append-only.** Never edit past entries.

## Action Items

Action items track follow-through — commitments from meetings, things you said you'd get back to someone on. Organized by person.

- `/day-start` reads them to build 1:1 agendas
- `/day-wrap` appends new items when flagged during end-of-day questions
- Items get marked done with a date stamp

## Managing Carry-Forwards

Every morning, `/day-start` reconciles yesterday's open items:

| How | What happens | When to use |
|-----|-------------|-------------|
| **Auto-resolved** | PRs and Jira tickets cross-referenced against live data. If merged/closed, marked `✓` automatically. | Happens without input |
| **Done** | Marked `✓ done`. Counts as an accomplishment. | Work you actually completed |
| **Dismissed** | Marked `✗ dismissed`. Won't resurface. | Items that weren't yours or became irrelevant |

## Known Limitations

- Requires macOS or Linux — hooks use `bash`, `jq`, and `python3`
- Glean OAuth session may expire; re-authenticate via `/mcp`
- Jira CLI requires an Atlassian API token (tokens expire periodically)
- Notes system files to `~/notes/` by default — Windows users must adapt paths
- `/snippet` is opinionated by default — customize during install for your team's format
