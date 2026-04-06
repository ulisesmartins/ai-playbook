# PM Agents

Full multi-step agent workflows for Product Managers. Each agent has its own `CLAUDE.md` — run it inside a dedicated folder.

<div class="grid cards" markdown>

-   :material-file-document-edit:{ .lg .middle } **PRD Generator**

    ---

    Full multi-step agent that produces a complete, Dialpad-formatted PRD from a feature brief. Includes research, structuring, and review phases.

    [:octicons-arrow-right-24: View agent](DP-General-prd-generator/CLAUDE.md)

-   :material-rocket-launch:{ .lg .middle } **GTM Generator**

    ---

    Generates a full go-to-market artifact set — positioning, messaging, launch brief, and channel plan — from a PRD.

    [:octicons-arrow-right-24: View agent](DP-General-gtm-generator/CLAUDE.md)

-   :material-cube-outline:{ .lg .middle } **Prototype Builder**

    ---

    Takes a feature brief and builds a clickable HTML/React prototype scoped to the described flows.

    [:octicons-arrow-right-24: View agent](DP-General-prototype-builder/CLAUDE.md)

-   :material-format-list-bulleted:{ .lg .middle } **Task Breakdown Agent**

    ---

    Breaks a feature or PRD into a full JIRA-ready epic with stories, acceptance criteria, and estimates.

    [:octicons-arrow-right-24: View agent](DP-General-task-breakdown/CLAUDE.md)

-   :material-weather-sunny:{ .lg .middle } **Start Day**

    ---

    Morning kickoff agent — pulls open tickets, surfaces blockers, and drafts your daily focus list.

    [:octicons-arrow-right-24: View agent](DP-General-start-day/CLAUDE.md)

-   :material-weather-sunset:{ .lg .middle } **Close Day**

    ---

    End-of-day agent — summarizes decisions made, updates in-progress tickets, and drafts async comms.

    [:octicons-arrow-right-24: View agent](DP-General-close-day/CLAUDE.md)

-   :material-timer-sand:{ .lg .middle } **Long-term PM Agent**

    ---

    Background agent for long-running PM tasks — competitive monitoring, stakeholder updates, and roadmap maintenance.

    [:octicons-arrow-right-24: View agent](DP-General-longterm/CLAUDE.md)

</div>

---

!!! info "How to run an agent"
    Each agent lives in its own folder with a `CLAUDE.md`. Open Claude Code in that folder, or pass `--context-file` pointing to the agent's `CLAUDE.md`.
