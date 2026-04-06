---
version: 1.0
last_updated: 2026-03-11
change_summary: "Initial version — sourced from GitHub Docs, GitHub Blog, and community research through March 2026"
status: GA
audience: Coding
---

# GitHub Copilot — Best Practices

## What It Is

GitHub Copilot provides AI assistance across three modes: **inline completions** (real-time suggestions as you type), **Edits mode** (targeted multi-line changes), and **Agent mode** (autonomous multi-file, multi-step work). As of 2026, it also includes Copilot Code Review (automated PR review), Copilot CLI (terminal agent), and Copilot Spaces (persistent multi-session workspaces).

**Dialpad default use:** Inline autocomplete and single-function generation. Use Claude Code or Windsurf for larger tasks — they understand Dialpad's patterns and Dialtone.

---

## Setup

- Copilot is provisioned for all Dialpad engineers — activate in your IDE settings
- Create `.github/copilot-instructions.md` in each active repository
- For monorepos, add path-specific `.github/instructions/*.md` files per directory
- Enable vulnerability protection in organization settings

---

## Core Best Practices

### 1. Create `copilot-instructions.md` as your foundation
This file is automatically injected into every Copilot interaction. Include: language/framework versions, testing framework, naming conventions, import style, and anti-patterns to avoid. Keep it under 1,000 lines — beyond that, response quality degrades. Use bullet-point imperatives with clear headings, not narrative paragraphs.

### 2. Use path-specific instruction files for monorepos
Scope `.instructions.md` files to specific directories via an `applyTo` field (stored in `.github/instructions/`). Give different conventions to `/frontend`, `/backend`, and `/infra` without one catch-all file creating conflicts.

### 3. Match the mode to the task

| Mode | Use for |
|---|---|
| **Inline/completions** | Boilerplate, routine patterns, single-location suggestions |
| **Edits** | Targeted multi-line changes within a file, refactors, renames |
| **Agent** | Cross-file, multi-step work: scaffolding, cross-cutting refactors, test iterations |

Agent mode sends multiple requests per prompt and consumes quota faster — don't use it for well-scoped, single-file changes.

### 4. Write precise, decomposed prompts
Break large asks into chains of small, specific sub-prompts. Instead of "build me a word search puzzle," ask Copilot to: (1) define the grid structure, (2) implement word placement logic, (3) generate the UI. Each prompt should state what you want, the constraints, and what a correct result looks like.

### 5. Control the context window deliberately
Open only files directly relevant to the task. Every unrelated open tab degrades signal. Use `#file` references or drag-and-drop files explicitly into Chat when you need precision.

### 6. Use `@workspace` / `@project` for cross-file awareness
These chat participants scan your entire workspace for relevant context before responding. Use them when you need Copilot to understand relationships between files — e.g., "where are all the places we call this deprecated API?"

### 7. Write tests first to anchor code generation
Write (or generate) the test file describing expected behavior, then ask Copilot to implement the function that satisfies those tests. This grounds Copilot in the actual contract and gives you a built-in acceptance gate.

### 8. Use Copilot Code Review on every PR with custom instructions
Enable Copilot Code Review and configure it with your `.instructions.md` files so it reviews against your actual standards. Enable Copilot Memory (Pro/Pro+ plans) so it builds a persistent understanding of your repository's patterns across reviews.

### 9. Connect MCP servers for integrated workflows
MCP is the standard for giving Copilot access to external tools. Connect servers for GitHub Issues, JIRA, internal APIs, or databases. This allows Agent mode to: read an issue, pull relevant code, make changes, run tests, and file a PR — all in one session.

### 10. Define custom agents for repeatable team workflows
Add a config file under `.github/agents/` to define team-specific agents — a "Security Reviewer," a "Migration Agent." These are reusable across your org via `{org}/.github`.

### 11. Treat every suggestion as untrusted code until reviewed
~30% of Copilot-generated code snippets contain security weaknesses across 43 CWE categories. Specific risks: hardcoded secrets, insecure auth patterns, SQL injection. Never ship Copilot suggestions without human review.

### 12. Never put secrets in prompts or instruction files
`.github/copilot-instructions.md` is plain text committed to your repo. Never include API keys, tokens, or passwords. Use environment variable references instead.

### 13. Give the coding agent explicit acceptance criteria
When assigning tasks to the Copilot coding agent, include: a clear problem statement, files that need to change, whether tests are required, and what a passing state looks like. "The unit tests should pass" is a better exit condition than "it should work."

### 14. Use Copilot Spaces for long-running, multi-session projects
Copilot Spaces (GA September 2025) lets you attach code, documents, and notes to a persistent workspace Copilot references across sessions. Use for extended feature work or onboarding engineers to a complex area of the codebase.

---

## Common Pitfalls

| Pitfall | Fix |
|---|---|
| Using Agent mode for simple tasks | Use inline or Edits mode; Agent mode is slower and burns quota |
| Narrative instruction files | Structure as bullet-point imperatives; Copilot scans structurally |
| Over-1,000-line instruction files | Split into path-specific files |
| Accepting suggestions without understanding them | Ask "explain this code" before accepting anything opaque |
| No vulnerability protection enabled | Enable in organization settings — it is an opt-in toggle |
| Secrets in instruction files | Environment variable references only |
| Multiple unrelated concerns in one agent session | Scope each session to one coherent task |
