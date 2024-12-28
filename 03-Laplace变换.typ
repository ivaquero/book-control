#import "@local/scibook:0.1.0": *
#show: doc => conf(
  title: "传递函数",
  author: "ivaquero",
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= 求解运动方程

== 冲激函数

=== 连续型

连续型冲激函数定义为

$ δ(t) = cases(∞ quad & t = 0, 0 & t ≠ 0) $

单位冲激函数，又称为 Dirac $δ$函数，满足

- $t ≠ 0$时，$δ(t) = 0$
- $∫_(-∞)^∞ δ(t) dd(t) = 1$

#tip[
  $δ$函数的宽度为 0，面积为 1，仅存在于数学中
]

=== 离散型

根据$δ$函数定义，构建离散型冲激函数

$ δ(t)_Δ = cases(frac(1, Δ T) quad & 0 < t < Δ T, 0 & "else") $

显然，$Δ T$内的冲激为

$ frac(1, Δ T) Δ T = 1 $

== 输入与输出

#figure(
  table(
    columns: 2,
    align: center + horizon,
    inset: 4pt,
    stroke: frame(rgb("000")),
    [$f(t)$], [$x(t)$],
    [$δ(t)_Δ$], [$h_Δ(t)$],
    [$δ(t - i Δ T)_Δ$], [$h_Δ(t - i Δ T)$],
    [$A δ(t - i Δ T)_Δ$], [$A h_Δ(t - i Δ T)$],
    [], [],
  ),
  caption: [输入与输出],
  supplement: "表",
  kind: table,
)

表格中，$A = Δ T f(i Δ T)$，在$t = i Δ T$时刻，有

$ x(t) = ∑_(i = 0)^i Δ T f(i Δ T) h_Δ(t - i Δ T) $

令$lim_(Δ T → 0)$，则$Δ T = dd(τ)$，$i Δ T = τ$，从而有

$
  x(t) &= ∫_0^t f(τ) h(t - τ) dd(τ)\
  &= f(t) ∗ h(t)
$

这就是#strong[卷积的定义]，$∗$即为卷积运算（米字号，不是星号）。

#tip[
  $x(t)$是系统对$t$时刻前所有响应的和，而冲激响应$h(t)$可以完全定义 LTI 系统
]


== 传递函数
<传递函数>

线性的一个重要结果是正弦输入总是导致具有相同频率的正弦输出，只有振荡的幅度和相位会发生变化。

使用 Euler 公式，正弦振荡可以用$e^(j ω t)$表示。若 LTI 系统的输入为$x(t) = e^(j ω t)$，则输出必须具有以下形式

$
  y(t) = r ⋅ e^(j δ) ⋅ e^(j ω t) = G(j ω) ⋅ e^(j ω t)
$

增益$r$量化了振幅的变化，$δ$量化了系统引入的相移。因此，一个复数$G(j ω)$完全表征了系统对该频率正弦输入的影响。因此，$G(j ω)$被称为系统的“传递函数”（transfer function）。

所有线性系统都遵循叠加（superposition）。若输入$x(t)$可以分解为正弦波的总和，使用 Fourier 变换来找到它们的振幅（对于离散的、时间有限的系统，产生的频率是 ω0 的倍数）。每个都通过$G(j ω)$。$G(j ω)$具有增益和相移，这取决于频率。然后可以将产生的正弦波$G(j n ω_0)e^(j n ω_0 t)$全部加起来。

换句话说，$x(t)$通过变换从时域移到频域。在那里，系统的传递函数对频率分量进行操作以产生在频域中的输出分量。逆变换可将这些分量组合起来并将结果转换回时域。显然，如果没有线性和叠加就无法做到这一点。

= Laplace 变换
<Laplace-变换>

Fourier 变换将时间信号表示为正弦波的总和，因此非常适合具有恒定频率内容的系统。但是，对于随时间变化的信号（例如，当电灯开关翻转时产生的电流），它不太适合。Laplace 变换可以更好地表示此类信号，Laplace 变换不仅包含具有恒定幅度的正弦波，还包含呈指数增长和衰减的信号。

