#import "lib/lib.typ": *
#show: chapter-style.with(
  title: "时域响应分析",
  info: info,
)

= 矩阵指数函数

== 推导

对独立方程组

$
  dot(x)_1(t) &= x_1(t)\
  dot(x)_2(t) &= -2 x_2(t)
$

即

$
  dot(x)_1(t) &= x_1 (0) e^t\
  dot(x)_2(t) &= x_2 (0) e^(-2 t)
$

矩阵形式为

$ dv(𝒙, t) = 𝑨 𝒙 $

其中，$𝒙 = mat(delim: "[", x_1; x_2)$。

对耦合方程组

$
  dot(x)_1(t) &= x_1(t) + x_2(t)\
  dot(x)_2(t) &= 4 x_1(t) - 2 x_2(t)
$

矩阵形式中，$𝒙(t) = e^(𝑨 t) 𝒙(0)$。

由 Taylor 级数

$ e^(𝑨 t) = ∑_(i = 0) frac(1, i!)(𝑨 t)^i $

于是

$ dv(e^(𝑨 t), t) = ∑_(i=1) frac(1, (i - 1))! 𝑨^i t^(i - 1) = 𝑨 e^(𝑨 t) $

而$e^(𝑨 t)$被称为矩阵$𝑨$的指数函数。

== 性质

设有矩阵指数函数$e^(𝑨 t)$，则

- 当$𝑨 = 𝟎$，$e^(𝑨 t) = 𝑰$
- 当$𝑨 = 𝚲$，$e^(𝑨 t) = dmat(delim: "[", e^(λ_1 t), e^(λ_t t), ⋱, e^(λ_n t))$
- $e^(𝑨 t) = 𝑷 e^(𝜦 t) 𝑷^(-1)$

对状态空间方程

$ dv(𝒙(t), t) = 𝑨 𝒙(t) + 𝑩 𝒖(t) $

其中，$𝒖(t)$为系统输入。两端同时乘以$e^(𝑨 t)$，得

$
  e^(-𝑨 t) 𝑩 𝒖(t) = e^(-𝑨 t) dv(𝒙(t), t) - 𝑨 e^(-𝑨 t) 𝒙(t)
  = dv(e^(-𝑨 t) 𝒙(t), t)
$

两端同时定积分，得

$ e^(-𝑨 τ) 𝒙(τ) bar.v_(t_0)^t = ∫_(t_0)^t e^(-𝑨 τ) 𝑩 𝒖(τ) dd(τ) $

整理，得

$ 𝒙(t) = e^(𝑨 (t - t_0)) 𝒙(t_0) + ∫_(t_0)^t e^((t - τ)) 𝑩 𝒖(τ) dd(τ) $

其中

- 第一项的$e^(𝑨 (t - t_0))$被称为状态转移矩阵（$n × n$），其变化由$𝑨$的特征值决定。
- 第二项为卷积运算

= 相平面
<相平面>

== 过渡矩阵

设$𝑷 = mat(delim: "[", 𝒗_1, 𝒗_2)$，则

#let mv = (i, j) => $v_(#(i)#(j))$

$
  𝑨 𝑷 &= mat(delim: "[", 𝑨 𝒗_1, 𝑨 𝒗_2)
  = mat(delim: "[", 𝑨 mat(delim: "[", v_(11); v_(12)), 𝑨 mat(delim: "[", v_(12); v_(22))) = xmat(delim: "[", 2, 2, #mv)
  dmat(delim: "[", λ_1, λ_2) = 𝑷
  dmat(delim: "[", λ_1, λ_2)
$

== 二维相平面
<二维相平面>

#let ma = (i, j) => $a_(#(i)#(j))$

$
  dv(, t)
  mat(delim: "[", z(t)_1; z(t)_2) = 𝑨
  mat(delim: "[", z(t)_1; z(t)_2) =
  xmat(delim: "[", 2, 2, #ma)
  mat(delim: "[", z(t)_1; z(t)_2)
$

- 实数根

#figure(
  table(
    columns: 4,
    align: center + horizon,
    inset: 4pt,
    stroke: table-three-line(rgb("000")),
    [$λ_1 λ_2$], [$λ_1 + λ_2$], [点类型], [稳定性],
    [$> 0$], [$< 0$], [node], [✓],
    [$> 0$], [$> 0$], [node], [×],
    [$< 0$], [], [saddle], [×],
  ),
  caption: "实数根",
  supplement: "表",
  kind: table,
)

- 复数根

#figure(
  table(
    columns: 3,
    align: center + horizon,
    inset: 3pt,
    stroke: table-three-line(rgb("000")),
    [$λ_i$], [点类型], [稳定性],
    [$a > 0$], [focus], [×],
    [$a < 0$], [focus], [✓],
    [$a = 0$], [center], [✓⁻],
  ),
  caption: "复数根",
  supplement: "表",
  kind: table,
)

