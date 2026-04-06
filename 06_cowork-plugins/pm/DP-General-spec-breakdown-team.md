---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
audience: PM, Coding
---

# Spec Breakdown Team — PM + Engineering Spec-to-Story Session

## Purpose

A collaborative Cowork session between PM and Engineering perspectives to break an approved
PRD into agent-executable stories. PM ensures customer value is preserved; Engineering ensures
implementation scope is realistic and correctly sequenced.

---

## Roles

| Role | Perspective | Focus |
|---|---|---|
| PM Analyst | Product value | Ensures each story delivers user-visible value; flags over-engineering |
| Engineering Analyst | Implementation | Sequences stories correctly; identifies technical prerequisites; flags ambiguity |

---

## Input Required

```
Core Area: [CORE_AREA]
Tech area: [Frontend / Backend / Full-stack / Infra]
Feature flag: [FLAG_NAME or "not used"]
[FULL PRD TEXT]
```

---

## Kickoff Prompt

```
Read the following files:
- 01_context/codebase-map/DP-General-index.md
- 01_context/codebase-map/DP-General-key-patterns.md
- 02_templates/cross-functional/DP-General-jira-story-template.md
- 01_context/personas-and-icps/DP-General-user-personas.md

You are running a PM + Engineering spec breakdown session.

Here is the approved PRD:
[PRD_CONTENT]

Core Area: [CORE_AREA]
Tech area: [TECH_AREA]
Feature flag: [FLAG_NAME]

ROLE 1: PM ANALYST
Read the PRD and identify:
1. The minimum shippable increment — what is the smallest unit that delivers customer value?
2. Stories that are product-critical (must be in MVP) vs. polish (could be deferred)
3. Stories where PM needs to make a scope decision (two approaches exist — which to take?)
4. Acceptance criteria that are too vague for Engineering to implement without interpretation

Output: a story priority map with must-have / nice-to-have classification

---

ROLE 2: ENGINEERING ANALYST
Read the PRD and produce:
1. Feature flag story (always first)
2. Data/schema changes story (if applicable)
3. API contract story (if applicable)
4. Frontend stories (separate from backend)
5. Backend stories (separate from frontend)
6. Test stories or exit criteria

For each story:
- Entry criteria (what must exist before this starts)
- Exit criteria (what must be true for Done)
- Acceptance criteria in Given/When/Then
- Size: S (1–2d) / M (3–5d) / L (6–10d — flag for splitting)
- Blocking dependencies

Output: sequenced story list with full descriptions

---

RECONCILIATION:
After both roles complete their analysis:
1. Merge PM's priority map with Engineering's story list
2. Flag any story the PM classified as "must-have" that Engineering sized as L — these need splitting
3. Flag any story that Engineering flagged as needing a PM scope decision
4. Produce the final story sequence table:

| # | Story title | PM priority | Eng size | Blocks | Blocked by |
|---|---|---|---|---|---|
```

---

## Handoff Format

Output of this session:
1. Story sequence table (ready for JIRA MCP or manual ticket creation)
2. Full story descriptions (copy-paste ready for JIRA)
3. Scope decision log (items PM must decide before sprint planning)

---

## Exit Condition

Session is complete when:
- All stories are sequenced
- No L-sized stories remain (each must be split or have a plan to split)
- Scope decisions are documented (even if unresolved — PM must resolve before sprint)

---

## Known Limitations

- Service names must be confirmed by Engineering team before sprint planning
- Story points are not set — Engineering sets these at sprint planning
- Cannot create JIRA tickets directly without JIRA MCP configured
