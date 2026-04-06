---
status: GA
audience: PM
hook_event: PostToolUse
trigger: Write|Edit
---

# Auto-Save PRD Artifacts

Automatically copies any markdown file written by Claude Code during a PRD workflow into a timestamped archive folder. Prevents losing work if the session ends unexpectedly and creates an audit trail of PRD versions.

## What it does

1. Fires after every `Write` or `Edit` tool call
2. Checks if the modified file path matches `*prd*` or `*PRD*`
3. If matched, copies the file to `~/Dialpad-PRD-Archive/YYYY-MM-DD_HH-MM_<filename>`
4. Logs the copy action to stdout (Claude Code receives this as context)

## Hook script

Save to `~/.claude/hooks/DP-General-auto-save-prd.sh`:

```bash
#!/usr/bin/env bash
# DP-General-auto-save-prd.sh
# PostToolUse hook: auto-archive PRD files written by Claude Code
#
# Claude Code passes tool output via stdin as JSON:
# { "tool_name": "Write", "tool_input": { "file_path": "...", ... } }

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_name',''))")
FILE=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null || echo "")

# Only act on Write/Edit tool calls
[[ "$TOOL" == "Write" || "$TOOL" == "Edit" ]] || exit 0

# Only act on files matching PRD pattern
echo "$FILE" | grep -qiE 'prd|PRD' || exit 0

ARCHIVE_DIR="$HOME/Dialpad-PRD-Archive"
mkdir -p "$ARCHIVE_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
BASENAME=$(basename "$FILE")
DEST="$ARCHIVE_DIR/${TIMESTAMP}_${BASENAME}"

cp "$FILE" "$DEST" 2>/dev/null && echo "[auto-save] PRD archived to $DEST"
```

## Configuration

Add to `.claude/settings.json` in your project root:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/DP-General-auto-save-prd.sh"
          }
        ]
      }
    ]
  }
}
```

## Setup

```bash
# 1. Create the hooks directory
mkdir -p ~/.claude/hooks

# 2. Copy the script
cp 10_hooks/pm/DP-General-auto-save-prd.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/DP-General-auto-save-prd.sh

# 3. Add the configuration to your .claude/settings.json
# (see snippet above)
```

## Archive location

Files are saved to `~/Dialpad-PRD-Archive/` with the format:
```
2026-03-11_14-30_DP-General-prd-template.md
2026-03-11_15-45_Support-voice-quality-prd.md
```
