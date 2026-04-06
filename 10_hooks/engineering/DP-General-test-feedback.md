---
status: GA
audience: Coding
hook_event: PostToolUse
trigger: Write on test files
---

# Test Feedback Loop

Runs Vitest automatically after Claude Code writes or edits a `*.spec.ts` or `*.test.ts` file. Test results are fed back to Claude Code so it can fix failures immediately — creating a tight write → test → fix loop.

## What it does

1. Fires after every `Write` or `Edit` tool call
2. Checks if the modified file matches `*.spec.ts` or `*.test.ts`
3. Runs `vitest run --reporter=verbose` scoped to that file
4. Prints pass/fail output to stdout
5. Claude Code reads failures and can propose fixes in the same session

## Hook script

Save to `~/.claude/hooks/DP-General-test-feedback.sh`:

```bash
#!/usr/bin/env bash
# DP-General-test-feedback.sh
# PostToolUse hook: run Vitest after test file edits and feed results back

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_name',''))")
FILE=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" 2>/dev/null || echo "")

# Only act on Write/Edit
[[ "$TOOL" == "Write" || "$TOOL" == "Edit" ]] || exit 0

# Only act on test files
echo "$FILE" | grep -qE '\.(spec|test)\.(ts|js)$' || exit 0

if ! command -v vitest &>/dev/null && ! command -v npx &>/dev/null; then
  echo "[test-feedback] vitest not found — skipping"
  exit 0
fi

echo "[test-feedback] Running tests for $FILE..."
RESULT=$(npx vitest run --reporter=verbose "$FILE" 2>&1 || true)
echo "$RESULT"
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
            "command": "bash ~/.claude/hooks/DP-General-test-feedback.sh"
          }
        ]
      }
    ]
  }
}
```

## Expected output pattern

```
[test-feedback] Running tests for src/components/DialButton.spec.ts...

 FAIL  src/components/DialButton.spec.ts
  ✓ renders with default props (23ms)
  ✗ emits click event when pressed
    AssertionError: expected 0 to equal 1

Test Files  1 failed (1)
Tests       1 failed | 1 passed (2)
```

Claude Code sees this output and can immediately diagnose the `AssertionError` and fix the implementation or test.
