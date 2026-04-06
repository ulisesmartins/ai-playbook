---
status: GA
audience: Coding
hook_event: PostToolUse
trigger: Write|Edit
---

# Lint on Edit

Runs ESLint automatically after every `Write` or `Edit` tool call on `.vue`, `.ts`, or `.js` files. Lint results are printed to stdout and Claude Code receives them as context — allowing it to self-correct lint errors before you see them.

## What it does

1. Fires after every `Write` or `Edit` tool call
2. Checks if the modified file ends in `.vue`, `.ts`, `.js`, or `.tsx`
3. Runs `eslint --fix-dry-run` on the file
4. Prints any errors/warnings to stdout
5. Claude Code reads the output and can automatically fix errors in the next step

## Hook script

Save to `~/.claude/hooks/DP-General-lint-on-edit.sh`:

```bash
#!/usr/bin/env bash
# DP-General-lint-on-edit.sh
# PostToolUse hook: run ESLint after file edits and feed results to Claude Code

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_name',''))")
FILE=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null || echo "")

# Only act on Write/Edit
[[ "$TOOL" == "Write" || "$TOOL" == "Edit" ]] || exit 0

# Only lint JS/TS/Vue files
echo "$FILE" | grep -qE '\.(vue|ts|js|tsx)$' || exit 0

# Run ESLint (non-zero exit = lint errors found)
if ! command -v eslint &>/dev/null; then
  echo "[lint-on-edit] eslint not found in PATH — skipping"
  exit 0
fi

RESULT=$(eslint --no-eslintrc --no-ignore "$FILE" 2>&1 || true)

if [ -n "$RESULT" ]; then
  echo "[lint-on-edit] ESLint output for $FILE:"
  echo "$RESULT"
else
  echo "[lint-on-edit] No lint issues in $FILE"
fi
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
            "command": "bash ~/.claude/hooks/DP-General-lint-on-edit.sh"
          }
        ]
      }
    ]
  }
}
```

## Why this works well

Claude Code reads stdout from hooks as contextual feedback. When ESLint reports a parsing error or a Dialtone-specific rule violation, Claude Code sees it and can immediately propose a fix — without you having to copy-paste the error message.

!!! tip "Use your project's own ESLint config"
    Replace `--no-eslintrc` with your project config path to apply Dialpad's actual linting rules:
    ```bash
    eslint --config /path/to/dialpad/web-clients/.eslintrc.js "$FILE"
    ```
