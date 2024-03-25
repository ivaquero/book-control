#import "lib/sci-book.typ": *
#show: doc => conf(
  title: "传递函数",
  header: "现代控制理论",
  author: ("ivaquero"),
  header-cap: "github@ivaquero",
  outline-on: true,
  doc,
)
#show: thmrules

= 传递函数
<传递函数>

== 弹簧阻尼系统

#h(2em) 范式

$ F(s) H(s) = X(s) $

#h(2em) 其中，

- $F(s)$：输入的 Laplace 变换- $H(s)$：传递函数- $X(s)$：输出的 Laplace 变换

#h(2em) 对等号两边做 Laplace 逆变换，可得

== 冲激函数

=== 连续型

#h(2em) 连续型冲激函数定义为

$ δ(t) = cases(∞ & t = 0, 0 & t ≠ 0) $

单位冲激函数，又称为 Dirac $δ$函数，满足

- $t ≠ 0$时，$δ(t) = 0$
- $∫_(-∞)^∞ δ(t) dd(t) = 1$

#tip[
  $δ$函数的宽度为 0，面积为 1，仅存在于数学中
]

=== 离散型

#h(2em) 根据$δ$函数定义，构建离散型冲激函数

$ δ(t)_Δ = cases(frac(1, Δ T) & 0 < t < Δ T, 0 & "else") $

#h(2em) 显然，$Δ T$内的冲激为

$ frac(1, Δ T) Δ T = 1 $

== 输入与输出

#figure(
  table(
    columns: 2,
    align: center + horizon,
    inset: 6pt,
    stroke: frame(rgb("000")),
    [$f(t)$], [$x(t)$],
    [$δ(t)_Δ$],
    [$h_Δ(t)$],
    [$δ(t - i Δ T)_Δ$],
    [$h_Δ(t - i Δ T)$],
    [$A δ(t - i Δ T)_Δ$],
    [$A h_Δ(t - i Δ T)$],
 ),
  caption: [输入与输出],
  supplement: "表",
  kind: table
)

#h(2em) 表格中，$A = Δ T f(i Δ T)$，在$t = i Δ T$时刻，有

$ x(t) = ∑_(i = 0)^i Δ T f(i Δ T) h_Δ(t - i Δ T) $

#h(2em) 令$lim_(Δ T → 0)$，则$Δ T = dd(τ)$，$i Δ T = τ$，从而有

$ x(t) &= ∫_0^t f(τ) h(t - τ) dd(τ)\
 &= f(t) ∗ h(t) $

#h(2em) 这就是#strong[卷积的定义]，$∗$即为卷积运算（不是$*$）。

#tip[
  $x(t)$是系统对$t$时刻前所有响应的和，而冲激响应$h(t)$可以完全定义 LTI 系统
]

= Laplace 变换
<Laplace-变换>

== 与卷积

#h(2em)Laplace 变换定义为

$ F(s) = ℒ[f(t)] = ∫_0^(∞) f(t) e^(-s t) dd(t) $

由之前的卷积的定义

$ ℒ[x(t) ∗ h(t)] = ∫_0^(∞)∫_0^t x(τ)h(t - τ) dd(τ) e^(-s t) dd(t) $

变换积分顺序，可以写成

$ ℒ[f(t) ∗ h(t)] = ∫_0^(∞)∫_τ^(∞) f(τ)h(t - τ) e^(-s t) dd(t, τ) $

令$u = t - τ ∈ [0, ∞)$，则$t = u + τ$，$dd(t) = dd(u)$，从而有

$
ℒ[f(t) ∗ h(t)]
&= ∫_0^(∞)∫_0^(∞) f(τ)h(u) e^(-s(u + τ)) dd(u, τ) \
&= ∫_0^(∞) f(τ)e^(-s τ) dd(τ) ∫_0^(∞) h(u) e^(-s u) dd(u) \
&= ℒ[f(s)] ℒ[h(s)] \
&= F(s)H(s) $

#tip[
  上面这个性质非常重要，它将复杂的卷积运算转化成了简单的乘积运算。
]

#theorem[
  若
  $ y (0) = y ̇ (0) = y ̈ (0) = … = y^((n-1))(0) = 0 $

  则
  $ ℒ (dv(y(t), t, n)) = s^n ℒ[y(t)] = s^n Y(s) $
]

#pagebreak()

== 时域与频域

#h(2em) 通过 Laplace 变换，将函数从时域转化至频域

$ f(t) F(s) $

#h(2em) 即

$ ℒ[f(t)] = F(s) = ∫_0^∞ f(t) e^(-s t) dd(t) $

