#import "lib/lib.typ": *
#show: chapter-style.with(title: "进入频域", info: info)

= 求解运动方程

== 运动方程的表示

通常，我们用微分方程组描述系统，它可以很好地解决系统的响应，但并不适合分析。在分析前，我们需要将微分方程组转化为适当的表示，其中两种最受欢迎的表示为传递函数（transfer function）和状态空间（state space），前者代表着经典控制理论时代，后者代表着现代控制理论时代。两者各有优缺，作为控制工程师，我们对两者都要熟悉，以最合适的方法解决问题。我们首先重点关注传递函数，为此，我们从线性系统讲起。

== 线性时不变系统

#definition[
  当函数$f(x)$满足以下条件时，称其是线性的：

  - 齐次性：$f(a x) = a f(x)$
  - 叠加性：$f(x_1 + x_2) = f(x_1) + f(x_2)$
]

#let (x, y, y2) = lq.load-txt(read("data/homegeneity.csv"))

#trans-linear(x, y, y2, lq.vec.multiply(y2, 2), kind: "skip")
#trans-linear(
  x,
  lq.vec.multiply(y, 2),
  lq.vec.multiply(y2, 2),
  lq.vec.multiply(y2, 2),
  caption: "齐次性",
)

自变量和自变量的导数均为线性的系统，称为线性系统。其中，不显含时间$t$的线性系统，称线性自治（linear autonomous）系统，也称为线性时不变（linear time invariant，LTI）系统，其系数不随时间变化，即

$ dot(x) = f(x) $

LTI 是最常用的动态系统，其在具有线性性质的同时，还服从自治（时不变）原理，即时滞仅使图像平移，但不改变图像形状

$ O{f(t)} = x(t) ⇒ O{f(t - τ)} = x(t - τ) $

与之相对，显含时间$t$的系统，称线性非自治（non-autonomous）系统或线性时变（time varying）系统，其系数不随时间变化，即

$ dot(x) = f(t, x) $

#let (x1, y1, y12) = lq.load-txt(read("data/superstition.csv"))
#trans-linear(x1, y1, y12, lq.vec.multiply(y2, 2), kind: "skip")
#let (x2, y2, y22) = lq.load-txt(read("data/superstition2.csv"))
#trans-linear(x2, y2, y22, lq.vec.multiply(y2, 2), kind: "skip")
#trans-linear(
  x1,
  lq.vec.add(y1, y2),
  lq.vec.add(y12, y22),
  lq.vec.multiply(y12, 2),
  caption: "叠加性",
)

== 冲激函数

通过了解系统在冲激函数下的表现，可以充分表征LTI系统。系统受到冲激函数作用后的输出称为系统的脉冲响应（impulse response）。

#definition[
  冲激函数是一种信号，其在短时间具有无限幅度，单位冲激函数，又称为 Dirac Delta 函数，以 Paul Dirac 命名，满足

  - $t ≠ 0$时，$δ(t) = 0$
  - $∫_(-∞)^∞ δ(t) dd(t) = 1$
]

#tip[
  Dirac Delta 函数的宽度为 0，面积为 1，仅存在于数学中。
]

连续型冲激函数定义为

$
  δ(t) = cases(
    ∞ quad & t = 0,
    0 & t ≠ 0
  )
$

离散型冲激函数可由定义构建为

$
  δ(t)_Δ = cases(
    frac(1, Δ T) quad & 0 < t < Δ T,
    0 & "else"
  )
$

显然，$Δ T$内的冲激为

$ frac(1, Δ T) Δ T = 1 $

== 卷积

#figure(
  table(
    columns: 2,
    align: center + horizon,
    inset: 6pt,
    stroke: table-three-line(rgb("000")),
    [$f(t)$], [$x(t)$],
    [$δ(t)_Δ$], [$h_Δ(t)$],
    [$δ(t - i Δ T)_Δ$], [$h_Δ(t - i Δ T)$],
    [$A δ(t - i Δ T)_Δ$], [$A h_Δ(t - i Δ T)$],
  ),
  caption: "输入与输出",
  kind: table,
)

表格中，$A = Δ T f(i Δ T)$，在$t = i Δ T$时刻，有

$
  x(t) = sum_(i = 0)^i Δ T f(i Δ T) h_Δ(t - i Δ T)
$

令$lim_(Δ T → 0)$，则$Δ T = dd(τ)$，$i Δ T = τ$，从而有

$
  x(t) = ∫_0^t f(τ) h(t - τ) dd(τ) = f(t) ∗ h(t)
$

