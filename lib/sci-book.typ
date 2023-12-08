#let conf(
    title: none,
    author: (),
    header-cap: [],
    header: [],
    outline-on: true,
    eqnumstyle: "1",
    eqnumsep: ".",
    eqnumlevel: 1,
    citestyle: none,
    figure-break: false,
    lang: "zh",
    doc,
) = {
  set page(
    paper: "a4",
    header: [
      #set text(6pt)
      #emph[#header-cap]-#datetime.today().display("[year]-[month]-[day]")
      #h(6fr) #emph[#header]
    ],
    footer: locate(loc => {
      let x = counter(page).at(loc).first()
      let total = counter(page).final(loc).first()
      if calc.odd(x) {
        align(right)[#counter(page).display()/#total]
      } else {
        align(left)[#counter(page).display()/#total]
      }
    }),
  )

  set heading(
    level: 2,
    numbering: "1.",
  )
  set par(
      first-line-indent: 2em,
      justify: true,
      leading: 1em,
      linebreaks: "optimized"
  )
  set block(above: 1em, below: 0.5em)

  let font = {
    if lang == "en" {"Arial"}
    if lang == "zh" {"Songti SC"}
  }

  set text(
      font: font,
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
      headingNumbering += [#eqnumsep#numbering("1", subchapter)#eqnumsep#numbering(eqnumstyle, equation)]
    }
    let equationNumbering = numbering("1", n)
    [(#headingNumbering#eqnumsep#equationNumbering)]
  }

  set math.equation(
    numbering: n => locate(loc => {
      eqNumbering(n, loc)
    }),
    supplement: [
      #if lang == "en" [#h(-.15em)Eq.#h(-.5em)]
      #if lang == "zh" [#h(-.25em) 式#h(-.5em)]
    ]
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

  show figure: it => align(center, block(breakable: figure-break)[
    #it.body#h(0.35em)#it.caption
  ])

  align(center, text(18pt)[
      *#title*
   ])

  if outline-on == true [
    #outline(
        title: [
          #if lang == "en" [Content]
          #if lang == "zh" [主要内容]
        ],
        indent: auto,
        depth: 2
     )
    #pagebreak(weak: true)
  ]
  doc
}

// import
#import "tablex.typ": *

// functions

#let code(text, lang:"python", breakable: false, width: 100%) = block(
  fill: rgb("#f3f3f3"),
  stroke: rgb("#dbdbdb"),
  inset: (x: .8em, y: .6em),
  radius: 5pt,
  spacing: 2em,
  breakable: breakable,
  width: width,
  raw(text,
      lang: lang,
      align: left))
