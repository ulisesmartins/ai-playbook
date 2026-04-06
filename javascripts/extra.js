/* ── Download-page button ──────────────────────────────────────────────────
   Injects a download icon next to the View / Edit buttons on every page.
   Downloads the markdown source (.md) from the GitHub raw URL.

   Strategy: find the "View source" link that MkDocs Material already
   generates (points to github.com/.../raw/master/path.md) and open it.
   This works for private repos because the user's GitHub session handles
   auth — unlike raw.githubusercontent.com which requires a token.
   ───────────────────────────────────────────────────────────────────────── */

document$.subscribe(function () {
  var inner = document.querySelector(".md-content__inner");
  if (!inner) return;

  if (inner.querySelector("[data-dp-dl]")) return;

  var viewLink = inner.querySelector('a[href*="/raw/master/"]');

  if (!viewLink) {
    var editLink = inner.querySelector('a[href*="/edit/master/"]');
    if (editLink) {
      var rawHref = editLink.href.replace("/edit/master/", "/raw/master/");
      viewLink = { href: rawHref };
    }
  }

  if (!viewLink) return;

  var rawUrl = viewLink.href;
  var filename = rawUrl.split("/").pop() || "source.md";

  var btn = document.createElement("a");
  btn.setAttribute("data-dp-dl", "1");
  btn.className = "md-content__button md-icon";
  btn.title = "Download markdown source";
  btn.setAttribute("aria-label", "Download markdown source");
  btn.href = rawUrl;
  btn.target = "_blank";
  btn.rel = "noopener noreferrer";
  btn.setAttribute("download", filename);

  btn.innerHTML =
    '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">' +
    '<path d="M5 20h14v-2H5v2zm7-2L5.41 11.41 7 9.83l4 4.01V2h2v11.84' +
    'l4-4.01 1.59 1.58L12 18z"/>' +
    "</svg>";

  var first = inner.querySelector(".md-content__button");
  if (first) inner.insertBefore(btn, first);
  else inner.prepend(btn);
});
