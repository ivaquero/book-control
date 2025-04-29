#import "@preview/fletcher:0.5.2": diagram, node, edge

// font style
// chinese text
#let ctext(label, size: .8em, font: "Songti SC") = text(label, size: size, font: font)

// node style
// rectangle node
#let rnode(sym, label) = node(sym, label, shape: rect)
// circle node
#let onode(sym, label) = node(sym, label, shape: circle, radius: 10pt)
// label node
#let label(sym, label) = node(sym, label, stroke: white)

// edge style
#let arrow(n1, n2, label, label-pos: 0.5, label-side: left, corner: none, corner-radius: none) = edge(
  n1,
  n2,
  marks: "-|>",
  label: label,
  label-pos: label-pos,
  label-side: label-side,
  corner: corner,
  corner-radius: 0pt,
)

#let segment(n1, n2, label, label-pos: 0.5, label-side: left, corner: none, corner-radius: none) = edge(
  n1,
  n2,
  marks: "-",
  label: label,
  label-pos: label-pos,
  label-side: label-side,
  corner: corner,
  corner-radius: 0pt,
)