指数增长和衰减函数也经常出现在微分方程的解中。因此，Laplace 变换非常适合将微分方程转换为频域。由于 Laplace 变换具有将微分方程（在时域中）转换为代数方程（在频域中）的非常方便的特性，因此它对于获得微分方程描述的问题的解非常有帮助。

在机械系统（或一般微分方程）的模拟中，从时间域到频域的转换通常使用 Laplace 变换来执行。该变化遵循范式

$ F(s) H(s) = X(s) $

其中，$F(s)$为输入的 Laplace 变换，$H(s)$为传递函数，$X(s)$为输出的 Laplace 变换。

== 与卷积

Laplace 变换定义为

$
  F(s) = ℒ[f(t)] = ∫_0^(∞) f(t) e^(-s t) dd(t)
$ <laplace>

由之前的卷积的定义

$
  ℒ[x(t) ∗ h(t)] = ∫_0^(∞)∫_0^t x(τ)h(t - τ) dd(τ) e^(-s t) dd(t)
$

变换积分顺序，可以写成

$
  ℒ[f(t) ∗ h(t)] = ∫_0^(∞)∫_τ^(∞) f(τ)h(t - τ) e^(-s t) dd(t, τ)
$

令$u = t - τ ∈ [0, ∞)$，则$t = u + τ$，$dd(t) = dd(u)$，从而有

$
  ℒ[f(t) ∗ h(t)]
  &= ∫_0^(∞)∫_0^(∞) f(τ)h(u) e^(-s(u + τ)) dd(u, τ) \
  &= ∫_0^(∞) f(τ)e^(-s τ) dd(τ) ∫_0^(∞) h(u) e^(-s u) dd(u) \
  &= ℒ[f(s)] ℒ[h(s)] \
  &= F(s)H(s)
$

#tip[
  上面这个性质非常重要，它将复杂的卷积运算转化成了简单的乘积运算。
]

#theorem[
  若
  $
    y (0) = y ̇ (0) = y ̈ (0) = … = y^((n-1))(0) = 0
  $

  则
  $ ℒ (dv(y(t), t, n)) = s^n ℒ[y(t)] = s^n Y(s) $
]

== 时域与频域

通过 Laplace 变换，将函数从时域转化至频域

$ f(t) F(s) $

即

$ ℒ[f(t)] = F(s) = ∫_0^∞ f(t) e^(-s t) dd(t) $

得到复数

$ s = σ + ω i $

此时，函数的图像就从二维转换成了三维。

当$σ = 0$时

$
  F(s) = F(ω) = ∫_0^∞ f(t) e^(-j ω t) dd(t)
$

$F(j ω)$-$j ω$的图像即为$f(t)$的 Fourier 变换。

== 与 Fourier 变换

对 Fourier 变换

$
  F(ω) = ∫_(-∞)^(+∞) f(t) e^(-j ω t) dd(t)
$

令$s = j ω$，即可得 Laplace 变换

$ F(s) = ∫_(-∞)^(+∞) f(t) e^(-s t) dd(t) $

由此，Fourier 变换为 Laplace 变换的一个特例，具有 Laplace 变换的所有性质。用 Fourier 变换只能处理正弦波 $e^(j ω t)$。我们可以让$s$为完全复数，即$s = σ + j ω$，这将大大扩展了$e^(s t)$可以表示的函数种类。

== 逆 Laplace 变换

逆 Laplace 变换由以下复积分给出，该积分有各种名称，如 Bromwich 积分或 Fourier-Mellin 积分：

$
  x(t) = frac(1, 2π j) lim_(T → ∞) ∫_(γ - j T)^(γ + j T) e^(s t) X(s) dd(s)
$ <inv>

其中，$γ$是实数，因此积分的轮廓路径位于$X(s)$的收敛区域内。$s$有时被称为复频率。

@eqt:inv 表示$x(t)$由无数个无穷小的小波相加而成，而 $X(s)$则表示$s$平面上每个点需要多少个小波。该加权因子由变换给出（@eqt:laplace）。分解出的每个小波都由复数$X(s)$ 加权。​​然后，它们通过传递函数$G$，该函数现在不再是$G(j ω)$（仅针对正弦波定义），而是针对整个复平面定义的$G(s)$。$X(s)G(s)$的结果表示输出中包含的$s$平面上每个点的$e^(s t)$量。$X(s)G(s)$上使用@eqt:inv，可让我们回到时间域并得到输出。

