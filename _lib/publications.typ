#import "/_calepin/calepin.typ" as calepin

/// One publication card: a bordered face with a centered image,
/// and the title as a label below the card border.
/// - href:  destination page, e.g. "papers/daml/"
/// - image: face image path (site asset)
/// - title: card title
#let card(href, image, title) = {
  html.elem("a", attrs: (
    href: calepin.url("/" + href),
    class: "mx-pubcard",
    "aria-label": title,
  ))[
    #html.elem("span", attrs: (class: "mx-pubcard__face"))[
      #html.elem("img", attrs: (
        src: calepin.url(image),
        alt: title,
        class: "mx-pubcard__img",
        loading: "lazy",
        decoding: "async",
      ))
    ]
    #html.elem("span", attrs: (class: "mx-pubcard__title"))[#title]
  ]
}

/// A responsive grid of publication cards.
#let cards(columns: 3, body) = {
  html.elem("div", attrs: (
    class: "mx-pubcards",
    style: "grid-template-columns: repeat(" + str(columns) + ", minmax(0, 1fr));",
  ))[#body]
}
