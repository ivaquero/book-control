#import "@preview/fletcher:0.5.2": diagram, node, edge

// font style
// chinese text
#let ctext(label, size: .8em, font: "Songti SC") = text(label, size: size, font: font)

// node style
// rectangle node
#let rnode(sym, label, height: 2em) = node(sym, label, shape: rect, corner-radius: 2pt, height: height)
// circle node
#let onode(sym, label, height: 1em) = node(sym, label, shape: circle, radius: 10pt, height: height)
// label node
#let label(sym, label) = node(sym, label, stroke: none)

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

#let dash(n1, n2, label, label-pos: 0.5, label-side: left, corner: none, corner-radius: none) = edge(
  n1,
  n2,
  marks: "--",
  label: label,
  label-pos: label-pos,
  label-side: label-side,
  corner: corner,
  corner-radius: 0pt,
)

#let sys_block(center, input: "", output: "", width: 2, height: 2em) = diagram(
  spacing: (1.5em, 1.5em),
  node-stroke: 1pt,
  mark-scale: 80%,

  let line = -2,
  let (O1, O2, O3) = ((1, line), (1 + width, line), (1 + 2 * width, line)),
  rnode(O2, center, height: height),
  arrow(O1, O2, input),
  arrow(O2, O3, output),
)


#let sys_simple = diagram(
  spacing: (1.5em, 1.5em),
  node-stroke: 1pt,
  mark-scale: 80%,
  let line = -2,
  let (O1, O2) = ((-2, line), (11, line)),
  let (C, A, P) = ((1, line), (5, line), (7, line)),
  rnode(C, ctext("控制器")),
  rnode(A, ctext("执行器")),
  rnode(P, ctext("过程")),
  arrow(O1, C, ctext("指令变量")),
  arrow(C, A, ctext("执行信号")),
  arrow(A, P, ctext("受操纵变量")),
  arrow(P, O2, ctext("受控信号")),
  let (B1, B2) = ((2.5, line), (9.5, line)),
  let B3 = (6, line + 1),
  dash(B1, B3, "", corner: left),
  dash(B3, B2, "", corner: left),
  label(B3, "工厂"),
)

#let sys_closed = diagram(
  spacing: (1.5em, 1.5em),
  node-stroke: 1pt,
  mark-scale: 80%,
  let line1 = 0.5,
  let line2 = 1.5,
  let (R, O, T, A) = ((1, line1), (3, line1), (5.5, line1), (9, line1)),
  let S = (5.5, line2),
  rnode(R, $V(s)$),
  onode(O, ""),
  label((3, line1 - 0.75), ctext("误差表")),
  label((3 - 0.4, line1 - 0.25), text("+", size: 0.8em)),
  label((3 - 0.2, line1 + 0.35), text("-", size: 1.2em)),
  rnode(T, ctext("控制器")),
  rnode(S, ctext("传感器")),
  rnode(A, ctext("执行器")),
  arrow(R, O, ""),
  arrow(O, T, ctext("指令信号")),
  arrow(T, A, ctext("执行信号")),
  arrow(A, S, "", corner: right),
  arrow(S, O, ctext("传感变量"), label-pos: 0.75, corner: right),
)
