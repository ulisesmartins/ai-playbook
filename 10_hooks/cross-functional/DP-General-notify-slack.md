---
status: GA
audience: All roles
hook_event: Stop
trigger: Session end
---

# Notify Slack on Session End

When a Claude Code agent session ends, this hook sends a Slack message to a designated channel with a brief summary of what was produced — keeping the team informed without requiring manual updates.

## What it does

1. Fires on the `Stop` event (session ending)
2. Reads the most recently written output files in the session
3. Constructs a short summary message
4. Posts to a Slack webhook URL (set via `DIALPAD_SLACK_WEBHOOK` env var)

## Hook script

Save to `~/.claude/hooks/DP-General-notify-slack.sh`:

```bash
#!/usr/bin/env bash
# DP-General-notify-slack.sh
# Stop hook: post a session completion summary to Slack

set -euo pipefail

WEBHOOK="${DIALPAD_SLACK_WEBHOOK:-}"

if [ -z "$WEBHOOK" ]; then
  echo "[notify-slack] DIALPAD_SLACK_WEBHOOK not set — skipping Slack notification"
  exit 0
fi

# Find recently modified files (last 30 minutes, excluding git/node_modules)
RECENT_FILES=$(find . -maxdepth 4 -newer /tmp/.claude-session-start \
  -name "*.md" -not -path "*/.git/*" -not -path "*/node_modules/*" \
  2>/dev/null | head -5 || echo "")

if [ -z "$RECENT_FILES" ]; then
  SUMMARY="Claude Code session completed — no tracked files modified."
else
  FILE_LIST=$(echo "$RECENT_FILES" | sed 's/^/• /' | tr '\n' '\\n')
  SUMMARY="Claude Code session completed.\n\nFiles produced:\n${FILE_LIST}"
fi

# Get current directory name as project context
PROJECT=$(basename "$(pwd)")

PAYLOAD=$(cat <<JSON
{
  "text": ":robot_face: *[$PROJECT]* ${SUMMARY}"
}
JSON
)

curl -s -X POST -H 'Content-type: application/json' \
  --data "$PAYLOAD" "$WEBHOOK" > /dev/null

echo "[notify-slack] Session summary posted to Slack."
```

## Configuration

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/DP-General-notify-slack.sh"
          }
        ]
      }
    ]
  }
}
```

## Environment variable

Set your Slack incoming webhook URL in your shell profile:

```bash
# Add to ~/.zshrc or ~/.bashrc
export DIALPAD_SLACK_WEBHOOK="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
```

Get the webhook URL from your Slack workspace admin or the `#ai-playbook` channel settings.

## Example Slack message

```
🤖 [ai-playbook] Claude Code session completed.

Files produced:
• ./03_skills/pm/DP-General-new-skill.md
• ./04_agents/pm/DP-General-new-agent/CLAUDE.md
```
