---
status: GA
audience: UI
hook_event: PostToolUse
trigger: Write on spec files
---

# UI Studio Export Trigger

After Claude Code writes a component spec or design handoff document, this hook logs the file to a design artifacts manifest and optionally opens the file in your default editor for review. Designed to work alongside the `/component-spec` and `/spec-to-code-context` skills.

## What it does

1. Fires after every `Write` or `Edit` tool call
2. Checks if the modified file matches `*spec*`, `*handoff*`, or `*component*`
3. Appends the file path + timestamp to `~/Dialpad-UI-Artifacts/manifest.md`
4. Prints a reminder about the UI Studio MCP for live component token lookups

## Hook script

Save to `~/.claude/hooks/DP-General-design-studio-export.sh`:

```bash
#!/usr/bin/env bash
# DP-General-design-studio-export.sh
# PostToolUse hook: log component specs to design artifact manifest

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_name',''))")
FILE=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null || echo "")

# Only act on Write/Edit
[[ "$TOOL" == "Write" || "$TOOL" == "Edit" ]] || exit 0

# Only act on design spec files
echo "$FILE" | grep -qiE 'spec|handoff|component' || exit 0

MANIFEST_DIR="$HOME/Dialpad-UI-Artifacts"
mkdir -p "$MANIFEST_DIR"

TIMESTAMP=$(date +"%Y-%m-%d %H:%M")
echo "- [$TIMESTAMP] $FILE" >> "$MANIFEST_DIR/manifest.md"

echo "[design-studio-export] UI spec logged to $MANIFEST_DIR/manifest.md"
echo "[design-studio-export] Tip: run the UI Studio MCP to validate Dialtone token usage in this spec."
```

## Configuration

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/DP-General-design-studio-export.sh"
          }
        ]
      }
    ]
  }
}
```

## Manifest format

Each spec write appends a line to `~/Dialpad-UI-Artifacts/manifest.md`:

```markdown
- [2026-03-11 14:30] ./components/DialButton-spec.md
- [2026-03-11 15:12] ./handoff/VoiceQuality-handoff.md
- [2026-03-12 09:45] ./components/CallCard-component-spec.md
```

This gives you an audit trail of all design specs produced across Claude Code sessions.

## Related

- [UI Studio MCP Setup](../../09_mcps/guides/DP-General-design-studio-setup.md)
- [Dialtone MCP Setup](../../09_mcps/guides/DP-General-dialtone-setup.md)
