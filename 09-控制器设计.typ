#import "lib/lib.typ": *
#show: chapter-style.with(
  title: "控制器设计",
  info: info,
)

= 基本要求
<基本要求>

== 可控性
<可控性>

对闭环 LTI 系统（离散型）

$ 𝒙_(k + 1) = 𝑨 𝒙_k + 𝑩 𝒖_k $

可得

$
  𝒙_n = mat(delim: "[", 𝑩, 𝑨 𝑩, ⋯, 𝑨^(n-1) 𝑩)
  mat(delim: "[", u_(n-1); u_(n - 2); ⋮; u_0) = 𝑪 𝒐⋅𝒖
$

#theorem(title: "可控性（controbility）")[
  可控的充要条件是，控制矩阵$𝑪 𝒐$满秩。
]

#tip[
  可控指点对点的可控。
]

== 稳定性

对开环 LTI 系统

$ dot(𝒙) = 𝑨 𝒙 $

令$λ = a + b i$为$𝑨$的特征值，有

- 若 Lyapunov 稳定，则$a≤0, b=0$
- 若渐近稳定，则$a < 0, b=0$
- 若$b≠0$则
  - 必有共轭
  - $b i$必引入振动

#tip[
  简单说，$λ$决定收敛速度，若$∃ λ > 0$，则系统不稳定。
]

#theorem(title: "Lyapunov 稳定性")[
  原点（起始点）稳定，当且仅当
  $ ∀t_0, ∀ɛ > 0, ∃δ(t_0, ɛ): |x(t_0)| < δ(t_0, ɛ) ⇒ ∀t ≥ t_0 med |x(t)| < ɛ $
]

#theorem(title: "渐近稳定性")[
  原点（起始点）渐近稳定，当且仅当其是一个稳定平衡点，同时
  $ ∃ δ(t_0) > 0: quad norm(x(t_0)) < δ(t_0) ⇒ lim_(t → ∞) norm(x(t)) = 0 $
]

对闭环 LTI 系统

$ dot(𝒙) = 𝑨 𝒙 + 𝑩 𝒖 $

若$𝒖 = -k 𝒙$，则

$ dot(𝒙) = (𝑨 - 𝑩 k)𝒙 = 𝑨_("cl") 𝒙 $

此时，可通过调整$k$来调整$𝑨_("cl")$的特征值，从而控制系统的稳定性。

对传递函数

$ G(s) = frac(N(s), D(s)) = frac(∑_(i=1)^m (s - z_i), ∑_(j=1)^n (s - p_j)) $

- $N(s) = 0$时，$s_1 = z_1, z_2 = z_2, …$，称零点（zeros）
- $D(s) = 0$时，$s_1 = p_1, s_2 = p_2, …$，称极点（poles）

#tip[
  BIBO 问题：输入有界（bounded input），则输出有界（bounded output）。
]

设

- $N(s) = 1$
- $D(s) = (s - p_1)(s - p_2)$

则输出

$
  X(s) = 1⋅G(s) = frac(C_1, (s - p_1)) + frac(C_2, (s - p_2)) \
  ⇓ \
  X(t) = ℒ^(-1)[X(s)] = C_1e^(p_1t) + C_2e^(p_2t)
$

对极点在复平面绘图，有如下结论

#figure(
  image("images/model/signal-poles-zeros.png", width: 60%),
  caption: "复平面的极点",
)

== 抽样要求

- 服从 Nyquist-Shannon 抽样定理
- (读取 + 计算 + 输出) 的总耗时 < 1 个周期

#theorem(title: "Nyquist-Shannon 抽样定理")[
  抽样有效性（重建原信号）需满足
  抽样频率 ≥ 被采信号最高频率 × 2
]

#tip[
  实际使用中，会选取 5～10 倍的频率进行抽样
]

对离散信号，通常使用保持器（hold）来保证其信号连续性

- 零阶保持：使输入在一个周期内不变

= 基于频率响应

如下闭环控制系统，其中

#block(
  height: 3em,
  columns(3)[
    - $R(s)$：参考信号
    - $C(s)$：控制器
    - $G(s)$：系统传递函数
    - $D(s)$：扰动函数
    - $N(s)$：噪声函数
    - $X(s)$：输出
  ],
)

#figure(
  image("images/block/design-freq.drawio.png", width: 40%),
  caption: "带有扰动和噪声的闭环控制系统",
)

可得

$
  [R(s) -(X(s) + N(s))] C(s) G(s) + D(s) &= X(s)
$

整理得

$
  underbrace(frac(C(s) G(s), 1 + C(s) G(s)), T(s)) (R(s) - N(s)) + underbrace(frac(1, 1 + C(s) G(s)), S(s)) D(s) = X(s)
$

这里，$S(s)$称灵敏度传递函数，$T(s)$称补偿灵敏度传递函数。

假设参考输入频率为$ω_R$，振幅为$M_R$；噪声频率为$ω_N$，振幅为$M_N$，扰动频率为$ω_D$，振幅为$M_D$，可得3个输入值

$
  T(s) R(s) = |T(j ω_R)| M_R \
  T(s) D(s) = |T(j ω_N)| M_N \
  S(s) D(s) = |S(j ω_D)| M_D
$

我们的目标为使上述3个输出值分别趋近于，$M_R$、$0$、$0$，于是有

$
  M_X = M_R
$

此时，3个振幅响应值如下

$
  |T(j ω_R)| = 1 \
  |T(j ω_N)| = 0 \
  |S(j ω_D)| = 0
$

实际使用中，$ω_R$往往为低频常数，而来自传感器的$ω_N$往往为高频常数。此时，将$T(s)$设计为一个低通滤波器，即可解决噪声问题。对于扰动，需要做如下考虑。

由

$ T(s) = frac(C(s) G(s), 1 + C(s) G(s)) $

又假设$C(s) G(s) = a + b j$，可知

$
  |T(j ω)| = frac(sqrt(a^2 + b^2), sqrt((1 + a)^2 + b^2)) ≤ 1
$

由灵敏度传递函数

$
  S(j ω) = frac(1, 1 + C(s) G(s)) = frac(1, 1 + a + b j)
$

其振幅响应为

$
  |S(j ω)| = frac(1, sqrt((1 + a)^2 + b^2)) ≤ 1
$

显然，$|T(j ω)|^2 + |S(j ω)|^2 ≈ 1$，即两者此消彼长。又因在实际使用中，$ω_D$往往也较小，此时需要设计$S(s)$为高通滤波器。也就是说，需要设计$C(s) G(s)$，使其在低频区幅度响应大，在高频区幅度响应小。
