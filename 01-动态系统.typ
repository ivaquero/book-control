#import "@local/scibook:0.1.0": *
#show: doc => conf(
  title: "动态系统",
  author: ("ivaquero"),
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= 控制系统组成
<控制系统组成>

控制系统由动态系统（dynamical system）和控制器（controller）组成。

== 线性时不变系统

#definition[
  当函数$f(x)$满足以下条件时，称其是线性的：

  - 可加性：$f(x_1 + x_2) = f(x_1) + f(x_2)$
  - 齐次性：$f(a x) = a f(x)$

  自变量和自变量的导数均为线性的系统，称为线性系统。
]

不显含时间$t$的线性系统，称线性自治系统（linear autonomous system），也称为线性时不变系统（linear time invariant system），如

$ dot(x) = f(x) $

LTI 是最常用的动态系统，其在具有线性性质的同时，还服从自治（时不变）原理，即

$ O{f(t)} = x(t) ⇒ O{f(t - τ)} = x(t - τ) $

LTI 还被称为线性常系数系统。与之相对，显含时间$t$的系统，称线性非自治系统（non-autonomous system）或线性时变系统（time varying system），即

$ dot(x) = f(t, x) $

== 控制器

从控制模式上，控制器分为开环控制和闭环控制

- 开环控制：根据参考值（reference）决定控制量，即系统输入
- 闭环控制：通过测量系统输出与参考值之间的误差，反馈（feedback）至输入端，决定控制量

#include "images/intro-closed.typ"

= 电学基础
<电学基础>

== 电学单元

#figure(
  table(
    columns: 4,
    align: center + horizon,
    inset: 4pt,
    stroke: frame(rgb("000")),
    [], [单位], [符号], [定义公式],
    [电量], [库仑（C）], [$Q$], [],
    [电流], [安培（A）], [$I$], [$dv(s:\/, Q, t)$],
    [电压], [伏特（V）], [$U \/ e$], [],
    [电阻], [欧姆（Ω）], [$R$], [$U\/I$],
    [电容], [法拉（F）], [$C$], [$Q\/U$],
    [电感], [亨利（H）], [$L$], [$U\/I^′$],
  ),
  caption: [电学单元],
  supplement: "表",
  kind: table,
)

#pagebreak()

- 电压

$
  e_R = I R\
  e_C = Q / C = 1 / C ∫_0^t I dd(t)\
  e_L = L dv(I, t) = L I^′
$

== 电学定律

#theorem("Ohm 定律")[
  $ I = e_R / R $

]

#theorem("Kirchhoff 电流定律（KCL）")[
  所有进入某节点的电流的总和等于所有离开这节点的电流的总和。
]

#theorem("Kirchhoff 电压定律（KVL）")[
  沿着闭合回路所有元件两端的电压的代数和等于零。
]

== RLC 电路
RLC 电路是一种由电阻 R、电感 L、电容 C 组成的电路结构。

#figure(
  image("./images/model/circuit-rlc.drawio.png", width: 40%),
  caption: [ RLC],
  supplement: "图",
)

定义上图区域 1 和区域 2 的电流方向均为顺时针，则

- 电容 C 上端为电压为正，下端电压为负- 电感 L 左端为电压为正，右端电压为负- 电阻 R 左端为电压为正，右端电压为负

由 KVL

$
  e_L + e_C - e_i = 0\
  e_(R_1) + e_(R_2) - e_C = 0
$

两式相加，得

$ e_L + e_(R_1) + e_(R_2) - e_i = 0 $

即，整体电路的闭环的电压代数和为$0$。

#pagebreak()
分别计算各项，有

- $e_(R_1) = I_2 R_1 = I_2$
- $e_(R_2) = I_2 R_2 = 3 I_2$
- $e_L = L I_1^′ = 2 I_1^′$
- $e_C = 1 / C ∫_0^t (I_1 - I_2) dd(t) = 4 ∫_0^t (I_1 - I_2) dd(t)$
回代入第一个方程组，得

$
  2 I_1^′ + 4 I_2 = e_i\
  I_2 = ∫_0^t (I_1 - I_2) dd(t)
$

对第二个子式连续求导，得

$ I_1^′ = I_2^″ + I_2^′ $

又$e_o = I_2 R_2 = 3 I_2$，则

$ 2 e_o^″ + 2 e_o^′ + 4 e_o = 3 e_i $

#figure(
  image("./images/model/circuit-rlc.png", width: 60%),
  caption: [RLC],
  supplement: "图",
)

#pagebreak()

= 电磁学基础
<电磁学基础>

== 电磁学单位

#figure(
  table(
    columns: 3,
    align: center + horizon,
    inset: 4pt,
    stroke: frame(rgb("000")),
    [], [单位], [符号],
    [磁感应强度], [特斯拉（T）], [$B$],
    [磁通量], [韦伯（Wb）], [$ϕ$],
  ),
  caption: [电磁学基础],
  supplement: "表",
  kind: table,
)

$ ϕ = B S $

其中，$B$为匀强磁场的磁感应强度，$S$是正对磁场的面积（$m^2$）。

== 电磁学定律

#theorem("Lenz 定律")[
  感应电流产生的磁场总要阻碍引起感应电流的磁通量的变化。

  $ e_L = -n frac(Δ ϕ, Δ t) $

  其中，$n$为循环数或线圈匝数、$ϕ$为磁通量。
]

#tip[
  Lenz 定律（电磁学）和 Newton 第一定律（力学）、Le Chatelier 原理（化学）本质相同，同属惯性定律。
]

= 流体力学基础
<流体力学基础>

== 压强

- 静压（hydrostatic pressure）

即重力产生的压力

$ P = frac(m g, A) $

对均值且不可压缩流体

$ P_("static") = frac(ρ A h g, A) = ρ g h $

- 绝对压强（absolute pressure）

$ P_("abs") = P_a + P_("static") $

- 表压（gauge pressure）

$ P_("gauge") = P_("abs") - P_a = ρ g h $

#figure(
  image("./images/model/liquid.drawio.png", width: 40%),
  caption: [流体系统],
  supplement: "图",
)

== 阻力

- 理想压源

阻力阀左右两端的压力差

$ P_2 = P_1 + P_(g a u g e) $

- 压头损失

阻力阀左右两端的压力差

$ P_1 - P_2 = ρ q R $

其中，$R$为流阻。

上图中，有

$ P_1 - P_a = ρ q_("out") R $

即

$
  q_("out")
  &= frac(P_1 - P_a, ρ R)\
  &= frac(P_a + ρ g h - P_a, ρ R)\
  &= frac(g h, R)
$

== 守恒

- 质量守恒

$ dv(m, t) = m_("in") - m_("out") $

等式两端除以$ρ$，得

$ dv(V, t) = q_("in") - q_("out") $

两端除以$A$，从而有

$ dv(h, t) = 1 / A (q_("in") - q_("out")) $

- 压力守恒

$ dv(P, t) = dv(P_a + ρ g h, t) $

可得

$ dv(P, t) = ρ g dv(h, t) = frac(ρ g, A)(q_("in") - q_("out")) $

由上，可得

$ dv(h, t) = q_("in") / A - frac(g h, A R) $

#pagebreak()

= 辅助知识

== 自动化系统

一个典型的自动化系统由 4 部分构成

+ Sense (collect data)
+ Perceive (interpret data)
+ Plan (find path)
+ Act (follow path)

其中，前 2 步的工作并称为传感融合（sensor fusion）。其作用有 3 个

+ 提高数据质量（降低噪声）
+ 估计未量测状态
+ 提高覆盖率
