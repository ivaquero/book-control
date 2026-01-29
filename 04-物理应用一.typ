#import "lib/lib.typ": *
#show: chapter-style.with(title: "物理应用一", info: info)

= 流体力学基础
<流体力学基础>

== 压强

- 静压（hydrostatic pressure）

即重力产生的压力

$ P = frac(m g, A) $

对均值且不可压缩流体

$
  P_("static") = frac(ρ A h g, A) = ρ g h
$

- 绝对压强（absolute pressure）

$ P_("abs") = P_a + P_("static") $

- 表压（gauge pressure）

$ P_("gauge") = P_("abs") - P_a = ρ g h $

#figure(
  image("images/liquid.drawio.png", width: 40%),
  caption: "流体系统",
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
  q_("out") & = frac(P_1 - P_a, ρ R) \
            & = frac(P_a + ρ g h - P_a, ρ R) \
            & = frac(g h, R)
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

= 电学基础
<电学基础>

== 电学单位

#let data = csv("data/electrics.csv")
#figure(
  tableq(data, 5),
  caption: "电学单位",
  kind: table,
)

=== 电压

$
  e_R = I R\
  e_C = Q / C = 1 / C ∫_0^t I dd(t)\
  e_L = L dv(I, t) = L I^′
$

== 电学定律

#theorem(title: ctext("Ohm 定律"))[
  $ I = e_R / R $
]

#theorem(title: ctext("Kirchhoff 电流定律（KCL）"))[

  所有进入某节点的电流的总和等于所有离开这节点的电流的总和。
]

#theorem(title: ctext("Kirchhoff 电压定律（KVL）"))[

  沿着闭合回路所有元件两端的电压的代数和等于零。
]

== RLC 电路

RLC 电路是一种由电阻 R、电感 L、电容 C 组成的电路结构。

#figure(
  zap.circuit({
    import zap: *
    let (t, b) = (3, 0)
    let (l, m, r) = (0, 3, 6)

    node("n1", (m, t))
    node("n2", (m, b))
    vsource("v", (l, b), (l, t), variant: "ieee", label: $e_i$, i: (content: $i_1$, distance: 15pt))

    capacitor("c", "n1", "n2", variant: "ieee", label: $C=1\/4F$)
    inductor("i", "v.out", "n1", variant: "ieee", label: $L=2H$)
    resistor("r1", "n1", (r, t), variant: "ieee", label: $R_1=1Ω$)
    resistor("r2", "r1.out", (r, b), variant: "ieee", label: $R_2=3Ω$)

    wire("r2.out", "n2")
    wire("n2", "v.in")
  }),
  caption: "RLC",
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

即，整体电路的闭环的电压代数和为$0$。分别计算各项，有

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
  image("images/circuit-rlc.png", width: 60%),
  caption: "RLC",
)

= 电磁学基础
<电磁学基础>

== 电磁学单位

#let data = csv("data/magnetics.csv")
#figure(
  tableq(data, 3),
  caption: "电磁学单位",
  kind: table,
)

$ ϕ = B S $

其中，$B$为匀强磁场的磁感应强度，$S$是正对磁场的面积（$m^2$）。

== 电磁学定律

#theorem(title: ctext("Lenz 定律"))[
  感应电流产生的磁场总要阻碍引起感应电流的磁通量的变化。

  $ e_L = -n frac(Δ ϕ, Δ t) $

  其中，$n$为循环数或线圈匝数、$ϕ$为磁通量。
]

#tip[
  Lenz 定律（电磁学）和 Newton 第一定律（力学）、Le Chatelier 原理（化学）本质相同，同属惯性定律。
]

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


= 系统设计
<系统设计>

== 并行系统

#figure(
  zap.circuit({
    import zap: *
    let (t, b) = (2.5, 0)
    let (l, r) = (0, 4)
    vsource("v", (l, b), (l, t), variant: "ieee")
    resistor("r", "v.out", (r, t), variant: "ieee", label: $R$)

    inductor("i", "r.out", (r, b), variant: "ieee", label: $L$)
    capacitor("c", "i.out", "v.in", variant: "ieee", label: $C$)
  }),
  caption: "电路",
)

由 KCL 有

$ e^′ = L i^″ + R i^′ + 1 / C i $

令初始条件为$0$，等式两边进行导数的 Laplace 变换，得

$
  s E[s] = L s^2 I_(s) + s R I_(s) + 1 / C I_(s)
$

从而有

$ I(s) = frac(s, L s^2 + R s + 1 / C) E[s] $

转换为框图形式，即有

#figure(
  sys-block(
    transfer: text($frac(s, L s^2 + R s + 1\/C)$, size: 1.2em),
    input: $E(s)$,
    output: $I(s)$,
    height: 2.5em,
  ),
  caption: "框图",
)

中间的函数即为传递函数。

== 串行系统

#figure(
  image("images/liquid.drawio.png", width: 40%),
  caption: "流体系统",
)

由上图

$ dv(h, t) + frac(g, R A) h = q_(i n) / A $

令$A = 1$，$x = h$，$u = q_(i n)$，得

$ x ̇(t) + g / R x(t) = u(t) $

两端做 Laplace 变换，得

$
  s X(s) + g / R X(s) = U(s), quad x(0) = 0
$

从而有，开环传递函数$G(s)$

$
  G(s) = frac(X(s), U(s)) = frac(1, s + g \/ R)
$

当$u(t) = C$，则

$ lim_(t → ∞) h = C R / g $

对闭环系统，此时引入参考值$V(s)$，输入值变成了$X(s) H(s)$

#figure(
  sys-block2(
    transfer: $D(s)G(s)$,
    transfer2: $H(s)$,
    input: $V(s)-X(s)H(s)$,
    output: $X(s)$,
    output2: $X(s)H(s)$,
    reference: $V(s)$,
  ),
  caption: "闭环系统",
)

若两个传递函数$D(s)$和$G(s)$级联，则组合的传递函数就是它们的乘法，即$D(s)G(s)$，则

$ (V - X H)(D G) = X $

#tip[
  对线性系统，序列可以颠倒，即，$D(s)G(s) = G(s)D(s)$，从而有

  $
    log(D ∗ G) = log(D) + log(G)
  $
]

得，闭环传递函数

$ X = V frac(D G, 1 + H D G) $

于是可知

#figure(
  sys-block(transfer: $frac(D G, 1 + H D G)$, input: $V$, output: $X$),
  caption: "框图",
)

== 非零初始条件

对一阶方程

$ x ̇(t) + a x(t) = u(t) $

当$x(0) = 0$时，有

$ G(s) = frac(X(s), U(s)) = frac(1, s + a) $

当$x(0) ≠ 0$时，有

$
  G(s) = frac(X(s), U(s) + x(0)) = frac(1, s + a)
$

对 LTI 系统，根据叠加原理，$x(0)$为另一输入，令其为$U_2(s)$，有

$ ℒ^(-1)[U_2(s)] = ℒ^(-1)[x(0)] $

即

$ U_2(t) = x(0) δ(t) $

其中，$δ(t)$为单位冲击，$x(0)$为冲击幅度。
