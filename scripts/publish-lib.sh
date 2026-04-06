#!/usr/bin/env bash
# publish-lib.sh — Pure functions for the publish skill.
# Sourced by publish-tests.sh (TDD) and by the Claude Code /publish command.

# ── detect_artifact_type ──────────────────────────────────────────
# Given file content and filename, return the artifact type.
# Args: $1=content  $2=filename
detect_artifact_type() {
  local content="$1" filename="$2"

  # Agent: CLAUDE.md is always an agent definition
  if [[ "$filename" == "CLAUDE.md" ]]; then
    echo "agent"; return
  fi

  # Skill: has slash_command in frontmatter
  if echo -e "$content" | grep -qi 'slash_command:' 2>/dev/null; then
    echo "skill"; return
  fi

  # Hook: has trigger event keyword
  if echo -e "$content" | grep -qi 'trigger event:' 2>/dev/null; then
    echo "hook"; return
  fi

  # Cowork-plugin: has Roles section + Kickoff prompt
  if echo -e "$content" | grep -qi '## Roles' 2>/dev/null && echo -e "$content" | grep -qi 'kickoff prompt' 2>/dev/null; then
    echo "cowork-plugin"; return
  fi

  # MCP guide: has MCP Server or MCP setup keywords
  if echo -e "$content" | grep -qi 'mcp server' 2>/dev/null; then
    echo "mcp-guide"; return
  fi

  # Template: has [PLACEHOLDER] or Template in header
  if echo -e "$content" | grep -qi '\[PLACEHOLDER\]' 2>/dev/null; then
    echo "template"; return
  fi
  if echo -e "$content" | grep -qi '## Template' 2>/dev/null; then
    echo "template"; return
  fi

  # Example: has Annotated Example
  if echo -e "$content" | grep -qi 'annotated example' 2>/dev/null; then
    echo "example"; return
  fi

  # Tool: has Recommended Tools or best practices
  if echo -e "$content" | grep -qi 'recommended tools' 2>/dev/null; then
    echo "tool"; return
  fi
  if echo -e "$content" | grep -qi 'best practices for using' 2>/dev/null; then
    echo "tool"; return
  fi

  # Getting started: has Prerequisites + dev environment
  if echo -e "$content" | grep -qi 'prerequisites' 2>/dev/null && echo -e "$content" | grep -qi 'dev environment\|setting up' 2>/dev/null; then
    echo "getting-started"; return
  fi

  # Context: has Mission or company-level markers
  if echo -e "$content" | grep -qi '## Mission' 2>/dev/null; then
    echo "context"; return
  fi
  if echo -e "$content" | grep -qi 'Dialpad exists to' 2>/dev/null; then
    echo "context"; return
  fi

  # Prompt: standalone instructional content (catch-all for prompt-like content)
  if echo -e "$content" | grep -qi 'you are a.*at dialpad\|given the following' 2>/dev/null; then
    echo "prompt"; return
  fi

  echo "unknown"
}

# ── detect_role ───────────────────────────────────────────────────
# Given file content, extract the target role.
# Args: $1=content
detect_role() {
  local content="$1"

  # Extract audience from frontmatter
  local audience=""
  audience=$(echo -e "$content" | grep -i '^audience:' 2>/dev/null | head -1 | sed 's/^audience:[[:space:]]*//' | tr -d '\r') || true

  if [[ -z "$audience" ]]; then
    echo "unknown"; return
  fi

  # Normalize
  case "$audience" in
    PM|pm)                    echo "pm" ;;
    UI|ui)                    echo "ui" ;;
    Coding|coding)            echo "coding" ;;
    Cross-functional|cross-functional|"All Roles"|"All roles"|"all roles")
                              echo "cross-functional" ;;
    *)                        echo "unknown" ;;
  esac
}

# ── resolve_target_path ───────────────────────────────────────────
# Given artifact type and role/subpath, return the repo-relative target dir.
# Args: $1=artifact_type  $2=role_or_subpath
resolve_target_path() {
  local type="$1" role="${2:-}"

  case "$type" in
    skill)           echo "03_skills/$role" ;;
    agent)           echo "04_agents/$role" ;;
    template)        echo "02_templates/$role" ;;
    prompt)          echo "05_prompts/$role" ;;
    hook)            echo "10_hooks/$role" ;;
    cowork-plugin)   echo "06_cowork-plugins/$role" ;;
    example)         echo "07_examples/$role" ;;
    tool)            echo "08_tools/$role" ;;
    mcp-guide)       echo "09_mcps/guides" ;;
    context)         echo "01_context/$role" ;;
    getting-started) echo "00_getting-started" ;;
    *)               echo "" ;;
  esac
}

# ── validate_filename ─────────────────────────────────────────────
# Check if filename follows the [CoreArea]-[name].md convention.
# Args: $1=filename
validate_filename() {
  local filename="$1"

  # Special files always valid
  if [[ "$filename" == "CLAUDE.md" || "$filename" == "index.md" ]]; then
    echo "valid"; return
  fi

  # Must end in .md
  if [[ "$filename" != *.md ]]; then
    echo "invalid"; return
  fi

  # Must start with a valid prefix
  if [[ "$filename" =~ ^(DP-General|DP-PM|Support|Connect|Sell|Ecosystem|SharedServices)- ]]; then
    echo "valid"
  else
    echo "invalid"
  fi
}

# ── generate_whats_new_entry ──────────────────────────────────────
# Generate a what's-new entry line.
# Args: $1=date  $2=description  $3=relative_path
generate_whats_new_entry() {
  local date="$1" desc="$2" path="$3"
  echo "**${date}** &mdash; ${desc}"$'\n'"[→ View](${path})"
}

# ── suggest_filename ──────────────────────────────────────────────
# Given a name and core area prefix, suggest a valid filename.
# Args: $1=name  $2=prefix
suggest_filename() {
  local name="$1" prefix="$2"

  # Strip .md if already present
  name="${name%.md}"

  # Lowercase the name part
  name=$(echo "$name" | tr '[:upper:]' '[:lower:]')

  echo "${prefix}-${name}.md"
}

# ── describe_artifact_type ────────────────────────────────────────
# Return a human-readable label for an artifact type.
# Args: $1=type
describe_artifact_type() {
  local type="$1"
  case "$type" in
    skill)           echo "Skill (Claude Code slash command)" ;;
    agent)           echo "Agent (multi-step workflow)" ;;
    template)        echo "Template (output skeleton)" ;;
    prompt)          echo "Prompt (standalone reusable prompt)" ;;
    hook)            echo "Hook (Claude event automation)" ;;
    cowork-plugin)   echo "Cowork Plugin (multi-agent session)" ;;
    mcp-guide)       echo "MCP Guide (server setup)" ;;
    tool)            echo "Tool (recommended AI tool)" ;;
    example)         echo "Example (annotated reference output)" ;;
    context)         echo "Context (Dialpad-specific grounding)" ;;
    getting-started) echo "Getting Started (onboarding guide)" ;;
    *)               echo "Unknown artifact type" ;;
  esac
}

# ── is_valid_role ─────────────────────────────────────────────────
# Args: $1=role
is_valid_role() {
  local role="${1:-}"
  case "$role" in
    pm|ui|coding|cross-functional) echo "true" ;;
    *) echo "false" ;;
  esac
}

# ── is_valid_prefix ───────────────────────────────────────────────
# Args: $1=prefix
is_valid_prefix() {
  local prefix="${1:-}"
  case "$prefix" in
    DP-General|DP-PM|Support|Connect|Sell|Ecosystem|SharedServices) echo "true" ;;
    *) echo "false" ;;
  esac
}
