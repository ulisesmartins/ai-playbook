<div class="dp-hero-logo dp-hero-logo--external" role="img" aria-label="Dialpad"><svg class="dp-hero-logo-mark" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true"><path d="M20.259 11.1925C20.4774 11.0905 20.431 10.6991 20.1975 10.6455C16.7071 9.84419 13.9897 6.64713 13.407 2.63637C13.3684 2.37077 12.9149 2.30763 12.821 2.55763C11.3179 7.34919 8.06497 11.0996 3.73671 12.9279C3.52642 13.031 3.56908 13.3954 3.795 13.4515C7.2042 14.2987 9.85057 17.4384 10.4432 21.3708C10.4823 21.6302 10.8983 21.6889 10.9931 21.4458C12.7256 16.432 16.0436 12.6656 20.259 11.1925Z" fill="url(#dp-star-ext)"/><defs><linearGradient id="dp-star-ext" gradientUnits="userSpaceOnUse" x1="3.6" y1="2.4" x2="22.6" y2="19.05"><stop stop-color="#7C52FF"/><stop offset="0.5" stop-color="#D52C86"/><stop offset="1" stop-color="#F3960F"/></linearGradient></defs></svg><span class="dp-hero-logo-text">dialpad</span></div>

<div class="dp-hero" markdown>

# AI Playbook ✦

A shared library of agents, prompts, skills, hooks, and templates — pick up and use, or contribute to.

[Get Started](00_getting-started/DP-General-ai-mindset.md){ .md-button .md-button--primary }
[Browse Skills](03_skills/pm/){ .md-button .md-button--hero }
[View All Agents](04_agents/cross-functional/){ .md-button .md-button--hero }
[Ask Glean](https://app.glean.com/){ .md-button .md-button--hero }

</div>

---

## What's in here

<div class="grid cards" markdown>

-   💡 **Getting Started**

    ---

    Dev environment, terminal basics, GitHub overview, and AI agent best practices for PMs and Designers new to the CLI.

    <span class="dp-badge dp-badge--ga">GA</span>

    [→ Start here](00_getting-started/DP-General-ai-mindset.md)

-   🗄️ **Context**

    ---

    Dialpad-specific grounding: company strategy, product areas, PDLC phases, personas, design system, and codebase map.

    <span class="dp-badge dp-badge--ga">GA</span>

    [→ Load context](01_context/company/)

-   📄 **Templates**

    ---

    Standardized output shapes for PRDs, design briefs, component specs, competitive analyses, JIRA epics, and more.

    <span class="dp-badge dp-badge--ga">GA</span>

    [→ Browse templates](02_templates/pm/)

-   ⚡ **Skills**

    ---

    Claude Code slash commands &mdash; `/draft-prd`, `/ticket-breakdown`, `/design-critique`, `/on-call-triage`, and more.

    <span class="dp-badge dp-badge--ga">GA</span>

    [→ Browse skills](03_skills/pm/)

-   🤖 **Agents**

    ---

    Full multi-step agent workflows for PRD generation, prototype building, JIRA sync, GTM, code review, on-call response, gate prep, and more.

    <span class="dp-badge dp-badge--ga">GA</span>

    [→ Browse agents](04_agents/cross-functional/)

-   💬 **Prompts**

    ---

    Single-purpose reusable prompts by role &mdash; PRD drafting, GTM artifacts, JIRA generation, PR descriptions, ADRs, and more.

    <span class="dp-badge dp-badge--ga">GA</span>

    [→ Browse prompts](05_prompts/pm/)

-   👥 **Cowork Plugins**

    ---

    Cowork task definitions for autonomous delegated work &mdash; PRD review, spec breakdown, code review, GTM, and gate review.

    <span class="dp-badge dp-badge--wip">In Progress</span>

    [→ Browse plugins](06_cowork-plugins/DP-General-cowork-overview.md)

-   🔍 **Examples**

    ---

    Annotated AI-generated outputs from real Dialpad work &mdash; PRDs, GTM briefs, and more with reviewer notes on what to adapt.

    <span class="dp-badge dp-badge--ga">GA</span>

    [→ Browse examples](07_examples/)

-   🔧 **Tools**

    ---

    Curated AI tools by role with best practices &mdash; Claude Code, Figma Make, Windsurf, Glean, Monday AI, and more.

    <span class="dp-badge dp-badge--ga">GA</span>

    [→ Browse tools](08_tools/best-practices/)

-   🔌 **MCPs**

    ---

    Drop-in MCP configs and setup guides for JIRA, GitHub, Figma, Glean, Google Drive, Amplitude, and more.

    <span class="dp-badge dp-badge--ga">GA</span>

    [→ Browse MCPs](09_mcps/guides/)

-   🪝 **Hooks**

    ---

    Shell scripts triggered by Claude Code events &mdash; auto-save artifacts, run linters, push to JIRA, and notify Slack on session end.

    <span class="dp-badge dp-badge--ga">GA</span>

    [→ Browse hooks](10_hooks/)

</div>

---

## Core Areas

| Area | Outcome | File prefix |
|---|---|---|
| **Support** | Strong alternative to Nice, Genesys, Five9 | `Support-` |
| **Connect** | Most modern Cloud Communications platform | `Connect-` |
| **Sell** | Credible alternative to Gong | `Sell-` |
| **Ecosystem** | Position Dialpad as a Platform | `Ecosystem-` |
| **SharedServices** | Industry-leading supporting services | `SharedServices-` |
| **Cross-functional** | Applies across all areas | `DP-General-` |

---

## Status legend

| Badge | Meaning |
|---|---|
| <span class="dp-badge dp-badge--ga">GA</span> | Stable, tested, ready for team-wide use |
| <span class="dp-badge dp-badge--wip">In Progress</span> | Actively being built or refined |
| <span class="dp-badge dp-badge--new">New</span> | Scaffolded &mdash; not yet ready for use |
| `DP-Official` | Sourced from or validated by Dialpad's official materials |

---

## Glossary

| Term | Definition |
|---|---|
| **Agent** | A multi-step AI workflow that uses Claude Code to accomplish a complex task autonomously &mdash; e.g., generating a PRD, triaging an on-call alert, or running a gate review. |
| **Claude Code** | Anthropic's CLI-based AI coding assistant. Dialpad's primary AI tool. Runs in the terminal and supports MCP integrations. |
| **Cowork** | Claude Code's multi-agent collaboration mode where multiple AI agents work together on a shared task (e.g., PRD review with PM + Engineering + Design perspectives). |
| **CLAUDE.md** | A configuration file at the root of a repo that gives Claude Code persistent context about the project &mdash; conventions, architecture, and instructions. |
| **Context** | Background information loaded into an AI session to ground its output &mdash; company strategy, product areas, personas, design system docs. |
| **Core Area** | One of Dialpad's five product pillars: Support, Connect, Sell, Ecosystem, or SharedServices. Used as file prefixes. |
| **AI Playbook** | Dialpad's shared AI knowledge base &mdash; originally built for Product Managers, now available to all Dialpad employees. |
| **Glean** | Enterprise search platform that indexes Confluence, Drive, Slack, JIRA, and other internal sources. Connected to Claude Code via MCP. |
| **GTM** | Go-to-Market &mdash; the strategy and artifacts for launching a product or feature (messaging, positioning, enablement). |
| **Hook** | A shell script triggered automatically by Claude Code events (e.g., on session end, on file edit) to run linters, push to JIRA, or notify Slack. |
| **MCP** | Model Context Protocol &mdash; an open standard that lets AI tools connect to external services. Claude Code uses MCPs to talk to JIRA, GitHub, Glean, etc. |
| **MkDocs** | The static site generator that builds this playbook from markdown files. Uses the Material theme. |
| **PDLC** | Product Development Life Cycle &mdash; Dialpad's framework for taking a product idea from discovery through launch. |
| **PRD** | Product Requirements Document &mdash; the primary artifact a PM produces to define what to build and why. |
| **Prompt** | A single-purpose, reusable text instruction for Claude Code &mdash; e.g., "draft a PRD from this brief" or "generate JIRA tickets from this spec." |
| **Skill** | A Claude Code slash command (e.g., `/draft-prd`, `/design-critique`) that runs a predefined prompt or workflow. |
| **Template** | A standardized output shape &mdash; the skeleton structure for a PRD, design brief, competitive analysis, or other artifact. |

---

## We Love

Internal tools built by Dialpad teams that complement the AI Playbook.

<div class="grid cards" markdown>

-   :material-robot-excited:{ .lg .middle } **AI Coach**

    ---

    Dialpad's AI Transformation Coach &mdash; personalized learning paths, hands-on exercises, and progress tracking to help every Dialpad employee build AI fluency. Requires Dialpad SSO.

    [:octicons-arrow-right-24: Open AI Coach](https://dialpadhq.com/ai-coach)

-   :material-palette-swatch:{ .lg .middle } **Design Studio**

    ---

    Dialpad's interactive design system explorer &mdash; browse, preview, and copy Dialtone components, tokens, icons, and patterns. The source of truth for UI consistency across all products.

    [:octicons-arrow-right-24: Open Design Studio](https://dialpad.github.io/design-studio/#/)

</div>

---

## Contributing

Want to add a new skill, prompt, agent, or template? See the full [Contributing guide](contributing.md) for links to every folder.

[Contribute](contributing.md){ .md-button .md-button--primary }
[Open an issue](https://github.com/dialpad/ai-playbook/issues){ .md-button }
