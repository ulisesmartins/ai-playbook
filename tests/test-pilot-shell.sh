#!/usr/bin/env bash
# RED/GREEN TDD tests for Pilot Shell integration into EPD AI Playbook
# Run: bash tests/test-pilot-shell.sh
# Expected: RED (all fail) before content creation, GREEN (all pass) after

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PASS=0
FAIL=0
TESTS=0

# --- helpers ---
assert() {
  local desc="$1"; shift
  TESTS=$((TESTS + 1))
  if "$@" 2>/dev/null; then
    PASS=$((PASS + 1))
    echo "  ✅ PASS: $desc"
  else
    FAIL=$((FAIL + 1))
    echo "  ❌ FAIL: $desc"
  fi
}

file_exists()    { [ -f "$1" ]; }
file_contains()  { grep -q "$2" "$1"; }
file_has_line()  { grep -qF "$2" "$1"; }

echo "========================================"
echo " Pilot Shell TDD Test Suite"
echo "========================================"
echo ""

# --- T1: Best-practices doc exists ---
echo "--- T1: Best-practices document ---"
BP_FILE="$REPO_ROOT/08_tools/best-practices/DP-General-pilot-shell.md"
assert "Best-practices file exists" file_exists "$BP_FILE"
assert "Has YAML frontmatter with version" file_contains "$BP_FILE" "^version:"
assert "Has YAML frontmatter with audience: Engineering" file_contains "$BP_FILE" "audience: Engineering"
assert "Has main heading 'Pilot Shell'" file_contains "$BP_FILE" "^# .*Pilot Shell"
assert "Describes what Pilot Shell is" file_contains "$BP_FILE" "professional development environment"
assert "Documents /spec command" file_contains "$BP_FILE" "/spec"
assert "Documents /setup-rules command" file_contains "$BP_FILE" "/setup-rules"
assert "Documents /create-skill command" file_contains "$BP_FILE" "/create-skill"
assert "Covers TDD enforcement" file_contains "$BP_FILE" "TDD"
assert "Covers quality hooks" file_contains "$BP_FILE" "[Hh]ooks"
assert "Covers persistent memory" file_contains "$BP_FILE" "[Mm]emory"
assert "Has Dialpad-specific guidance" file_contains "$BP_FILE" "Dialpad"
assert "Has installation section" file_contains "$BP_FILE" "[Ii]nstall"
assert "Has best practices section" file_contains "$BP_FILE" "Best Practices"
assert "References pilot-shell.com" file_contains "$BP_FILE" "pilot-shell.com"
echo ""

# --- T2: mkdocs.yml nav includes pilot-shell ---
echo "--- T2: mkdocs.yml navigation ---"
MKDOCS="$REPO_ROOT/mkdocs.yml"
assert "mkdocs.yml references Pilot Shell page" file_has_line "$MKDOCS" "Pilot Shell"
assert "mkdocs.yml points to correct file path" file_has_line "$MKDOCS" "DP-General-pilot-shell.md"
echo ""

# --- T3: Engineering tools page references pilot-shell ---
echo "--- T3: Engineering tools page ---"
ENG_TOOLS="$REPO_ROOT/08_tools/engineering/DP-General-tools.md"
assert "Engineering tools mentions Pilot Shell" file_contains "$ENG_TOOLS" "Pilot Shell"
assert "Engineering tools links to best-practices file" file_contains "$ENG_TOOLS" "DP-General-pilot-shell.md"
assert "Engineering tools has Pilot Shell in tool selection guide" file_contains "$ENG_TOOLS" "[Pp]ilot"
echo ""

# --- T4: whats-new.md has pilot-shell entry ---
echo "--- T4: What's New page ---"
WHATS_NEW="$REPO_ROOT/whats-new.md"
assert "whats-new mentions Pilot Shell" file_contains "$WHATS_NEW" "Pilot Shell"
assert "whats-new has 2026-03-27 date entry" file_contains "$WHATS_NEW" "2026-03-27"
assert "whats-new links to best-practices page" file_contains "$WHATS_NEW" "DP-General-pilot-shell.md"
echo ""

# --- T5: Content quality checks ---
echo "--- T5: Content quality ---"
assert "Best-practices doc is at least 100 lines" [ "$(wc -l < "$BP_FILE" 2>/dev/null || echo 0)" -ge 100 ]
assert "Best-practices doc has code blocks" file_contains "$BP_FILE" '```'
assert "Best-practices doc has tables" file_contains "$BP_FILE" '|.*|.*|'
assert "No broken internal links (08_tools path)" file_contains "$BP_FILE" "08_tools\|03_skills\|01_context"
echo ""

# --- Summary ---
echo "========================================"
echo " Results: $PASS/$TESTS passed, $FAIL failed"
echo "========================================"
if [ "$FAIL" -eq 0 ]; then
  echo " 🟢 ALL GREEN — ready to ship!"
  exit 0
else
  echo " 🔴 RED — $FAIL test(s) need fixing"
  exit 1
fi
