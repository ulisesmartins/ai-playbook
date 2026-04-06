# Cross-functional Agents

Full multi-step agent workflows that span PM, Design, and Engineering.

<div class="grid cards" markdown>

-   :material-sync:{ .lg .middle } **JIRA Sync**

    ---

    Bi-directional JIRA sync agent — reads open epics and stories, surfaces stale tickets, drafts updates, and flags blockers.

    [:octicons-arrow-right-24: View agent](DP-General-jira-sync/CLAUDE.md)

-   :material-check-all:{ .lg .middle } **Gate Review Team**

    ---

    Simulates PM Lead, Design Lead, Engineering Lead, and GTM Lead review perspectives on a PRD. Surfaces gaps before the actual gate review.

    [:octicons-arrow-right-24: View agent](DP-General-gate-review-team/CLAUDE.md)

-   :material-refresh:{ .lg .middle } **Sprint Retro**

    ---

    Synthesizes raw retro input into a structured report with themes, action items, and a Slack-ready async summary.

    [:octicons-arrow-right-24: View agent](DP-General-sprint-retro/CLAUDE.md)

-   :material-chart-timeline-variant:{ .lg .middle } **Weekly Status**

    ---

    Aggregates JIRA, Slack, and meeting notes into a polished weekly status update calibrated for Leadership, Team, or Stakeholder audiences.

    [:octicons-arrow-right-24: View agent](DP-General-weekly-status/CLAUDE.md)

</div>

---

!!! info "How to run an agent"
    Each agent lives in its own folder with a `CLAUDE.md`. Open Claude Code in that folder, or pass `--context-file` pointing to the agent's `CLAUDE.md`.
