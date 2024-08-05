// indent
#import "@preview/indenta:0.0.3": fix-indent
// header-footer
#import "@preview/hydra:0.5.1": *
// physics
#import "@preview/physica:0.9.2": *
// theorems
#import "@preview/ctheorems:1.1.2": *
// banners
#import "@preview/gentle-clues:0.9.0": *
// figures
#import "@preview/subpar:0.1.1": grid as sgrid
// diagram
#import "@preview/fletcher:0.5.0": diagram, node, edge
// numbering
#import "@preview/i-figured:0.2.4"
// index
#import "@preview/in-dexter:0.4.2": *

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

  show heading: i-figured.reset-counters.with(level: 2)
  show math.equation: i-figured.show-equation

  set figure.caption(separator: "  ")

  show figure: it => align(
    center,
    block(breakable: figure-break)[
      #it.body#h(0.35em)#it.caption
    ],
  )

  show raw.where(block: true): block.with(
    fill: luma(240),
    inset: .8em,
    radius: 5pt,
    width: 100%,
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

  show link: underline
  show: thmrules
  show: fix-indent()
  doc
}

// tables
#let frame(stroke) = (
  (x, y) => (
    top: if y < 2 {
      stroke
    } else {
      0pt
    },
    bottom: stroke,
  )
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
  fill: rgb("#F3F3F3"),
  stroke: rgb("#DBDBDB"),
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
  "rule": "法则",
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
  fill: rgb("#FFFFFF"),
  // stroke: rgb("#000000"),
  inset: (left: 0em, right: 0.5em, top: 0.2em, bottom: 0.2em)
)

#let theorem = thmbox(
  "theorem",
  terms.theo,
  base_level: 1,
  separator: [#h(0.5em)],
  padding: (top: 0em, bottom: 0.2em),
  fill: rgb("#E5EEFC"),
  // stroke: rgb("#000000")
)

#let lemma = thmbox(
  "theorem",
  terms.lem,
  separator: [#h(0.5em)],
  fill: rgb("#EFE6FF"),
  titlefmt: strong,
)

#let corollary = thmbox(
  "corollary",
  terms.coro,
  base: "theorem",
  separator: [#h(0.5em)],
  titlefmt: strong,
)

#let rule = thmbox(
  "",
  terms.rule,
  base_level: 1,
  separator: [#h(0.5em)],
  fill: rgb("#EEFFF1"),
  titlefmt: strong,
)

#let tip = thmbox(
 "",
 none,
 fill: rgb("#FFFEE6"),
 radius: 0.5em,
 padding: (top: 0em, bottom: 0em),
 separator: [],
 // stroke: rgb("#000000")
).with(numbering: none)

#let algo = thmbox(
 "",
 terms.algo,
 fill: rgb("#FAF2FB"),
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
