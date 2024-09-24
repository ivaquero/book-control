#import "lib/sci-book.typ": *
#show: doc => conf(
  title: "控制器设计",
  author: ("ivaquero"),
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
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

#theorem("可控性（controbility）")[
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

#theorem("Lyapunov 稳定性")[
  原点（起始点）稳定，当且仅当
  $ ∀t_0, ∀ɛ > 0, ∃δ(t_0, ɛ): |x(t_0)| < δ(t_0, ɛ) ⇒ ∀t ≥ t_0 med |x(t)| < ɛ $
]

#theorem("渐近稳定性")[
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
  supplement: "图",
)

== 抽样要求

- 服从 Nyquist-Shannon 抽样定理
- (读取 + 计算 + 输出) 的总耗时 < 1 个周期

#theorem("Nyquist-Shannon 抽样定理")[
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
  supplement: [图],
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
