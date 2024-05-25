#import "lib/sci-book.typ": *
#show: doc => conf(
  title: "奈奎斯特稳定性",
  author: ("ivaquero"),
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= Nyquist 稳定性

== 定义

对如下系统

#figure(
  image("images/block/sensor.drawio.png", width: 40%),
  caption: "传感器",
  supplement: "图"
)

- 开环传递函数：$G(s)H(s)$
- 闭环传递函数：$G(s)/(1+G(s)H(s))$

令

- $G(s) = N_G(s)/D_G(s)$
- $H(s) = N_H(s)/D_H(s)$

可得

$
G(s)H(s) = frac(N_G N_H, D_G D_H) \
1 + G(s)H(s) = frac(D_G D_H + N_G N_H, D_G D_H)\
frac(G(s), 1 + G(s)H(s)) = frac(N_G D_H, D_G D_H + N_G N_H) $

不难得到

- 开环传递函数的极点 = 媒介函数的极点
- 闭环传递函数的极点 = 媒介函数的零点

若有映射$F(s) = 1 + G(s)H(s)$，将平面$A$中的闭合曲线，映射到平面$B$中，则对新的闭合曲线逆时针绕原点的圈数$N$有

$ N = P - Z
$
其中

- $P$为 Nyquist 闭合区内，$F(s)$的极点（开环传递函数的极点）个数
- $Z$为 Nyquist 闭合区内，$F(s)$的零点（闭环传递函数的极点）个数

> Nyquist 闭合区：复平面的右半平面

变换映射函数为$F(s) - 1 = G(s)H(s)$，闭合曲线$B$将整体左移，中心点变为$(-1, 0)$，绘制出的图形称为 Nyquist Plot。

#theorem("Nyquist 稳定性")[
  若系统稳定，则其闭环传递函数在 Nyquist 闭合区没有极点，即
  $ P = N $
]

#tip[
  现实生活中，传递函数均为真分数，即分母≥分子。
]

== 裕度分析

#h(2em) 由于$G(j ω)$和$G(-j ω)$共轭，其模相等，角度互为相反数，故其映射关于实轴对称。此时，分析只需绘制正虚轴部分。

=== 幅值裕度

#h(2em) 幅值裕度（gain magin）表示开环增益$K$在系统变得不稳定前，还能增加的比例。

=== 相位裕度

#h(2em) 相位裕度（phase magin）表示相位角在系统变得不稳定前，还能延迟的比例。
