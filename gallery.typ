#import "/_lib/gallery.typ": gallery, photo

#set document(title: [Gallery])
#metadata((
  title: "Gallery",
  translation_key: "gallery",
  description: "Full-resolution images from the code-space layout experiments in our DAML paper.",
)) <website-metadata>

These are the full-resolution versions of the layout figures from our paper
#link("https://arxiv.org/abs/2508.00869")[A discrete approach to machine learning].
The PNGs are lossless copies of the originals, so you can zoom in and inspect
individual clusters and pinwheels at pixel level. Click any thumbnail to open
it; use the mouse wheel or a pinch gesture to zoom, drag to pan, and the arrow
keys to move between images.

= Russian morphology layout

The layout was performed on a code space built from the Tatoeba corpus. The
figures below follow the process described in the Practice chapter, from the
preliminary layout through several rounds of code fixes and re-layouts.

== Preliminary layout

Visualisation $C dot.op hat(E)$ of the preliminary layout, $n = 419 thin 566$,
$d = 1316$. Values of $lambda$ in alphabetical order of the images: $0.65,
0.71, 0.77, 0.81, 0.85$.

#gallery(columns: 5, label: "Preliminary layout")[
  #photo("ru-layout-pre-0-65", label: "a", note: [λ = 0.65])
  #photo("ru-layout-pre-0-71", label: "b", note: [λ = 0.71])
  #photo("ru-layout-pre-0-77", label: "c", note: [λ = 0.77])
  #photo("ru-layout-pre-0-81", label: "d", note: [λ = 0.81])
  #photo("ru-layout-pre-0-85", label: "e", note: [λ = 0.85])
]

== Roots insertion

Layout after adding root fragmentations. $n = 2 thin 414 thin 645$,
$d = 1587$. *a*: layout start; *b*: space reconfiguration; *c, d*: processing;
*e*: result.

#gallery(columns: 5, label: "Roots insertion")[
  #photo("ru-layout-root-1", label: "a", note: [layout start])
  #photo("ru-layout-root-2", label: "b", note: [space reconfiguration])
  #photo("ru-layout-root-3", label: "c", note: [processing])
  #photo("ru-layout-root-4", label: "d", note: [processing])
  #photo("ru-layout-root-5", label: "e", note: [result])
]

== Defect analysis and re-layout

Layout after code correction. *a*: dissociation of the previous layout;
*b, c, d*: space reconfiguration; *e*: refinement by the near algorithm.
Values of $lambda$ in alphabetical order of the images: $0.65, 0.75, 0.8, 0.85,
0.9$.

#gallery(columns: 5, label: "Defect analysis and re-layout")[
  #photo("ru-layout-fix-0-65", label: "a", note: [λ = 0.65 · dissociation])
  #photo("ru-layout-fix-0-75", label: "b", note: [λ = 0.75 · reconfiguration])
  #photo("ru-layout-fix-0-8", label: "c", note: [λ = 0.8 · reconfiguration])
  #photo("ru-layout-fix-0-85", label: "d", note: [λ = 0.85 · reconfiguration])
  #photo("ru-layout-fix-0-9", label: "e", note: [λ = 0.9 · near algorithm])
]

== Suffixes insertion

Layout after adding suffix fragmentations. *a*: matrix augmentation, code
addition and dissociation; *b*: migration of old codes to the periphery;
*c*: layout of the central region and migration of clusters; *d*: continued
layout; *e*: result.

#gallery(columns: 5, label: "Suffixes insertion")[
  #photo("ru-layout-suffix-1", label: "a", note: [matrix augmentation])
  #photo("ru-layout-suffix-2", label: "b", note: [migration to the periphery])
  #photo("ru-layout-suffix-3", label: "c", note: [central region layout])
  #photo("ru-layout-suffix-4", label: "d", note: [continued layout])
  #photo("ru-layout-suffix-5", label: "e", note: [result])
]

== Per-character table codes

Code replacement and re-layout. *a, b*: space before and after in-place code
replacement (without layout), $lambda = 0.65$; *c*: the new code space after
layout over $lambda = 0 ... 0.85$, visualised at $lambda = 0.65$; *d*: layout
after switching to tabular codes, visualised at $lambda = 0.65$ while the space
was laid out at $lambda = 0.85$; *e*: final result, $n = 3 thin 037 thin 878$
points, $d = 1764$, visualised at $lambda = 0.55$.

#gallery(columns: 5, label: "Per-character table codes")[
  #photo("ru-layout-before-patch", label: "a", note: [before code replacement])
  #photo("ru-layout-after-patch", label: "b", note: [after code replacement])
  #photo("ru-relayout-after-patch", label: "c", note: [re-layout, λ = 0.65])
  #photo("ru-layout-after-table-codes", label: "d", note: [table codes, λ = 0.65])
  #photo("ru-layout-final", label: "e", note: [final result, λ = 0.55])
]

= Histochemistry

The same chapter also tests the layout on immunohistochemical markers from a
tertiary lymphoid structure (TLS). These are the channel images used to build
the primary codes. They are shown here for closer inspection; the coloured
region markers from the paper are not reproduced.

== TLS channels

Multispectral image of a tertiary lymphoid structure (TLS) from CRC08. From
left to right, top to bottom: localisation of activated T-lymphocytes (CD45RO);
cell proliferation (Ki67); activated B-lymphocytes (CD20); leukocytes (CD45).

#gallery(columns: 2, label: "TLS channels")[
  #photo("tls-1", label: "a", note: [CD45RO · activated T-lymphocytes])
  #photo("tls-2", label: "b", note: [Ki67 · cell proliferation])
  #photo("tls-3", label: "c", note: [CD20 · activated B-lymphocytes])
  #photo("tls-4", label: "d", note: [CD45 · leukocytes])
]

== Marker channels

*a*: localisation of CD4 (blue) and CD8a (purple) in the TLS region;
*b*: CD4 (blue) and PD-1 (cyan); *c, d*: separate CD4 and PD-1 channels,
respectively.

#gallery(columns: 4, label: "Marker channels")[
  #photo("hist-cd4-cd8a", label: "a", note: [CD4 and CD8a])
  #photo("hist-cd4-pd1", label: "b", note: [CD4 and PD-1])
  #photo("hist-cd4", label: "c", note: [CD4 channel])
  #photo("hist-pd1", label: "d", note: [PD-1 channel])
]

The complete study, including the annotated layout and its discussion, is
available as the preprint
#link("https://arxiv.org/abs/2508.00869")[A discrete approach to machine learning].
