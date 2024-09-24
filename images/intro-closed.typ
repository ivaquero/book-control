#import "../lib/plot-control.typ": *

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
    aedge(R, O, "", 0, left, 0pt),
    aedge(O, T, ctext("输入"), .7, right, 0pt),
    aedge(T, A, ctext("输出"), .25, right, 0pt),
    aedge(A, H, "", 0, right, 0pt),
    aedge(H, O, "", 0, none, 0pt),
  ),
  caption: "闭环控制器",
  supplement: "\n图",
)