#h(2em) 得到复数

$ s = σ + ω i $

#h(2em) 此时，函数的图像就从二维转换成了三维。

当$σ = 0$时

$ F(s) = F(ω) = ∫_0^∞ f(t) e^(-j ω t) dd(t) $

#h(2em) $F(j ω)$-$j ω$的图像即为$f(t)$的 Fourier 变换。

== 收敛域

#h(2em) Laplace 变换后，要保证

- 分子 > $0$- 分子的每一部分都 > $0$

#h(2em) 所以，还要加上关于$s$的收敛域（region of convergence，ROC）。如

$ ℒ[e^(-a t)] = ∫_0^∞ e^(-a t) e^(-s t) dd(t) = underbrace(∫_0^(+∞) e^(-(s + a))t) dd(t), 可 积 $

$e^(-a t)$的 Laplace 变换存在的条件是上式的积分可积

#h(2em) 令$s = σ + j ω$

$ ℒ[e^(-a t)] = ∫_0^(+∞) e^(-a t) e^(-(σ + j ω)t) dd(t) = ∫_0^(+∞) e^(-(a + σ))t e^(-j ω t) dd(t) $

#h(2em) 由 Euler 公式

$ e^(-j ω t) = cos ω t - i sin ω t $

#h(2em) 则$|e^(-j ω t)| = 1$，故可积取决于$e^(-(a + σ))t$，即

$ σ > - a $

= 常用 Laplace 变换
<常用-Laplace-变换>

== 指数函数

对函数$f(t) = e^(-a t)$

$ ℒ[e^(-a t)] &= ∫_0^∞ e^(-a t) e^(-s t) dd(t)
 = ∫_0^∞ e^(-(a + s))t dd(t)
 = frac(1, a + s) $

显然，θ

$ ℒ[1] = 1/s $

#pagebreak()

== 三角函数

#h(2em) Laplace 变换是一种线性变换。对线性系统

$ ℒ[a f(t) + b g(t)] = a F(s) + b G(s) $

#h(2em) 由 Euler 公式

$ e^(i θ) &= cos θ + i sin θ\
e^(i (-θ)) &= cos θ - i sin θ $

#h(2em) 得

$ sin θ = frac(e^(i θ) - e^(-i θ), 2 i) $

#h(2em) 于是

$ ℒ[sin(a t)] &= ℒ (frac(e^(i a t), 2 i)) - ℒ (frac(e^(-i a t), 2 i))\
 &= 1/2i (ℒ[e^(i a t)]) - ℒ[e^(-i a t)] (\
 &= 1/2i (frac(1, s - a i) - frac(1, s + a i))\
 &= frac(a, s^2 + a^2) $

#h(2em) 同理

$ ℒ[cos(a t)] = frac(s, s^2 + a^2)\
ℒ[sinh(a t)] = frac(a, s^2 - a^2)\
ℒ[cosh(a t)] = frac(s, s^2 - a^2) $

== 导数

#h(2em) 分部积分

$ ∫f^′(t) g(t) dd(t) = f(t) g(t) - ∫f(t) g^′(t) dd(t) $

#h(2em) 有

$ ℒ[f^′(t)] &= ∫_0^(+∞) f^′(t) e^(-s t) dd(t)\
 &= f(t) e^(-s t) bar.v_0^∞ - ∫_0^(+∞) f(t)(-s e^(-s t))) dd(t)\
 &= lim_(t → ∞) f(∞) e^(-s t) - f(0) + s ∫_0^(+∞) f(t) e^(-s t) dd(t)\
 &= s F(s) - f(0) $

#tip[
  因为初始条件$f(0)$往往被选定为$0$，所以
  $ ℒ[f^′(t)] = s F(s) $
]

#h(2em) 进而有

$ ℒ[f^″(t)] = s^2 F(s) - s f(0) - f^′(0) $

#h(2em) 以及

$ ℒ[∫_0^t f(τ) dd(t)] = 1/s F(s) $

== 逆变换

#h(2em) 通过 Laplace 变换求解微分方程主要有 3 步

+ Laplace 变换：$ℒ[f(x)], med t → s$
+ 求解代数方程
+ Laplace 逆变换：$ℒ^(-1)[f(x)], med s → t$

#h(2em) 指数

$ ℒ (- frac(1, s + a)) = e^(-a t) $

#h(2em) 三角函数

$ sin 2 t &= frac(e^(-2 i t) - e^(2 i t), 2 i)\
cos 2 t &= frac(e^(-2 i t) + e^(2 i t), 2) $

= 系统设计
<系统设计>

== 电路系统

