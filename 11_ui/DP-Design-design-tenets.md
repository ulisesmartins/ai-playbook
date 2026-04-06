---
title: UI Tenets
description: Seven decisive rules for making trade-off decisions faster and more consistently across the UI team.
---

# UI Tenets Framework

The UI Tenets framework is a set of seven specific, decisive rules the UI team should use to make trade-off decisions faster and more consistently, especially when there are multiple equally valid approaches and the team needs a clear way to break ties.

## Principles vs. Tenets

- **UI Principles** answer: *What do we believe in?* — foundational beliefs that guide philosophy but often don't resolve trade-offs
- **UI Tenets** answer: *When we have to choose, which path do we take?* — specific rules that intentionally choose a consistent trade-off

## The Seven UI Tenets

### 1. UI systems, not surfaces

Features should exist where people need them, not where the team decides to place them. UI should follow the user's path rather than forcing users to follow the product's structure.

This means distributing functionality across multiple contexts — thinking about ingress points, egress points, and natural moments of need. This is especially important for Dialpad where a single person may move between personas (supervisor in one contact center, agent in another).

> **Tiebreaker:** One dedicated location vs. distributed across multiple contexts? → **Choose distribution.**

### 2. Opt into complexity

Power lives in the product, but not all power should live on the surface. Users should discover advanced features when they need them, without being overwhelmed upfront.

Common workflows should feel frictionless. Advanced or rare workflows can require discovery. This is especially relevant as Dialpad ships more AI capabilities.

> **Tiebreaker:** Add a powerful capability to the core experience vs. stay simple? → **Choose simplicity.**

### 3. Transparency is non-negotiable

Complexity should be hidden in the implementation, not in the interface. Users deserve to understand what is happening and why.

This is especially important for AI features — the interface must clearly communicate inputs, outputs, and enough reasoning for users to calibrate trust.

> **Tiebreaker:** Hide system complexity vs. show the truth? → **Show the truth.**

### 4. Anticipation over reaction

The moment a user finishes an action and has to hunt for the next step, friction enters. The product should surface what users are most likely to need next.

AI can significantly enhance anticipation by understanding context and conversation history to surface relevant actions before the user asks.

> **Tiebreaker:** Wait for explicit user input vs. surface predicted needs? → **Anticipate.**

### 5. Friction is deliberate

Not everything should be frictionless. Important actions should feel important.

Everyday actions should be fast and effortless. Rare, risky, or high-impact actions should introduce friction (confirmation steps, re-authentication, review screens, explicit warnings).

> **Tiebreaker:** Smooth and effortless always vs. intentional friction for rare actions? → **Add deliberate friction.**

### 6. Customize to lock-in

In a crowded market, the moat is not features but the time and energy users invest in making the product their own.

As users personalize — saved configurations, custom AI instructions, learned preferences, custom skills — they build muscle memory and fluency that creates switching costs.

> **Tiebreaker:** One-size-fits-all vs. letting the user make it their own? → **Invest in customization.**

### 7. Capability without clarity is just noise

A powerful feature without understanding is worse than not shipping the feature at all.

Users need to understand when a feature is useful, how it works, and what it's good at or not good at. This is especially true for AI features. Shipping more slowly with clarity is preferable to shipping quickly and creating confusion.

> **Tiebreaker:** Ship powerful feature quickly vs. hold until refined? → **Wait for clarity.**

## Resources

- FY26 Q4 UI All Hands Recording
- FY26 Q4 UI All Hands Deck
- [Lenny's Podcast: 35 years of product design wisdom](https://www.lennysnewsletter.com/) from Apple, Disney, Pinterest and beyond

*For feedback or questions about UI Tenets, contact Joshua Hynes.*

---

!!! info "Source"

    This content is sourced from [UI Tenets Framework](https://dialpad.atlassian.net/wiki/spaces/DES/pages/2354610325) on Confluence.