== 收敛域

Laplace 变换后，要保证

- 分子 > $0$
- 分子的每一部分都 > $0$
\

所以，还要加上关于$s$的收敛域（region of convergence，ROC）。如

$
  ℒ[e^(-a t)] = ∫_0^∞ e^(-a t) e^(-s t) dd(t) = underbrace(∫_0^(+∞) e^(-(s + a))t) dd(t), 可 积
$

$e^(-a t)$的 Laplace 变换存在的条件是上式的积分可积
令$s = σ + j ω$

$
  ℒ[e^(-a t)] = ∫_0^(+∞) e^(-a t) e^(-(σ + j ω)t) dd(t) = ∫_0^(+∞) e^(-(a + σ))t e^(-j ω t) dd(t)
$

由 Euler 公式

$ e^(-j ω t) = cos ω t - i sin ω t $

则$|e^(-j ω t)| = 1$，故可积取决于$e^(-(a + σ))t$，即

$ σ > - a $

= 常用 Laplace 变换
<常用-Laplace-变换>

== 指数函数

对函数$f(t) = e^(-a t)$

$
  ℒ[e^(-a t)] &= ∫_0^∞ e^(-a t) e^(-s t) dd(t)
  = ∫_0^∞ e^(-(a + s))t dd(t)
  = frac(1, a + s)
$

显然，θ

$ ℒ[1] = 1 / s $

== 三角函数

Laplace 变换是一种线性变换。对线性系统

$ ℒ[a f(t) + b g(t)] = a F(s) + b G(s) $

由 Euler 公式

$
  e^(i θ) &= cos θ + i sin θ\
  e^(i (-θ)) &= cos θ - i sin θ
$

得

$ sin θ = frac(e^(i θ) - e^(-i θ), 2 i) $

于是

$
  ℒ[sin(a t)] &= ℒ (frac(e^(i a t), 2 i)) - ℒ (frac(e^(-i a t), 2 i))\
  &= 1 / 2i (ℒ[e^(i a t)]) - ℒ[e^(-i a t)] (\
  &= 1 / 2i (frac(1, s - a i) - frac(1, s + a i))\
  &= frac(a, s^2 + a^2)
$

同理

$
  ℒ[cos(a t)] = frac(s, s^2 + a^2)\
  ℒ[sinh(a t)] = frac(a, s^2 - a^2)\
  ℒ[cosh(a t)] = frac(s, s^2 - a^2)
$

== 导数

分部积分

$ ∫f^′(t) g(t) dd(t) = f(t) g(t) - ∫f(t) g^′(t) dd(t) $

有

$
  ℒ[f^′(t)] &= ∫_0^(+∞) f^′(t) e^(-s t) dd(t)\
  &= f(t) e^(-s t) bar.v_0^∞ - ∫_0^(+∞) f(t)(-s e^(-s t))) dd(t)\
  &= lim_(t → ∞) f(∞) e^(-s t) - f(0) + s ∫_0^(+∞) f(t) e^(-s t) dd(t)\
  &= s F(s) - f(0)
$

#tip[
  因为初始条件$f(0)$往往被选定为$0$，所以
  $ ℒ[f^′(t)] = s F(s) $

]
进而有

$ ℒ[f^″(t)] = s^2 F(s) - s f(0) - f^′(0) $

以及

$ ℒ[∫_0^t f(τ) dd(t)] = 1 / s F(s) $

== 解方程

通过 Laplace 变换求解微分方程主要有 3 步

+ Laplace 变换：$ℒ[f(x)], med t → s$
+ 求解代数方程
+ 逆 Laplace 变换：$ℒ^(-1)[f(x)], med s → t$
\

指数

$ ℒ(-frac(1, s + a)) = e^(-a t) $

三角函数

$
  sin(2t) &= frac(e^(-2 i t) - e^(2 i t), 2 i)\
  cos(2t) &= frac(e^(-2 i t) + e^(2 i t), 2)
$

= 系统设计
<系统设计>

== 电路系统

#figure(
  image("images/model/circuit.drawio.png", width: 25%),
  caption: [电路],
  supplement: "图",
)

