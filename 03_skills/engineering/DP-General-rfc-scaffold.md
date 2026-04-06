---
version: 1.0
last_updated: 2026-03-11
change_summary: "Initial version"
status: GA
slash_command: /rfc-scaffold
audience: Coding
---

# `/rfc-scaffold` — Scaffold an RFC or Engineering Spec from a Problem Statement

## Purpose

Generates a structured RFC or Engineering Spec from a problem statement, producing all required sections with targeted questions where information is missing. Follows the format used across Dialpad RFCs. Output is ready to paste into Confluence for review.

## Required Inputs

```
/rfc-scaffold

Problem statement: [describe the problem you are solving in 2–5 sentences]
Core Area: [Support / Connect / Sell / Ecosystem / SharedServices]
Services involved: [list known services or "unknown"]
Author: [your name]
Reviewers: [names / roles, or "TBD"]
RFC type: [Architecture change / New service / API change / Data model change / Process / Other]
```

## Expected Output

A complete RFC scaffold with:
1. Metadata header (status, author, date, reviewers, related links)
2. Problem statement and background
3. Goals and non-goals
4. Proposed solution with architecture overview
5. Alternatives considered
6. Component / service impact summary
7. Error handling and failure modes
8. Migration and rollout plan
9. Open questions
10. Completion checklist

## Skill Body (Prompt)

```
Read the following files:
- 01_context/codebase-map/DP-General-index.md
- 01_context/codebase-map/DP-General-key-patterns.md
- 01_context/product-areas/[CORE_AREA]-context.md

Here is the RFC request:
Problem statement: [USER_INPUT]
Core Area: [USER_INPUT]
Services involved: [USER_INPUT]
Author: [USER_INPUT]
Reviewers: [USER_INPUT]
RFC type: [USER_INPUT]

Generate a structured RFC scaffold. Rules:

METADATA HEADER:
| Field | Value |
|---|---|
| Status | Draft |
| RFC type | [USER_INPUT] |
| Author | [USER_INPUT] |
| Date | [today's date] |
| Reviewers | [USER_INPUT] |
| Related JIRA | [leave blank] |
| Related Confluence | [leave blank] |
| Services impacted | [USER_INPUT or derived from problem statement] |

PROBLEM STATEMENT (3–5 sentences):
- What is broken, missing, or needs to change?
- Who is affected and how?
- What is the cost of not solving this?

BACKGROUND (paragraph):
- What exists today? What decisions led to the current state?
- Reference services from the codebase-map if applicable
- If you don't know the history, write: [AUTHOR TO FILL — current state context]

GOALS (bulleted list):
- What must this RFC achieve?
- State goals as measurable outcomes where possible

NON-GOALS (bulleted list):
- What is explicitly out of scope for this RFC?
- Why is each item deferred?

PROPOSED SOLUTION:
- Write a 3–5 sentence high-level description of the approach
- Then scaffold an architecture section with these subsections:
  - System diagram: [AUTHOR TO ADD — attach Excalidraw or Miro diagram]
  - Component changes: table listing each service/component and what changes
  - API contract changes: list any new or modified endpoints (method, path, request/response shape)
  - Data model changes: any new tables, fields, or schema migrations
  - Feature flag: [flag name — leave blank if unknown]

ALTERNATIVES CONSIDERED:
| Option | Description | Why not chosen |
|---|---|---|
| Option A (current approach) | [what is done today] | [reason it's insufficient] |
| Option B | [describe] | [tradeoff that ruled it out] |
- Add at least 2 alternatives. Mark as [AUTHOR TO COMPLETE] if not known.

ERROR HANDLING AND FAILURE MODES:
- List at least 3 failure scenarios relevant to the proposed change
- For each: what fails, what the user/system observes, and what the recovery path is
- If failure modes are unknown at this stage, mark with [NEEDS ANALYSIS]

MIGRATION AND ROLLOUT:
- How will this be deployed? (feature flag, phased rollout, dark launch)
- Are there backward compatibility requirements?
- Is a data migration required? If yes, is it reversible?
- What is the rollback plan if the deploy fails?

OPEN QUESTIONS:
| # | Question | Owner | Target resolution |
|---|---|---|---|
| Q-1 | | | |
- Generate 3–5 open questions based on the problem statement
- Mark questions that block implementation as [BLOCKING]

COMPLETION CHECKLIST:
- [ ] Architecture diagram added
- [ ] All impacted services listed
- [ ] API contracts defined
- [ ] Data migration plan confirmed
- [ ] Feature flag name confirmed with Engineering
- [ ] At least 2 reviewers assigned
- [ ] Open questions resolved or tracked in JIRA
- [ ] Security review required? [YES / NO / NEEDS ASSESSMENT]

If the problem statement is too vague to scaffold a meaningful RFC, ask up to 3 clarifying questions before generating.
Do not invent service names, endpoint paths, or architecture decisions not stated in the input.
Mark any section where information is missing as [AUTHOR TO FILL — reason].
```

## Known Limitations

- Cannot determine exact service names or API paths without codebase access — always verify against `01_context/codebase-map/`
- Architecture diagrams cannot be generated — author must attach separately in Confluence
- Security review requirement must be assessed by Engineering lead — skill flags it but cannot determine necessity
- Does not replace peer review — the RFC must go through the team's review process before implementation
- RFC format may vary slightly by team — align with your Core Area lead before publishing
