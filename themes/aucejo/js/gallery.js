// Gallery: open thumbnails in a zoomable PhotoSwipe lightbox.
// PhotoSwipe is vendored under assets/photoswipe and loaded only when the
// page actually contains a gallery.
(() => {
  "use strict";

  function start() {
    const first = document.querySelector(".mx-gallery");
    if (!first) return;

    // Data attributes hold page-relative paths such as "assets/...".
    // Dynamic import treats that as a bare specifier, so resolve it to an
    // absolute URL first.
    const url = (value) => new URL(value, document.baseURI).href;

    const css = url(first.dataset.pswpCss);
    if (!document.querySelector(`link[href="${css}"]`)) {
      const link = document.createElement("link");
      link.rel = "stylesheet";
      link.href = css;
      document.head.appendChild(link);
    }

    const container = document.querySelector(".mx-main") || document.body;
    const lightboxUrl = url(first.dataset.pswpLightbox);
    const moduleUrl = url(first.dataset.pswpModule);

    import(lightboxUrl)
      .then(({ default: PhotoSwipeLightbox }) => {
        const lightbox = new PhotoSwipeLightbox({
          gallery: container,
          children: "a.mx-gallery__item",
          pswpModule: () => import(moduleUrl),
          wheelToZoom: true,
          maxZoomLevel: 8,
          bgOpacity: 0.96,
          padding: { top: 40, bottom: 80, left: 20, right: 20 },
        });

        lightbox.on("zoomPanUpdate", () => {
          const pswp = lightbox.pswp;
          if (!pswp?.element) return;
          const zoomed = (pswp.currSlide?.currZoomLevel || 1) > 1.01;
          pswp.element.classList.toggle("mx-zoomed", zoomed);
        });

        lightbox.on("uiRegister", () => {
          lightbox.pswp.ui.registerElement({
            name: "mx-caption",
            order: 9,
            isButton: false,
            appendTo: "root",
            html: "",
            onInit: (el, pswp) => {
              pswp.on("change", () => {
                const item = pswp.currSlide?.data?.element;
                const caption = item?.querySelector(".mx-gallery__caption-src");
                const figure = item?.closest(".mx-gallery")?.dataset.label;
                const text = caption ? caption.innerHTML : "";
                el.innerHTML = figure ? `${figure} — ${text}` : text;
              });
            },
          });
        });

        lightbox.init();
      })
      .catch((error) => {
        console.error("PhotoSwipe failed to load", error);
      });
  }

  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", start);
  } else {
    start();
  }
})();
