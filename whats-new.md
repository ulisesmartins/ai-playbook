# :material-newspaper-variant-outline: What's New

Latest updates to the AI Playbook. Newest first.

---

**2026-04-02** &mdash; **MCP Security Clearance Policy** &mdash; New policy requiring Security team approval before adopting any self-hosted MCP server that requires API keys or stored credentials. Applies to community packages (Gmail, Google Calendar, Google Drive). Includes clearance request process and current status table. Security admonition added to MCP index page.
[&rarr; View policy](09_mcps/guides/DP-General-mcp-security-policy.md) &middot; [&rarr; View MCP index](09_mcps/guides/index.md)

---

**2026-04-01** &mdash; **Playwright MCP setup guide** &mdash; New guide for the Playwright MCP server &mdash; lets Claude Code control a browser directly from the CLI (navigate pages, click elements, fill forms, take screenshots, run E2E tests). Includes setup via `claude mcp add` or `~/.mcp.json`, configuration options (headless, vision, browser selection), full tool reference table, Dialpad-specific use cases, and troubleshooting. Also added to the MCP index grid, dev environment setup guide, and mkdocs nav.
[&rarr; View setup guide](09_mcps/guides/DP-General-playwright-setup.md) &middot; [&rarr; View MCP index](09_mcps/guides/index.md)

---

**2026-03-31** &mdash; **MCP setup overhaul** &mdash; Fixed all 11 MCP server configurations. Atlassian, GitHub, Figma, Amplitude, BigQuery, and **Monday.com** now use **remote OAuth servers** (no tokens to manage &mdash; just `claude mcp add` and authenticate in browser). Monday.com switched from local npx package to `claude mcp add monday --transport http https://mcp.monday.com/mcp --scope user:ID` (find your user ID from your Monday.com profile URL). Glean corrected to `@gleanwork/local-mcp-server` (OAuth by default). Gmail and Google Calendar guides updated to note official packages don't exist (community alternatives listed). Dev Environment Setup guide restructured into Remote vs Local sections. Help channels corrected (`#ai-coding`, `it@dialpad.com`).
[&rarr; View setup guide](00_getting-started/DP-General-dev-environment-setup.md) &middot; [&rarr; View MCP guides](09_mcps/guides/index.md)

---

**2026-03-27** &mdash; New "Pilot Shell" best-practices guide added to Engineering tools &mdash; covers spec-driven development (`/spec`), TDD-enforced quality hooks, rule generation (`/setup-rules`), reusable skill creation (`/create-skill`), persistent memory, smart model routing, and the local Pilot Shell Console dashboard. Includes Dialpad-specific integration guidance for web-clients and firespotter repos.
[→ View best practices](08_tools/best-practices/DP-General-pilot-shell.md) · [→ View engineering tools](08_tools/engineering/DP-General-tools.md)

---

**2026-03-26** &mdash; New **Design Toolkit** section launched &mdash; 10 pages sourced from the Design Confluence space covering Figma 101, Jira for Product Design, UX Heuristics & Scorecards, Research Tools, Content Design, Resources for Design Managers, Design Tools Repository, Git & GitHub for Designers, Resources for Product Designers, and the Design Tenets Framework. Fully integrated into nav, search, sitemap, and directory.
[→ Browse Design Toolkit](../11_ui/)

---

**2026-03-19** &mdash; Claude Code best practices now recommend using `gh` CLI directly over the GitHub MCP for most daily operations &mdash; zero-setup, lower latency, full examples included. GitHub MCP setup guide updated with a pointer to the CLI alternative.
[→ View best practices](08_tools/best-practices/DP-General-claude-code.md) · [→ View MCP guide](09_mcps/guides/DP-General-github-setup.md)

---

**2026-03-19** &mdash; New `/publish` cross-functional skill added &mdash; auto-detects artifact type and role, validates naming conventions, places files in the correct repo location, updates what's-new, commits, pushes, and verifies gh-pages deployment. Backed by TDD-tested `publish-lib.sh` (9 pure functions, 76 assertions).
[→ View skill](03_skills/cross-functional/DP-General-publish.md)

---

**2026-03-18** &mdash; Claude Code best practices expanded with Anthropic's internal skill lessons &mdash; 9-category skill types taxonomy, advanced authoring tips (gotchas, progressive disclosure, on-demand hooks, skill memory), and distribution/measurement guidance.
[→ View best practices](08_tools/best-practices/DP-General-claude-code.md)

---

**2026-03-18** &mdash; New "Daily Workflow" cross-functional skill added &mdash; automatic session notes, morning briefings (`/day-start`), end-of-day wraps (`/day-wrap`), weekly snippets, action-item tracking, and integration setup for Glean, GitHub, Jira, and Dialpad MCPs.
[→ View skill](03_skills/cross-functional/DP-General-daily-workflow.md)

---

**2026-03-16** &mdash; Glean search best practices added to MCP guide &mdash; operators, filters, Slack integration, browser shortcuts.
[→ View guide](09_mcps/guides/DP-General-glean-setup.md)

---

**2026-03-16** &mdash; New "Tools & Landscape" doc added to Getting Started &mdash; explains Git, why we chose Claude Code and Glean, and how the stack will evolve.
[→ View doc](00_getting-started/DP-General-tools-and-landscape.md)

---

**2026-03-16** &mdash; CEO message from Craig Walker added to AI Mindset page &mdash; "The Future Belongs to Those Who Build With AI."
[→ View page](00_getting-started/DP-General-ai-mindset.md)

---

**2026-03-16** &mdash; Dev Environment Setup expanded with all 11 MCP server configs (Atlassian, GitHub, Glean, Amplitude, Google Drive, Gmail, Calendar, BigQuery, Monday, Design Studio, Dialtone). Removed engineering-only Plugin Marketplace step and Supporting Tools step.
[→ View setup guide](00_getting-started/DP-General-dev-environment-setup.md)

---

**2026-03-16** &mdash; Home page links are now role-aware &mdash; clicking "Browse Skills" or "View All Agents" routes to your selected role's sub-section automatically.

---

**2026-03-16** &mdash; Contributing section on the home page now has an interactive artifact tree with collapsible folders, role tabs, edit links, and "+ New" buttons for every artifact type.

---

**2026-03-16** &mdash; Glossary added to the home page with 17 key terms (Agent, Claude Code, MCP, PDLC, PRD, Skill, etc.).

---

**2026-03-11** &mdash; AI Mindset guide launched &mdash; the mental model for working with AI tools in an accelerating environment.
[→ View guide](00_getting-started/DP-General-ai-mindset.md)

---

**2026-03-09** &mdash; Initial playbook launch with 13 sections, 50+ artifacts across PM, Design, and Engineering. MkDocs Material site deployed to GitHub Pages.
