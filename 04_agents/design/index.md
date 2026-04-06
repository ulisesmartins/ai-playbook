# Design Agents

Full multi-step agent workflows for Designers. Each agent has its own `CLAUDE.md` — run it inside a dedicated folder.

<div class="grid cards" markdown>

-   :material-weather-sunny:{ .lg .middle } **Start Day**

    ---

    Morning design kickoff — pulls Design Studio comments, surfaces open critique threads, and sets your design focus for the day.

    [:octicons-arrow-right-24: View agent](DP-General-start-day/CLAUDE.md)

-   :material-weather-sunset:{ .lg .middle } **Close Day**

    ---

    End-of-day design agent — documents decisions made, generates handoff notes, and queues async feedback requests.

    [:octicons-arrow-right-24: View agent](DP-General-close-day/CLAUDE.md)

-   :material-check-decagram:{ .lg .middle } **Dialtone Audit**

    ---

    Audits Design Studio files or component specs for DT9 compliance — flags color, typography, component, spacing, and icon violations with severity ratings.

    [:octicons-arrow-right-24: View agent](DP-General-dialtone-audit/CLAUDE.md)

-   :material-clipboard-check:{ .lg .middle } **Gate Prep**

    ---

    Verifies Gate 1 and Gate 2 readiness — AC coverage, state coverage, Dialtone compliance, and handoff completeness. Produces a structured readiness report.

    [:octicons-arrow-right-24: View agent](DP-General-gate-prep/CLAUDE.md)

-   :material-timer-sand:{ .lg .middle } **Long-term Design Agent**

    ---

    Background agent for ongoing design tasks — tracking design debt, monitoring Dialtone adoption, and maintaining a design log.

    [:octicons-arrow-right-24: View agent](DP-General-longterm/CLAUDE.md)

</div>

---

!!! info "How to run an agent"
    Each agent lives in its own folder with a `CLAUDE.md`. Open Claude Code in that folder, or pass `--context-file` pointing to the agent's `CLAUDE.md`.
