// header-footer
#import "@preview/hydra:0.4.0": *
// physics
#import "@preview/physica:0.9.2": *
// diagram
#import "@preview/fletcher:0.5.0": diagram, node, edge
// theorems
#import "@preview/ctheorems:1.1.2": *
// banners
#import "@preview/gentle-clues:0.8.0": *
// indent
#import "@preview/indenta:0.0.3": fix-indent

#let conf(
  title: none,
  author: (),
  header-cap: [],
  footer-cap: [],
  outline-on: true,
  eqnumstyle: "1",
  eqnumsep: ".",
  eqnumlevel: 1,
  citestyle: none,
  figure-break: false,
  doc,
) = {
  set page(
    paper: "a4",
    numbering: "1",
    header: context {
      set text(size: 8pt)
      if calc.odd(here().page()) {
        align(right, [#header-cap #h(6fr) #emph(hydra(1))])
      } else {
        align(left, [#emph(hydra(1)) #h(6fr) #header-cap])
      }
      line(length: 100%)
    },
    footer: context {
      set text(size: 8pt)
      let page_num = here().page()
      if calc.odd(page_num) {
        align(
          right,
          [#footer-cap #datetime.today().display("[year]-[month]-[day]") #h(6fr) #page_num],
        )
      } else {
        align(
          left,
          [#page_num #h(6fr) #footer-cap #datetime.today().display("[year]-[month]-[day]")],
        )
      }
    },
  )
  set heading(numbering: "1.")

  set par(
    first-line-indent: 2em,
    justify: true,
    leading: 1em,
    linebreaks: "optimized",
  )
  set block(above: 1em, below: 0.5em)
  set list(indent: 1.2em)
  set enum(indent: 1.2em)

  set text(
    font: "Songti SC",
    size: 10.5pt,
  )

  if citestyle != none {
    set cite(style: citestyle)
  }

  let eqNumbering(n, loc) = {
    let hCounter = counter(heading).at(loc)
    let chapter = hCounter.at(0)
    let headingNumbering = numbering("1", chapter)
    if eqnumlevel == 2 and hCounter.len() > 1 {
      let subchapter = hCounter.at(1)
      headingNumbering += [#eqnumsep#numbering(
          "1",
          subchapter,
        )#eqnumsep#numbering(eqnumstyle, equation)]
    }
    let equationNumbering = numbering("1", n)
    [(#headingNumbering#eqnumsep#equationNumbering)]
  }

  set math.equation(
    numbering: n => locate(loc => {
      eqNumbering(n, loc)
    }),
    supplement: [
      #h(-.25em) 式#h(-.5em)
    ],
  )

  // equation numbering
  show ref: it => {
    let element = it.element
    if element != none and element.func() == math.equation {
      let loc = element.location()
      let n = counter(math.equation).at(loc).first()
      eqNumbering(n, loc)
    } else {
      it
    }
  }

  set figure.caption(separator: none)

  show figure: it => align(
    center,
    block(breakable: figure-break)[
      #it.body#h(0.35em)#it.caption
    ],
  )

  align(
    center,
    text(18pt)[
      *#title*
    ],
  )

  if outline-on == true [
    #outline(
      title: "主要内容",
      indent: auto,
      depth: 2,
    )
    #pagebreak()
  ]

  show: thmrules
  show: fix-indent()
  doc
}

// tables
#let frame(stroke) = (x, y) => (
  top: if y < 2 {
    stroke
  } else {
    0pt
  },
  bottom: stroke,
)

#let ktable(data, k, inset: 0.3em) = table(
  columns: k,
  inset: inset,
  align: center + horizon,
  stroke: frame(rgb("000")),
  ..data.flatten(),
)

// functions
#let code(text, lang: "python", breakable: false, width: 100%) = block(
  fill: rgb("#f3f3f3"),
  stroke: rgb("#dbdbdb"),
  inset: (x: .8em, y: .6em),
  radius: 5pt,
  spacing: 2em,
  breakable: breakable,
  width: width,
  raw(
    text,
    lang: lang,
    align: left,
  ),
)

// theorems
#let terms = (
  "def": "定义",
  "theo": "定理",
  "lem": "引理",
  "coro": "推论",
  "algo": "算法",
  "tip": "提示",
  "alert": "注意",
)

#let definition = thmbox(
  "definition",
  terms.def,
  base_level: 1,
  separator: [#h(0.5em)],
  padding: (top: 0em, bottom: 0em),
  fill: rgb("#ffffff"),
  // stroke: rgb("#000000"),
  inset: (left: 0em, right: 0.5em, top: 0.2em, bottom: 0.2em)
)

#let theorem = thmbox(
  "theorem",
  terms.theo,
  base_level: 1,
  separator: [#h(0.5em)],
  padding: (top: 0em, bottom: 0.2em),
  fill: rgb("#e5eefc"),
  // stroke: rgb("#000000")
)

#let lemma = thmbox(
  "theorem",
  terms.lem,
  separator: [#h(0.5em)],
  fill: rgb("#efe6ff"),
  titlefmt: strong,
)

#let corollary = thmplain(
  "corollary",
  terms.coro,
  base: "theorem",
  separator: [#h(0.5em)],
  titlefmt: strong,
)

#let tip = thmbox(
 "",
 none,
 fill: rgb("#fffee6"),
 radius: 0.5em,
 padding: (top: 0em, bottom: 0em),
 separator: [],
 // stroke: rgb("#000000")
).with(numbering: none)

#let algo = thmbox(
 "",
 terms.algo,
 fill: rgb("#faf2fb"),
 radius: 0em,
 padding: (top: 0em, bottom: 0em),
 separator: [],
 // stroke: rgb("#000000")
)

// banners
#let tip(title: terms.tip, icon: emoji.bubble, ..args) = clue(
  accent-color: yellow,
  title: title,
  icon: icon,
  ..args,
)

#let alert(title: terms.alert, icon: emoji.excl, ..args) = clue(
  accent-color: red,
  title: title,
  icon: icon,
  ..args,
)
