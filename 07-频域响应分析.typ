#import "@local/scibook:0.1.0": *
#show: doc => conf(
  title: "频域响应分析",
  author: "ivaquero",
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= 一阶系统
<一阶系统>

== LTI 系统
<lti-系统>

对 LTI 系统，已知输入和输出

$
  & M_i sin(ω_i t + ϕ_i)\
  & M_o sin(ω_i t + ϕ_o)
$

其中，$M_i$和$M_o$为输入和输出振福，$ϕ_i$和$ϕ_o$为输入和输出相位。

#tip[
  对 LTI 系统，输入为正弦函数，输出必为正弦函数
]

- 振幅响应（magitude response）

$ M = frac(M_o, M_i) $

- 幅角响应（phase response）

$ ϕ = ϕ_0 - ϕ_i $

== 正弦波

对一个正弦波

$
  u(t) &= A sin(ω_i t) + B cos(ω_i t) \
  &= sqrt(A^2 + B^2)(frac(A, sqrt(A^2 + B^2)) sin(ω_i t) + frac(B, sqrt(A^2 + B^2)) cos(ω_i t))
$

令$cos(ϕ_i) = frac(A, sqrt(A^2 + B^2))$，$sin(ϕ_i) = frac(B, sqrt(A^2 + B^2))$，得

$
  u(t) &= sqrt(A^2 + B^2)(cos(ϕ_i) sin(ω_i t) + sin(ϕ_i) cos(ω_i t)) \
  &= M_i sin(ω_i t + ϕ_i)
$

对系统

$ X(s) = U(s)G(s) $

有

$
  U(s) = ℒ[μ(t)] &= frac(A ω_i, s^2  + ω^2) + frac(B s, s^2  + ω^2) \
  &= frac(A ω_i + B s, (s + j ω_i)(s - j ω_i))
$

且

$ G(s) = frac(D(s), N(s)) = frac(D(s), ∏_(i=1)^n (s - p_i)) $

其中，$p_i$为$G(s)$的极值点。于是

$
  X(s) = U(s)G(s)
  &= frac(k_1, s + j ω) + frac(k_2, s - j ω) + ∑_(i=1)^n frac(c_i, s - p_i) \
  &= frac((A ω_i + B s)D(s), (s + j ω_i)(s - j ω_i) ∏_(i=1)^n (s - p_i))
$

易得

$
  x(t) = ℒ^(-1)[X(s)] = k_1 e^(-j ω_i t) + k_2 e^(j ω_i t) + ∑_(i=1)^n c_i e^(p_i t)
$

对于稳定系统，$p_i$的实部小于 0，此时稳态

$ X_(s s)(t) = k_1 e^(-j ω_i t) + k_2 e^(j ω_i t) $

> 频域响应，实质上是稳态响应。

== 求解稳态

由上面的式子

$
  k_1(s - j ω_i) N(s) + k_2(s + j ω_i) N(s) + ∑_(i=1)^n c_i(s + j ω_i) = (A ω_i + B s) D(s)
$
- 令$s = -j ω$，得

$ k_1(-j ω - j ω_i) N(-j ω_i) + ∑_(i=1)^n 0 = (A ω_i - B j ω_i) D(-j ω_i) $
$
  k_1 = frac(A ω_i - B j ω_i,  - 2j ω) frac(D(-j ω_i), N(-j ω_i)) = frac(B + A j, 2) G(-j ω_i)
$
- 令$s = j ω$，得

$ k_2 = frac(B - A j, 2) G(j ω_i) $

其中，$G(j ω_i) = |G(j ω_i)|e^(j∠G(j ω_i))$。

#tip[
  $s = j ω_i$时，Laplace 变换即为 Fourier 变换。实信号函数的 Fourier 变换属于 Hermite 函数，符合共轭对称。
]

使用复数的极坐标形式，可得

$
  X_(s s)(t)
  &= frac(B + A j, 2) |G(j ω_i)| e^(-j ϕ_G) e^(-j ω_i t) + frac(B - A j, 2) |G(j ω_i)| e^(j ϕ_G) e^(j ω_i t)\
  &= 1 / 2 |G(j ω_i)| [(B + A j) e^(-(ϕ_G + ω_i t)) j + (B - A j) e^((ϕ_G + ω_i t)) j]
$

通过 Euler 公式，化简得

$
  X_(s s)(t)
  &= 1 / 2 |G(j ω_i)| (2 B cos(ϕ_G + ω_i t)) + 2 A sin(ϕ_G + ω_i t)\
  &= |G(j ω_i)| sqrt(A^2 + B^2)(B / sqrt(A^2 + B^2) cos(ϕ_G + ω_i t)) + A / sqrt(A^2 + B^2) sin(ϕ_G + ω_i t)\
  &= |G(j ω_i)| M_i sin(ω_i t + ϕ_i + ϕ_G)\
  &= M_G M_i sin(ω_i t + ϕ_i + ϕ_G)
$

= 低通滤波
<低通滤波>

