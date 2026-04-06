#!/usr/bin/env python3
"""Post-build link checker. Scans all HTML files in the built site for
internal links and verifies each target exists as a file or directory
with index.html. Exits non-zero if any broken links are found.

Usage: python scripts/check-links.py /path/to/built/site
"""
import os
import re
import sys
from pathlib import Path
from urllib.parse import urlparse, unquote


def check_links(site_dir):
    site = Path(site_dir)
    if not site.exists():
        print("ERROR: site directory {} does not exist".format(site_dir))
        return 1

    broken = []
    checked = 0
    files_scanned = 0

    for html_file in sorted(site.rglob("*.html")):
        files_scanned += 1
        content = html_file.read_text(encoding="utf-8", errors="ignore")

        # Extract all href values from <a> tags
        for match in re.finditer(r'<a[^>]+href="([^"]*)"', content):
            href = match.group(1)

            # Skip external links, anchors, mailto, javascript
            if not href or href.startswith(("#", "mailto:", "javascript:", "http://", "https://")):
                continue

            # Skip search query links
            if "?q=" in href:
                continue

            checked += 1

            # Resolve the href relative to the HTML file's directory
            href_clean = unquote(href.split("?")[0].split("#")[0])
            if not href_clean:
                continue

            # Strip site base path prefix (e.g. /ai-playbook/) from absolute links
            site_prefix = None
            for meta in re.finditer(r'<meta[^>]+property="og:url"[^>]+content="([^"]*)"', content):
                parsed = urlparse(meta.group(1))
                if parsed.path and parsed.path != "/":
                    site_prefix = parsed.path.rstrip("/") + "/"
                break
            if site_prefix and href_clean.startswith(site_prefix):
                href_clean = "/" + href_clean[len(site_prefix):]
            if href_clean.startswith("/"):
                # Strip site base path if present (e.g. /ai-playbook/)
                # MkDocs adds this prefix when site_url has a path component
                stripped = href_clean.lstrip("/")
                target = site / stripped
                if not (target.resolve().is_file() or (target.resolve().is_dir() and (target.resolve() / "index.html").exists())):
                    # Try removing first path segment (base path prefix)
                    parts = stripped.split("/", 1)
                    if len(parts) > 1:
                        alt_target = site / parts[1]
                        if alt_target.resolve().is_file() or (alt_target.resolve().is_dir() and (alt_target.resolve() / "index.html").exists()):
                            target = alt_target
            else:
                target = html_file.parent / href_clean

            target = target.resolve()

            # Check if target exists
            if target.is_file():
                continue
            if target.is_dir() and (target / "index.html").exists():
                continue

            # Broken link
            page = str(html_file.relative_to(site))
            broken.append((page, href))

    print("Scanned {} HTML files, checked {} internal links".format(files_scanned, checked))

    if broken:
        print("\nBROKEN LINKS FOUND: {}".format(len(broken)))
        for page, href in sorted(set(broken)):
            print("  {} -> {}".format(page, href))
        return 1
    else:
        print("All internal links OK")
        return 0


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python check-links.py <site-dir>")
        sys.exit(1)
    sys.exit(check_links(sys.argv[1]))
