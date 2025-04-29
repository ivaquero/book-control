#import "control-blocks.typ": *

#let sys_simple = diagram(
  spacing: (1.5em, 1.5em),
  node-stroke: 1pt,
  mark-scale: 80%,
  let line = -2,
  let (O1, O2) = ((-2, line), (11, line)),
  let (C, A, P) = ((1, line), (4, line), (8, line)),
  rnode(C, ctext("控制器")),
  rnode(A, ctext("执行器")),
  rnode(P, ctext("过程")),
  arrow(O1, C, ctext("指令变量")),
  arrow(C, A, ctext("执行信号")),
  arrow(A, P, ctext("受操纵变量")),
  arrow(P, O2, ctext("受控信号")),
)

#let sys_closed = diagram(
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
  rnode(A, ctext("执行器")),
  arrow(R, O, "", corner: left),
  arrow(O, T, ctext("输入"), label-pos: .7, corner: right),
  arrow(T, A, ctext("输出"), label-pos: .25, corner: right),
  arrow(A, H, "", corner: right),
  arrow(H, O, ""),
)
