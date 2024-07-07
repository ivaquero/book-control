#import "lib/sci-book.typ": *
#show: doc => conf(
  title: "线性控制器",
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

令$λ_i$为$𝑨$的特征值，有

- 若 Lyapunov 稳定，则$λ_i$只有非正的实部
- 若渐近稳定，则$λ_i$只有负的实部

#tip[
  简单说，$λ_i$决定收敛速度，若$∃ λ_i > 0$，则系统不稳定。
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

= LQR 控制器
<lqr-控制器>

== 基本设计
<基本设计>

控制器的作用

- 稳定系统
- 调整平衡点

对闭环 LTI 系统

$ dot(𝒙) = 𝑨_(c l) 𝒙 $

- 若$λ$为虚数，则
  - 必有共轭
  - $b i$必引入振动 对$𝒖$考虑，则需要引入最优化控制，其损失函数为

$ J = ∫_0^∞ (𝒙^(⊤) 𝑸 𝒙 + 𝒖^(⊤) 𝑹 𝒖) dd(t) $

该式也被称为 LQR（linear-quadratic-regulator）。其中

- $𝒙^(⊤) 𝑸 𝒙 > 0$，类似惩罚项
- $𝒖^(⊤) 𝑹 𝒖$中，$𝑹$越大，$𝒖$的影响越大

== 轨迹跟踪
<轨迹跟踪>

对系统

$ ϕ^(̈) - g / L ϕ + 1 / L δ^′ = 0 $

令

- $x_1 = ϕ$
- $x_2 = dot(ϕ)$
- $u = 1 / L δ^(̈)$

可得

$
  mat(delim: "[", dot(x)_1; dot(x)_2) = mat(delim: "[", 0, 1; g/L, 0) mat(delim: "[", x_1; x_2) + mat(delim: "[", 0; - 1) u
$

又令

$ u = -mat(delim: "[", k_1, k_2) mat(delim: "[", x_1; x_2) $

其开环平衡点

$
  dot(x)_1 = 0 ⇒ x_2 = 0\
  dot(x)_2 = 0 ⇒ x_1 = 0
$

故当$t → ∞$，$x_1, x_2 → 0$。

设目标值$x_(1 d) = 5$，则误差为$e = x_(1 d) - x_1$，于是有

$ dot(e) = dot(x)_(1 d) - dot(x)_1 = -dot(x)_1 = x_2 $

又

$ dot(x)_2 = g / L x_1 - u = g / L (x_(1 d) - e) - u $

即

$
  mat(delim: "[", e ̇; dot(x)_2) =
  mat(delim: "[", 0, - 1; - g/L, 0)
  mat(delim: "[", e; x_2) +
  mat(delim: "[", 0; - 1) u +
  mat(delim: "[", 0; g/L x_(1 d))
$

其开环平衡点

$
  & dot(e) = 0 ⇒ x_(2 f) = 0\
  & dot(x)_2 = 0 ⇒ e_f = x_1 d
$

为改变平衡点，令$u = -mat(delim: "[", k_1, k_2) mat(delim: "[", e_(x_2); x_2) + e_f$，代入，得

$
  mat(delim: "[", e ̇; dot(x)_2) = mat(delim: "[", 0, - 1; - g/L + k_1, k_2) mat(delim: "[", e; x_2)
$

此时

- $e_f = 0$
- $x_(2 f) = 0$

设计$k_1, k_2$，令$"Re"("eig"(A_("cl"))) < 0$，于是由特征行列式为$0$，得

$
  mat(delim: "[", λ, 1; g/L - k_1, λ - k_2)
  &= λ^2 - k_2 λ - g / L + k_1\
  &= λ^2 + 2 λ + 1
$

得

- $k_1 = 1 + g / L$
- $k_2 = -2$

代入$u$的表达式，得

$ u = -x_d + (1 + g / L) x_1 + 2 x_2 $
