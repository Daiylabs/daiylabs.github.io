#set document(title: [Морфология русского языка])
#metadata((
  title: "Морфология русского языка",
  kind: "post",
  lang: "ru",
  date: "2025-08-30T00:50:00+05:00",
  slug: "morphology-video-ru",
  translation_key: "morphology-video",
  summary: "Попытка описать подход к морфологии «на пальцах»",
  description: "Морфология русского языка: на пальцах и без формул.",
)) <website-metadata>

#set text(lang: "ru")

Здесь есть я на пальцах и без формул рассказываю наш подход к построению морфологических эмбеддингов русского языка. Все это описано в седьмой главе нашей первой статьи: #link("https://arxiv.org/abs/2508.00869")[arxiv:2508.00869].

На момент записи этого видео самой статьи еще не существовало, поэтому пространство использовалось то, что было посчитано на тот момент.

#calepin.elements.callout(kind: "note", title: [Совет])[
  Рекомендую поставить скорость воспроизведения видео в районе 1.2 - 1.5,
  чтобы темп речи получился адекватный.
]

#html.elem("div", attrs: (class: "mx-video"))[
  #html.elem("iframe", attrs: (
    src: "https://www.youtube-nocookie.com/embed/lG7vGl9qfWA",
    title: "Подход к морфологии «на пальцах»",
    loading: "lazy",
    allowfullscreen: "",
    allow: "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share",
  ))
]

_Эта заметка также доступна на английском:_
#link("morphology-video-en.html")[Morphology of the Russian Language].
