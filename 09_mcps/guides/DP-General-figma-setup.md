---
version: 1.1
last_updated: 2026-03-31
change_summary: "Switch to Figma remote OAuth MCP server — no personal access token needed"
status: GA
audience: UI, Coding
---

# Figma MCP Setup Guide

## Purpose

Configures the Figma MCP server so that Claude Code can read Figma file content, extract
component data, and reference designs during code generation and design critique sessions.
Required for `/design-critique`, `/component-spec`, and `/spec-to-code-context` to work
with live Figma designs.

---

## Prerequisites

- Claude Code installed
- Figma account with access to Dialpad's Figma organization

---

## Step 1: Add the Figma MCP

Run this command in your terminal:

```bash
claude mcp add --transport http figma https://mcp.figma.com/mcp
```

---

## Step 2: Authenticate

On first use, Claude Code will open your browser for **Figma OAuth**. Log in with your Figma account that has access to the Dialpad organization. No personal access token to create or manage.

---

## Step 3: Verify the Connection

Start a Claude Code session:

```
/mcp list
```

`figma` should appear. Then test with a real Figma file URL:

```
Read the frame "Agent Dashboard" from this Figma file: [paste Figma URL]
```

---

## Step 4: Key Dialpad Figma Resources

### Libraries (enable in all Figma files)

| Library | Contents |
|---|---|
| `DT9 Component Library Rebrand 2025` | All Dialtone Vue components (58+) |
| `DT9 Design Tokens` | Color, typography, spacing, shadow tokens |
| `DT9 Icon Library` | Dialpad icon set |

### Key Design Files

| File | Link | Contents |
|---|---|---|
| Dialtone Component Specs | (internal Figma org) | Component usage documentation |
| Dialpad Design System | (internal Figma org) | Brand and product design guidelines |
| Product Area Files | (per Core Area folder) | Feature design files |

To find the correct Figma URL for your Core Area: search the Dialpad Figma organization by
Core Area name (e.g., "Sell", "Connect").

---

## Common Operations

### Extract component spec from a Figma frame
```
Read the "CSAT Score Card" frame from [Figma URL] and generate a component spec using
the template in 01_context/design-system/DP-General-component-library.md
```

### Critique a design against Dialtone
```
Read the "Power Dialer" screen from [Figma URL].
Compare it against Dialtone DT9 standards from 01_context/design-system/DP-General-tokens.md
and flag any violations.
```

### Check design for accessibility
```
Read all interactive elements in [Figma URL] and list any that are missing aria labels
or have contrast ratios below 4.5:1.
```

---

## Troubleshooting

| Issue | Solution |
|---|---|
| "Could not access file" | Check that your Figma account has view access to the file |
| OAuth expired | Re-authenticate via browser — re-run the `claude mcp add` command |
| MCP not listed | Restart Claude Code after adding the MCP |
| Frame not found | Use the exact frame name as it appears in Figma layers panel |

---

## Known Limitations

- Read-only — cannot create or edit Figma designs via MCP
- Cannot extract interactive prototyping flows — only static frame content
- Large files (>500 frames) may timeout — specify the exact frame name to narrow scope
- Auto Layout details may not fully translate to component spec — Designer review required