这就是#strong[卷积的定义]，$∗$即为卷积运算（米字号，不是星号），其将求和技巧扩展到实数连续输入。

#tip[
  $x(t)$是系统对$t$时刻前所有响应的和，而冲激响应$h(t)$可以完全定义 LTI 系统。
]

== 一个有趣的观察

两个多项式相乘可以通过对多项式系数进行离散卷积来实现，对此计算有如下法则。

#theorem(title: "FOILMM 法则")[
  对多项式$a_1 x^2 + b_1 x + c_1$和$a_2 x + b_2 x c_2$，分别计算
  #block(height: 3em, columns(3)[
    - First: $a_1 a_2 x^4$
    - Middle First: $b_1 a_2 x^3$
    - Outer: $a_1 c_2 x^2$
    - Inner: $a_2 c_1 x^2$
    - Last: $c_1 c_2$
    - Middle Last: $b_1 c_2 x$
  ])
  从而有
  $
    (a_1 a_2)x^4 + b_1 a_2 x^3 + (a_1 c_2 + a_2 c_1)x^2 + b_1 c_2 x + c_1 c_2
  $
]

这正是离散卷积所做的。我们可以将第一个多项式定义为向量$[a_1,b_1,c_1]$，将第二个多项式定义为向量$[a_2,b_2,c_2]$。为了执行离散卷积，我们需要反转其中一个向量的顺序，将其扫过另一个向量，然后计算两者的乘积之和。

卷积赋予我们判断任何 LTI 系统对任意输入的响应的能力，只要我们知道该系统的脉冲响应。

= 进入频域

卷积积分似乎相当复杂，对于任意输入进行积分会非常繁琐。不仅要进行积分困难，卷积也不能让我们轻松地将多个系统组合成一个大型系统。那么，什么会帮助我们呢？是传递函数。我们可以使用传递函数进行卷积，这里我们使用乘法而非积分来进行。为了继续我们的旅程，我们需要离开时域，并进入频域。

== 弹簧阻尼系统

乍一看，进入频域似乎是一个不便的步骤，但它绝对值得付出努力。想象一下一个静止在弹簧上的一质点。若施加一个脉冲力作用于该质点，它将像弹簧玩具一样上下弹跳。若系统没有阻尼，或者没有能量损失，那么质点将永远上下弹跳。这总是很难在时域中绘制，更重要的是，在只看到系统时域响应的情况下，有时很难观察到有意义的行为。

对于这个特定系统，我们可以通过定义三个参数来完整地描述响应：弹跳的频率、弹跳的振幅以及与质量起始位置相对应的相位移。我们可以解微分方程

$
  m dot.double(x)(t) + k x(t) = f(t)
$ <spring>

通过假设解的形式为

$ x(t) = A cos(ω t +φ) $

然后求解三个未知系数$A$（弹性幅度）、$ω$（弹性频率）和$φ$（初始起跳点）。 由于有三个未知数，我们需要三个方程来求解它们。对于第一个方程，我们可以计算$x(t)$的二阶导数，然后将$x(t)$插入运动方程中。

$
              x(t) & =   &     A ⋅ & cos(ω t + ϕ) \
         dot(x)(t) & = - &   A ω ⋅ & sin(ω t + ϕ) \
  dot.double(x)(t) & = - & A ω^2 ⋅ & cos(ω t + ϕ)
$

代入@spring，同时令$h(t) = cos(ω t + ϕ)$，得

$
  m ⋅ (-A) w^2 ⋅ h(t) + k ⋅ A ⋅ h(t) = f(t)
$

后两个方程来自两个已知的初始条件。我们知道初始位置为零，即$x(0) = 0$。 并且我们知道以前的瞬时力产生的结果是，瞬时速度等于物体质量的倒数，即$dot(x)(0) = −1 \/ m$。由于我们已经将输入力计为初始速度，因此我们在第一个方程中将力设为 0。于是有

#block(height: 6em, columns(3, gutter: -80pt)[
  $
    -A w^2 ⋅ h(t) ⋅ m + A ⋅ h(t) ⋅ k & = 0 \
                          A ⋅ cos(ϕ) & = 0 quad ⇒ \
                      - A w ⋅ sin(ϕ) & = - 1 \/m
  $
  $
    \ \ quad quad quad quad ⇒
  $
  $
    ω & = sqrt(k \/ m) \
    φ & = π \/ 2 \
    A & = 1 \/ sqrt(k m)
  $
])



= 周期函数
<周期函数>

== 函数的正交
<函数的正交>