由 KCL 有

$ e^′ = L i^″ + R i^′ + 1 / C i $

令初始条件为$0$，等式两边进行导数的 Laplace 变换，得

$ s E[s] = L s^2 I_(s) + s R I_(s) + 1 / C I_(s) $

从而有

$ I(s) = frac(s, L s^2 + R s + 1/C) E[s] $

转换为框图形式，即有

#figure(
  diagram(
    spacing: (2em, 2em),
    node-stroke: 1pt,
    mark-scale: 80%,
    let (M, A, B) = ((4, 1), (2, 1), (6, +1)),
    node(
      M,
      text($frac(s, L s^2 + R s + 1\/C)$, size: 1.2em),
      height: 2.5em,
      corner-radius: 3pt,
    ),
    edge(A, M, $E(s)$, "-|>"),
    edge(M, B, $I(s)$, "-|>"),
  ),
  caption: "框图",
  supplement: "\n图",
)

中间的函数即为传递函数。

== 流体系统

#figure(
  image("images/model/liquid.drawio.png", width: 40%),
  caption: "流体系统",
  supplement: "图",
)

由上图

$ dv(h, t) + frac(g, R A) h = q_(i n) / A $

令

- $A = 1$
- $x = h$
- $u = q_(i n)$
得

$ x ̇(t) + g / R x(t) = u(t) $

两端做 Laplace 变换，得

$ s X(s) + g / R X(s) = U(s), med x(0) = 0 $

从而有，开环传递函数$G(s)$

$ G(s) = frac(X(s), U(s)) = frac(1, s + g/R) $

当$u(t) = C$，则

$ lim_(t → ∞) h = C R / g $

对闭环系统，此时引入参考值$V(s)$，输入值变成了$X(s) H(s)$

#figure(
  diagram(
    spacing: (2em, 2em),
    node-stroke: 1pt,
    mark-scale: 80%,
    let (R, O, T, H, A) = ((1, 1), (2, 2), (4, 1), (4, 2), (5, 1.5)),
    node(R, $V(s)$, height: 2em, corner-radius: 3pt),
    node(O, text($+ quad -$, size: 0.6em), inset: 1em, radius: 1em),
    node(T, $D(s)G(s)$, height: 2em, width: 6em, corner-radius: 3pt),
    node(H, $H(s)$, height: 2em, width: 6em, corner-radius: 3pt),
    edge(R, O, "-|>", corner: left),
    edge(
      O,
      T,
      text($V(s)-X(s)H(s)$, size: 0.6em),
      "-|>",
      corner: right,
      label-pos: 0.7,
    ),
    edge(T, A, text($X(s)$, size: 0.6em), "-", corner: right, label-pos: 0.4),
    edge(A, H, "-", corner: right),
    edge(H, O, text($X(s)H(s)$, size: 0.6em), "-|>"),
  ),
  caption: "闭环系统",
  supplement: "\n图",
)

由

$ (V - X H)(D G) = X $

得，闭环传递函数

$ X = V frac(D G, 1 + H D G) $

于是可知

#figure(
  diagram(
    spacing: (2em, 2em),
    node-stroke: 1pt,
    mark-scale: 80%,
    let (M, A, B) = ((4, 1), (2, 1), (6, +1)),
    node(M, $frac(D G, 1 + H D G)$, height: 2em, corner-radius: 3pt),
    edge(A, M, $V$, "-|>"),
    edge(M, B, $X$, "-|>"),
  ),
  caption: "框图",
  supplement: "\n图",
)

== 非零初始条件

对一阶方程

$ x ̇(t) + a x(t) = u(t) $

当$x(0) = 0$时，有

$ G(s) = frac(X(s), U(s)) = frac(1, s + a) $

当$x(0) ≠ 0$时，有

$ G(s) = frac(X(s), U(s) + x(0)) = frac(1, s + a) $

对 LTI 系统，根据叠加原理，$x(0)$为另一输入，令其为$U_2(s)$，有

$ ℒ^(-1)[U_2(s)] = ℒ^(-1)[x(0)] $

即

$ U_2(t) = x(0) δ(t) $

其中，$δ(t)$为单位冲击，$x(0)$为冲击幅度。
