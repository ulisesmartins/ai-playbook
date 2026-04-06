#!/usr/bin/env bash
# publish-tests.sh — RED/GREEN TDD test suite for the publish skill
# Tests artifact detection, path resolution, filename validation,
# and what's-new entry generation.

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source the library under test
source "$SCRIPT_DIR/publish-lib.sh"

# ── Test harness ──────────────────────────────────────────────────

PASS=0
FAIL=0
ERRORS=()

assert_eq() {
  local test_name="$1" expected="$2" actual="$3"
  if [[ "$expected" == "$actual" ]]; then
    ((PASS++))
    echo "  PASS: $test_name"
  else
    ((FAIL++))
    ERRORS+=("FAIL: $test_name — expected '$expected', got '$actual'")
    echo "  FAIL: $test_name"
    echo "        expected: '$expected'"
    echo "        actual:   '$actual'"
  fi
}

assert_contains() {
  local test_name="$1" needle="$2" haystack="$3"
  if [[ "$haystack" == *"$needle"* ]]; then
    ((PASS++))
    echo "  PASS: $test_name"
  else
    ((FAIL++))
    ERRORS+=("FAIL: $test_name — '$haystack' does not contain '$needle'")
    echo "  FAIL: $test_name"
    echo "        haystack: '$haystack'"
    echo "        missing:  '$needle'"
  fi
}

assert_not_empty() {
  local test_name="$1" value="$2"
  if [[ -n "$value" ]]; then
    ((PASS++))
    echo "  PASS: $test_name"
  else
    ((FAIL++))
    ERRORS+=("FAIL: $test_name — value was empty")
    echo "  FAIL: $test_name — value was empty"
  fi
}

# ── 1. Artifact Type Detection ────────────────────────────────────

echo ""
echo "=== 1. detect_artifact_type ==="

assert_eq "skill file by frontmatter" \
  "skill" \
  "$(detect_artifact_type "slash_command: /brainstorm" "some-file.md")"

assert_eq "agent by CLAUDE.md filename" \
  "agent" \
  "$(detect_artifact_type "some content" "CLAUDE.md")"

assert_eq "template by content keyword" \
  "template" \
  "$(detect_artifact_type "## Template Header\n[PLACEHOLDER]" "DP-General-prd-template.md")"

assert_eq "prompt by content pattern" \
  "prompt" \
  "$(detect_artifact_type "You are a senior PM at Dialpad. Given the following" "DP-General-prd-from-brief.md")"

assert_eq "hook by trigger event keyword" \
  "hook" \
  "$(detect_artifact_type "Trigger event: PostToolUse\nWhat it does: auto-save" "DP-General-auto-save.md")"

assert_eq "cowork-plugin by roles keyword" \
  "cowork-plugin" \
  "$(detect_artifact_type "## Roles\n- PM Lead\n- Design Lead\n## Kickoff prompt" "DP-General-review-team.md")"

assert_eq "mcp-guide by MCP keyword" \
  "mcp-guide" \
  "$(detect_artifact_type "## MCP Server Setup\nInstall the MCP server" "DP-General-slack-setup.md")"

assert_eq "tool by tools keyword" \
  "tool" \
  "$(detect_artifact_type "## Recommended Tools\nBest practices for using" "DP-General-tools.md")"

assert_eq "example by annotated output" \
  "example" \
  "$(detect_artifact_type "## Annotated Example\nThis PRD demonstrates" "DP-PM-prd-example.md")"

assert_eq "context by context markers" \
  "context" \
  "$(detect_artifact_type "## Mission\nDialpad exists to" "DP-General-mission.md")"

assert_eq "getting-started by onboarding markers" \
  "getting-started" \
  "$(detect_artifact_type "## Prerequisites\nBefore you begin setting up your dev environment" "DP-General-dev-setup.md")"

assert_eq "unknown for ambiguous content" \
  "unknown" \
  "$(detect_artifact_type "Hello world" "random.md")"

# ── 2. Role Detection ─────────────────────────────────────────────

echo ""
echo "=== 2. detect_role ==="

assert_eq "PM from audience frontmatter" \
  "pm" \
  "$(detect_role "audience: PM\nslash_command: /brainstorm")"

