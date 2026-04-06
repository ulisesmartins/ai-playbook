---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
category: code-context
audience: Coding
---

# Spec to Inline Comments — Generate In-Code Spec Comments from a PRD or Story

## Purpose

Reads a PRD section or JIRA story acceptance criteria and generates inline code comments that
describe the expected behavior at each implementation point. These comments serve as a living
spec inside the codebase — helping AI coding agents, reviewers, and future engineers understand
the "why" behind the code.

---

## Context to Load Before Running

- `01_context/codebase-map/DP-General-key-patterns.md`
- The JIRA story or PRD section for this code
- The target file(s) to annotate

---

## Prompt Body

```
You are a Staff Engineer at Dialpad annotating code with spec comments that clarify intent
for AI coding agents and future reviewers.

Here is the spec (JIRA story or PRD section):
[SPEC_CONTENT]

Here is the code to annotate:
[CODE_CONTENT]

File path: [FILE_PATH]
Framework: [Vue 3 / Python / "detect from code"]
Feature flag: [FLAG_NAME or "not used"]

Add inline spec comments to the code following these rules:

COMMENT TYPES:
1. // SPEC: [description] — explains WHAT this code is expected to do per the spec
2. // WHY: [reason] — explains WHY this approach was chosen (architectural decision)
3. // CONSTRAINT: [rule] — documents a business rule or constraint the code must enforce
4. // TODO(spec): [question] — flags a spec gap where the implementation choice is unclear

PLACEMENT RULES:
- Add SPEC comments above every function, method, or computed property that implements
  an acceptance criterion
- Add CONSTRAINT comments on any conditional that enforces a business rule
  (e.g., permission check, feature flag gate, plan-tier logic)
- Add WHY comments only for non-obvious implementation choices
  (e.g., "WHY: Vue reactivity requires this to be a computed, not a method")
- Add TODO(spec) comments where the AC is ambiguous — do not guess intent
- Do NOT add comments that restate what the code obviously does
  (e.g., // increment counter — bad; // SPEC: count is incremented on each completed call — good)

FEATURE FLAG PATTERN:
- Every feature-flag gate must have a CONSTRAINT comment:
  // CONSTRAINT: [FLAG_NAME] gates this behavior — off by default, enabled per org

RETURN:
The fully annotated code file, with a summary at the top listing:
- ACs covered by this file
- ACs NOT covered (must be implemented elsewhere)
- Spec gaps (TODO(spec) items that require PM clarification)
```

---

## Variables

| Variable | Description | Example |
|---|---|---|
| `[SPEC_CONTENT]` | JIRA story ACs or PRD section | Paste AC list or PRD section |
| `[CODE_CONTENT]` | The source file to annotate | Paste `.vue` or `.py` file content |
| `[FILE_PATH]` | Relative path for context | `src/components/coaching/CsatCard.vue` |
| `[FLAG_NAME]` | Feature flag if applicable | `dp_coaching_csat_v2` |

---

## Usage Example

```
Spec (JIRA Story ACs):
1. Given an agent's CSAT score is below 3.5, when the coach views the coaching dashboard,
   then the CSAT card displays a red indicator badge.
2. Given the feature flag dp_coaching_csat_v2 is OFF, when any user accesses the dashboard,
   then the CSAT card is not rendered.

[Paste CsatCard.vue content]

File path: src/components/coaching/CsatCard.vue
Feature flag: dp_coaching_csat_v2
```

---

## Expected Output

1. Fully annotated code file with SPEC, WHY, CONSTRAINT, and TODO(spec) comments
2. Coverage summary:
   - ACs covered
   - ACs not covered (to be addressed in other files)
   - Spec gaps requiring PM clarification

---

## Known Limitations

- Cannot run the code — annotations are based on static analysis of the spec and code
- Cannot guarantee 100% AC coverage from a single file — complex features span multiple files
- TODO(spec) items must be resolved by PM before code review — do not merge with open spec gaps
- Python annotation style uses `# SPEC:` prefix instead of `//`