#tip[
  ✓⁻：Lyapunov 稳定，见后续章节。
]

其中，传递函数$G(s)$可用代数函数表示

= 一阶系统
<一阶系统>

== 单位阶跃响应

对一阶系统，其传递函数的形式通常为

$ G(s) = frac(a, s + a) $

若输入为

$ u(t) = cases(delim: "{", 0 quad & t = 0, 1 & t > 0) $

则

$
  ℒ[u(t)] = ∫_0^(+∞) 1⋅e^(-s t) dd(t)
  = -1 / s e^(-s t) bar.v_0^∞ = 1 / s
$

于是

$ X(s) = U(s) G(s) = 1 / s frac(a, s + a) = 1 / s - frac(1, s + a) $

对等式两端同时进行 逆 Laplace 变换，得

$ x(t) = 1 - e^(-a t) $

当$t = τ = 1 / a$

$ x(τ) = x(1 / a) = 1 - e^(-1) = 0.63 $

此处

- $τ$：时间常数（time constant），反映系统响应速度。
- $T_("ss")$：稳定时间（settlingtime），通常定义为$4τ$，即

$ x(t_(s s)) = x(4 / a) = 1 - e^(-4) = 0.98 $

对于如下系统

#figure(
  image("images/model/liquid.drawio.png", width: 40%),
  caption: "流体系统",
)

$ x(t) = frac(C R, g)(1 - e^(-g / R t)) $

则其传递函数

$ G(s) = frac(1, s + g / R) $

可得

$ τ = frac(1, g / R) = R / g $

#tip[
  上述流体系统的传递函数$frac(a, s + a)$是一个典型的低通滤波，其特点之一是数值积累，又如积分运算。
]

又

$ ℒ[u(t)] = ℒ[C e^0] = C frac(1, s + 0) = C 1 / s $

从而有

$
  X(s) &= U(s) G(s)\
  &= C 1 / s frac(1, s + g / R)\
  &= frac(C R, g)(frac(1, s - 0) - frac(1, s + g / R))
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

= 二阶系统
<二阶系统>

== 弹簧阻尼系统
<弹簧阻尼系统>

#figure(
  image("images/model/vibration.drawio.png", width: 40%),
  caption: "振动阻尼系统",
)

对弹簧阻尼系统

$ m dot.double(x) = F - k x - B dot(x) $

整理得

$ dot.double(x) + B / m dot(x) + k / m x = F $

这里定义

- $ω_n = sqrt(k\/m)$：固有频率
- $ζ = B \/ 2 sqrt(k m)$：阻尼比

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

- 当$ζ > 1$，此时系统处于过阻尼状态（over damped），即阻尼力很大，该极点为稳定节点。此时有解

$ x(t) = C_1 e^(λ_1 t) + C_2 e^(λ_2 t) $

#tip[
  解收敛，且收敛速度取决于$λ_1$。
]

- 当$ζ = 1$，此时系统处于临界状态，$λ_1 = λ_2 = ω_n$。此时有解

$ x(t) = (C_1 + C_2 t) e^(λ t) $

- 当$0 < ζ < 1$，此时系统处于欠阻尼状态（under damped），该节点为稳定焦点。此时有解

$ x(t) = e^(-ζ ω_n t)(C_1 cos ω_n sqrt(1 - ζ^2)t + C_2 sin ω_n sqrt(1 - ζ^2)t) $

令$ω_d = ω_n sqrt(1 - ζ^2)$，称阻尼固有频率（damped natural frequency），可得

