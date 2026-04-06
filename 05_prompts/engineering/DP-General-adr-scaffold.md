---
version: 1.0
last_updated: 2026-03-12
status: GA
author: Engineering team
---

# Architecture Decision Record (ADR) Scaffold Prompt

## Purpose

Generate a structured Architecture Decision Record (ADR) from a technical decision description. Outputs a complete ADR ready to commit to the repository or paste into Confluence.

## When to Use

- After making a significant architectural decision (framework choice, API design, data model)
- When documenting a decision that was made informally in a meeting
- When writing a design doc for a complex engineering change

## Prompt

```
You are writing an Architecture Decision Record (ADR) for a Dialpad engineering decision.

Decision context:
[DESCRIBE THE DECISION: What problem were you solving? What options did you consider? What did you decide?]

Produce an ADR in the following format:

# ADR-[number]: [Short title]

**Date:** YYYY-MM-DD  
**Status:** Proposed / Accepted / Deprecated / Superseded by ADR-[X]  
**Deciders:** [names or teams]  
**Consulted:** [names or teams]  

## Context

[What is the issue we're addressing? What forces are at play? What constraints exist? Keep this factual — not yet about the decision.]

## Decision Drivers

- [Driver 1 — e.g., performance requirements]
- [Driver 2 — e.g., team familiarity]
- [Driver 3 — e.g., existing infrastructure]

## Options Considered

### Option A: [name]
**Description:** [1–2 sentences]  
**Pros:** [list]  
**Cons:** [list]  

### Option B: [name]
**Description:**  
**Pros:**  
**Cons:**  

### Option C: [name] (if applicable)
**Description:**  
**Pros:**  
**Cons:**  

## Decision

We chose **Option [X]** because [1–2 sentence rationale connecting back to the decision drivers].

## Consequences

**Positive:**
- 

**Negative / Tradeoffs:**
- 

**Neutral:**
- 

## Revisit Criteria

[Under what conditions should this decision be revisited? What signals would indicate this decision is no longer the right one?]
```

## Tips

- Store ADRs in `docs/decisions/` in the affected codebase repository
- Link ADRs from JIRA epics using the "Architecture" link type
- Use "Superseded by" when a newer decision replaces this one — never delete ADRs
