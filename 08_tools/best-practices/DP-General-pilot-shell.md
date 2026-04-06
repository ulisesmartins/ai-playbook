---
version: 1.0
last_updated: 2026-03-27
change_summary: "Initial version — sourced from Pilot Shell official docs, pilot-shell.com, and integration testing with Dialpad repos"
status: GA
audience: Coding
---

# Pilot Shell — Best Practices

## What It Is

Pilot Shell is a professional development environment built on top of Claude Code that enforces TDD, spec-driven development, quality hooks, persistent memory, and provides a local web console. It replaces Claude Code's default plan mode with a structured `/spec` workflow that walks through exploration, planning, approval, TDD implementation, and verification. Every edit passes through an automatic quality hooks pipeline — linting, formatting, type checking, and test enforcement — so defects are caught before they reach your branch.

**Dialpad default use:** Spec-driven feature implementation, TDD-first bugfixes, and automated quality enforcement on `dialpad/web-clients` and `dialpad/firespotter`. Pairs with Claude Code (primary agent) and Windsurf (IDE) in the default stack.

Website: [pilot-shell.com](https://pilot-shell.com) | Docs: [pilot-shell.com/docs](https://pilot-shell.com/docs)

---

## Setup

1. Install Pilot Shell:
   ```bash
   curl -fsSL https://raw.githubusercontent.com/maxritter/pilot-shell/main/install.sh | bash
   ```
   Works on macOS, Linux, and Windows (WSL2). Requires an active Claude subscription — Max 5x or 20x for solo developers, Team Premium for teams.

2. Run `/setup-rules` once per repository. This executes an 11-phase codebase exploration that generates modular rules, discovers conventions (Vue 3, Dialtone, TypeScript in Dialpad repos), and documents any MCP servers. Re-run when the project structure changes significantly.

3. Pilot Shell auto-installs language servers for Python (basedpyright), TypeScript (vtsls), and Go (gopls). No manual configuration is needed.

4. Open the **Pilot Shell Console** at the local URL shown after startup to access the web dashboard.

---

## Core Best Practices

### 1. Use `/spec` for every planned feature or bugfix — not raw prompts

`/spec` replaces Claude Code's plan mode with a structured, auditable workflow. It auto-detects whether you are building a feature or fixing a bug:

- **Feature mode:** explore → plan → approve → TDD implement → verify
- **Bugfix mode:** investigate → write test-before-fix → verify

The spec is saved, versioned, and reviewable in the Console's Specifications view (with annotation mode). Skipping `/spec` for anything beyond a trivial change means skipping the quality pipeline that justifies using Pilot Shell in the first place.

### 2. Use Quick Mode for small, scoped tasks — TDD and hooks still apply

Quick Mode is regular conversational chat, but the quality hooks pipeline and TDD enforcement remain active. Use it for one-off questions, small refactors, or tasks where a full spec is overhead. The hooks pipeline still runs auto-linting (ruff, ESLint, go vet), formatting, and type checking on every edit.

### 3. Use Headless Mode for CI/CD pipelines

The `-p` flag runs Pilot Shell non-interactively. Use it for automated tasks in CI — spec verification, code generation from templates, or batch processing. Example:

```bash
pilot-shell -p "Run the full test suite and report failures"
```

### 4. Run `/setup-rules` on Dialpad repos to auto-discover conventions

On `dialpad/web-clients` and `dialpad/firespotter`, `/setup-rules` will automatically detect Vue 3 component patterns, Dialtone design system usage, TypeScript conventions, and existing MCP server configurations. This replaces manual rule writing and ensures Pilot Shell respects the codebase as it actually is, not as you remember it.

### 5. Use `/create-skill` to capture recurring domain knowledge

`/create-skill` is a 6-phase interactive skill creator that converts domain expertise into reusable slash commands. If your team repeatedly does the same type of task (e.g., creating a new Dialtone component, scaffolding a Vue 3 page), encode it as a skill once rather than re-prompting every time.

### 6. Let the Quality Hooks Pipeline do its job — do not bypass it

The pipeline runs automatically on every edit:
- **Linting:** ruff (Python), ESLint (JS/TS), go vet (Go)
- **Formatting:** applied automatically
- **Type checking:** via the auto-installed language servers
- **TDD enforcement:** RED → GREEN → REFACTOR cycle is enforced, not suggested

Bypassing hooks to "move faster" defeats the purpose. If hooks are catching too many issues, fix the underlying code or adjust rules via `/setup-rules`.

### 7. Use Smart Model Routing — Opus for planning, Sonnet for implementation

Pilot Shell routes to Opus for planning and reasoning phases and to Sonnet for implementation. This is configurable per-phase in settings. The default routing is well-calibrated; override only when you have a specific reason (e.g., forcing Opus for a particularly complex implementation step).

### 8. Leverage Persistent Memory for cross-session continuity

Observations — decisions, discoveries, bugfix rationale — are automatically preserved across sessions. This means Dialpad architecture decisions, codebase-map context, and past debugging insights carry forward without re-prompting. Review and prune memories periodically in the Console's Memories view to prevent stale context from degrading output.

### 9. Share team rules and skills via the Extensions system

Extensions (rules, commands, skills, agents) are plain Markdown files with APM format support. Share them via git for Dialpad team standardization. This is the mechanism for distributing Dialpad-specific conventions, shared skills, and architectural guardrails across the team.

### 10. Use the Pilot Shell Console for review and oversight

The local web dashboard provides these views:

| View | Purpose |
|---|---|
| **Dashboard** | Real-time session overview |
| **Specifications** | Browse and annotate specs created via `/spec` |
| **Extensions** | Manage rules, commands, skills, agents |
| **Changes** | Review mode for code changes before commit |
| **Memories** | View, edit, and prune persistent observations |
| **Sessions** | Session history and replay |
| **Usage** | Token and cost tracking |
| **Settings** | Model routing, hooks, and preference configuration |
| **Help** | Documentation and troubleshooting |

### 11. Use the built-in MCP servers before adding external ones

Pilot Shell ships with 6 built-in MCP servers:

| Server | Use Case |
|---|---|
| Library docs | API reference lookups |
| Persistent memory | Cross-session observation store |
| Web search | Live web queries |
| GitHub code search | Search across GitHub repos |
| Web page fetching | Pull content from URLs |
| Code knowledge graph | Codebase relationship mapping |

These cover the majority of common needs. Add external MCP servers only when a specific integration is required.

### 12. Monitor the Status Line — it surfaces problems early

The 3-line real-time status bar below every response shows: current model, context window usage, git branch and status, running cost, and spec progress. Watch context fill — the same 70% rule from Claude Code applies. Watch cost — Pilot Shell's token optimization via RTK achieves 60–90% savings, but unusual spikes indicate a problem.

---

## Dialpad Integration

- **Codebase context:** Use `/setup-rules` to generate Dialpad-specific rules rather than maintaining them manually. Cross-reference `01_context/codebase-map/` for additional architecture context.
- **Existing skills complement `/spec`:** Use Pilot Shell's `/spec` for planned features and structured bugfixes. Use AI Playbook skills like `/ticket-breakdown` and `/test-from-spec` from `03_skills/engineering/` for quick, scoped tasks.
- **Persistent memory preserves Dialpad context:** Architecture decisions, component patterns, and codebase-map insights persist across sessions automatically.
- **Team standardization via Extensions:** Distribute Dialpad-specific rules and skills through git using the Extensions system and APM format.
- **Stack fit:** Pilot Shell enhances Claude Code (primary) and pairs with Windsurf (IDE). It does not replace either — it adds TDD enforcement, spec workflow, quality hooks, and a review console on top of Claude Code's core capabilities.

---

## Common Pitfalls

| Pitfall | Fix |
|---|---|
| Skipping `/spec` for non-trivial features | Use `/spec` for anything beyond a one-liner; Quick Mode for small tasks |
| Not running `/setup-rules` after major repo changes | Re-run when project structure, dependencies, or conventions change |
| Overriding Smart Model Routing without reason | Trust the defaults; override only for specific, justified cases |
| Ignoring stale persistent memories | Review the Memories view in the Console periodically and prune |
| Bypassing quality hooks to move faster | Fix the code, not the hooks — the pipeline exists to catch defects early |
| Not using the Console's Changes review mode | Review AI-generated changes before committing, especially for multi-file specs |
| Manually writing rules that `/setup-rules` would auto-generate | Let the 11-phase exploration do the work; manually add only what it misses |

---

## Links

- Pilot Shell website: [pilot-shell.com](https://pilot-shell.com)
- Pilot Shell docs: [pilot-shell.com/docs](https://pilot-shell.com/docs)
- Installation script: `curl -fsSL https://raw.githubusercontent.com/maxritter/pilot-shell/main/install.sh | bash`
- Dialpad codebase context: `01_context/codebase-map/`
- Dialpad engineering skills: `03_skills/engineering/`
- Dev environment setup: `00_getting-started/DP-General-dev-environment-setup.md`
- Claude Code best practices: `08_tools/best-practices/DP-General-claude-code.md`
- Windsurf best practices: `08_tools/best-practices/DP-General-windsurf.md`
