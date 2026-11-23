# Daiy Labs

Static website for [daiylabs.com](https://daiylabs.com), built with
[Calepin](https://vincentarelbundock.github.io/calepin/) and Typst.

## Structure

| File | Route | Purpose |
|---|---|---|
| `index.typ` | `/` | About us — the landing page |
| `team.typ` | `/team.html` | The team (stub) |
| `papers.typ` | `/papers.html` | Publications (stub) |
| `playground.typ` | `/playground.html` | Interactive experiments (stub) |
| `blog.typ` | `/blog.html` | Blog listing |
| `contacts.typ` | `/contacts.html` | Contacts (stub) |
| `404.typ` | `/404.html` | Not-found page |
| `posts/` | | Blog posts, included through `[pages]` in `calepin.toml` |
| `assets/` | | Static files copied as-is |

Site settings, navigation, and theme values live in `calepin.toml`.

## Theme

`themes/aucejo/` is a local theme extending Calepin's bundled `academic`
theme, adapted from
[maucejo/maucejo.github.io](https://github.com/maucejo/maucejo.github.io).
It provides:

- `css/60_aucejo.css` — design tokens (crimson/navy palette, Inter fonts,
  light and dark modes) and the `mx-*` components
- `js/aucejo.js` — mobile nav, scroll reveal, and filters for publications,
  posts, and the table of contents
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

#title()

Post body.
```

## Generated files

`.calepin/`, `_calepin/`, `_site/`, and `.calepin-entry.*` are build artifacts
and are ignored by Git.