#definition[
  对向量$𝒙, 𝒚 in ℝ^n$，$x$和$y$的点积，定义为其对应坐标乘积之和，即
  $ 𝒙⋅𝒚 = sum_(i=1)^n x_i y_i $
]

向量正交时，有

$ 𝒙⋅𝒚 = 0 ↔ 𝒙 ⊥ 𝒚 $

对两个连续函数$f(x)$和$g(x)$，其内积可表示为

$ ∫_a^b f(x) g(x) dd(x) $

若两函数正交，则该积分的值为$0$。

== 三角函数的正交
<三角函数的正交>

如下集合，构成一个三角函数系

$ {1, cos θ, sin θ, cos 2 θ, sin 2 θ, …, cos n θ, sin n θ, … n in ℕ_+} $

- 正交性质 1

$
  ∫_(-π)^π sin n x = 0 quad
  ∫_(-π)^π cos n x = 0 quad
  ∫_(-π)^π sin n x cos m x dd(x) = 0
$


- 正交性质 2（n ≠ m）

$
  ∫_(-π)^π sin n x sin m x dd(x) = 0 quad
  ∫_(-π)^π cos n x cos m x dd(x) = 0
$

#tip[
  利用积化和差公式，可证。
]

== 周期为 2π 的函数
<周期为-2π-的函数>

对周期为$2π$的函数

$ f(x) = f(x + 2π) $

利用三角函数构造函数

$
  f(x) & = sum_(n = 0)^∞ a_n cos n x + sum_(n = 0)^∞ b_n sin n x \
       & = a_0 + sum_(n = 1)^∞ a_n cos n x + sum_(n = 1)^∞ b_n sin n x
$

- $a_0$

$
  ∫_(-π)^π f( x ) dd(x) &= ∫_(-π)^π a_0 dd(x) + ∫_(-π)^π sum_(n = 1)^∞ a_n cos n x dd(x) + ∫_(-π)^π sum_(n = 1)^∞ b_n sin n x dd(x)\
  &= a_0 ∫_(-π)^π dd(x)
  = 2π a_0 → π a_0
$

故有

$ a_0 = 1 / π ∫_(-π)^π f(x) dd(x) $

- $a_n$和$b_n$

等式两边乘以$cos n x$，得

$ ∫_(-π)^π f(n) cos n x dd(x) = a_n ∫_(-π)^π cos^2 x dd(x) = π a_n $

即

$ a_n = 1 / π ∫_(-π)^π f(n) cos n x dd(x) $

类似地，等式两边乘以$sin n x$，可得

$ b_n = 1 / π ∫_(-π)^π f(n) sin n x dd(x) $

== 周期为 2L 的函数
<周期为-2l-的函数>

对周期为$2L$的函数

$ f(t) = f(t + 2L) $

令 $x = π / L t$，得

$ f(t) = f(L / π x) ≡ g(x) $

从而可得

$ g(x) = g(x + 2π) $

由之前的结论，可得

$ g(x) = a_0 / 2 + sum_(n = 1)^n (a_n cos n x + b_n sin n x) $

将$x$回代，得

$
  cos n x & = cos frac(n π, L) t quad
            sin n x & = sin frac(n π, L) t
$

由 $∫_(-π)^π dd(x) = ∫_(-L)^L d π / L t$

得

$
  1 / π ∫_(-π)^π dd(x)
  = 1 / π π / L ∫_(-L)^L dd(t)
  = 1 / L ∫_(-L)^L dd(t)
$

最终有

$
  f(t) = a_0 / 2 + sum_(n = 1)^∞ (a_n cos frac(n π, L) t + b_n sin frac(n π, L) t)
$ <periode>

工程中，因为时间总为正数，故令$t_0 = 0$，周期为$2 T$，则有

$ ω = π / L = frac(2π, T) $

同时

$
  ∫_(-L)^L dd(t) → ∫_0^(2L) dd(t) → ∫_0^T dd(t)
$

于是，三个系数调整为

#sgrid(
  figure(
    $
      a_0 & = 1 / L ∫_(-L)^L f(t) dd(t) \
      a_n & = 1 / L ∫_(-L)^L f(t) cos frac(n π, L) t dd(t) \
      b_n & = 1 / L ∫_(-L)^L f(t) sin frac(n π, L) t dd(t)
    $,
  ),
  $=>\ \ \ \ \ \ $,
  figure(
    $
      a_0 & = 2 / T ∫_0^T f(t) dd(t) \
      a_n & = 2 / T ∫_0^T f(t) cos n ω t \
      b_n & = 2 / T ∫_0^T f(t) sin n ω t
    $,
  ),
  kind: "skip",
  supplement: none,
  columns: (100pt,) * 3,
  gutter: 2pt,
)

