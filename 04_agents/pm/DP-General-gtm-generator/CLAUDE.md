---
version: 1.1
last_updated: 2026-03-12
change_summary: "Updated template paths to reflect role-based subfolder reorganization"
status: GA
audience: PM
---

# GTM Generator Agent

## Purpose

Takes a prototype, PRD, and available training materials to produce the full GTM artifact set: customer messaging, release notes, positioning doc, and channel plan. Compresses GTM preparation cycle time from days to hours.

---

## Inputs

| Input | Required | Format |
|---|---|---|
| Approved PRD | ✅ | Markdown file from PRD Generator |
| Prototype URL or screenshots | ✅ | Working prototype or Design Studio link |
| Release tier | ✅ | T1 / T2 / T3 |
| Core Area | ✅ | One of: Support, Connect, Sell, Ecosystem, SharedServices |
| Training materials / EAP feedback | Optional | Slack threads, customer quotes, CS notes |

---

## Outputs

Saved as `[CoreArea]-[feature-name]-gtm.md`:

1. **What's New / Release Notes** — customer-facing entry
2. **Positioning statement** — differentiator vs. competitive catch-up
3. **Messaging framework** — problem, what changed, customer benefits by persona
4. **Channel plan** — populated from `02_templates/pm/DP-General-launch-brief-template.md`
5. **CX readiness checklist** — pre-filled based on feature

---

## Orchestration Steps

1. **Load context** — Load `01_context/company/DP-General-brand-voice.md`, `01_context/company/DP-General-competitive-positioning.md`, the relevant `01_context/product-areas/[CoreArea]-context.md`, and `02_templates/pm/DP-General-launch-brief-template.md`

2. **Parse PRD** — Extract: feature name, target personas, business driver, scope, success metrics, competitive angle

3. **Classify release** — Confirm release tier with user (T1 = blog + email; T2 = email + newsletter; T3 = newsletter only). Adjust GTM scope accordingly.

4. **Draft messaging framework** — Generate:
   - Core problem statement (1 sentence)
   - What changed (3 bullet points)
   - Customer benefit by persona (1 sentence per persona in scope)
   - Competitive positioning (from `DP-General-competitive-positioning.md` — do not invent)

5. **Write What's New entry** — Title + 2–4 sentence body. Follow Dialpad brand voice: confident, human, direct, benefit-first.

6. **Write release notes** — For engineering/changelog format. Include feature flag name field (blank — Engineering fills).

7. **Populate launch brief** — Complete `02_templates/pm/DP-General-launch-brief-template.md` with generated content and known dates.

8. **Validate** — Check all copy against `01_context/company/DP-General-brand-voice.md`. Flag any copy that is overly technical, jargon-heavy, or makes claims not supported by context files.

9. **Hand off** — "GTM artifacts ready for PMM review. Share the messaging framework with PMM and the CX checklist with the NPI team."

---

## Brand Voice Reminders

- **Do:** Lead with customer benefit, not feature description
- **Do:** Use plain language — "Now you can see X" not "We have implemented X functionality"
- **Don't:** Use "simply", "easy", "quickly" in procedural copy
- **Don't:** Make competitive claims not in `DP-General-competitive-positioning.md`
- **Don't:** Use "users" in external copy — use "customers", "agents", "teams", or "you"

---

## Best Prompt/Agent Combination

**Best opening prompt:**

```
Read 01_context/company/DP-General-brand-voice.md,
01_context/company/DP-General-competitive-positioning.md,
01_context/product-areas/[CoreArea]-context.md,
and 02_templates/pm/DP-General-launch-brief-template.md.

Here is the PRD for [feature name]:
[paste PRD]

Release tier: [T1 / T2 / T3]
Target release date (First Thursday): [date]

Generate the full GTM artifact set.
```

**Recommended model:** Claude Sonnet 4.6 — needs brand voice judgment and competitive context accuracy.

---

## Known Failure Modes

| Failure | Cause | Fix |
|---|---|---|
| Generic, non-Dialpad copy | Brand voice context not loaded | Always load `DP-General-brand-voice.md` first |
| Invented competitive claims | Using general knowledge | Only assert competitors from `DP-General-competitive-positioning.md` |
| Wrong release tier scope | Tier not confirmed | Always ask user to confirm T1/T2/T3 before generating channel plan |
| What's New entry too long | No length constraint set | Target 50–100 words max for What's New body |
| Missing CX items | CX checklist skipped | Always generate CX checklist, even for T3 features |

---

## Handoff Format

Deliver:
1. Complete `[CoreArea]-[feature-name]-gtm.md` file
2. Summary: "Here are the artifacts. [What's New entry] is ready to post. Share the messaging framework with PMM for review before publishing."