assert_eq "ui from audience frontmatter" \
  "ui" \
  "$(detect_role "audience: UI\nslash_command: /design-brief")"

assert_eq "coding from audience frontmatter" \
  "coding" \
  "$(detect_role "audience: Coding")"

assert_eq "cross-functional from audience" \
  "cross-functional" \
  "$(detect_role "audience: Cross-functional")"

assert_eq "cross-functional from All Roles" \
  "cross-functional" \
  "$(detect_role "audience: All Roles")"

assert_eq "unknown when no audience" \
  "unknown" \
  "$(detect_role "some content without audience")"

# ── 3. Target Path Resolution ─────────────────────────────────────

echo ""
echo "=== 3. resolve_target_path ==="

assert_eq "skill + pm" \
  "03_skills/pm" \
  "$(resolve_target_path "skill" "pm")"

assert_eq "skill + coding" \
  "03_skills/coding" \
  "$(resolve_target_path "skill" "coding")"

assert_eq "skill + ui" \
  "03_skills/ui" \
  "$(resolve_target_path "skill" "ui")"

assert_eq "skill + cross-functional" \
  "03_skills/cross-functional" \
  "$(resolve_target_path "skill" "cross-functional")"

assert_eq "agent + pm returns dir" \
  "04_agents/pm" \
  "$(resolve_target_path "agent" "pm")"

assert_eq "template + pm" \
  "02_templates/pm" \
  "$(resolve_target_path "template" "pm")"

assert_eq "template + cross-functional" \
  "02_templates/cross-functional" \
  "$(resolve_target_path "template" "cross-functional")"

assert_eq "prompt + coding" \
  "05_prompts/coding" \
  "$(resolve_target_path "prompt" "coding")"

assert_eq "hook + ui" \
  "10_hooks/ui" \
  "$(resolve_target_path "hook" "ui")"

assert_eq "cowork-plugin + pm" \
  "06_cowork-plugins/pm" \
  "$(resolve_target_path "cowork-plugin" "pm")"

assert_eq "example + coding" \
  "07_examples/coding" \
  "$(resolve_target_path "example" "coding")"

assert_eq "tool + pm" \
  "08_tools/pm" \
  "$(resolve_target_path "tool" "pm")"

assert_eq "mcp-guide no role" \
  "09_mcps/guides" \
  "$(resolve_target_path "mcp-guide" "")"

assert_eq "context with company subpath" \
  "01_context/company" \
  "$(resolve_target_path "context" "company")"

assert_eq "context with product-areas" \
  "01_context/product-areas" \
  "$(resolve_target_path "context" "product-areas")"

assert_eq "getting-started" \
  "00_getting-started" \
  "$(resolve_target_path "getting-started" "")"

# ── 4. Filename Validation ────────────────────────────────────────

echo ""
echo "=== 4. validate_filename ==="

assert_eq "valid DP-General prefix" \
  "valid" \
  "$(validate_filename "DP-General-brainstorm.md")"

assert_eq "valid Support prefix" \
  "valid" \
  "$(validate_filename "Support-ai-csat-prd.md")"

assert_eq "valid Connect prefix" \
  "valid" \
  "$(validate_filename "Connect-daart-context.md")"

assert_eq "valid Sell prefix" \
  "valid" \
  "$(validate_filename "Sell-power-dialer.md")"

assert_eq "valid Ecosystem prefix" \
  "valid" \
  "$(validate_filename "Ecosystem-sfdc-integration.md")"

assert_eq "valid SharedServices prefix" \
  "valid" \
  "$(validate_filename "SharedServices-billing.md")"

assert_eq "valid DP-PM prefix" \
  "valid" \
  "$(validate_filename "DP-PM-product-deep-dive.md")"

assert_eq "invalid no prefix" \
  "invalid" \
  "$(validate_filename "brainstorm.md")"

assert_eq "invalid wrong prefix" \
  "invalid" \
  "$(validate_filename "Random-brainstorm.md")"

assert_eq "invalid no .md extension" \
  "invalid" \
  "$(validate_filename "DP-General-brainstorm.txt")"

assert_eq "CLAUDE.md is always valid (agents)" \
  "valid" \
  "$(validate_filename "CLAUDE.md")"