$ x(t) = e^(-ζ ω_n t) sqrt(c_1 + c_2)(sin(ω_dd(t) + ϕ)) $

其中，$ϕ = arctan c_1\/c_2$。此时，系统振幅在震动中衰减，且震动周期为$2π\/ω_d$。

#tip[
  欠阻尼是日常生活中最常见的状态
]

- 当$ζ = 0$，此时系统处于无阻尼状态，该极点为中心点。此时有解，图像为正弦函数，周期为$2π\/ω_n$

$
  x_((t)) &= e^0 (c_1 cos ω_n t + c_2 sin ω_n t)\
  &= sqrt(c_1 + c_2) sin(ω_n t + ϕ)
$

- 当$-1 < ζ < 0$或$ζ < - 1$，得到的解是发散的，图像与各自取符号后的图像趋势相反。

= 关键点分析

== 极点与零点
<极点与零点>

对上述弹簧阻尼系统，定义输入（单位化的外力）为

$ u(t) = F / ω_n^2 $

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

- 正弦函数$sin(ω_dd(t) + ϕ)$的频率为$w_d$（周期为$2π / w_d$）
- $e^(-ζ ω_n t)$是一个衰减（单调递减）函数

== 一般形式

对于 LTI 系统，输入和输出在频域中具有简单的关系：

$
  Y(s) = G(s) ∗ X(s)
$

其中，传递函数$G(s)$可用代数函数表示

$
  G(s) = frac("num"(s), "den"(s)) = frac(n_0 * s^0 + n_1 * s^1 + n_2 * s^2 + ⋯, d_0 * s^0 + d_1 * s^1 + d_2 * s^2 + ⋯)
$

换句话说，指定分子和分母系数向量，可以唯一地表征传递函数。计算工具可以使用该符号来模拟此类系统对给定输入的响应。

== 特征行列式

对弹簧阻尼系统

$ m dot.double(x) + B dot(x) + k x = f(t) $

选择状态变量，$z_1 = x$，$z_2 = x$。由此，得

$ z ̇ = 1 / m u(t) - B / m z_2 - k / m z_1 $

转化为矩阵形式

$
  dot(z) = A z + B u\
  y = C z + D u
$

对原方程两端做 Laplace 变换，得

$ m s^2 X(s) + B s X(s) + k X(s) = F(s) $

结合状态空间方程，有

$ G(s) = frac(X (s), F(s)) = frac(Y (s), U(s)) = frac(1, m s^2 + B s + k) $

对状态空间方程两端做 Laplace 变换，得

$
  Z(s) = (s 𝑰 - 𝑨)^(-1) B U(s)\
  Y(s) = C (s 𝑰 - 𝑨)^(-1) B U(s) + D U(s)
$

由此，得

$ G(s) = frac(Y(s), U(s)) = C (s 𝑰 - 𝑨)^(-1) B + D $

又

$
  s 𝑰 - 𝑨 = mat(delim: "[", s, 0; 0, s) - mat(delim: "[", 0, 1; - k / m, - B / m) = mat(delim: "[", s, - 1; k / m, s + B / m)
$

则

$
  (s 𝑰 - 𝑨)^(-1) = (s 𝑰 - 𝑨)^*|s 𝑰 - 𝑨| =
  frac(mat(delim: "[", s + B / m, 1; - k / m, s), s (s + B / m)) - (-1) k / m =
  frac(mat(delim: "[", s + B / m, 1; - k / m, s), s^2 + B / m s + k / m)
$

代入可知，空间状态方程和传递函数是统一的。其中，$G(s)$的极点，即是$G(s)$分母的根，其
- 决定系统的稳定性
- 数值上等于$𝑨$的特征值，即$|s 𝑰 - 𝑨|$的根

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

- $2%$：$T_(s s) = 4\/ζ ω_n$
- $5%$：$T_(s s) = 3\/ζ ω_n$

== 比较
<比较>

- $T_r$：反映系统的响应速度，越短越好
- $M_p$：反映系统的稳定性，越小越好
- $T_(s s)$：越短越好

给定以上指标比重

- 列表，计算总得分
- 在`x-y-z`坐标系中，描点连线，计算面积
