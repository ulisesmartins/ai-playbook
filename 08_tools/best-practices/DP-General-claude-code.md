---
version: 1.4
last_updated: 2026-03-19
change_summary: "Added guidance on using gh CLI directly instead of GitHub MCP, with examples"
status: GA
audience: PM, UI, Coding
---

# Claude Code — Best Practices

## What It Is

Claude Code is Anthropic's terminal-native agentic coding assistant. It runs directly in your shell with full filesystem access, executes commands, manages git, runs tests, and orchestrates subagents. Unlike IDE extensions, it operates headlessly and integrates with the rest of this repo through skills (slash commands), hooks, and MCP servers.

**Dialpad default use:** Primary AI agent for PRD drafting, JIRA generation, code review, test writing, ticket breakdown, and any workflow with a skill or agent in `03_skills/` or `04_agents/`.

---

## Setup

1. `npm install -g @anthropic-ai/claude-code`
2. Open `DPAIPlaybook` as your working directory — `CLAUDE.md` loads automatically
3. Configure MCP servers: `09_mcps/guides/DP-General-atlassian-setup.md`, `09_mcps/guides/DP-General-github-setup.md`
4. Load codebase context at the start of engineering sessions: `01_context/codebase-map/DP-General-index.md`

> **Important during first-time setup:** When prompted to log in, select **“Anthropic Console”** — not the other options. The keyword is “Console.” Full guide: https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1974862081/Claude+Code+setup

---

## Core Best Practices

### 1. Use Plan Mode before any multi-file or architectural task
Activate with `Shift+Tab` before complex changes. Claude reads your codebase and proposes a strategy — review and correct it before any code is written. Skipping this is the most expensive mistake for large refactors.

### 2. Keep sessions short and scoped — use `/clear` aggressively
Context window saturation is the primary cause of degraded output. Performance drops measurably above 80% fill. Rules:
- Target 30–45 minute sessions for complex tasks
- Use `/clear` between unrelated tasks
- Use `/compact` (not `/clear`) when transitioning between related phases of the same task — it compresses history while preserving key decisions

### 3. Monitor your token budget with `/context`
Run at session start and periodically throughout. When it hits ~70%, compact, clear, or hand off to a subagent. Do not wait until Claude starts hallucinating.

### 4. Scope file reads — never load entire repositories
Asking Claude to read an entire codebase can consume the entire context window before you ask a question. Use `@filename` to reference specific files. Let Claude’s search tools find what it needs.

### 5. Use subagents for parallel work and isolation
Subagents are separate Claude instances with clean context and scoped permissions. Use them to:
- Run security-scanner, style-checker, and test-coverage checks simultaneously
- Delegate backend work while the main session handles frontend
- Use `isolation: worktree` in subagent config to prevent file conflicts

Define custom subagents in `.claude/agents/` with frontmatter specifying `description`, `prompt`, `tools`, and `permissionMode`.

### 6. Build and share custom slash commands
Store in `.claude/commands/` as markdown files. Check them into version control. In this repo, skills in `03_skills/` are the team’s shared command library — run them with `/skill-name`. See the full authoring guide below.

### 7. Configure hooks for automated quality enforcement
Hooks fire on Claude events (pre-tool use, post-tool use). Practical uses:
- Block writes to certain paths
- Auto-run tests after code changes
- Log all tool invocations for audit

Register in Claude settings pointing to scripts in `10_hooks/`.

### 8. Structure prompts with Context → Intent → Format (CIF)
Non-trivial requests work best as: **Context** (what exists, what constraints apply) → **Intent** (exactly what you want and why) → **Format** (output structure, file targets, code style). Vague intent is the most common source of wasted iterations.

### 9. Provide a model file — don’t describe patterns abstractly
“Write a handler in the style of `src/handlers/users.ts`” dramatically outperforms “follow our handler pattern.” Concrete examples beat abstract descriptions every time.

### 10. Use Extended Thinking for genuinely hard problems
Extended Thinking is slower but produces substantially better results on: system architecture design, complex debugging, large refactor planning. Do not use it for simple edits.

### 11. Use permission modes intentionally

| Mode | When to use |
|---|---|
| **Plan** | Reviews, unfamiliar codebases |
| **AcceptEdits** | Active coding — edits apply, commands ask |
| **Auto** | Pre-approved commands, trusted environment |
| **Full** | Never in production-adjacent environments |

