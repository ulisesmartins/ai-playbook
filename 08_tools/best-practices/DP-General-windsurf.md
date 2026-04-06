---
version: 1.0
last_updated: 2026-03-11
change_summary: "Initial version — sourced from Windsurf official docs, Cascade best practices guides, and community research"
status: GA
audience: Coding
---

# Windsurf — Best Practices

## What It Is

Windsurf is a VS Code-fork IDE built around "Flows" — continuous real-time AI awareness of your development context. Its AI assistant, Cascade, operates in three modes: **Code** (agentic implementation), **Ask** (contextual Q&A), and **Plan** (strategy before code). Cascade passively observes file edits, terminal output, and conversation history to infer intent without you repeating yourself.

**Dialpad default use:** Large codebase work, multi-file refactors, and feature implementations that span many files — especially in `dialpad/web-clients` and `dialpad/firespotter`.

---

## Setup

- Install from Windsurf (see `00_getting-started/DP-General-dev-environment-setup.md`)
- Point Windsurf's context at key files from `01_context/codebase-map/` for Dialpad-specific pattern accuracy
- Create a `.windsurfrules` file at the project root and commit it to version control

---

## Core Best Practices

### 1. Write a focused `.windsurfrules` file — layer it correctly
Three rule scopes:
- **Global rules** — your personal coding style and preferences; applied across all projects
- **`.windsurfrules` (project root)** — team conventions and architecture decisions; commit to version control
- **Directory-level rules** — module-specific patterns in monorepos

Do not duplicate rules across layers — it creates contradictions Cascade cannot resolve. Format rules as bullet points or numbered lists, not dense paragraphs.

### 2. Keep rules concise — fewer, sharper rules beat comprehensive coverage
The effective sweet spot is a small set of high-signal rules combined with specific in-prompt guidance for edge cases. Beyond 30–40 rules, Cascade treats all rules as low-priority. Treat rule writing like writing acceptance criteria: precise, testable, minimal.

### 3. Use Plan Mode before any multi-file change
Plan Mode generates a structured implementation plan before Cascade writes any code. Review the plan, edit it directly in the conversation, then approve. Critical for refactors touching shared infrastructure.

### 4. Use `@codebase` search instead of manually attaching files
When uncertain which files are relevant, use `@codebase` search rather than navigating the file tree. Cascade's context engine uses this signal efficiently and avoids the common mistake of over-providing unrelated context.

### 5. Use Memories for persistent cross-session context
Create memories explicitly for:
- Architectural decisions that must not be reversed
- Recurring code patterns or boilerplate
- Team preferences Cascade keeps getting wrong

Cascade also auto-generates memories — review these periodically and delete stale or incorrect ones. Bad memories silently degrade all future sessions.

### 6. Start a fresh Cascade thread for every distinct task
Context drift is Windsurf's primary quality failure mode. A new thread for each task (or feature branch) minimizes this. Think of Cascade threads like git branches — cheap to create, valuable for isolation.

### 7. Use Checkpoints at every major milestone
Before any large change, create a named Checkpoint. If output drifts or breaks something, revert without losing all your work. Especially important when Turbo Mode is on. Create checkpoints liberally.

### 8. Enable Turbo Mode session-by-session, not globally
Turbo Mode auto-executes terminal commands without approval. Enabling it globally removes the review step that catches command errors. Enable it explicitly for safe, disposable environments only.

### 9. Use SWE-1.5 for agentic tasks, lighter models for autocomplete
SWE-1.5 is Windsurf's purpose-trained agentic model. Use it for Cascade's Code and Plan modes. Use faster, cheaper models for autocomplete — quality difference at the autocomplete level is negligible, latency difference is significant.

### 10. Use multiple Cascade windows for parallel feature work
Open separate Cascade windows for separate features. Each window maintains its own context, preventing cross-contamination. This is Windsurf's equivalent of Claude Code subagents.

### 11. Use Cascade Hooks for team-wide policy enforcement
Cascade Hooks fire before and after every Cascade interaction. Use them to:
- Log AI interactions for compliance
- Block prompts containing PII before they reach the model
- Enforce that every Cascade-generated change includes a test file

### 12. Prompt around outcomes and constraints — not implementation steps
Cascade is a multi-step planner. Specify: the desired outcome, constraints it must respect, and any non-obvious context. Telling Cascade *how* to implement something often produces worse results than telling it *what* and *why*.

### 13. Enforce critical architectural rules in prompts — not just in rules files
Cascade can drift from your architecture over long sessions. Periodically repeat the most critical constraints explicitly in prompts, even if they are in `.windsurfrules`. Automated tests that enforce architectural patterns are the reliable backstop.

### 14. Reload rulesets at 70% context capacity for long sessions
For unavoidably long sessions, trigger a ruleset reload when context approaches 70% fill. Use a structured Markdown file as a secondary memory store alongside the native Memories system.

---

## Common Pitfalls

| Pitfall | Fix |
|---|---|
| Turbo Mode enabled globally | Enable per-session in safe environments only |
| Long single threads spanning multiple features | New feature = new thread |
| Rules files with 50+ rules | Fewer, sharper rules + in-prompt guidance for edge cases |
| No automated architecture tests | Automated tests are the reliable backstop against AI drift |
| Stale auto-generated Memories | Review and prune the memory store periodically |
| Manual file attachment when `@codebase` would do better | Use `@codebase` search; attach files only when precision requires it |
| No Checkpoints before large changes | Create a Checkpoint before every major Cascade-driven change |
