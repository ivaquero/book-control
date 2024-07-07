#import "lib/sci-book.typ": *
#show: doc => conf(
  title: "时域响应分析",
  author: ("ivaquero"),
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= 一阶系统
<一阶系统>

== 单位阶跃响应

对一阶系统，其传递函数的形式通常为

$ G(s) = frac(a, s + a) $

若输入为

$ u(t) = cases(delim: "{", 0 & t = 0, 1 & t > 0) $

则

$
  ℒ[u(t)] &= ∫_0^(+∞) 1⋅e^(-s t) dd(t)\
  &= -1 / s e^(-s t) bar.v_0^∞ = 1 / s
$

于是

$ X(s) = U(s) G(s) = 1 / s frac(a, s + a) = 1 / s - frac(1, s + a) $

对等式两端同时进行 Laplace 逆变换，得

$ x(t) = 1 - e^(-a t) $

当$t = τ = 1/a$

$ x(τ) = x(1 / a) = 1 - e^(-1) = 0.63 $

此处

- $τ$：#strong[时间常数（time constant）]，反映系统响应速度。
- $T_("ss")$：#strong[稳定时间（settlingtime）]，通常定义为$4τ$，即

$ x(t_(s s)) = x(4 / a) = 1 - e^(-4) = 0.98 $

对于如下系统

#figure(
  image("./images/model/liquid.drawio.png", width: 40%),
  caption: [liquid],
  supplement: "图",
)

$ x(t) = frac(C R, g)(1 - e^(-g / R t)) $

则其传递函数

$ G(s) = frac(1, s + g/R) $

可得

$ τ = frac(1, g/R) = R / g $

#tip[
  上述流体系统的传递函数$frac(a, s + a)$是一个典型的低通滤波，其特点之一是数值积累，又如积分运算。
]

又

$ ℒ[u(t)] = ℒ[C e^0] = C frac(1, s + 0) = C 1 / s $

从而有

$
  X(s) &= U(s) G(s)\
  &= C 1 / s frac(1, s + g/R)\
  &= frac(C R, g)(frac(1, s - 0) - frac(1, s + g/R))
$

最终得

$
  x(t) = ℒ^(-1)(X(s))
  &= frac(C R, g)(e^(o t) - e^(-g / R t))\
  &= frac(C R, g)(1 - e^(-g / R t))
$

即得到极点。

== 相图视角
<相图视角>

对 LTI 系统

$ dot(x) + a x = a u, med x(0) = dot(x)(0) = 0 $

若$u = 1$

$ dot(x) = a(1 - x) $

通过分析$x ̇$-$x$的图像，可以得出$x$的变化趋势。

#pagebreak()

= 二阶系统
<二阶系统>

== 弹簧阻尼系统
<弹簧阻尼系统>

#figure(
  image("./images/model/vibration.drawio.png", width: 40%),
  caption: [vibration],
  supplement: "图",
)

对弹簧阻尼系统

$m dot.double(x) = F - k x - B dot(x)$

整理得

$ dot.double(x) + B / m dot(x) + k / m x = F $

这里定义

- $ω_n = sqrt(k/m)$：固有频率
- $ζ = frac(B, 2 sqrt(k m))$：阻尼比

设初始时刻没有外力，即初始条件为

- $x_((0)) = 5$
- $dot(x)_((0)) = 0$

代入原方程，得

$ dot.double(x) + 2 ζ ω_n dot(x) + ω_n^2 x = 0 $

即

$ dot.double(x) = -2 ζ ω_n dot(x)- ω_n^2 x $

对微分方程，其解的形式为$x(t) = e^(λ t)$，于是可知

- $dot(x) = λ e^(λ t)$
- $dot.double(x) = λ^2 e^(λ t)$

回代入上述方程，得

$ (λ^2 + 2 ζ ω_n λ + ω_n^2) e^(λ t) = 0 $

显然，由于$e^(λ t) ≠ 0$，第一个因式

$ λ^2 + 2 ζ ω_n λ + ω_n^2 = 0 $

此式即为特征方程。

解之，得

$
  λ_1 &= -ξ ω_n + w_n sqrt(xi^2 - 1)\
  λ_2 &= -ξ ω_n - ω_n sqrt(xi^2 - 1)
$

== 动态响应
<动态响应>

对特征方程

- 当$ζ > 1$，此时系统处于过阻尼状态（over damped），即阻尼力很大，该极点为#strong[稳定节点]。

此时有解

$ x(t) = C_1 e^(λ_1 t) + C_2 e^(λ_2 t) $

#tip[
  解收敛，且收敛速度取决于$λ_1$。
]

- 当$ζ = 1$，此时系统处于临界状态，$λ_1 = λ_2 = ω_n$

