---
version: 1.0
last_updated: 2026-03-12
status: GA
author: Coding team
---

# PR Description Generator Prompt

## Purpose

Generate a clear, structured pull request description from a diff summary, commit messages, or a brief description of the change. Outputs a PR body ready to paste into GitHub.

## When to Use

- Before opening a PR for code review
- When a draft PR description is too thin or unclear
- When pairing this with the GitHub MCP to auto-populate PR bodies

## Prompt

```
You are generating a GitHub pull request description for a Dialpad codebase change.

Input — provide any of the following:
- Diff summary or list of changed files
- Commit messages
- Feature ticket / JIRA link
- Brief verbal description of the change

[PASTE INPUT HERE]

Produce a PR description in the following format:

## Summary
[2–3 sentences explaining WHAT changed and WHY. Lead with the business or user impact, not the implementation detail.]

## Changes
- [Bullet: specific change 1 — what file/module and what behavior changed]
- [Bullet: specific change 2]
- [Include migration notes or config changes if present]

## Test Plan
- [ ] Unit tests added / updated for [component/function]
- [ ] Integration test: [specific scenario verified]
- [ ] Manual test: [step-by-step verification for the primary change]
- [ ] Verified no regression in [affected area]

## Screenshots
[Include if UI changes. Write "N/A — no UI changes" if backend-only.]

## Related
- JIRA: [ticket link or "not tracked"]
- UI Studio: [link or "N/A"]
- Depends on: [PR link or "none"]

## Reviewer Notes
[Optional: what should reviewers pay special attention to? Any tradeoffs made? Any areas of uncertainty?]
```

## Tips

- Run this with the actual diff pasted in for the most accurate output
- The "Reviewer Notes" section is where you flag tradeoffs — don't skip it
- Pair with the `/postmortem-draft` skill if this PR is a hotfix
