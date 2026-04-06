#!/usr/bin/env python3
"""Auto-generate section index pages and directory.md from the filesystem."""
import os
import re
from pathlib import Path

ROOT = Path(os.environ.get("DOCS_DIR", "."))

def parse_md(path):
    text = path.read_text(encoding="utf-8")
    fm = {}
    body = text
    if text.startswith("---"):
        parts = text.split("---", 2)
        if len(parts) >= 3:
            for line in parts[1].strip().splitlines():
                if ":" in line:
                    k, v = line.split(":", 1)
                    fm[k.strip()] = v.strip().strip('"').strip("'")
            body = parts[2]
    h1_match = re.search(r"^#\s+(.+)$", body, re.MULTILINE)
    title = h1_match.group(1).strip() if h1_match else path.stem
    purpose = ""
    purpose_match = re.search(r"^##\s+Purpose\s*\n+(.+?)(?:\n\n|\n##|\Z)", body, re.MULTILINE | re.DOTALL)
    if purpose_match:
        purpose = purpose_match.group(1).strip().split("\n")[0]
    return fm, title, purpose

def badge_html(status):
    s = status.lower().replace(" ", "-")
    cls_map = {"ga": "ga", "in-progress": "wip", "new": "new"}
    cls = cls_map.get(s, "new")
    return '<span class="dp-badge dp-badge--{}">{}</span>'.format(cls, status)

ICON_MAP = {
    "skills": "lightning-bolt", "agents": "robot", "prompts": "chat",
    "hooks": "webhook", "tools": "wrench", "examples": "school",
    "cowork-plugins": "account-group", "templates": "file-document-outline",
}

def section_icon(key):
    return ICON_MAP.get(key, "file-document-outline")

SECTION_CONFIG = {
    "03_skills": {
        "key": "skills", "link_label": "View skill", "show_command": False,
        "show_badge": False,
        "footer": '!!! tip "How to install a skill"\n\n    Copy the `.md` file into `~/.claude/commands/` (global) or `.claude/commands/` (project-local). Then run it with the slash command shown above.',
    },
    "04_agents": {
        "key": "agents", "link_label": "View agent", "show_command": False,
        "show_badge": False, "is_agent": True,
        "footer": "!!! info \"How to run an agent\"\n\n    Open Claude Code in the repo root and paste the agent's kickoff prompt from its `CLAUDE.md`. The agent will load its own context and execute the workflow.",
    },
    "05_prompts": {
        "key": "prompts", "link_label": "View prompt", "show_command": False,
        "show_badge": False,
        "footer": '!!! tip "Using prompts"\n\n    Copy-paste the prompt body into Claude Code, or reference it in an agent workflow. Treat prompts as code \u2014 iterate based on output quality.',
    },
    "10_hooks": {
        "key": "hooks", "link_label": "View hook", "show_command": False,
        "show_badge": True, "footer": "",
    },
}

ROLE_TITLES = {"pm": "PM", "ui": "UI", "coding": "Coding", "cross-functional": "Cross-functional"}

def generate_role_index(section_dir, role_dir, config):
    role_title = ROLE_TITLES.get(role_dir.name, role_dir.name.title())
    section_name = config["key"].replace("-", " ").title()
    icon = section_icon(config["key"])
    children = []
    if config.get("is_agent"):
        for d in sorted(role_dir.iterdir()):
            if d.is_dir() and (d / "CLAUDE.md").exists():
                fm, title, purpose = parse_md(d / "CLAUDE.md")
                children.append((d.name, fm, title, purpose, d.name + "/CLAUDE/"))
    else:
        for f in sorted(role_dir.glob("*.md")):
            if f.name == "index.md":
                continue
            fm, title, purpose = parse_md(f)
            children.append((f.stem, fm, title, purpose, f.stem + "/"))
    if not children:
        return
    lines = ["# {} {}\n".format(role_title, section_name), "",
             '<div class="grid cards" markdown>\n']
    for stem, fm, title, purpose, link in children:
        lines.append("-   :material-{}:{{ .lg .middle }} **{}**".format(icon, title))
        if config["show_badge"] and fm.get("status"):
            lines.append("    {}".format(badge_html(fm["status"])))
        lines.append("")
        lines.append("    ---")
        lines.append("")
        if purpose:
            lines.append("    {}".format(purpose))
            lines.append("")
        if config["show_command"] and fm.get("slash_command"):
            lines.append("    **Command:** `{}`".format(fm["slash_command"]))
            lines.append("")
        lines.append("    [:octicons-arrow-right-24: {}]({})".format(config["link_label"], link))
        lines.append("")
    lines.append("</div>\n")
    if config.get("footer"):
        lines.append("---\n")
        lines.append(config["footer"])
        lines.append("")
    index_path = role_dir / "index.md"
    index_path.write_text("\n".join(lines), encoding="utf-8")
    print("  Generated {}".format(index_path.relative_to(ROOT)))

