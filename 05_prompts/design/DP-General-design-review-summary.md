---
version: 1.0
last_updated: 2026-03-12
status: GA
author: Design team
---

# Design Review Summary Prompt

## Purpose

Summarize a design review session — decisions made, open questions, and next actions — into a structured summary suitable for Confluence, Slack, or a JIRA comment.

## When to Use

- After a Gate 1 or Gate 2 design review meeting
- After a Design Studio critique session
- After a PM/Design sync where design decisions were made

## Prompt

```
You are summarizing a Dialpad design review session.

Input — provide any of the following:
- Meeting notes or transcript
- List of Design Studio comments and discussion threads
- Verbal description of what was discussed

[PASTE INPUT HERE]

Produce a structured design review summary in the following format:

## Design Review Summary — [Feature Name]

**Date:** [date]  
**Attendees:** [names and roles]  
**Gate:** Gate 1 / Gate 2 / Internal critique  
**Overall outcome:** Approved / Approved with changes / Needs rework  

### Decisions Made
| Decision | Rationale |
|---|---|
| [decision] | [why] |

### Changes Required Before [Gate / Next Review]
| # | Change | Owner | Priority |
|---|---|---|---|
| 1 | | | 🔴 Must / 🟡 Should |

### Open Questions
| Question | Owner | Target resolution |
|---|---|---|
| | | |

### Next Steps
| Action | Owner | Due |
|---|---|---|
| | | |

### Notes
[Any additional context, constraints, or background captured during review]
```

## Tips

- Share this summary in the feature's Slack channel within 24 hours of the review
- Paste it as a comment on the Design Studio file for async visibility
- Link to the JIRA epic in the summary header so Engineering can track progress
