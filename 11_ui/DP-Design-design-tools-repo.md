---
title: "UI Tools Repo"
---

# UI Tools Repository

UI Tools is our shared home for building, sharing, and shipping tools made by designers, for designers. It lives in a single GitHub repository — a monorepo where all tools sit side by side, but each one is completely independent.

- **Website:** [dialpad.github.io/design-tools](https://dialpad.github.io/design-tools/)
- **Repository:** [github.com/dialpad/design-tools](https://github.com/dialpad/design-tools)

!!! note "Access"

    The UI Tools website and CSS Converter require Dialpad org access. Links will only work for authenticated Dialpad team members.

## What's Inside

| Tool | What it does | Type |
|------|-------------|------|
| **CSS Converter** | Converts between CSS, Tailwind, and Dialtone tokens instantly | Web app |
| **GCP Cloud Functions** | Backend services that power AI features like GPT, Claude, and copy generation | Serverless APIs |
| **Claude Skills** | Reusable AI workflows you can drop into any project | Config files |
| **AI Clients** | Custom GPTs, Google Gems, Rovo agents, and NotebookLM configs | AI configurations |
| **Text-to-AI** | A FigJam plugin that extracts text content for AI processing | FigJam plugin |

## Repository Structure

```
design-tools/
├── css-converter/       ← Web app for CSS/Tailwind/Dialtone conversion
├── gcp-functions/       ← Cloud functions (GPT, Claude, copywriting)
├── claude-skills/       ← AI workflows for Claude Code
├── ai-agents/           ← Custom GPTs, Gems, Rovos, NotebookLMs
├── text-to-ai/          ← FigJam plugin
├── src/                 ← The UI Tools website itself
├── README.md            ← Technical overview
├── DEVELOPER_GUIDE.md   ← Full dev setup guide
└── CONTRIBUTING.md      ← How to contribute
```

## Getting Started

### 1. Clone the repo

```bash
git clone git@github.com:dialpad/design-tools.git
cd design-tools
```

For a single tool only (faster download):

```bash
git clone --filter=blob:none --no-checkout git@github.com:dialpad/design-tools.git
cd design-tools
git sparse-checkout init --cone
git sparse-checkout set css-converter
git checkout main
```

### 2. Install and run

```bash
cd css-converter
npm install
npm run dev
# Open http://localhost:5173
```

For Claude Skills — no install needed. Just copy the skill files into any project's `.claude/skills/` folder.

## Building Something New

1. **Propose it** — Create a GitHub Issue describing what the tool does and how it would be deployed
2. **Create your folder** — Root-level folder with its own `README.md` and `CHANGELOG.md`
3. **Build and document** — Include install, run, deploy, and troubleshooting instructions
4. **Submit a PR** — Push your branch and open a pull request

### Branch Naming

```
css-converter/add-new-tokens
gcp-functions/update-cors
claude-skills/add-new-skill
your-tool/initial-setup
```

## Quick Reference

| I want to... | Do this |
|---------------|---------|
| Browse all tools | Visit [dialpad.github.io/design-tools](https://dialpad.github.io/design-tools/) |
| Convert CSS to Dialtone | Visit [dialpad.github.io/css-converter](https://dialpad.github.io/css-converter/) |
| Clone the repo | `git clone git@github.com:dialpad/design-tools.git` |
| Run CSS Converter locally | `cd css-converter && npm install && npm run dev` |
| Create a new tool | Open a GitHub Issue first, then create a folder |
| Get help | Dialpad `#design-eng-support` or open a GitHub Issue |

---

!!! info "Source"

    This content is sourced from [UI Tools](https://dialpad.atlassian.net/wiki/spaces/DES/pages/2511470632) on Confluence.
