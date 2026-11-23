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

Site settings, navigation, and the sidebar live in `calepin.toml`.

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