此时有解

$ x(t) = (C_1 + C_2 t) e^(λ t) $

- 当$0 < ζ < 1$，此时系统处于欠阻尼状态（under damped），该节点为#strong[稳定焦点]。

此时有解

$ x(t) = e^(-ζ ω_n t)(C_1 cos ω_n sqrt(1 - ζ^2)t + C_2 sin ω_n sqrt(1 - ζ^2)t) $

令$ω_d = ω_n sqrt(1 - ζ^2)$，称阻尼固有频率（damped natural frequency），可得

$ x(t) = e^(-ζ ω_n t) sqrt(c_1 + c_2)(sin(ω_dd(t) + ϕ)) $

其中，$ϕ = arctan c_1/c_2$。

此时，系统振幅在震动中衰减，且震动周期为$2π/ω_d$。

#tip[
  欠阻尼是日常生活中最常见的状态
]

- 当$ζ = 0$，此时系统处于无阻尼状态，该极点为#strong[中心点]。

此时有解，图像为正弦函数，周期为$2π/ω_n$

$
  x_((t)) &= e^0 (c_1 cos ω_n t + c_2 sin ω_n t)\
  &= sqrt(c_1 + c_2) sin(ω_n t + ϕ)
$

- 当$-1 < ζ < 0$或$ζ < - 1$，得到的解是发散的，图像与各自取符号后的图像趋势相反。

== 极点与零点
<极点与零点>

对上述弹簧阻尼系统，定义输入为

$ u(t) = F / ω_n^2 $

#tip[
  即单位化的外力
]

输出为位移$x(t)$，从而有

$ dot.double(x) + 2 ζ ω_n dot(x) + ω_n^2 x = ω_n^2 u(t) $

两端同时 Laplace 变换，得

$ H(s) = frac(X(s), U(s)) = frac(ω_n^2, s^2 + 2 ζ ω_n s + ω_n^2) $

从而有

$ X(s) = 1 / s frac(ω_n^2, s^2 + 2 ζ ω_n s + ω_n^2) $

因子之一即特征方程

$ s^2 + 2 ζ ω_n s + ω_n^2 = 0 $

可以找到极值点

- $P_1 = 0$
- $P_2 = -ζ ω_n + i ω_n sqrt(1 - ζ^2)$
- $P_3 = -ζ ω_n - i ω_n sqrt(1 - ζ^2)$

于是

$
  X(s)
  &= frac(A, s - p_1) + frac(B, s - p_2) + frac(C, s - p_3)\
  &= frac(A (s - p_2)(s - p_3) + B (s - p_1)(s - p_3) + C (s - p_1)(s - p_2), (s - p_1)(s - p_2)(s - p_s))
$

已知

$ A (s - p_2)(s - p_3) + B (s - p_1)(s - p_3) + C (s - p_1)(s - p_2) = ω_n^2 $

- 令$s = P_1$，得$A = 1$
- 令$s = P_2$，得

$ B = -1 / 2 (1 - ζ / sqrt(1 - ζ^2) i) $

- 令$s = P_3$，得

$ C = -1 / 2 (1 + ζ / sqrt(1 - ζ^2) i) $

代回原方程

$ x(t) = 1 - e^(-ζ ω_n t) sqrt(frac(1, 1 - ζ^2)) sin(ω_dd(t) + ϕ) $

其中

- 正弦函数$sin(ω_dd(t) + ϕ)$的频率为$w_d$（周期为$2π/w_d$）
- $e^(-ζ ω_n t)$是一个衰减（单调递减）函数

= 性能分析
<性能分析>

== 指标
<指标>

- $T_d$：延迟时间（delay time），系统达到稳态 50% 的时间
- $T_r$：上升时间（rise time），系统首次达到稳定点的时间，即正弦函数首次为$0$的时间，此时

$ T_r = frac(π - ϕ, ω_d) $

- $M_p$：最大超调量（max overshot），峰值与稳态值的差值与稳定值的百分比，即

$ M_p = e^(-ζ π / sqrt(1 - ζ^2)) × 100% $

- $T_(s s)$：调节时间（settling time）：系统进入稳态范围内的时间，稳态范围通常选择稳定值的$±2%$或$±5%$，即

- $2%$：$T_(s s) = frac(4, ζ ω_n)$

- $5%$：$T_(s s) = frac(3, ζ ω_n)$

== 比较
<比较>

- $T_r$：反映系统的响应速度，越短越好
- $M_p$：反映系统的稳定性，越小越好
- $T_(s s)$：越短越好

给定以上指标比重

- 列表，计算总得分
- 在`x-y-z`坐标系中，描点连线，计算面积