#figure(
  image("./images/model/circuit.drawio.png", width: 40%),
  caption: [
    circuit
  ],
  supplement: "图"
)

#h(2em) 由 KCL 有

$ e^′ = L i^″ + R i^′ + 1/C i $

#pagebreak()

#h(2em) 令初始条件为$0$，等式两边进行导数的 Laplace 变换，得

$ s E[s] = L s^2 I_(s) + s R I_(s) + 1/C I_(s) $

#h(2em) 从而有

$ I(s) = frac(s, L s^2 + R s + 1/C) E[s] $

#h(2em) 转换为框图形式，即有

#figure(
   diagram(
   spacing: (2em, 2em),
   node-stroke: 1pt,
   mark-scale: 80%,
   let (M,A,B)=((4,1),(2,1),(6,+1)),
   node(M, text($frac(s, L s^2 + R s + 1\/C)$, size: 1.2em), height: 2.5em,corner-radius: 3pt),
   edge(A, M, $E(s)$, "-|>"),
   edge(M, B, $I(s)$, "-|>")
  ),
  caption: "",
  supplement: "\n图"
)

#h(2em) 中间的函数即输出函数与输入函数的比值，称为#strong[传递函数（transfer function）]。

== 流体系统

#figure(
  image("./images/model/liquid.drawio.png", width: 40%),
  caption: [流体系统],
  supplement: "图"
)

#h(2em) 由上图

$ dv(h, t) + frac(g, R A) h = q_(i n)/A $

#h(2em) 令

- $A = 1$
- $x = h$
- $u = q_(i n)$

#h(2em) 得

$ x ̇(t) + g/R x(t) = u(t) $

#h(2em) 两端做 Laplace 变换，得

$ s X(s) + g/R X(s) = U(s), med x(0) = 0 $

#h(2em) 从而有，开环传递函数$G(s)$

$ G(s) = frac(X(s), U(s)) = frac(1, s + g/R) $

当$u(t) = C$，则

$ lim_(t → ∞) h = C R/g $

#h(2em) 对闭环系统，此时引入参考值$V(s)$，输入值变成了$X(s) H(s)$

#figure(
  diagram(
     spacing: (2em, 2em),
     node-stroke: 1pt,
     mark-scale: 80%,

     let (R,O,T,H,A)=((1,1),(2,2),(4,1),(4,2),(5,1.5)),
     node(R, $V(s)$, height: 2em,corner-radius: 3pt),
     node(O, text($+ quad -$, size: 0.6em), inset: 1em,radius: 1em),
     node(T, $D(s)G(s)$, height: 2em, width: 6em, corner-radius: 3pt),
     node(H, $H(s)$, height: 2em, width: 6em, corner-radius: 3pt),
     edge(R, O, "-|>", corner: left),
     edge(O, T, text($V(s)-X(s)H(s)$, size: 0.6em), "-|>", corner: right, label-pos: 0.7),
     edge(T, A, text($X(s)$, size: 0.6em), "-", corner: right, label-pos: 0.4),
     edge(A, H, "-", corner: right),
     edge(H, O, text($X(s)H(s)$, size: 0.6em), "-|>"),
    ),
  caption: "",
  supplement: "\n图"
)

#h(2em) 由

$ (V - X H)(D G) = X $

#h(2em) 得，闭环传递函数

$ X = V frac(D G, 1 + H D G) $

#h(2em) 于是可知

#figure(
   diagram(
   spacing: (2em, 2em),
   node-stroke: 1pt,
   mark-scale: 80%,
   let (M,A,B)=((4,1),(2,1),(6,+1)),
   node(M, $frac(D G, 1 + H D G)$, height: 2em,corner-radius: 3pt),
   edge(A, M, $V$, "-|>"),
   edge(M, B, $X$, "-|>")
  ),
  caption: "",
  supplement: "\n图"
)

== 非零初始条件

#h(2em) 对一阶方程

$ x ̇(t) + a x(t) = u(t) $

#h(2em) 当$x(0) = 0$时，有

$ G(s) = frac(X(s), U(s)) = frac(1, s + a) $

#h(2em) 当$x(0) ≠ 0$时，有

$ G(s) = frac(X(s), U(s) + x(0)) = frac(1, s + a) $

#h(2em) 对 LTI 系统，根据叠加原理，$x(0)$为另一输入，令其为$U_2(s)$，有

$ ℒ^(-1)[U_2(s)] = ℒ^(-1)[x(0)] $

#h(2em) 即

$ U_2(t) = x(0) δ(t) $

#h(2em) 其中，$δ(t)$为单位冲击，$x(0)$为冲击幅度。