def generate_section_indexes():
    for section_name, config in SECTION_CONFIG.items():
        section_dir = ROOT / section_name
        if not section_dir.exists():
            continue
        for role_dir in sorted(section_dir.iterdir()):
            if role_dir.is_dir() and role_dir.name in ROLE_TITLES:
                generate_role_index(section_dir, role_dir, config)

def has_page(dir_path):
    return (dir_path / "index.md").exists()

def generate_directory():
    SECTIONS = [
        "00_getting-started", "01_context", "02_templates", "03_skills",
        "04_agents", "05_prompts", "06_cowork-plugins", "07_examples",
        "08_tools", "09_mcps", "10_hooks", "11_ui", "12_sandbox",
    ]
    def tree_lines(dir_path, prefix=""):
        result = []
        entries = sorted(dir_path.iterdir(), key=lambda p: (p.is_file(), p.name))
        entries = [e for e in entries
                   if (e.is_dir() and not e.name.startswith("."))
                   or (e.is_file() and e.suffix == ".md")]
        for i, entry in enumerate(entries):
            is_last = i == len(entries) - 1
            connector = "\u2514\u2500\u2500 " if is_last else "\u251c\u2500\u2500 "
            child_prefix = prefix + ("    " if is_last else "\u2502   ")
            rel = entry.relative_to(ROOT)
            if entry.is_dir():
                if (entry / "CLAUDE.md").exists():
                    result.append('{}{}<a href="../{}/CLAUDE/">{}/</a>'.format(prefix, connector, rel, entry.name))
                elif has_page(entry):
                    result.append('{}{}<a href="../{}/">{}/</a>'.format(prefix, connector, rel, entry.name))
                else:
                    result.append('{}{}{}/'.format(prefix, connector, entry.name))
                result.extend(tree_lines(entry, child_prefix))
            else:
                if entry.name == "index.md":
                    if has_page(entry.parent):
                        result.append('{}{}<a href="../{}/">{}</a>'.format(prefix, connector, rel.parent, entry.name))
                    else:
                        result.append('{}{}{}'.format(prefix, connector, entry.name))
                elif entry.name == "CLAUDE.md":
                    result.append('{}{}<a href="../{}/CLAUDE/">{}</a>'.format(prefix, connector, rel.parent, entry.name))
                elif entry.name == "README.md":
                    result.append('{}{}{}'.format(prefix, connector, entry.name))
                else:
                    result.append('{}{}<a href="../{}/{}/"> {}</a>'.format(prefix, connector, rel.parent, entry.stem, entry.name))
        return result

    lines = [
        "# Directory\n", "",
        "Complete repository map \u2014 every section and file is clickable.", "",
        '<div class="dp-tree-wrap">', "<pre>", "ai-playbook/", "\u2502",
        '\u251c\u2500\u2500 <a href="../">index.md</a>',
        '\u251c\u2500\u2500 <a href="../directory/">directory.md</a>', "\u2502",
    ]
    for i, section in enumerate(SECTIONS):
        section_dir = ROOT / section
        if not section_dir.exists():
            continue
        is_last = i == len(SECTIONS) - 1
        connector = "\u2514\u2500\u2500 " if is_last else "\u251c\u2500\u2500 "
        child_prefix = "    " if is_last else "\u2502   "
        if has_page(section_dir):
            lines.append('{}<a href="../{}/">{}/</a>'.format(connector, section, section))
        else:
            lines.append('{}{}/'.format(connector, section))
        lines.extend(tree_lines(section_dir, child_prefix))
        if not is_last:
            lines.append("\u2502")
    lines.extend(["</pre>", "</div>", ""])
    (ROOT / "directory.md").write_text("\n".join(lines), encoding="utf-8")
    print("  Generated directory.md")

if __name__ == "__main__":
    print("Generating section index pages...")
    generate_section_indexes()
    print("Generating directory.md...")
    generate_directory()
    print("Done.")