== 积分滤波
<积分滤波>

积分的 Laplace 的变换为$G(s) = 1/s$，

$ G(j ω_i) = frac(1, j ω_i) = -1 / ω_i j $

其幅角为$pi/2$，其长度

$ |G(j ω_i)| = 1 / ω_i $

显然，频率$ω$越高时，其振幅响应越低。即积分是一个低通滤波，高频信号通过它时，会大幅衰减。

#tip[
  容器系统（如容积、电容）的积分是一个低通滤波，高频信号通过它时，会大幅衰减。这带来了容器系统的两个重要特性缓冲和延迟。
]

== 一阶系统

对一阶系统

$ G(s) = frac(a, s + a) $

令$s = j ω$，得

$
  G(j ω_i)
  &= frac(a, a + j ω) = frac(a(a - j ω_i), (a + j ω_i)(a - j ω_i)) \
  &= frac(a^2, a^2 + ω^2) + (-frac(a ω, a^2 + ω^2))j
$

$G(j ω_i)$的模为

$
  |G(j ω_i)| &= sqrt((frac(a^2, a^2 + ω^2))^2 + (frac(a ω, a^2 + ω^2))^2) \
  &= sqrt(frac(1, 1 + (frac(w, a)^2)))
$

于是

- 当$ω ≪ a$，$|G(j ω_i)| → 1$
- 当$ω ≫ a$，$|G(j ω_i)| → 0$
- 当$ω = a$，$|G(j ω_i)| = sqrt(1/2) = 0.707$
\

$a$被称为截止频率。

$
  ϕ_G = arctan (-frac(a ω, a^2)) = -arctan frac(ω, a)
$

#tip[
  显然，一阶系统
  $ G(s) = frac(s, s + a) $

  是一个高通滤波。其$G(j ω_i)$的模为
  $ sqrt(frac(1, 1 + (frac(a, ω)^2))) $
]

= 二阶系统
<二阶系统>

== 共振响应
<共振响应>

对弹簧阻尼系统

$ G(s) = frac(X(s), U(s)) = frac(ω_n^2, s^2 + 2 ζ ω_n s + ω_n^2) $

其中

- $ω_n = sqrt(k/m)$：固有频率
- $ζ = frac(B, 2 sqrt(k m))$：阻尼比

令$s = j ω$，得

$
  G(j ω_i) &= frac(ω_n^2, - ω^2 + 2 ζ ω_n ω_j + ω_n^2)\
  &= frac(1, - ω^2/ω_n^2 + 2 ζ ω/ω_n j + 1)
$

令输入频率$Ω = ω/ω_n$，则

$
  G(j ω_i) &= frac(1, -Ω^2 + 2 ζ Ω j + 1)\
  &= frac(1 - Ω^2 - 2 ζ Ω j, (1 - Ω^2 + 2 ζ Ω j))(1 - Ω^2 - 2 ζ Ω j)\
  &= frac(1 - Ω^2, (1 - Ω^2))^2 + 4 ζ^2 Ω^2 - frac(2 ζ Ω, (1 - Ω^2))^2 + 4 ζ^2 Ω^2 j
$

于是

$
  |G(j ω_i)| &= sqrt(("Re"(G(j ω_i))))^2 + "Im"(G(j ω_i))^2\
  &= sqrt(frac(1, (1 - Ω^2))^2 + 4 ζ^2 Ω^2)
$

- 当$Ω = 0$，则$ω = 0$，有$|G(j ω_i)| = 1$
- 当$Ω → +∞$，则$ω ≫ ω_n$，有$|G(j ω_i)| → 0$
- 当$Ω = 1$，则$ω = ω_n$，有$|G(j ω_i)| = 1/2 ζ$
  - 当$ζ < 0.5$，则$|G(j ω_i)| > 1$
  - 当$ζ > 0.5$，则$|G(j ω_i)| < 1$
\

由上面的讨论，在$0$和$+∞$之间，存在着一个极值点

令

$ f(Ω) = (1 - Ω^2)^2 + 4 ζ^2 Ω^2 $

则$f^′(Ω) = 0$时

$ 2(1 - Ω^2)(-2 Ω) + 8 ζ^2 Ω^2 = 0 $

于是，当$Ω = sqrt(1 - 2 ζ^2) > 0$，存在极值，此时

$ ω_r = ω_n sqrt(1 - 2 ζ^2) $

称为共振频率（resonance frequency）。

#tip[
  显然，当$ζ → 0$，共振频率将接近固有频率。
]

== 共振响应的模
<共振响应的模>

$ |G(j ω_i)|_(ω = ω_n sqrt(1 - 2 ζ^2)) = frac(1, 2 ζ sqrt(1 - ζ^2)) $

- 当$ζ = 1$
  - 若$ω = ω_n$，有$|G(j ω_i)| = 1/2$
- 当$ζ = 1/2$
  - 若$ω = ω_n$，有$|G(j ω_i)| = 1$
  - 若$ω = ω_r$，有$|G(j ω_i)| = 1.16$
