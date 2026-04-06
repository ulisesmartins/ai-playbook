# Hooks

Claude Code hooks are shell commands that fire automatically in response to agent events — before or after a tool call, on notification, or when a session ends. They let you automate repetitive actions that happen *around* the agent's work.

!!! info "What is a hook?"
    A hook is a shell command (or script path) configured in `~/.claude/settings.json` or `.claude/settings.json`. When the trigger event fires, Claude Code executes the command and can optionally receive its stdout as additional context.

## Hook event types

| Event | Fires when | Common use cases |
|---|---|---|
| `PreToolUse` | Before a tool call executes | Block dangerous operations, inject context |
| `PostToolUse` | After a tool call completes | Lint files after edits, archive artifacts |
| `Notification` | When Claude needs attention | Desktop alerts, Slack pings |
| `Stop` | When the agent session ends | Summarize + post to Slack, log completion |

## Configure a hook

Add hooks to `~/.claude/settings.json` (global) or `.claude/settings.json` (project-local):

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/hooks/lint-on-edit.sh"
          }
        ]
      }
    ]
  }
}
```

The `matcher` is a regex tested against the tool name (e.g. `Write`, `Edit`, `Bash`).

## Available hooks at Dialpad

<div class="grid cards" markdown>

-   :material-briefcase:{ .lg .middle } **PM Hooks**

    ---

    Auto-save PRD artifacts and push JIRA tickets from agent output — zero copy-paste.

    [:octicons-arrow-right-24: PM hooks](pm/DP-General-auto-save-prd.md)

-   :material-code-braces:{ .lg .middle } **Engineering Hooks**

    ---

    Run linter and tests after every file edit. Feed results back to Claude Code automatically.

    [:octicons-arrow-right-24: Engineering hooks](coding/DP-General-lint-on-edit.md)

-   :material-pencil-ruler:{ .lg .middle } **Design Hooks**

    ---

    Trigger Design Studio exports and archive design specs when Claude Code writes a component spec.

    [:octicons-arrow-right-24: Design hooks](ui/DP-General-figma-export.md)

-   :material-account-group:{ .lg .middle } **Cross-functional Hooks**

    ---

    Notify Slack when an agent session completes with a summary of what was produced.

    [:octicons-arrow-right-24: Cross-functional hooks](cross-functional/DP-General-notify-slack.md)

</div>

---

!!! tip "Project-local vs global hooks"
    Place hooks in `.claude/settings.json` in the repo root for team-shared behavior.
    Use `~/.claude/settings.json` for personal automation you don't want committed.
