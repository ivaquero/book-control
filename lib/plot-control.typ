#import "@preview/fletcher:0.5.0": diagram, node, edge

// 字体样式
#let ctext(label, font: "Songti SC") = text(label, size: .7em, font: font)

// 节点样式
#let rnode(sym, label) = node(sym, label, shape: rect)
#let onode(sym, label) = node(sym, label, shape: circle, radius: 10pt)
#let label(sym, label) = node(sym, label, stroke: white)

// 边样式
#let aedge(n1, n2, label, label-pos, corner, corner-radius) = edge(
  n1,
  n2,
  marks: "-|>",
  label: label,
  label-pos: label-pos,
  corner: corner,
  corner-radius: 0pt,
)