### 12. After two failed corrections, rewrite the prompt
When corrections are not converging after two attempts, the problem is the original prompt. Use `/clear`, apply what you learned, and start with a tighter prompt. Continuing to correct in a degraded context compounds the problem.

---

## Creating Custom Slash Commands

Slash commands (also called **skills**) are reusable prompts stored as `.md` files that Claude Code runs on demand. They are the fastest way to codify a repeated workflow, encode team standards into a single invocable command, and share best practices across the team without copying prompts into every session.

### Where to store command files

| Location | Scope | When to use |
|---|---|---|
| `~/.claude/commands/` | **Global** — available in every project on your machine | Personal shortcuts, role-specific workflows you use daily |
| `.claude/commands/` (repo root) | **Project-local** — available only in this repo | Team-shared skills checked into version control |

Project-local commands take precedence over global commands with the same name. The team’s shared library lives in `03_skills/` and is symlinked or copied to `.claude/commands/` during setup.

### File format

A command file is a plain markdown file. The filename (minus `.md`) becomes the slash command name.

```
.claude/commands/draft-prd.md   →   /draft-prd
.claude/commands/my-review.md  →   /my-review
```

**Minimal example — `hello.md`:**

```markdown
Say hello to the user and introduce yourself as their Dialpad AI assistant.
```

That’s it. Invoke with `/hello`.

### Frontmatter (optional but recommended)

Add YAML frontmatter to provide metadata. Claude Code uses `description` to display help text in the command picker.

```markdown
---
description: Drafts a structured PRD from a feature brief
---

You are a Senior PM at Dialpad. Draft a PRD for the following feature:

$ARGUMENTS
```

Supported frontmatter fields:

| Field | Purpose |
|---|---|
| `description` | Shown in the `/` command picker — keep it one line |
| `allowed-tools` | Restrict which tools the command can use (e.g. `Read, Grep`) |

### Passing arguments with `$ARGUMENTS`

`$ARGUMENTS` is a special placeholder that captures everything the user types after the command name and injects it into the prompt.

```markdown
---
description: Explain a file or code snippet in plain English
---

Explain the following to a non-engineer in plain English. Be concise.

$ARGUMENTS
```

Invoke as:
```
/explain src/components/CallBar.vue
/explain "what does the retry logic in queue.ts do?"
```

When no `$ARGUMENTS` placeholder is present, the user’s inline input is appended to the end of the prompt automatically.

### Multi-step prompts and file loading

Commands can instruct Claude to read context files before responding. This is how the team’s skills load Dialpad-specific context automatically:

```markdown
---
description: Generate JIRA tickets from a PRD section
---

Read the following files before starting:
- 01_context/company/DP-General-mission-and-strategy.md
- 01_context/personas-and-icps/DP-General-user-personas.md

You are a Senior PM at Dialpad. Convert the following PRD section into
JIRA-ready tickets with acceptance criteria and story points.

$ARGUMENTS
```

### Invoking subagents from a command

Commands can spin up subagents by describing the task and tool scope:

```markdown
---
description: Run a parallel PM + Engineering review of a spec
---

Launch two subagents in parallel:

1. PM reviewer: Read $ARGUMENTS and critique it against
   01_context/pdlc/DP-General-design-gate-checklist.md.
   Focus on: JTBD clarity, acceptance criteria completeness, risk coverage.

2. Engineering reviewer: Read $ARGUMENTS and critique it for
   technical feasibility, missing edge cases, and API contract gaps.

Combine both reviews into a single structured output with Critical / Important / Suggestions.
```

### Worked example — full skill file

This is the structure every skill in `03_skills/` follows:

```markdown
---
version: 1.0
last_updated: 2026-03-17
change_summary: "Initial version"
status: GA
slash_command: /my-skill
audience: PM
description: One-line description shown in the command picker
---

# `/my-skill` — Short Title

## Purpose

What this command does and when to use it.

## Required Inputs

```
/my-skill

Input1: [describe]
Input2: [describe]
```

## Expected Output

What Claude will produce.

## Skill Body (Prompt)

```
Read the following files:
- 01_context/...

You are acting as a [role] at Dialpad. [Task description]

[USER_INPUT or $ARGUMENTS]
```

## Known Limitations

- What this command cannot do
```

### Installing a command

**Global (personal use):**
```shell
cp 03_skills/pm/DP-General-draft-prd.md ~/.claude/commands/draft-prd.md
```

**Project-local (team-shared, already set up in this repo):**
```shell
# Commands in .claude/commands/ are picked up automatically
# when Claude Code is opened in the repo root
ls .claude/commands/
```