= Fourier 级数
<Fourier-级数>

== 复数形式
<复数形式>

由 Euler 公式，可知

$
  cos θ & = 1 / 2(e^(i θ) + e^(-j θ)) \
  sin θ & = -1 / 2(e^(i θ) - e^(-i θ))
$

回代入@periode，得

$
  f(t) & = a_0 / 2 + sum_(n = 1)^∞ (a_n cos frac(n π, L) t + b_n sin frac(n π, L) t) \
       & = a_0 / 2 +
         sum_(n = 1)^∞ (a_n 1 / 2(e^(i n ω t) + e^(-i n ω t))) -
         1 / 2 i b_n (e^(i n ω t) - e^(-i n ω t)) \
       & = a_0 / 2 +
         sum_(n = 1)^∞ frac(a_n - i b_n, 2) e^(i n ω t) +
         sum_(n = 1)^∞ frac(a_n + i b_n, 2) e^(-i n ω t)
$

令第二项中的$n ≡ - n$，则

$
  f(t) & = sum_(n = 0)^0 a_0 / 2 e^(i n ω t) +
         sum_(n = 1)^∞ frac(a_n - i b_n, 2) e^(i n ω t) +
         sum_(n = -∞)^(-1) frac(a_(-n) + i b_(-n), 2) e^(i n ω t) \
       & = sum_(-∞)^∞ C_n e^(i n ω t)
$

对$C_n$，有

$
  C_n = cases(
    delim: "{",
    a_0 / 2 & n = 0,
    frac(a_n - i b_n, 2) & n = 1\, 2\, 3\, 4\, …,
    frac(a_(-n) + i b_(-n), 2) quad & n = -1\, -2\, -3\, -4\, …
  )
$

分别展开，整理得

$ C_n = 1 / T ∫_0^T f(t) e^(-i n ω t) dd(t) $

== 汇总
<汇总>

综上猜想，任意周期函数都可写成三角函数之和。对周期函数分解

$
  f(x) =
  frac(f(x) + f(-x), 2) +
  frac(f(x) - f(-x), 2) =
  f_("even") + f_("odd")
$

可得

$
  f(x) = a_0 / 2 + sum_(n = 1)^∞ ( a_n cos (frac(2π n, T) x) + b_n sin (frac(2π n, T) x) ), C ∈ ℝ
$

其中

$
  a_n = 2 / T ∫_(-T \ 2)^(T \ 2) f(x) cos frac(2 n π, T) x dd(x)\
  b_n = 2 / T ∫_(-T \ 2)^(T \ 2) f(x) sin frac(2 n π, T) x dd(x)
$

= 常用变换
<常用变换>

== 一般形式
<一般形式>

由 Fourier 级数的复数形式（频域形式）

$ f_T(t) = sum_(n = -∞)^∞ C_n e^(i n ω_0 t) $

其中

$ C_n = 1 / T ∫_(-T / 2)^(T / 2) f_T(t) e^(-i n ω_0 t) dd(t) $

此处，称$ω_0 = frac(2π, T)$为基频率。当 Fourier 级数中的$T → ∞$，$f(t)$则不再是周期函数，此时需要寻找更一般的形式。对如下频率

$ Δ ω = (n + 1) ω_0 - n ω_0 = ω_0 = frac(2π, T) $

$T$增大，则$Δ ω$减小。此处，令$1 / T = frac(Δ ω, 2π)$，并将$C_n$表达式代入
Fourier 级数的复数表达式，得

$
  f_T(t) = sum_(n = -∞)^∞ frac(Δ ω, 2π) ∫_(-T / 2)^(T / 2) f_T(t) e^(-i n ω_0 t) dd(t) e^(i n ω_0 t)
$

当$T → ∞$，有

$
  ∫_(-T / 2)^(T / 2) dd(t) & → ∫_(-∞)^(+∞) dd(t) \
                     n ω_0 & → ω \
        sum_(n = -∞)^∞ Δ ω & → ∫_(-∞)^(+∞) d ω
$

于是，有

$
  f(t) = frac(1, 2π) ∫_(-∞)^(+∞) ∫_(-∞)^(+∞) f(t) e^(-i ω t) dd(t) e^(i ω t) d ω
$

其中，将如下积分称为 Fourier 变换

$ F(ω) = ∫_(-∞)^(+∞) f(t) e^(-i ω t) dd(t) $

而将如下公式，称为逆 Fourier 变换

$ f(t) = frac(1, 2π) ∫_(-∞)^(+∞) F(ω) e^(i ω t) d ω $
