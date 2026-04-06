# Tools — PM

Curated AI tools for Product Managers at Dialpad, organized by workflow stage. Start with **Glean + Gemini** for daily work; layer Claude Code for structured EPD artifacts.

<div class="grid cards" markdown>

-   :material-robot-excited:{ .lg .middle } **Claude Code**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Primary EPD workflow engine. Run `/draft-prd`, `/generate-jira-epic`, `/gtm-draft`, and the full PRD → JIRA agent pipeline with Dialpad context loaded.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-claude-code.md)

-   :material-magnify:{ .lg .middle } **Glean**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Cross-app internal search — past PRDs, Confluence docs, customer research, competitive intel, and prior roadmap decisions. Always run Glean before drafting.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-glean.md)

-   :material-google:{ .lg .middle } **Gemini for Workspace**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Everyday writing assistant — email drafts, meeting summaries, doc editing, slide generation. Built into Gmail, Docs, Sheets, and Drive; no context switching needed.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-gemini-workspace.md)

-   :material-draw:{ .lg .middle } **Gemini Canvas**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Collaborative drafting workspace for scripts, briefs, and lightweight tools. Choose Canvas when you want a co-editing experience over a single-turn output.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-gemini-canvas.md)

-   :material-pencil-ruler:{ .lg .middle } **Design Studio**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    AI-powered UI prototyping inside Design Studio. Generate screens from a text prompt then remap to Dialtone components. The Gate 1 prototype standard — replaces v0.dev and Bolt.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-figma-make.md)

-   :material-ticket-outline:{ .lg .middle } **Atlassian Rovo**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    AI inside Jira and Confluence — Q&A on existing docs, in-place ticket updates, and workflow automations without leaving the Atlassian suite.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-atlassian-rovo.md)

-   :material-calendar-check:{ .lg .middle } **monday.com AI**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    AI sidekick within Monday boards — status rollups, task generation, and sprint planning without leaving your project workspace.

    [:octicons-arrow-right-24: Best practices](../best-practices/DP-General-monday-ai.md)

-   :material-link-variant:{ .lg .middle } **JIRA MCP**
    <span class="dp-badge dp-badge--ga">GA</span>

    ---

    Push Claude Code ticket output directly to Jira without copy-paste. Configure once in `09_mcps/` and the full PRD → tickets pipeline is seamless.

    [:octicons-arrow-right-24: Setup guide](../../09_mcps/guides/DP-General-atlassian-setup.md)

</div>

---

[:octicons-book-24: Full overview & tool selection guide](DP-General-tools.md){ .md-button } &nbsp;
[:octicons-tools-24: Best practices index](../best-practices/){ .md-button }
