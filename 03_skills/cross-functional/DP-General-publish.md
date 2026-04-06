---
version: 1.0
last_updated: 2026-03-19
change_summary: "Initial version"
status: GA
slash_command: /publish
audience: All Roles
---

# `/publish` — Upload Artifact to AI Playbook

## Purpose

Takes any playbook artifact — skill, agent, template, prompt, hook, cowork-plugin, MCP guide, tool doc, example, context doc, or getting-started guide — and publishes it to the correct location in the `dialpad/ai-playbook` repository. Auto-detects artifact type and role from file content, validates naming conventions, asks when in doubt, updates the changelog, commits, pushes, and verifies the gh-pages deployment.

## Required Inputs

Provide one of:

- **File path** — path to an existing `.md` file you want to publish
- **Inline content** — paste the full artifact content directly
- **Description** — describe what you want to publish (the skill will ask for actual content)

```
/publish path/to/my-new-skill.md
```

Or simply:

```
/publish
```

Then provide or describe the artifact when prompted.

## How It Works

### Step 1 — Analyze

The skill reads the source file and uses the `publish-lib.sh` helper library to classify it:

| Detection | How | Possible Values |
|-----------|-----|-----------------|
| **Artifact type** | Content heuristics (frontmatter keywords, section headers, structural patterns) | skill, agent, template, prompt, hook, cowork-plugin, mcp-guide, tool, example, context, getting-started |
| **Role** | `audience:` frontmatter field | pm, design, engineering, cross-functional |
| **Filename** | Prefix validation against naming convention | valid / invalid |

### Step 2 — Ask When In Doubt

The skill prompts you if:

- Artifact type can't be determined → asks you to choose
- Role is ambiguous and the type requires one → asks which role
- Filename doesn't follow `[CoreArea]-[name].md` → suggests a corrected name
- Context files need a subfolder → asks: company, product-areas, pdlc, personas-and-icps, design-system, or codebase-map

### Step 3 — Place the File

Resolves the target path using the artifact type + role mapping:

| Type | Target Directory |
|------|-----------------|
| skill | `03_skills/<role>/` |
| agent | `04_agents/<role>/<agent-name>/CLAUDE.md` |
| template | `02_templates/<role>/` |
| prompt | `05_prompts/<role>/` |
| hook | `10_hooks/<role>/` |
| cowork-plugin | `06_cowork-plugins/<role>/` |
| example | `07_examples/<role>/` |
| tool | `08_tools/<role>/` |
| mcp-guide | `09_mcps/guides/` |
| context | `01_context/<subfolder>/` |
| getting-started | `00_getting-started/` |

Confirms the destination with you before writing.

### Step 4 — Validate Frontmatter

Ensures proper YAML frontmatter exists. Adds missing fields:

```yaml
---
version: 1.0
last_updated: YYYY-MM-DD
change_summary: "Initial version"
status: New
---
```

For skills, also ensures `audience:` and `slash_command:` are present.

### Step 5 — Update Changelog & Push

1. Prepends a dated entry to `whats-new.md`
2. Commits the new file + changelog update
3. Pushes to `master`
4. Verifies the GitHub Actions deployment was triggered

The CI/CD pipeline (`deploy-docs.yml`) automatically regenerates `directory.md`, section index pages, and deploys to gh-pages.

## Expected Output

After a successful publish:

```
File published to: 03_skills/pm/DP-General-brainstorm.md
Commit: a1b2c3d
Deployment: in_progress (auto-deploys to gh-pages on push to master)
Pages URL: https://dialpad.github.io/ai-playbook/03_skills/pm/DP-General-brainstorm/
```

## Helper Library

The detection logic lives in `scripts/publish-lib.sh` — 9 pure, tested functions:

| Function | Purpose |
|----------|---------|
| `detect_artifact_type` | Classify file by content heuristics |
| `detect_role` | Extract role from `audience:` frontmatter |
| `resolve_target_path` | Map type + role → repo directory |
| `validate_filename` | Check `[CoreArea]-[name].md` convention |
| `suggest_filename` | Generate a valid filename from name + prefix |
| `generate_whats_new_entry` | Format a what's-new changelog line |
| `describe_artifact_type` | Human-readable type label |
| `is_valid_role` | Validate role string |
| `is_valid_prefix` | Validate Core Area prefix |

Test suite: `scripts/publish-tests.sh` — 76 assertions across 9 test groups.

## Naming Convention

Files MUST start with one of:

| Prefix | When to Use |
|--------|-------------|
| `DP-General-` | Cross-functional or role-agnostic (default) |
| `DP-PM-` | PM-specific with product focus |
| `Support-` | Support Core Area |
| `Connect-` | Connect Core Area |
| `Sell-` | Sell Core Area |
| `Ecosystem-` | Ecosystem Core Area |
| `SharedServices-` | Shared Services Core Area |

## Known Limitations

- Agent detection requires the file to be named `CLAUDE.md` — if the agent content is in a differently named file, the skill may misclassify it
- Content heuristic detection is pattern-based and may misclassify highly unusual files — the skill asks for confirmation when uncertain
- The skill does not update `contributing.md` — the interactive artifact tree there is manually maintained
- gh-pages deployment is asynchronous; the skill verifies the workflow was triggered but cannot confirm the final deploy succeeded in real time
