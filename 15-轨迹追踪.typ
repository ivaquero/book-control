#import "lib/lib.typ": *
#show: qooklet.with(
  title: "轨迹追踪",
  author: "ivaquero",
  header-cap: "简明现代控制理论",
  footer-cap: "github@ivaquero",
  lang: "zh",
)

= 钟摆系统
<钟摆系统>

== 系统构成

对系统

$ dot.double(ϕ) - g / L ϕ + 1 / L dot(δ) = 0 $

令$x_1 = ϕ, x_2 = dot(ϕ), u = 1 / L dot.double(δ)$

可得

$
  mat(delim: "[", dot(x)_1; dot(x)_2) = mat(delim: "[", 0, 1; g / L, 0) mat(delim: "[", x_1; x_2) + mat(delim: "[", 0; - 1) u
$

又令

$ u = -mat(delim: "[", k_1, k_2) mat(delim: "[", x_1; x_2) $

其开环平衡点

$
  dot(x)_1 = 0 ⇒ x_2 = 0\
  dot(x)_2 = 0 ⇒ x_1 = 0
$

故当$t → ∞$，$x_1, x_2 → 0$。

== 误差函数

设目标值$x_(1 d) = 5$，则误差为$e = x_(1 d) - x_1$，于是有

$ dot(e) = dot(x)_(1 d) - dot(x)_1 = -dot(x)_1 = x_2 $

又

$ dot(x)_2 = g / L x_1 - u = g / L (x_(1 d) - e) - u $

即

$
  mat(delim: "[", e ̇; dot(x)_2) =
  mat(delim: "[", 0, - 1; - g / L, 0)
  mat(delim: "[", e; x_2) +
  mat(delim: "[", 0; - 1) u +
  mat(delim: "[", 0; g / L x_(1 d))
$

其开环平衡点

$
  & dot(e) = 0 ⇒ x_(2 f) = 0\
  & dot(x)_2 = 0 ⇒ e_f = x_1 d
$

为改变平衡点，令$u = -mat(delim: "[", k_1, k_2) mat(delim: "[", e_(x_2); x_2) + e_f$，代入，得

$
  mat(delim: "[", e ̇; dot(x)_2) = mat(delim: "[", 0, - 1; - g / L + k_1, k_2) mat(delim: "[", e; x_2)
$

此时

- $e_f = 0$
- $x_(2 f) = 0$

设计$k_1, k_2$，令$"Re"("eig"(A_("cl"))) < 0$，于是由特征行列式为$0$，得

$
  mat(delim: "[", λ, 1; g / L - k_1, λ - k_2)
  &= λ^2 - k_2 λ - g / L + k_1\
  &= λ^2 + 2 λ + 1
$

得

- $k_1 = 1 + g / L$
- $k_2 = -2$

代入$u$的表达式，得

$ u = -x_d + (1 + g / L) x_1 + 2 x_2 $

= 弹簧振动阻尼系统

== 系统构成

对弹簧振动阻尼系统

#figure(
  image("images/model/vibration.drawio.png", width: 40%),
  caption: "弹簧振动阻尼系统",
  supplement: "图",
)

- 当目标$𝒙_d = vec(delim: "[", 0, 0)$，为经典 LQR 问题
- 当目标$𝒙_d = vec(delim: "[", 1, 0)$或不为$𝟎$时，为轨迹追踪问题

其离散线性系统方程为

$ 𝒙_([k+1]) = 𝑨 𝒙_([k]) + 𝑩 𝒖_([k]) $ <sys-spring>

若追踪目标为

$ 𝒙_(d[k+1]) = 𝑨_D 𝒙_(d[k]) $

设$𝒙_d$为常数向量，则令

$ 𝒆_([k]) = 𝒙_([k]) - 𝒙_(d[k]) = underbrace(mat(delim: "[", 𝑰, -𝑰), "𝑪ₐ") vec(delim: "[", 𝒙_([k]), 𝒙_(d[k])) $

此时，目标值$𝒆_(d[k]) = 0$，问题转化为 LQR 问题。于是有

$
  underbrace(vec(delim: "[", 𝒙_([k+1]), 𝒙_(d[k+1])), "𝒙ₐ[k+1]") = underbrace(dmat(delim: "[", 𝑨, 𝑨_0), "𝑨ₐ") underbrace(vec(delim: "[", 𝒙_([k]), 𝒙_(d[k])), "𝒙ₐ[k]") + underbrace(vec(delim: "[", 𝑩, 𝟎), "𝑩ₐ") 𝒖
$

进一步有

$ 𝒆_([k]) = 𝑪_a 𝒙_(a[k]) $

对应的代价函数为

$
  J &= 1 / 2 𝒆^⊤_([N]) 𝑺 𝒆_([N]) + 1 / 2 ∑_(k=0)^(N-1) (𝒆^⊤_([k]) 𝑸 𝒆_([k]) + 𝒖^⊤_([k]) 𝑹 𝒖_([k]))\
  &= 1 / 2 (𝑪_a 𝒙_(a[k]))^⊤_([N]) 𝑺 (𝑪_a 𝒙_(a[k])) + 1 / 2 ∑_(k=0)^(N-1) ( (𝑪_a 𝒙_(a[k]))^⊤_([k]) 𝑸 (𝑪_a 𝒙_(a[k]))_([k]) + 𝒖^⊤_([k]) 𝑹 𝒖_([k]) )\
  &= 1 / 2 𝒙_(a[k])^⊤ 𝑺_a 𝒙_(a[k]) + 1 / 2 ∑_(k=0)^(N-1) (𝒙_(a[k])^⊤ 𝑸_a 𝒙_(a[k]) + 𝒖^⊤_([k]) 𝑹 𝒖_([k]))
