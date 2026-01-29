#import "lib/lib.typ": *
#show: chapter-style.with(title: "反馈线性化控制", info: info)

= 非线性系统稳定性
<非线性系统稳定性>

== Lyapunov 方法
<Lyapunov-方法>

已知

#figure(
  table(
    columns: 4,
    align: center + horizon,
    inset: 4pt,
    stroke: table-three-line(rgb("000")),
    [∀x ∈ D - {0}], [Abbr.], [V(0)], [V(x)],
    [正定], [PD], [0], [$>$],
    [半正定], [PSD], [0], [$≥$],
    [负定], [ND], [0], [$<$],
    [半负定], [NSD], [0], [$≤$],
  ),
  caption: "Lyapunov 稳定性",
  kind: table,
)

#theorem(title: ctext("Lyapunov 第二方法"))[
  系统
  $ dot(𝒙) = f(x_0) $

  其中，$x_0$是平衡点，即$dot(𝒙)(0) = 0$。

  若$∃$函数$V(x)$，且满足
  - $V(x)$正定且$dot(V)(x)$半负定，则称$x_0$稳定
  - $V(x)$正定且$dot(V)(x)$负定，则称$x_0$渐近稳定
]

== 无摩擦单摆

对如下单摆系统，有

$
  sum F_x = m a_x = l dot.double(θ)
$

#import "images/mechanics.typ": *
#pendulum

即

$
  -m g sin θ = m l dot.double(θ)
$

整理，得

$ dot.double(θ) + frac(g, L) sin θ = 0 $

令

- $x_1 = θ$
- $x_2 = dot(x)_1 = dot(θ)$
- $dot(x)_2 = -frac(g, L) sin(x_1)$

又

$ E = K("kinetic") + P("potential") $

于是令

$
  V & = E = frac(1, 2) m v^2 + m g h \
    & = frac(1, 2)m(l x_2)^2 + m g l(1 - cos(x_1))
$

求导，可得

$
  dot(V)(x) = grad V_f & =
                         mat(delim: "[", pdv(V, x_1), pdv(V, x_2))
                         mat(delim: "[", f_1; f_2) \
                       & =
                         mat(delim: "[", m g l sin(x_1) & m l^2 x_2)
                         mat(delim: "[", x_2 - frac(g, L) sin(x_1)) \
                       & = 0
$

又

- $V(0) = 0$
- $V(x) > 0$

故，该系统渐近稳定。其意味着

- $x_1, x_2$有界
- $x_1, x_2$不趋近于$0$

== 有摩擦单摆

对有摩擦单摆系统

$ dot.double(θ) + frac(g, L) sin θ + frac(k, m) dot(θ) = 0 $

令

- $dot(x)_1 = x_2$
- $dot(x)_2 = dot.double(θ) = -frac(g, L)sin(x_1) - frac(k, m)x_2$

令$V = E = K("kinetic") + P("potential")$，求导，可得

$
  dot(V)(x) = grad V_f & =
                         mat(delim: "[", pdv(V, x_1) & pdv(V, x_2))
                         mat(delim: "[", f_1; f_2) \
                       & =
                         mat(delim: "[", m g l sin(x_1), m l^2 x_2)
                         mat(delim: "[", x_2; -frac(g, L)sin(x_1) - frac(k, m)x_2) \
                       & = k l^2 x_2^2
$

显然，$dot(V)(x)$半负定。

#theorem(title: ctext("LaSalle's 不变性原理"))[
  系统
  $ dot(𝒙) = f(x_0) $

  其中，$x_0$是平衡点，即$dot(𝒙)(0) = 0$。

  若$∃$函数$V(x)$，且满足
  - $V(x)$正定，$∀x ∈ D$且${0} ∈ D$
  - $dot(V)(x)$半负定，$∀x ∈ R ⊂ D$
  - $dot(V)(x) ≠ 0, ∀x ≠ 0$

  称系统渐近稳定
]

== 非线性反馈系统
<非线性反馈系统>

对系统

$ dot(x) = f(x, u) $

假设，输入$u = ϕ (x)$，于是可得

$ dot(x) = f(x, ϕ (x)) $

#figure(
  image("images/feedback.drawio.png", width: 40%),
  caption: "反馈",
)

考虑系统

