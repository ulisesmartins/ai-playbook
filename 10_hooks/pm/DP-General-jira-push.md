---
status: GA
audience: PM
hook_event: Stop
trigger: Session end
---

# JIRA Push on Session End

When a Claude Code session ends after running `/generate-jira-epic` or `/task-breakdown`, this hook reads the last artifact written and prints a reminder with the JIRA MCP command to push the tickets — or automatically invokes the push if the JIRA MCP is configured.

## What it does

1. Fires on the `Stop` event (session ending)
2. Checks if any `*epic*` or `*jira*` markdown files were written in the session
3. If found, prints the JIRA MCP push command as a reminder
4. If `JIRA_AUTO_PUSH=1` env var is set, automatically invokes the Atlassian MCP push

## Hook script

Save to `~/.claude/hooks/DP-General-jira-push.sh`:

```bash
#!/usr/bin/env bash
# DP-General-jira-push.sh
# Stop hook: remind PM to push JIRA artifacts after session ends

set -euo pipefail

# Find recently written JIRA/epic files in the current directory
RECENT=$(find . -maxdepth 3 -name "*epic*" -o -name "*jira*" -o -name "*tickets*" \
  | grep -v ".git" | head -5 2>/dev/null || echo "")

if [ -z "$RECENT" ]; then
  exit 0
fi

echo ""
echo "JIRA artifacts detected in this session:"
echo "$RECENT"
echo ""
echo "To push to JIRA, run:"
echo "  claude --mcp-server atlassian \"Create the JIRA epic from the file above\""
echo ""
echo "Or configure the Atlassian MCP in 09_mcps/guides/DP-General-atlassian-setup.md"
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
            "command": "bash ~/.claude/hooks/DP-General-jira-push.sh"
          }
        ]
      }
    ]
  }
}
```

## Related

- [JIRA MCP Setup](../../09_mcps/guides/DP-General-atlassian-setup.md)
- [Generate JIRA Epic skill](../../03_skills/pm/DP-General-generate-jira-epic.md)
