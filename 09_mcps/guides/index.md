# MCP Setup Guides

Drop-in MCP (Model Context Protocol) server configurations and step-by-step setup guides for every integration used at Dialpad.

> **New (2026-03-31):** Most MCP servers now use **remote OAuth** — just run a single `claude mcp add` command and authenticate in your browser. No API tokens to create or manage.

!!! warning "Security Clearance Required for Self-Hosted MCP Servers"
    Any MCP server that is **self-hosted and requires API keys or stored credentials** must be **cleared with the Security team** before adoption. This includes community npm packages like `google-workspace-mcp` and `mcp-gsuite`. Always include the MCP's GitHub repo link in your Security review request. See the full [MCP Security Clearance Policy](DP-General-mcp-security-policy.md) for details and the clearance process.

<div class="grid cards" markdown>

-   :material-atlassian:{ .lg .middle } **Atlassian (JIRA + Confluence)**

    ---

    Connect Claude Code to JIRA and Confluence. Create tickets, read epics, and update pages directly from the CLI.

    :material-shield-check:{ .middle } **OAuth — no tokens needed**

    [:octicons-arrow-right-24: Setup guide](DP-General-atlassian-setup.md)

-   :material-github:{ .lg .middle } **GitHub**

    ---

    Connect Claude Code to GitHub. Read PRs, create issues, search code, and manage branches from the CLI.

    :material-shield-check:{ .middle } **OAuth — no tokens needed**

    [:octicons-arrow-right-24: Setup guide](DP-General-github-setup.md)

-   :material-pencil-ruler:{ .lg .middle } **Figma**

    ---

    Connect Claude Code to Figma. Read design context, extract tokens, and analyze components from the CLI.

    :material-shield-check:{ .middle } **OAuth — no tokens needed**

    [:octicons-arrow-right-24: Setup guide](DP-General-figma-setup.md)

-   :material-search-web:{ .lg .middle } **Glean**

    ---

    Connect Claude Code to Glean for enterprise search — surface internal docs, people, and meeting context.

    :material-shield-check:{ .middle } **OAuth — no tokens needed**

    [:octicons-arrow-right-24: Setup guide](DP-General-glean-setup.md)

-   :material-chart-bar:{ .lg .middle } **Amplitude**

    ---

    Connect Claude Code to Amplitude for product analytics — query charts, funnels, and user cohorts from the CLI.

    :material-shield-check:{ .middle } **OAuth — no tokens needed**

    [:octicons-arrow-right-24: Setup guide](DP-General-amplitude-setup.md)

-   :material-database:{ .lg .middle } **Google BigQuery**

    ---

    Connect Claude Code to BigQuery for SQL query generation, data exploration, and results summarization.

    :material-shield-check:{ .middle } **OAuth — no tokens needed** (requires IAM roles)

    [:octicons-arrow-right-24: Setup guide](DP-General-google-bigquery-setup.md)

-   :material-google-drive:{ .lg .middle } **Google Drive**

    ---

    Connect Claude Code to Google Drive to read and reference Docs, Sheets, and Slides as agent context.

    :material-alert:{ .middle } **Deprecated package** — see guide for alternatives

    [:octicons-arrow-right-24: Setup guide](DP-General-google-drive-setup.md)

-   :material-gmail:{ .lg .middle } **Gmail**

    ---

    Connect Claude Code to Gmail for email search, summarization, and draft generation from the CLI.

    :material-account-group:{ .middle } **Community packages** — no official server

    [:octicons-arrow-right-24: Setup guide](DP-General-gmail-setup.md)

-   :material-calendar:{ .lg .middle } **Google Calendar**

    ---

    Connect Claude Code to Google Calendar for meeting context, scheduling awareness, and agenda drafting.

    :material-account-group:{ .middle } **Community packages** — no official server

    [:octicons-arrow-right-24: Setup guide](DP-General-google-calendar-setup.md)

-   :material-check-bold:{ .lg .middle } **Monday.com**

    ---

    Connect Claude Code to Monday.com for project tracking, board updates, and status summaries.

    :material-shield-lock:{ .middle } **OAuth via browser**

    [:octicons-arrow-right-24: Setup guide](DP-General-monday-setup.md)

-   :material-palette:{ .lg .middle } **Dialtone**

    ---

    Connect Claude Code to the Dialtone design system MCP for live token, icon, and component lookups.

    :material-lock-open:{ .middle } **No authentication needed**

    [:octicons-arrow-right-24: Setup guide](DP-General-dialtone-setup.md)

-   :material-web:{ .lg .middle } **Playwright**

    ---

    Connect Claude Code to a browser. Navigate pages, click elements, fill forms, take screenshots, and run end-to-end tests.

    :material-lock-open:{ .middle } **No authentication needed** — runs locally

    [:octicons-arrow-right-24: Setup guide](DP-General-playwright-setup.md)

</div>

---

!!! tip "Drop-in configs"
    JSON config files for each MCP are available in `09_mcps/configs/`. Copy the relevant config block into your `~/.mcp.json` or project-level `.mcp.json`.

!!! info "Remote vs Local MCPs"
    **Remote MCPs** (Atlassian, GitHub, Figma, Amplitude, BigQuery) are hosted by the vendor — add with `claude mcp add --transport http` and authenticate via browser. **Local MCPs** (Glean, Dialtone, Playwright) run as npm packages on your machine via `npx`.