**Verify it loaded:**
```shell
# In a Claude Code session, type / to open the command picker
# Your command should appear with its description
```

### Naming conventions used in this repo

| Convention | Example |
|---|---|
| Kebab-case filename | `draft-prd.md` → `/draft-prd` |
| Prefix with audience area for clarity | `pm-ux-review.md`, `design-critique.md` |
| File prefix matches Core Area | `DP-General-` for cross-functional, `Support-` for Support-specific |
| One command = one job | Don’t combine unrelated tasks in a single command |

---

## Skill Types — What to Build

Skills are not just markdown files — they are folders that can include scripts, assets, data, and reference code that Claude discovers and uses at runtime. The best skills fit cleanly into one of these categories. Use this as a checklist to identify gaps in your team’s skill library.

*Source: [Lessons from Building Claude Code: How We Use Skills](https://x.com/trq212/status/2033949937936085378) — Thariq (Anthropic)*

| Category | What it does | Dialpad examples |
|---|---|---|
| **1. Library & API Reference** | Explains how to correctly use a library, CLI, or SDK. Includes reference snippets and gotchas. | `billing-lib` — internal billing library edge cases; `frontend-design` — Dialtone design system patterns |
| **2. Product Verification** | Describes how to test or verify code is working. Often paired with Playwright, tmux, or other external tools. Include scripts that enforce assertions. | `signup-flow-driver` — headless browser through signup + email verify + onboarding; `checkout-verifier` — Stripe test cards through checkout UI |
| **3. Data Fetching & Analysis** | Connects to data and monitoring stacks. Includes credentials, dashboard IDs, and common query workflows. | `funnel-query` — signup-to-paid event joins; `grafana` — datasource UIDs, cluster names, problem-to-dashboard lookup |
| **4. Business Process & Team Automation** | Automates repetitive workflows into one command. May depend on other skills or MCPs. | `standup-post` — aggregates ticket tracker + GitHub + Slack; `create-jira-ticket` — enforces schema + post-creation workflow |
| **5. Code Scaffolding & Templates** | Generates framework boilerplate for specific codebase patterns. Useful when scaffolding has natural-language requirements beyond pure code. | `new-migration` — migration file template + common gotchas; `create-app` — new internal app with auth, logging, deploy pre-wired |
| **6. Code Quality & Review** | Enforces code quality standards. Can include deterministic scripts. Run via hooks or GitHub Actions. | `adversarial-review` — spawns a fresh-eyes subagent to critique, iterates until findings degrade to nitpicks; `testing-practices` — what and how to test |
| **7. CI/CD & Deployment** | Helps fetch, push, and deploy code. May reference other skills to collect data. | `babysit-pr` — monitors PR, retries flaky CI, resolves merge conflicts, enables auto-merge; `cherry-pick-prod` — isolated worktree + cherry-pick + PR |
| **8. Runbooks** | Takes a symptom (Slack thread, alert, error) and walks through a multi-tool investigation to produce a structured report. | `oncall-runner` — fetches alert, checks usual suspects, formats finding; `log-correlator` — given a request ID, pulls matching logs from every system |
| **9. Infrastructure Operations** | Performs routine maintenance with guardrails for destructive actions. | `dependency-management` — org’s approval workflow; `cost-investigation` — storage/egress bill spike with specific bucket and query patterns |

---

## Advanced Skill Authoring Tips

Lessons from Anthropic’s internal use of hundreds of skills across their engineering org.

### Don’t state the obvious
Claude already knows a lot about coding and your codebase. Focus skill content on information that pushes Claude **out** of its default behavior — internal conventions, footguns, non-obvious constraints. Don’t repeat what Claude would already do correctly.

### Build a Gotchas section
The highest-signal content in any skill is the **Gotchas** section. Build it from real failure points Claude hits when using your skill. Update it over time as new edge cases surface. This is what separates a mediocre skill from a great one.

### Use the file system for progressive disclosure
A skill is a **folder**, not just a markdown file. Think of the entire file system as context engineering:

- Split detailed API signatures into `references/api.md`
- Put output templates in `assets/template.md` for Claude to copy
- Include folders of reference code, scripts, and examples
- Tell Claude what files exist in your skill folder — it reads them at the right time

### Avoid railroading Claude
Skills are reusable across many situations. Be careful of over-specifying instructions. Give Claude the information it needs but the flexibility to adapt. Overly rigid instructions produce brittle behavior across varied inputs.

### Think through first-run setup
Some skills need user-specific config (e.g., which Slack channel to post to). Store setup information in a `config.json` file in the skill directory. If the config doesn’t exist, have Claude ask the user via `AskUserQuestion`. This pattern makes skills portable across teammates.

### Write the description field for the model
When Claude Code starts a session, it scans every skill’s `description` to decide whether a skill matches the user’s request. The description is not a summary for humans — it’s a **trigger condition** for the model. Write it to describe *when* to invoke the skill, not *what* the skill is.

### Use skills as memory stores
Skills can include persistent data — an append-only log, JSON files, or even a SQLite database. For example, a `standup-post` skill might keep a `standups.log` so the next invocation reads its own history and knows what changed since yesterday. Store durable data in `${CLAUDE_PLUGIN_DATA}` to survive skill upgrades.

### Include scripts and helper libraries
One of the most powerful things you can give Claude is code. Giving Claude scripts and libraries lets it spend turns on **composition** — deciding what to do next — rather than reconstructing boilerplate. For example, a data analysis skill might include a Python library of fetch functions so Claude can generate scripts that compose them for complex queries.

### Use on-demand hooks
Skills can register hooks that activate **only when the skill is invoked** and last for the session. Use this for opinionated guardrails that would be annoying if always-on:

- `/careful` — blocks `rm -rf`, `DROP TABLE`, force-push, `kubectl delete` via PreToolUse matcher on Bash. Only activate when touching prod.
- `/freeze` — blocks any Edit/Write outside a specific directory. Useful when debugging to prevent accidental "fixes" to unrelated code.

---

## Distributing and Measuring Skills

### Sharing with your team

| Method | When to use |
|---|---|
| **Check into repo** (`.claude/skills/`) | Small teams, few repos. Every checked-in skill adds to model context, so keep the set curated. |
| **Plugin marketplace** | Scaling teams. Distribute via an internal plugin marketplace — users install only the skills they need. See [Anthropic plugin marketplace docs](https://code.claude.com/docs/en/plugin-marketplaces). |

### Organic curation process
Don’t centralize skill approval. Let authors upload to a sandbox folder in GitHub and share via Slack. Once a skill has traction (owner’s judgment), submit a PR to move it into the marketplace. **Bad or redundant skills are easy to create** — have some curation method before wide release.

### Composing skills
Skills can reference other skills by name. If a CSV-generation skill needs a file-upload skill, just reference it — Claude invokes it if installed. Formal dependency management isn’t built in yet, but naming conventions make this work.

### Measuring skill usage
Use a `PreToolUse` hook to log skill invocations ([example code](https://gist.github.com/ThariqS/24defad423d701746e23dc19aace4de5)). Track which skills are popular and which are under-triggering relative to expectations.

---

## Use the `gh` CLI Directly — Skip the MCP When You Can

Claude Code can run shell commands natively, which means the GitHub CLI (`gh`) is available out of the box — no MCP server setup, no PAT rotation, no config files. For most GitHub operations, `gh` is faster, simpler, and more reliable than routing through the GitHub MCP.

### Why prefer `gh` over the GitHub MCP

- **Zero setup** — `gh auth login` once and you're done. No MCP config, no PAT management.
- **Lower latency** — CLI calls are direct; MCP adds a server roundtrip and JSON-RPC overhead.
- **Full feature parity** — `gh` covers PRs, issues, releases, Actions, gists, and more. The MCP exposes a subset.
- **Easier debugging** — CLI errors are plain text. MCP errors require checking server logs.
- **Works offline from MCP** — if the MCP server crashes or misconfigures, `gh` still works.

### Common examples

```shell
# List open PRs assigned to you
gh pr list --assignee @me --state open

# View a specific PR diff
gh pr diff 4521

# Check CI status on a PR
gh pr checks 4521

# Create a PR
gh pr create --title "feat: add CSAT card" --body "Implements the new CSAT card component"

# Post a review comment
gh pr review 4521 --comment --body "Looks good, one nit on line 42"

# List recent issues
gh issue list --label "on-call" --state open --limit 20

# View issue details
gh issue view 1234

# Search code across the org
gh search code "featureFlag('CSAT')" --owner dialpad

# Check recent Actions runs
gh run list --limit 5
```

### When to use the GitHub MCP instead

The MCP is still useful when you need **structured data** that Claude will process programmatically (e.g., iterating over all files in a PR diff as JSON objects), or when a skill or agent is already wired to use MCP tools. For interactive, one-off operations — which covers most daily work — `gh` is the better choice.

---

## Dialpad-Specific Guidance

- Always load `01_context/codebase-map/DP-General-index.md` before generating code
- Use Dialtone components and tokens — never hardcode colors or create custom components for existing patterns
- Feature flags wrap ALL new behavior: `v-if="featureFlag('[FLAG_NAME]')"`
- All TypeScript props must have explicit types — no `any`
- Every generated component must include `vi.mock()` tests

---

## Common Pitfalls

| Pitfall | Fix |
|---|---|
| Long multi-topic sessions | `/clear` between unrelated tasks |
| Loading entire repo upfront | Use targeted `@file` references |
| Skipping Plan Mode for large changes | Always run Plan Mode first |
| Over-specified CLAUDE.md (500+ lines) | Ruthlessly edit for density |
| Running Full permissions by default | Use AcceptEdits for daily work |
| Continuing bad threads past 2 corrections | Rewrite the prompt, start fresh |

---

## Git Worktree Workflow

Git worktrees let you run multiple Claude sessions on separate branches simultaneously without conflicts — each worktree gets its own directory and its own Claude conversation history.

### Commands

```shell
# Create a new local branch from a base branch and check it out in a new worktree directory
git worktree add -b <new-local-branch-name> <worktree-directory> <base-branch>

# Create a new local branch from a remote branch and check it out in a new worktree directory
git worktree add -b <new-local-branch-name> <worktree-directory> <origin/remote-branch>

# List all active worktrees
git worktree list

# Remove a worktree when done (use the directory path, not the branch name)
git worktree remove <worktree-directory>
```

### Why Use Worktrees with Claude

- Claude saves conversation history **per worktree** — use `claude --resume` inside a worktree to pick up exactly where you left off
- Run two Claude agents in parallel: one on a feature branch, one on a bug fix, no context bleed
- Pairs with the `isolation: worktree` subagent config to prevent file conflicts across sessions

---

## Key Claude Commands Reference

| Command | What it does |
|---|---|
| `/model` | Change model and effort level — match the model to the task complexity |
| `/rewind` | Roll back changes Claude made in the current session |
| `claude --resume` | Resume a previous conversation (per-worktree history) |
| `/clear` | Clear context window — use between unrelated tasks |
| `/compact` | Compress history while preserving key decisions — use between related phases |
| `/context` | Check token budget — compact or clear at ~70% |
| `Shift+Tab` | Activate Plan Mode before multi-file or architectural tasks |

---

## Plan-Reviewer Prompt

Use this prompt to have Claude review an implementation plan before any code is written. Paste it into a new session, then append the path to your `plan.md` at the end.

> **Tip (Mac):** Keep your `plan/` folder in your Finder sidebar. Click `plan.md` and press `Cmd + Opt + C` to copy its full path, then paste it at the end of this prompt.

```
Act as a staff SWE performing a design and implementation review.
Carefully analyze the proposed plan to fully understand the motivation,
requirements, constraints, and intended outcomes.

Review the plan in detail and identify:
- Missing assumptions or requirements
- Logical inconsistencies or flawed reasoning
- Edge cases that are not addressed
- Architectural or design risks
- Scalability, reliability, or maintainability concerns
- Opportunities to reuse existing classes, functions, modules, or
  abstractions instead of introducing duplicate logic
- Any gaps that could cause issues during implementation

Provide clear, actionable feedback and call out areas that should be
clarified or revised before implementation begins.

The plan is here: <paste path to plan.md>
```

---

## Resources

- **Dialpad setup guide:** https://dialpad.atlassian.net/wiki/spaces/ENG/pages/1974862081/Claude+Code+setup
- **Lessons from Building Claude Code: How We Use Skills** — Thariq (Anthropic): https://x.com/trq212/status/2033949937936085378 — skill types taxonomy, authoring tips, distribution patterns
- **Skill Creator** — Anthropic tool for building skills: https://claude.com/blog/improving-skill-creator-test-measure-and-refine-agent-skills
- **Skills documentation:** https://code.claude.com/docs/en/skills
- **Agent Skills course (Skilljar):** https://anthropic.skilljar.com/introduction-to-agent-skills
- **exploreclaudecode.com** — community resource covering agentic coding patterns, parallel tool execution, and full-repo context strategies with Claude Code
- **Anthropic docs:** https://docs.anthropic.com/claude-code
