// theorems
#import "ctheorems.typ": *

#let terms = (
  "def": "定义",
  "theo": "定理",
  "lem": "引理",
  "coro": "推论",
  "algo": "算法",
  "alert": "！注意："
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
  titlefmt: strong
)

#let corollary = thmplain(
  "corollary",
  terms.coro,
  base: "theorem",
  separator: [#h(0.5em)],
  titlefmt: strong
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

#let alert = thmbox(
 "",
 terms.alert,
 fill: rgb("#fbf2f2"),
 radius: 0em,
 padding: (top: 0em, bottom: 0em),
 separator: [],
 // stroke: rgb("#000000")
).with(numbering: none)
