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
#let arredge(n1, n2, label, label-pos, corner, corner-radius) = edge(
  n1,
  n2,
  marks: "-|>",
  label: label,
  label-pos: label-pos,
  corner: corner,
  corner-radius: 0pt,
)

// 闭环控制器
#figure(
  diagram(
    spacing: (1.5em, 1.5em),
    node-stroke: 1pt,
    mark-scale: 80%,
    let (R, T) = ((1, 0.5), (4, 0.5)),
    let (O, H) = ((2, 2), (4, 2)),
    let A = (5.5, 1.25),
    rnode(R, $V(s)$),
    onode(O, ""),
    label((2, 2.65), ctext("误差表")),
    rnode(T, ctext("控制器")),
    rnode(H, ctext("传感器")),
    rnode(A, ctext("设备")),
    arredge(R, O, "", 0, left, 0pt),
    arredge(O, T, ctext("输入"), .7, right, 0pt),
    arredge(T, A, ctext("输出"), .25, right, 0pt),
    arredge(A, H, "", 0, right, 0pt),
    arredge(H, O, "", 0, none, 0pt),
  ),
  caption: "闭环控制器",
  supplement: "图",
)
