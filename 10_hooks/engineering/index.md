# Hooks — Engineering

Shell scripts triggered by Claude Code events during engineering workflows. Creates a tight write → lint → test → fix loop without manual intervention.

<div class="grid cards" markdown>

-   :material-code-braces-box:{ .lg .middle } **Lint on Edit**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Runs ESLint automatically after every `Write` or `Edit` on `.vue`, `.ts`, `.js` files. Results are fed back to Claude Code so it can self-correct lint errors. Fires on `PostToolUse`.

    [:octicons-arrow-right-24: View hook](DP-General-lint-on-edit.md)

-   :material-test-tube:{ .lg .middle } **Test Feedback Loop**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Runs Vitest after every `Write` or `Edit` on `*.spec.ts` / `*.test.ts` files. Failures are fed back to Claude Code to fix in the same session. Fires on `PostToolUse`.

    [:octicons-arrow-right-24: View hook](DP-General-test-feedback.md)

</div>

---

[:octicons-book-24: All hooks overview](../)
