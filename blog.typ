#import "/_calepin/calepin.typ" as calepin

#let _meta(page, key, default: none) = {
  let meta = page.at("meta", default: (:))
  if type(meta) == dictionary {
    meta.at(key, default: default)
  } else {
    default
  }
}

#let _date(page) = _meta(page, "date", default: "")

#let _lang(page) = _meta(page, "lang", default: "en")

#let _months = (
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
)

// Accepts "YYYY-MM-DD" or "YYYY-MM-DDTHH:MM:SS+HH:MM".
#let _date-display(value) = {
  if type(value) != str or value.len() < 10 {
    return value
  }
  let year = value.slice(0, 4)
  let month = int(value.slice(5, 7))
  let day = int(value.slice(8, 10))
  let clock = if value.len() >= 16 { value.slice(11, 16) } else { "" }
  let stamp = [#day #_months.at(month - 1) #year]
  if clock != "" { [#stamp, #clock] } else { stamp }
}

#let _listing-thumbnail(page) = {
  let thumbnail = _meta(page, "thumbnail", default: none)
  if thumbnail != none {
    thumbnail
  } else {
    let path = page.at("path", default: none)
    if type(path) != str or not path.ends-with(".typ") {
      none
    } else {
      let stem = path.slice(0, path.len() - 4)
      let results-path = "/_calepin/" + stem + "/results.json"
      let results-doc = json(results-path)
      let image-paths = ()
      for (_, chunk) in results-doc.at("chunks", default: (:)).pairs() {
        for item in chunk.at("items", default: ()) {
          let data = item.at("data", default: none)
          if type(data) == dictionary {
            for (mime, value) in data.pairs() {
              if type(mime) == str and mime.starts-with("image/") {
                let image-path = value.at("path", default: none)
                if type(image-path) == str {
                  image-paths.push(image-path)
                }
              }
            }
          }
        }
      }
      if image-paths.len() == 0 {
        none
      } else {
        image-paths.first()
      }
    }
  }
}

#let _listing-asset(path) = {
  if type(path) != str {
    none
  } else if path.starts-with("http://") or path.starts-with("https://") {
    path
  } else if path.starts-with("/") {
    calepin._resolve-asset-path(path)
  } else {
    calepin._resolve-asset-path("/" + path)
  }
}

#let entries(source, kind: none, language: none) = {
  source
    .filter(page => kind == none or _meta(page, "kind") == kind)
    .filter(page => language == none or _lang(page) == language)
    .filter(page => _meta(page, "draft", default: false) != true)
    .sorted(key: _date)
    .rev()
}

#let listing(title, source, kind: "post", language: none) = {
  let items = entries(source, kind: kind, language: language)

  if title != none {
    heading(level: 2)[#title]
  }

  let tab(lang, label, active: false) = html.elem("button", attrs: (
    type: "button",
    class: if active { "mx-tab is-active" } else { "mx-tab" },
    "data-lang": lang,
    "aria-pressed": if active { "true" } else { "false" },
  ))[#label]

  let filters = html.elem("div", attrs: (
    class: "mx-blog-filters mx-pub-tabs",
    "data-blog-filters": "",
  ))[
    #tab("all", "All", active: true)
    #tab("en", "English")
    #tab("ru", "Русский")
  ]

  html.elem("div", attrs: (class: "mx-blog"))[
    #filters
    #if items.len() == 0 [
      No posts yet.
    ] else [
      #{
        let cells = ()
        for (index, page) in items.enumerate() {
          let thumbnail = _listing-thumbnail(page)
          let date = _meta(page, "date", default: "")
          let lang = _lang(page)
          if thumbnail != none {
            cells.push(image(_listing-asset(thumbnail), width: 1.2cm))
          } else {
            cells.push([])
          }
          cells.push(html.elem("time", attrs: (datetime: date))[
            #_date-display(date)
          ])
          cells.push([
            #link(page.href)[#page.title]
            #html.elem("span", attrs: (
              class: "mx-blog__lang",
              "data-lang": lang,
            ))[#upper(lang)]
          ])
          if index < items.len() - 1 {
            cells.push(table.hline(stroke: 0.5pt + luma(80%)))
          }
        }
        table(
          columns: (1.8cm, auto, 1fr),
          stroke: none,
          inset: (x: 0pt, y: 0.45em),
          ..cells,
        )
      }
    ]
    #html.elem("p", attrs: (class: "mx-blog-empty", hidden: ""))[
      No posts in this language yet.
    ]
  ]
}

#set document(title: [Blog])
#metadata((
  title: "Blog",
  translation_key: "blog",
  description: "Everything about our research.",
)) <website-metadata>

Semi-organized collection of everything related to our research: work notes, news, announcements, thoughts and insights. For more structured content see #link("/publications.html")[Publications].

We publish in English and Russian, and the two versions may differ. Use the
filter below to show one language or both.

#listing("Posts", calepin.pages(), kind: "post")
