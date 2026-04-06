# Hooks — PM

Shell scripts triggered by Claude Code events during PM workflows. Copy to `~/.claude/hooks/` and configure in your `settings.json`.

<div class="grid cards" markdown>

-   :material-content-save-outline:{ .lg .middle } **Auto-Save PRD**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Automatically copies any PRD markdown file written by Claude Code into a timestamped archive folder. Fires on `PostToolUse` after every `Write` or `Edit` call.

    [:octicons-arrow-right-24: View hook](DP-General-auto-save-prd.md)

-   :material-upload-outline:{ .lg .middle } **JIRA Push**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    When a session ends after running `/generate-jira-epic` or `/task-breakdown`, prints the JIRA MCP push command as a reminder. Fires on `Stop`.

    [:octicons-arrow-right-24: View hook](DP-General-jira-push.md)

</div>

---

[:octicons-book-24: All hooks overview](../)
