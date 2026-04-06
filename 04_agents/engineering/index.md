# Engineering Agents

Full multi-step agent workflows for Engineers. Each agent has its own `CLAUDE.md` — run it inside a dedicated folder.

<div class="grid cards" markdown>

-   :material-phone-alert:{ .lg .middle } **On-Call Responder**

    ---

    Autonomous on-call response agent — triages alerts, identifies root cause, generates a mitigation plan, and drafts a comms.

    [:octicons-arrow-right-24: View agent](DP-General-on-call-responder/CLAUDE.md)

-   :material-source-branch:{ .lg .middle } **Code Review**

    ---

    Automated code review workflow — checks for correctness, test coverage, performance issues, and Dialpad coding standards.

    [:octicons-arrow-right-24: View agent](DP-General-code-review/CLAUDE.md)

-   :material-test-tube:{ .lg .middle } **Test Writer**

    ---

    Generates a full test suite from a spec or existing implementation — unit, integration, and edge cases.

    [:octicons-arrow-right-24: View agent](DP-General-test-writer/CLAUDE.md)

-   :material-weather-sunny:{ .lg .middle } **Start Day**

    ---

    Morning engineering kickoff — surfaces open PRs, failing tests, and on-call alerts. Sets your engineering focus.

    [:octicons-arrow-right-24: View agent](DP-General-start-day/CLAUDE.md)

-   :material-weather-sunset:{ .lg .middle } **Close Day**

    ---

    End-of-day agent — documents decisions, updates PR descriptions, and drafts async engineering updates.

    [:octicons-arrow-right-24: View agent](DP-General-close-day/CLAUDE.md)

-   :material-timer-sand:{ .lg .middle } **Long-term Eng Agent**

    ---

    Background agent for long-running engineering tasks — tech debt tracking, dependency monitoring, and incident pattern analysis.

    [:octicons-arrow-right-24: View agent](DP-General-longterm/CLAUDE.md)

</div>

---

!!! info "How to run an agent"
    Each agent lives in its own folder with a `CLAUDE.md`. Open Claude Code in that folder, or pass `--context-file` pointing to the agent's `CLAUDE.md`.
