
#set document(title: [О горьком уроке, который мы усвоили неверно])
#metadata((
  title: "О горьком уроке",
  kind: "post",
  lang: "ru",
  date: "2025-09-04T13:17:21+05:00",
  slug: "bitter-lesson-ru",
  summary: "…который мы усвоили неверно",
  description: "Горький урок можно и нужно понимать в обе стороны",
)) <website-metadata>

#set text(lang: "ru")


Недавно в блоге Obviously Wrong вышла #link("https://obviouslywrong.substack.com/p/the-bitter-lesson-is-misunderstood")[отличная статья] на тему горького урока и тех выводов, которые мы можем из него сделать.

Цитата из оригинала:

#calepin.elements.callout(
  kind: "important",
  title: none,
)[
  *tl;dr:* For years, we've been reading the Bitter Lesson backwards. It wasn't about compute — it was about data. Here's the part of Scaling Laws no one talks about:

  $
    C ~ D^2
  $

  Translation: Double your GPUs? You need 40% more data or you're just lighting cash on fire. But there's no 2nd Internet (we’ve already eaten the first one). The path forward: data alchemists (high-variance, 300% lottery ticket) or model architects (20-30% steady gains), not chip buyers. Full analysis below.
]

Выводы автора совпадают и с нашими. Мы изначально ставили своей целью не бенчмаксинг, а возможность работать с недостоверными, противоречивыми и зашумленными данными, которых, как всегда, не хватает.

Очевидно, что ни один взрослый человек (ни тем более ребенок) в жизни не читал столько текста, сколько мы скармливаем современным языковым моделям. Но это почему-то прекрасно работает.

В наших исследованиях мы пытаемся строить модели, которые смогут вытащить смысл из тех данных, что есть. В этом нам помогают Лемма Йонеды с принципом многих взглядов и активная память. Мы сохраняем и работаем с фактами в том виде, как они есть, а не с их усреднениями.
