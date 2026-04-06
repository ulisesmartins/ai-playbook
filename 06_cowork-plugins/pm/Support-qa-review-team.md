---
version: 1.0
last_updated: 2026-03-09
change_summary: "Initial version"
status: GA
audience: PM, Coding
---

# Support QA Review Team — Pre-GA Quality Review for Contact Center Features

## Purpose

A Support-specific Cowork session that reviews a contact center feature release for QA
completeness before GA approval (Gate 3). Covers test coverage, CX readiness, omnichannel
edge cases, and AI feature behavior. Tailored for Dialpad's Support Core Area.

---

## Roles

| Role | Perspective | Focus |
|---|---|---|
| QA Engineer | Test coverage | Test completeness, edge cases, regression risk |
| CX Readiness | Customer experience | Help center docs, training, known issues for CX team |
| AI Feature Reviewer | AI behavior | CSAT accuracy, transcription quality, PII handling, multilingual |

---

## Input Required

```
Feature: [FEATURE_NAME]
Core Area: Support
Release tier: [T1 / T2 / T3]
Feature flag: [FLAG_NAME or "GA to all"]
[JIRA epic and story list OR PRD]
[Test plan (if available)]
```

---

## Kickoff Prompt

```
Read the following files:
- 01_context/pdlc/DP-General-phases-and-gates.md
- 01_context/personas-and-icps/DP-General-user-personas.md
- 01_context/product-areas/Support-context.md (if available)

You are running a pre-GA QA review for a Support (Contact Center) feature.

Feature: [FEATURE_NAME]
Release tier: [RELEASE_TIER]
Feature flag: [FLAG_NAME]

[EPIC AND STORY LIST OR PRD]

ROLE 1: QA ENGINEER
Review the feature for test coverage gaps:
1. Are happy path, error, empty, and loading states all tested?
2. Are permission boundary tests included (admin vs. agent vs. supervisor)?
3. Are omnichannel flows tested? (Voice, chat, email, SMS if applicable)
4. Are feature flag on/off states tested?
5. Are regression tests in place for existing CC features this touches?

Output: test coverage gap list with severity (blocker / high / medium / low)

---

ROLE 2: CX READINESS REVIEWER
Review the feature for CX team readiness:
1. Is there a help center article draft or update queued?
2. Are there known edge cases that CX agents will encounter on day 1?
3. Are there admin configuration steps required before customers can use the feature?
4. Is the error messaging customer-friendly (not stack traces)?
5. What are the top 3 questions customers will ask CX on launch day?

Output: CX readiness checklist with gaps flagged

---

ROLE 3: AI FEATURE REVIEWER (if AI components are involved)
Review any AI-powered components in this feature:
1. CSAT scoring: Is accuracy validated across all supported languages?
2. Transcription: Are accuracy baselines met for supported languages and accents?
3. PII handling: Is PII redacted from logs and transcripts per compliance requirements?
4. Coaching recommendations: Are AI suggestions validated against known bias patterns?
5. Multilingual: Is language detection accurate? Is fallback behavior defined?

Output: AI quality checklist with gaps and confidence levels

---

CONSOLIDATED GA READINESS REPORT:
1. Overall status: Ready for GA / Not Ready / Blocked
2. Blocker list (items that must be fixed before GA)
3. High severity gaps (should be fixed, could delay if not)
4. Launch risk summary (top 3 risks on GA day)
5. CX escalation guide (what CX should do if X happens on day 1)
```

---

## Handoff Format

Output of this session:
1. GA readiness report (share with Engineering lead and PM before Gate 3)
2. CX readiness checklist (share with CX team lead)
3. AI quality report (share with AI/ML team if AI components are involved)

---

## Exit Condition

Session is complete when all three roles produce their outputs AND the consolidated GA readiness
report is generated. Gate 3 should not be scheduled until blockers are resolved.

---

## Known Limitations

- Cannot run actual test suites — gap identification is based on spec review only
- AI quality assessment is qualitative — actual accuracy metrics require evaluation data
- CX readiness assessment relies on PM/CX knowledge of existing help center content
