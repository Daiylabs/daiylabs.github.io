// Blog: filter the post table by language. The state lives in #lang=… so a
// filtered view can be linked to.
(() => {
  "use strict";

  const filter = document.querySelector("[data-blog-filters]");
  const list = document.querySelector(".mx-blog");
  if (!filter || !list) return;

  const buttons = Array.from(filter.querySelectorAll("[data-lang]"));
  const rows = Array.from(list.querySelectorAll("tr")).filter((row) =>
    row.querySelector(".mx-blog__lang"),
  );
  const empty = list.querySelector(".mx-blog-empty");

  function apply(lang, updateHash = true) {
    let shown = 0;
    rows.forEach((row) => {
      const badge = row.querySelector(".mx-blog__lang");
      const ok = lang === "all" || badge?.dataset.lang === lang;
      row.hidden = !ok;
      if (ok) shown += 1;
    });

    if (empty) empty.hidden = shown > 0;

    buttons.forEach((button) => {
      const active = button.dataset.lang === lang;
      button.classList.toggle("is-active", active);
      button.setAttribute("aria-pressed", active ? "true" : "false");
    });

    if (updateHash) {
      const hash = lang === "all" ? "" : `#lang=${lang}`;
      history.replaceState(null, "", location.pathname + location.search + hash);
    }
  }

  buttons.forEach((button) => {
    button.addEventListener("click", () => apply(button.dataset.lang));
  });

  function readHash() {
    const match = location.hash.match(/^#lang=(all|en|ru)$/);
    apply(match ? match[1] : "all", false);
  }

  window.addEventListener("hashchange", readHash);
  readHash();
})();
