---
version: 1.0
last_updated: 2026-03-11
change_summary: "Initial version — sourced from Google Workspace blog, Google Learning Center, and TechCrunch through March 2026"
status: GA
audience: PM, UI, Coding
---

# Gemini for Google Workspace — Best Practices

## What It Is

Gemini is embedded directly inside Gmail, Docs, Sheets, Slides, Drive, and Meet. It operates through the persistent side panel (click the Gemini star icon, top-right in any Workspace app) and through inline "Help me write" features. As of March 2026, it can synthesize content from Gmail, Chat history, and Drive files simultaneously in a single prompt — the most significant capability upgrade to date.

**Dialpad default use:** Everyday writing assistance — email drafts, meeting summaries, doc editing, spreadsheet formulas. Built into your existing tools so no context switching is needed. Not recommended for gate-quality PRDs or Dialpad-specific artifacts — use Claude Code for those.

---

## Core Best Practices

### 1. Use the PTCF framework — Persona, Task, Context, Format
Every effective Workspace prompt has all four elements.

> "As a product manager [persona], draft a follow-up email [task] to the Q1 planning meeting where we aligned on the roadmap but left budget open [context], in a concise professional tone with a clear next step at the end [format]."

Research shows the most effective prompts average 21 words. Prompts under 9 words consistently underperform.

### 2. Use `@` to cross-reference Drive files mid-prompt
In the side panel of Gmail or Docs, type `@` and the file name to pull context from a Drive document directly into your output. Eliminates manual copy-paste and grounds the output in your actual content.

### 3. Be specific about format in the prompt itself
Do not let Gemini choose structure. Specify: "Return this as a bulleted list with bolded action items," or "Format as a two-column table: risk in column 1, mitigation in column 2."

### 4. Iterate — do not restart
Follow up a weak output with refinements: "Make the tone more direct," "Shorten this to 3 sentences," "Add a section on rollout risks." Rewriting your entire prompt from scratch is less effective than iterating on the result.

### Gmail

### 5. Summarize long threads before replying
> "Summarize this thread in a bulleted list. Bold any action items or decisions I am responsible for."

High value for threads with 10+ replies or cross-functional stakeholders.

### 6. Draft replies with specific tone and audience context
Don't say "draft a reply." Say: "Draft a reply declining this request, explaining we are deprioritizing this feature in Q2, and offering to revisit in Q3 planning."

### Docs

### 7. Generate full documents from cross-app context (March 2026)
Gemini in Docs can now synthesize content from Gmail, Chat history, and Drive files to populate an entire structured document from one prompt.

> "Create a project brief for Project Falcon. Pull from the email thread with @Sarah about scope, the @Falcon-Spec.doc, and our Q2 planning Chat."

### 8. Use Gemini to pressure-test your writing
After drafting a PRD or design brief, prompt: "What assumptions in this document are not supported by evidence?" or "What objections would an engineer raise about the technical feasibility section?"

### Sheets

### 9. Generate complex formulas via plain language
> "Write a formula that calculates the 90th percentile of column C, excluding rows where column B says 'Draft'."

Gemini writes the formula with an explanation. Removes a chronic bottleneck for PMs and Designers who are not spreadsheet-fluent.

### 10. Use "Fill with Gemini" to categorize or summarize data in bulk
Select a column range, trigger Fill with Gemini, and prompt: "Categorize each row as High, Medium, or Low priority based on the description in column A." Applies to tagging, summarizing, or transforming text data at scale.

### Meet

### 11. Enable "Take notes for me" as a default habit in every call
Gemini captures key points and action items in a Google Doc automatically attached to the calendar event and shared with participants. Set this as a default, not an occasional feature.

---

## Common Pitfalls

| Pitfall | Fix |
|---|---|
| Prompts under 9 words | Use the PTCF framework; 21-word average is the effective benchmark |
| Assuming memory across sessions | Re-establish context at the start of each side panel session |
| Not verifying `@` file references | Always confirm output actually reflects the referenced document |
| Accepting first-pass output as a deliverable | Treat as draft zero; iterate before sharing |
| Using Gemini for factual research | It is a drafting and structuring tool, not a research tool |

---

## Gemini for Workspace vs. Gemini Canvas

| Scenario | Use |
|---|---|
| Summarizing a long email thread | Gemini Workspace (Gmail side panel) |
| Drafting an email with `@` file reference | Gemini Workspace |
| Taking notes in a live meeting | Gemini Workspace (Meet "Take notes for me") |
| Building a complex formula | Gemini Workspace (Sheets inline) |
| Generating a full PRD or design brief from scratch | Gemini Canvas |
| Building a shareable interactive prototype | Gemini Canvas |
| Iterating on a document across many sessions | Gemini Canvas |

See `DP-General-gemini-canvas.md` for Canvas-specific best practices.
