# Tools — Coding

Curated AI tools for Engineers at Dialpad across the development lifecycle. The EPD default stack is **Claude Code + Windsurf + GitHub Copilot** — all three are provisioned for EPD. Start with this trio before adding other tools.

<div class="grid cards" markdown>

-   :material-robot-excited:{ .lg .middle } **Claude Code**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Multi-file edits, ticket breakdown, test writing, code review, and on-call triage with Dialpad codebase context loaded. Runs all engineering skills and agents in this repo.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-claude-code.md)

-   :material-waves:{ .lg .middle } **Windsurf**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    AI-native IDE for large codebase work — multi-file refactors, feature implementations spanning `web-clients` or `firespotter`. Point context at codebase-map files for Dialpad pattern compliance.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-windsurf.md)

-   :material-github:{ .lg .middle } **GitHub Copilot**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Inline autocomplete, single-function generation, and PR workflows in GitHub-native contexts. Best for line-by-line completions; use Claude Code or Windsurf for full component or feature work.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-github-copilot.md)

-   :material-google:{ .lg .middle } **Gemini for Workspace**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Summarize incident retrospectives, draft PR descriptions, write engineering RFC summaries, and generate spreadsheet formulas — without leaving Gmail, Docs, or Sheets.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-gemini-workspace.md)

-   :material-ticket-outline:{ .lg .middle } **Atlassian Rovo**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    AI inside Jira — Q&A on existing tickets, automated story updates, Confluence doc generation. Use when working inside an existing epic rather than generating a net-new artifact.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-atlassian-rovo.md)

-   :material-link-variant:{ .lg .middle } **JIRA MCP**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    After running `/ticket-breakdown`, push stories directly to the Jira board without copy-paste. One-time config in `09_mcps/guides/DP-General-atlassian-setup.md`.

    [:octicons-arrow-right-24: Setup guide](../../09_mcps/guides/DP-General-atlassian-setup.md)

-   :material-autorenew:{ .lg .middle } **n8n**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Low-code workflow automation for EPD integrations — Jira webhooks, Slack notifications, GitHub → Monday sync, and custom event-driven pipelines.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-n8n.md)

</div>

---

!!! tip "Codebase context — always load first"
    Before generating code, load `01_context/codebase-map/DP-General-index.md` and `DP-General-key-patterns.md`.
    This prevents hallucinated file paths and ensures Dialtone + Vue 3 pattern compliance.

---

[:octicons-book-24: Full overview & tool selection guide](DP-General-tools.md){ .md-button } &nbsp;
[:octicons-tools-24: Best practices index](../best-practices/){ .md-button }
