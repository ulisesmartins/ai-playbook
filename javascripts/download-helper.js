/* ── download-helper.js ──────────────────────────────────────────────────
   Intercepts all download links (per-page button + directory icons) and
   forces a real file download instead of opening a new tab.

   Strategy:
   1. On click, try to fetch the raw content via the redirect chain
      (github.com/raw → raw.githubusercontent.com?token=...).
   2. If fetch succeeds, create a Blob and trigger download via
      a temporary <a> with a blob: URL and the download attribute.
   3. If fetch fails (CORS, auth), fall back to window.open which
      at least shows the raw content in a new tab.

   Applies to:
   - Per-page download button:  a[data-dp-dl]
   - Directory page icons:      a.dp-dl
   ───────────────────────────────────────────────────────────────────────── */
(function () {
  "use strict";

  function triggerBlobDownload(text, filename) {
    var blob = new Blob([text], { type: "text/markdown;charset=utf-8" });
    var url = URL.createObjectURL(blob);
    var a = document.createElement("a");
    a.href = url;
    a.download = filename;
    a.style.display = "none";
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    setTimeout(function () { URL.revokeObjectURL(url); }, 1000);
  }

  function handleDownloadClick(e) {
    var link = e.currentTarget;
    var href = link.href;
    if (!href) return;

    var filename = (link.getAttribute("download") || href.split("/").pop() || "source.md");

    e.preventDefault();
    e.stopPropagation();

    /* Try fetching via the redirect chain (needs CORS + auth) */
    fetch(href, { redirect: "follow", credentials: "include" })
      .then(function (r) {
        if (!r.ok) throw new Error("HTTP " + r.status);
        return r.text();
      })
      .then(function (text) {
        triggerBlobDownload(text, filename);
      })
      .catch(function () {
        /* CORS or auth failure — try the raw.githubusercontent.com URL
           derived from the github.com/raw URL (the redirect target) */
        var rawUrl = href
          .replace("github.com/dialpad/ai-playbook/raw/",
                   "raw.githubusercontent.com/dialpad/ai-playbook/");
        fetch(rawUrl, { redirect: "follow" })
          .then(function (r) {
            if (!r.ok) throw new Error("HTTP " + r.status);
            return r.text();
          })
          .then(function (text) {
            triggerBlobDownload(text, filename);
          })
          .catch(function () {
            /* Last resort: open in new tab */
            window.open(href, "_blank", "noopener");
          });
      });
  }

  /* Bind to all download links — run on load and after instant-nav */
  function bindAll() {
    /* Per-page download buttons */
    document.querySelectorAll("a[data-dp-dl]").forEach(function (a) {
      if (a.dataset.dpDlBound) return;
      a.dataset.dpDlBound = "1";
      a.removeAttribute("target");
      a.addEventListener("click", handleDownloadClick);
    });

    /* Directory page download icons */
    document.querySelectorAll("a.dp-dl").forEach(function (a) {
      if (a.dataset.dpDlBound) return;
      a.dataset.dpDlBound = "1";
      a.removeAttribute("target");
      a.addEventListener("click", handleDownloadClick);
    });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", bindAll);
  } else {
    bindAll();
  }

  if (typeof document$ !== "undefined") {
    document$.subscribe(bindAll);
  }
})();
