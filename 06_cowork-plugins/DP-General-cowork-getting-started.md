---
version: 2.0
last_updated: 2026-03-16
change_summary: "Rewritten to match Anthropic's actual Cowork product — autonomous delegated task execution"
status: GA
audience: PM, UI, Coding
---

# Cowork Getting Started Guide

## What You Need

- Access to Claude (desktop app with Cowork, or Claude Code CLI)
- The input artifact for your chosen workflow (PRD, epic, PR diff, feature brief, etc.)
- This repo cloned or accessible for context files

---

## Step 1: Choose Your Plugin

Browse `06_cowork-plugins/` for the right task definition. See `DP-General-cowork-overview.md` for a decision guide.

Quick reference:

| I want to... | Use this plugin |
|---|---|
| Get my PRD reviewed before Gate 1 | `pm/DP-General-prd-review-team.md` |
| Break a spec into sized stories | `pm/DP-General-spec-breakdown-team.md` |
| Generate GTM launch artifacts | `cross-functional/DP-General-gtm-team.md` |
| Simulate a gate review | `cross-functional/DP-General-gate-review-team.md` |
| Run a multi-perspective code review | `engineering/DP-General-code-review-team.md` |
| Debug a stubborn issue | `engineering/DP-General-debug-team.md` |
| Audit design for Dialtone compliance | `design/DP-General-dialtone-audit-team.md` |

---

## Step 2: Open the Plugin File

Each plugin file contains:

1. **Objective** — What the task produces
2. **Context files to load** — Which `01_context/` documents Claude should read first
3. **Steps** — The workflow Claude follows autonomously
4. **Output format** — What the deliverable looks like
5. **Exit condition** — What "done" means

Read the full plugin before starting. The task description has `[PLACEHOLDER]` values you must fill in.

---

## Step 3: Fill in the Placeholders

Replace all `[PLACEHOLDER]` values with your actual input.

**Example for `pm/DP-General-prd-review-team.md`:**

```
[PRD_CONTENT] → paste your full PRD text
[CORE_AREA]   → Support
[GATE_TARGET] → Gate 1
```

---

## Step 4: Delegate the Task

**In Cowork (Claude desktop app):** Paste the filled-in task description. Claude will execute it autonomously — reading context files, analyzing your input, and producing structured output. You can step away and come back to the results.

**In Claude Code:** Paste the task description as a prompt. Claude will execute the steps sequentially in your terminal session.

Either way, Claude:
1. Loads the specified context files from `01_context/`
2. Reads your input artifact
3. Executes each step in the workflow
4. Delivers structured output matching the plugin's format

---

## Step 5: Review the Output

Claude delivers a structured result. Review it critically:

- Agree or disagree with each finding
- Prioritize gaps that are Gate blockers vs. nice-to-fix
- Use the output to update your artifact before the human gate review

**Cowork output is a preparation tool, not a gate approval.** Human reviewers at Gate 1 / Gate 2 make the actual decision.

---

## Step 6: Act on the Output

| If the output says... | Do this |
|---|---|
| Ready | Schedule the gate review |
| Not Ready — gaps identified | Fix the flagged gaps, re-run the plugin |
| Blocked — dependencies unresolved | Resolve blockers with the relevant team, then re-run |

---

## Tips for Better Output

1. **Give Claude the full artifact** — A complete PRD produces better feedback than a summary
2. **State the gate target explicitly** — Gate 1 vs. Gate 2 checklists are different
3. **Iterate** — Run the plugin, fix gaps, re-run. Each cycle produces sharper output
4. **Share the output with your team** — Cowork output is a great pre-meeting alignment artifact

---

## Common Mistakes

| Mistake | Fix |
|---|---|
| Pasting a summary instead of the full artifact | Include the complete document — Claude catches details that summaries miss |
| Skipping context files | The plugin specifies which context to load — don't skip this step |
| Treating the output as a gate approval | It is preparation, not a rubber stamp |
| Running multiple plugins in one session | One plugin per session — start fresh for each task |

---

## Support

Questions about Cowork plugins? Post in `#ai-enablement` or `#epd-ai` on Slack.
