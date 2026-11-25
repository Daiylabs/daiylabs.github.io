# Daiy Labs

Static website for [daiylabs.com](https://daiylabs.com), built with
[Calepin](https://vincentarelbundock.github.io/calepin/) and Typst.

## Structure

| File | Route | Purpose |
|---|---|---|
| `index.typ` | `/` | About us — the landing page |
| `team.typ` | `/team.html` | The team (stub) |
| `papers.typ` | `/papers.html` | Publications (stub) |
| `gallery.typ` | `/gallery.html` | Full-resolution layout gallery |
| `playground.typ` | `/playground.html` | Interactive experiments (stub) |
| `blog.typ` | `/blog.html` | Blog listing |
| `contacts.typ` | `/contacts.html` | Contacts (stub) |
| `404.typ` | `/404.html` | Not-found page |
| `posts/` | | Blog posts, included through `[pages]` in `calepin.toml` |
| `_lib/` | | Typst helpers and generated data (not published) |
| `scripts/` | | Build helpers (not published) |
| `assets/` | | Static files copied as-is (brand, gallery, PhotoSwipe, math font) |

Site settings, navigation, and theme values live in `calepin.toml`.

## Theme

`themes/aucejo/` is a local theme extending Calepin's bundled `academic`
theme, adapted from
[maucejo/maucejo.github.io](https://github.com/maucejo/maucejo.github.io).
It provides:

- `css/60_aucejo.css` — design tokens (crimson/navy palette, Inter fonts,
  light and dark modes) and the `mx-*` components
- `css/70_gallery.css` — thumbnail grid and PhotoSwipe caption styling
- `js/aucejo.js` — mobile nav, scroll reveal, and filters for publications,
  posts, and the table of contents
- `js/gallery.js` — initializes PhotoSwipe when a `.mx-gallery` is present
- `layouts/` — `site.html` for inner pages and `site-home.html` for an
  optional hero landing page
- `partials/` — top bar, brand, page header, footer, and social links
- `assets/fonts/STIXTwoMath.woff2` — math font referenced by the stylesheet

Theme values used by the templates live under `[store]` in `calepin.toml`
(`name`, `role`, `tagline`, `copyright`). The home layout is available but
not enabled; select it per page with:

```typ
#metadata((layout: "layouts/site-home.html")) <website-metadata>
```

Pages use `description` in `<website-metadata>` for the header band, and no
longer call `#title()`: the theme renders the page title from metadata.

## Brand

The site logo and favicon are derived from `assets/images/grad-color.png`:

- `assets/images/logo.png` — 256×256, shown in the top bar
- `assets/images/favicon.png` — 64×64 browser icon

The full-resolution source stays in the repo but is excluded from the build
(`[static] exclude` in `calepin.toml`).

## Gallery

`gallery.typ` shows full-resolution figures from the DAML paper's code-space
layout experiments. Thumbnails are 480 px JPEGs; the lossless PNGs (97 MB in
total) are loaded only when a thumbnail is clicked, inside a zoomable
PhotoSwipe lightbox.

Regenerate the assets from the paper sources:

```bash
python3 scripts/prepare-gallery.py          # copy PNGs, build thumbnails
python3 scripts/prepare-gallery.py --force  # rebuild everything
```

The script reads `~/work/papers/daml-paper/images` by default (override with
`--source`), writes `assets/gallery/full/`, `assets/gallery/thumbs/`, and
`_lib/gallery-images.json`. PhotoSwipe 5.4.4 is vendored in
`assets/photoswipe/` (MIT, © Dmytro Semenov).

## Commands

```bash
# Build the site into _site/
calepin compile .

# Rebuild on change and preview at http://127.0.0.1:8000
calepin watch . --serve --open

# Serve an existing build
calepin serve _site --open

# Check the toolchain, internal links, images, and routes
calepin health
```

## Blog posts

Add a `.typ` file under `posts/` with post metadata:

```typ
#set document(title: [Post title])
#metadata((
  title: "Post title",
  kind: "post",
  date: "2026-11-23",
  tags: ("research",),
  summary: "One-line summary shown in the listing.",
)) <website-metadata>

Post body.
```

## Generated files

`.calepin/`, `_calepin/`, `_site/`, and `.calepin-entry.*` are build artifacts
and are ignored by Git.