assert_eq "index.md is always valid" \
  "valid" \
  "$(validate_filename "index.md")"

# ── 5. What's New Entry Generation ────────────────────────────────

echo ""
echo "=== 5. generate_whats_new_entry ==="

entry=$(generate_whats_new_entry \
  "2026-03-19" \
  "New brainstorm skill added for PM role" \
  "03_skills/pm/DP-General-brainstorm.md")

assert_contains "has date" "2026-03-19" "$entry"
assert_contains "has description" "New brainstorm skill" "$entry"
assert_contains "has link" "03_skills/pm/DP-General-brainstorm.md" "$entry"
assert_contains "has arrow prefix" "→ View" "$entry"
assert_contains "has markdown bold date" "**2026-03-19**" "$entry"
assert_contains "has mdash separator" "&mdash;" "$entry"

# ── 6. Suggest Filename ───────────────────────────────────────────

echo ""
echo "=== 6. suggest_filename ==="

assert_eq "suggest from name + core area" \
  "DP-General-brainstorm.md" \
  "$(suggest_filename "brainstorm" "DP-General")"

assert_eq "suggest from name + Support" \
  "Support-ai-csat-review.md" \
  "$(suggest_filename "ai-csat-review" "Support")"

assert_eq "strips .md if already present" \
  "Sell-power-dialer.md" \
  "$(suggest_filename "power-dialer.md" "Sell")"

assert_eq "lowercases the name part" \
  "DP-General-my-skill.md" \
  "$(suggest_filename "My-Skill" "DP-General")"

# ── 7. Describe Artifact Type ─────────────────────────────────────

echo ""
echo "=== 7. describe_artifact_type ==="

assert_eq "skill description" \
  "Skill (Claude Code slash command)" \
  "$(describe_artifact_type "skill")"

assert_eq "agent description" \
  "Agent (multi-step workflow)" \
  "$(describe_artifact_type "agent")"

assert_eq "template description" \
  "Template (output skeleton)" \
  "$(describe_artifact_type "template")"

assert_eq "prompt description" \
  "Prompt (standalone reusable prompt)" \
  "$(describe_artifact_type "prompt")"

assert_eq "hook description" \
  "Hook (Claude event automation)" \
  "$(describe_artifact_type "hook")"

assert_eq "cowork-plugin description" \
  "Cowork Plugin (multi-agent session)" \
  "$(describe_artifact_type "cowork-plugin")"

# ── 8. Valid Roles ────────────────────────────────────────────────

echo ""
echo "=== 8. is_valid_role ==="

assert_eq "pm is valid" "true" "$(is_valid_role "pm")"
assert_eq "ui is valid" "true" "$(is_valid_role "ui")"
assert_eq "coding is valid" "true" "$(is_valid_role "coding")"
assert_eq "cross-functional is valid" "true" "$(is_valid_role "cross-functional")"
assert_eq "random is invalid" "false" "$(is_valid_role "random")"
assert_eq "empty is invalid" "false" "$(is_valid_role "")"

# ── 9. Valid Core Area Prefixes ───────────────────────────────────

echo ""
echo "=== 9. is_valid_prefix ==="

assert_eq "DP-General valid" "true" "$(is_valid_prefix "DP-General")"
assert_eq "Support valid" "true" "$(is_valid_prefix "Support")"
assert_eq "Connect valid" "true" "$(is_valid_prefix "Connect")"
assert_eq "Sell valid" "true" "$(is_valid_prefix "Sell")"
assert_eq "Ecosystem valid" "true" "$(is_valid_prefix "Ecosystem")"
assert_eq "SharedServices valid" "true" "$(is_valid_prefix "SharedServices")"
assert_eq "DP-PM valid" "true" "$(is_valid_prefix "DP-PM")"
assert_eq "Random invalid" "false" "$(is_valid_prefix "Random")"

# ── Summary ───────────────────────────────────────────────────────

echo ""
echo "========================================"
echo "  Results: $PASS passed, $FAIL failed"
echo "========================================"

if [[ $FAIL -gt 0 ]]; then
  echo ""
  echo "Failures:"
  for err in "${ERRORS[@]}"; do
    echo "  $err"
  done
  exit 1
fi

exit 0