- 当$ζ = 0$
  - $ω_r = ω_n$，有$|G(j ω_i)| → +∞$

= Bode 图
<bode-图>

== 由来
<由来>

对 LTI 系统的振幅响应和幅角响应绘图，得到

- $20 lg M$-$ω$图，单位$"dB"$-$r a d/s$
- $ϕ$-$ω$图，单位$deg$-$r a d/s$

#tip[
  分贝（decibel），意为十分之一贝尔（Alexander Bell），最初用于度量电话/电报的噪声损失，定义为
  $ "dB" = 10 lg P_M / P_R $

  其中，$P_M$为测量功率，$P_R$为参考功率。
]

已知，功率是振幅平方的函数，即

$ P = f(M^2) $

此时

$ "dB" = 10 lg P_M / P_R = 10 lg (M_0 / M_i)^2 = 20 lg M $

这就是 Bode 图纵坐标的由来。

== 常见案例
<常见案例>

#block(
  height: 6em,
  columns()[
    - 对$G(s) = 1/s$
      - $|G(j ω_i)| = 1 / ω$
      - $20 lg |G(j ω_i)| = -20 lg ω$
      - $∠G(j ω_i) = π / 2$
    - 对$G(s) = a/(a + s)$
      - $|G(j ω_i)| = sqrt(frac(1, 1 + (ω/a)^2))$],
)


#figure(
  table(
    columns: 5,
    align: center + horizon,
    inset: 4pt,
    stroke: frame(rgb("000")),
    [], [$ω?a$], [$|G(j ω_i)|$], [$20|G(j ω_i)|$], [$∠G(j ω_i)$],
    [低频], [≪], [$1$], [$0$], [$0$],
    [截止频率], [=], [$sqrt(1\/2)$], [$-3$], [$-π\/4$],
    [高频], [≫], [$1\/ω$], [$-20 lg ω$], [$-π\/2$],
  ),
  caption: [频域分析],
  supplement: "表",
  kind: table,
)

== 绘制
<绘制>

Euler 公式，有

$ G(j ω_i) = r e^(j θ) $

其中，$r = |G(j ω_i)|$，$θ = ∠G(j ω_i)$。由

$
  G(j ω_i) = G_1(j ω_i)⋅G_2(j ω_i) = r_1 e^(j θ_1)⋅r_2 e^(j θ_2) = r_1 r_2 e^(j (θ_1 + θ_2))
$

可知 Bode 图纵坐标可以通过对数的性质，将复合函数的振幅响应和幅角响应拆分成多个常见函数叠加组合的形式，即

$ 20 lg |G(j ω_i)| = 20 lg |G_1(j ω_i)| + 20 lg |G_2(j ω_i)| $


= Nyquist 稳定性

== 定义

对如下系统

#figure(
  image("images/block/sensor.drawio.png", width: 40%),
  caption: "传感器",
  supplement: "图",
)

- 开环传递函数：$G(s)H(s)$
- 闭环传递函数：$G(s)/(1+G(s)H(s))$

令

- $G(s) = N_G(s) / D_G(s)$
- $H(s) = N_H(s) / D_H(s)$

可得

$
  G(s)H(s) = frac(N_G N_H, D_G D_H) \
  1 + G(s)H(s) = frac(D_G D_H + N_G N_H, D_G D_H)\
  frac(G(s), 1 + G(s)H(s)) = frac(N_G D_H, D_G D_H + N_G N_H)
$

不难得到

- 开环传递函数的极点 = 媒介函数的极点
- 闭环传递函数的极点 = 媒介函数的零点

若有映射$F(s) = 1 + G(s)H(s)$，将平面$A$中的闭合曲线，映射到平面$B$中，则对新的闭合曲线逆时针绕原点的圈数$N$有

$ N = P - Z $

其中

- $P$为 Nyquist 闭合区内，$F(s)$的极点（开环传递函数的极点）个数
- $Z$为 Nyquist 闭合区内，$F(s)$的零点（闭环传递函数的极点）个数

#tip[
  Nyquist 闭合区：复平面的右半平面
]

变换映射函数为$F(s) - 1 = G(s)H(s)$，闭合曲线$B$将整体左移，中心点变为$(-1, 0)$，绘制出的图形称为 Nyquist Plot。

#theorem("Nyquist 稳定性")[
  若系统稳定，则其闭环传递函数在 Nyquist 闭合区没有极点，即
  $ P = N $
]

#tip[
  现实生活中，传递函数均为真分数，即分母≥分子。
]

== 裕度分析

由于$G(j ω)$和$G(-j ω)$共轭，其模相等，角度互为相反数，故其映射关于实轴对称。此时，分析只需绘制正虚轴部分。

=== 幅值裕度

幅值裕度（gain magin）表示开环增益$K$在系统变得不稳定前，还能增加的比例。

=== 相位裕度

相位裕度（phase magin）表示相位角在系统变得不稳定前，还能延迟的比例。
