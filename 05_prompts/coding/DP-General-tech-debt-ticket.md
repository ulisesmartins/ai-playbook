---
version: 1.0
last_updated: 2026-03-12
status: GA
author: Coding team
---

# Tech Debt Ticket Prompt

## Purpose

Convert a code smell, architectural issue, or observed tech debt into a well-structured JIRA ticket that can be prioritized and estimated. Produces a ticket with clear scope, impact, and acceptance criteria.

## When to Use

- When you notice tech debt during a code review or feature implementation
- When filing tech debt from a postmortem action item
- When quarterly tech debt cleanup planning

## Prompt

```
You are writing a JIRA tech debt ticket for Dialpad Coding.

Tech debt description:
[DESCRIBE THE DEBT: What is the problem? Where in the codebase? What is the impact? Why was it deferred?]

Produce a JIRA ticket in the following format:

## [Component/Area]: [Short description of the debt]

**Type:** Tech Debt  
**Priority:** High / Medium / Low  
**Estimated effort:** XS / S / M / L / XL  
**Component:** [Frontend / Backend / Infra / Test Coverage / Documentation]  

### Background
[What is the current state? Why does this debt exist? When was it introduced (if known)?]

### Why it matters
[What is the cost of leaving this unaddressed? Performance impact, maintainability cost, risk of bugs, onboarding friction?]

### What "done" looks like
[Specific, binary acceptance criteria for when this debt is resolved]

- [ ] [Criterion 1: e.g., All usages of deprecated API replaced with new pattern]
- [ ] [Criterion 2: e.g., Unit tests updated to reflect new implementation]
- [ ] [Criterion 3: e.g., No regressions in existing behavior]

### Files / areas in scope
[List specific files, modules, or components that need to change. Be specific — this helps estimation.]

### Files / areas out of scope
[What adjacent things should NOT be changed in this ticket? This prevents scope creep.]

### References
- [Link to PR or commit where the debt was introduced, if known]
- [Link to related ADR or design doc]
- [Link to any existing JIRA tickets this is related to]
```

## Tips

- **Priority guide:** High = blocks feature work or causes user-visible bugs; Medium = slows down the team but no immediate user impact; Low = code quality / maintainability only
- Always include "out of scope" to prevent this from ballooning during implementation
- Tag tech debt tickets with the `tech-debt` label in JIRA for quarterly planning