$ dot(x) = f(x, u) = a x^2 + u, u = ϕ (x) $

不难看出，$f(0, 0) = 0$，若想令$(0, 0)$为渐近稳定平衡点，则可以令

$ u = -a x^2 - x $

此时，$x(t) = C e^(-t)$。简单说，控制函数中的$-a x^2$消除了非线性，$-x$保证了渐近稳定。

考虑系统

$ dot(x) = x^2 - x^3 + u $

令$V(x) = 1 / 2 x^2$，则易得

- $V(0) = 0$
- $V(x)$正定

求导，得

$ dot(V)= pdv(V, x) dv(x, t) = x dot(x) = x(x^2 - x^3 + u) = x^3 - x^4 + x u $

由于$-x^4$负定，则为得到稳定点，简单方法是使$x^3 + x u$负定或为$0$，显然可令

- $u = x^3 - x^2 - x$
- $u = -x^2 - x$
- $u = -x^2$

其中，$-x$项会明显加快收敛速度。

= 反步设计
<反步设计>

== 链式系统
<链式系统>

对非线性弹簧系统

$ m dot.double(x) + α x^3 = F $

#import "images/mechanics.typ": *
#vibration-nl

令

- 输入$u = F$
- 位移$x_1 = x$
- 速度$x_2 = x ̇$
- 目标$x_(1 d)$

于是有

$
  dot(x)_1 = dot(x) = x_2\
  dot(x)_2 = dot.double(x) = -α / m x_1^3 + 1 / m u
$

显然，通过控制$u$，可以控制$x_2$，进而控制$x_1$，所以，这是一个链式系统。

令$e = x_(1 d) - x_1$，求导得

$ dot(e) = dot(x)_(1 d) - dot(x)_1 = dot(x)_(1 d) - x_2 $

又令$V = 1 / 2 e^2$，则

$ dot(V)_1 = pdv(V_1, e)⋅dv(e, t) = e dot(e) = e (dot(x)_(1 d) - x_2) $

== 引入中间输入
<引入中间输入>

若希望$dot(V)_1$负定，则可引入中间输入$x_(2 d)$，使$x_1 → x_(1 d)$

$ x_(2 d) = dot(x)_(1 d) + k_1 e $

此时，新的误差函数为

$ δ = x_(2 d) - x_2 $

于是

$
  dot(V)_1 & = e (dot(x)_(1 d) - (x_(2 d) - δ)) \
           & = e (-k_1 e + δ) = -k_1 e^2 + δ e
$

进而有

$
  dot(δ) & = dot(x)_(2 d) - dot(x)_2 \
         & = dot.double(x)(1 d) + k_1 dot(e) - (-α / m x_1^3 + 1 / m u) \
         & = dot.double(x)(1 d) + k_1 (dot(x)_(1 d) - x_2) + α / m x_1^3 - 1 / m u
$

又$V_1$正定，现令$V_2 = V_1 + 1 / 2 δ^2$，则

$
  dot(V)_2 & = dot(V)_1 + δ dot(δ) \
           & = -k_1 e^2 + e δ + δ dot(δ) \
           & = -k_1 e^2 + δ(e + dot(δ))
$

== 控制中间输入
<控制中间输入>

现在，需要设计输入$u$，使$x_2 → x_(2 d)$。可令$e + dot(δ) = -k_2 δ$，得

$
  e + dot.double(x)(1 d) + k_1 (dot(x)_(1 d) - x_2) + α / m x_1^3 - 1 / m u = -k_2 δ
$

最终，得

$
  u = m e + m dot.double(x)(1 d) + m k_1 (dot(x)_(1 d) - x_2)) + α x_1^3 + m k_2 δ
$

$(6)$代入$(3)$，$(11)$代入$(10)$，得

$
  mat(delim: "[", e ̇; dot(δ)) =
  mat(delim: "[", - k_1, 1; - 1, - k_2)
  mat(delim: "[", e; δ)
$

不难得出

- $λ_1 + λ_2 = -k_1 - k_2 < 0$
- $λ_1 λ_2 = k_1 k_2 > 0$

故，$∀λ < 0$。又$mat(delim: "[", e ̇; dot(δ)) = 0$，故，$mat(delim: "[", e; δ) = 0$，从而知，系统渐近稳定。