$ <cost-spring>

上式成功将追踪问题转化为了 LQR 问题。但当$𝑹$过大，则系统将躺平，无法进行追踪。

== 稳态非零常数输入

对轨迹追踪问题，有

$ 𝒙_(a[k+1]) = 𝑨_D 𝒙_(d[k]) $ <aug>

考虑特例，如恒温或匀速控制，此时$𝑨_D = 𝑰$，即

$ 𝒙_(d[k]) = 𝒙_d $

且$𝒙_d$处，系统处于稳态，即输入$𝒖$使系统总能得到$𝒙_d$。于是

$ 𝒙_d = 𝑨 𝒙_d + 𝑩 𝒖_d $

可得

$ (𝑰 - 𝑨)𝒙_d = 𝑩 𝒖_d $

定义稳态误差

$ δ 𝒖_([k]) = 𝒖_([k]) - 𝒖_([d]) $

代入@sys-spring，可得

$
  𝒙_([k+1]) &= 𝑨 𝒙_([k]) + 𝑩(δ 𝒖_([k]) + 𝒖_([d])) \
  &= 𝑨 𝒙_([k]) + 𝑩 δ 𝒖_([k]) + (𝑰 - 𝑨) 𝒙_d
$

构造增广矩阵

$
  𝒙_(a[ k+1 ]) = vec(delim: "[", 𝒙_([k+1]), 𝒙_d) = underbrace(mat(delim: "[", 𝑨, 𝑰 - 𝑨; 𝟎, 𝑰), "𝑨ₐ") vec(delim: "[", 𝒙_([k]), 𝒙_d) + underbrace(vec(delim: "[", 𝑩, 𝟎), "𝑩ₐ") δ 𝒖_([ k ])
$

令

$
  𝒆_([k]) = 𝒙_([k]) - 𝒙_d = underbrace(mat(delim: "[", 𝑰, -𝑰), "𝑪ₐ") underbrace(vec(delim: "[", 𝒙_([k]), 𝒙_d), "𝒙ₐ[k]")
$

代入@cost-spring，得

$
  J &= 1 / 2 𝒙^⊤_(a[N]) 𝑪^⊤_a 𝑺 𝑪_a 𝒙_(a[N]) + 1 / 2 ∑_(k=0)^(N-1) ( 𝒙^⊤_(a[k]) 𝑪^⊤_a 𝑸 𝑪_a 𝒙_(a[k]) + δ 𝒖^⊤_([k]) 𝑹 δ 𝒖_([k]) )
$ <cost-spring2>

这就得到了一个新的 LQR 问题。

#figure(
  image("images/block/lqr-trk-const.drawio.png", width: 40%),
  caption: "轨迹追踪 LQR 系统",
  supplement: "图",
)

== 稳态非零矩阵输入

对非常数输入，@aug 中$𝑨_D ≠ 𝑰$。此时，定义输入增量

$ Δ 𝒖_([k]) = underbrace(𝒖_([k]) - 𝒖_([k-1]), "平滑输入的变化") $

代人@sys-spring，可得

$ 𝒙_([k+1]) = 𝑨 𝒙_([k]) + 𝑩 𝒖_([k]) + 𝑩 𝒖_([k-1]) $

设增广向量

$ 𝒙_(a[k]) = vec(delim: "[", 𝒙_([k]), 𝒙_([d]), 𝒖_([k-1])) $

于是

$ 𝒆_([k]) = 𝒙_([k]) - 𝒙_d = mat(delim: "[", 𝑰, -𝑰, 𝟎) vec(delim: "[", 𝒙_([k]), 𝒙_([d]), 𝒖_([k-1])) = 𝑪_a 𝒙_(a[k]) $

进一步有

$
  𝒙_(a[k+1]) = underbrace(mat(delim: "[", 𝑨, 𝟎, 𝑩; 𝟎, 𝑨_D, 𝟎; 𝟎, 𝟎, 𝑰), "𝑨ₐ") 𝒙_(a[ k ]) + underbrace(vec(delim: "[", 𝑩, 𝟎, 𝑰), "𝑩ₐ") Δ 𝒖_([k])
$

类比@cost-spring2，得

$
  J = 1 / 2 𝒙^⊤_(a[N]) 𝑪^⊤_a 𝑺 𝑪_a 𝒙_(a[N]) + 1 / 2 ∑_(k=0)^(N-1) ( 𝒙^⊤_(a[k]) 𝑪^⊤_a 𝑸 𝑪_a 𝒙_(a[k]) + Δ 𝒖^⊤_([k]) 𝑹 Δ 𝒖_([k]) )
$

#figure(
  image("images/block/lqr-trk-var.drawio.png", width: 40%),
  caption: "稳态非零矩阵输入",
  supplement: "图",
)

这里，我们通过矩阵变换将追踪（tracking）转换为了调控（regulation）。

== 稳态正弦函数输入

在符合 Newton 第二定律的系统中，正弦振动是线性系统的内生特性

$
  x_(1d) &= sin(ω t) \
  x_(2d) &= dv(x_(1d), t) = ω cos(ω t) \
  dv(x_(2d), t) &= -ω^2 sin(ω t) = -ω^2 x_(1d)
$

其矩阵形式为

$
  dv(, t) vec(delim: "[", x_(1d), x_(2d)) = underbrace(mat(delim: "[", 0, 1; -ω^2, 0), 𝐀_D) vec(delim: "[", x_(1d), x_(2d))
$
