#import "lib/mathmod.typ": *
#import "lib/sci-book.typ": *
#show: doc => conf(
  title: "附录A：Fourier 变换",
  header: "现代控制理论",
  author: ("ivaquero"),
  header-cap: "github/ivaquero",
  outline-on: true,
  doc,
)
#show: thmrules

= 三角函数
<三角函数>

== 函数的正交
<函数的正交>

#definition[
  对向量$𝒙, 𝒚 in ℝ^n$，$x$和$y$的点积，定义为其对应坐标乘积之和，即
  $ 𝒙⋅𝒚 = ∑_(i=1)^n x_i y_i $
]

向量正交时，有

$ 𝒙⋅𝒚 = 0 ↔ 𝒙 ⊥ 𝒚 $

对两个连续函数$f(x)$和$g(x)$，其内积可表示为

$ ∫_a^b f(x) g(x) dif x $

若两函数正交，则该积分的值为$0$。

== 三角函数的正交
<三角函数的正交>

如下集合，构成一个三角函数系

$ {1, cos θ, sin θ, cos 2 θ, sin 2 θ, …, cos n θ, sin n θ, … n in ℕ_+ } $

- 正交性质 1

$ & ∫_(-π)^π sin n x = 0\
 & ∫_(-π)^π cos n x = 0\
 & ∫_(-π)^π sin n x cos m x dif x = 0 $

- 正交性质 2

$ & ∫_(-π)^π sin n x sin m x dif x = 0 & n ≠ m\
 & ∫_(-π)^π cos n x cos m x dif x = 0 & n ≠ m $

#tip[
  利用积化和差公式，可证。
]

= 周期为 2π 的函数
<周期为-2π-的函数>

== 构建函数
<构建函数>

对周期为$2π$的函数

$ f(x) = f(x + 2π) $

利用三角函数构造函数

$ f(x)
&= ∑_(n = 0)^∞ a_n cos n x + ∑_(n = 0)^∞ b_n sin n x\
&= a_0 + ∑_(n=1)^∞ a_n cos n x + ∑_(n=1)^∞ b_n sin n x $

== $a_0$
<a_0>

$ ∫_(-π)^π f(x) dif x &= ∫_(-π)^π a_0 dif x + ∫_(-π)^π ∑_(n=1)^∞ a_n cos n x dif x + ∫_(-π)^π ∑_(n=1)^∞ b_n sin n x dif x\
&= a_0 ∫_(-π)^π dif x\
&= 2π a_0 → π a_0 $

故有

$ a_0 = 1/π ∫_(-π)^π f(x) dif x $

== $a_n$和$b_n$
<a_n和b_n>

等式两边乘以$cos n x$

$ ∫_(-π)^π f(x) cos n x dif x &=
∫_(-π)^π a_0/2 cos n x dif x +
∫_(-π)^π ∑_(n=1)^∞ a_n cos n x cos n x dif x +
∫_(-π)^π ∑_(n=1)^∞ b_n sin n x cos n x dif x\
&= ∫_(-π)^π ∑_(n=1)^∞ a_n cos n x cos m x dif x $

故有

$ ∫_(-π)^π f(n) cos n x dif x = a_n ∫_(-π)^π cos^2 x dif x = π a_n $

即

$ a_n = 1/π ∫_(-π)^π f(n) cos n x dif x $

类似地，等式两边乘以$sin n x$，可得

$ b_n = 1/π ∫_(-π)^π f(n) sin n x dif x $

= 周期为 2L 的函数
<周期为-2l-的函数>

== 构建函数
<构建函数-1>

对周期为$2L$的函数

$ f(t) = f(t + 2L) $

令 $x = π/L t$，得

$ f(t) = f(L/π x) ≡ g(x) $

从而可得

$ g(x) = g(x + 2π) $

== 求系数
<求系数>

由之前的结论，可得

$ g(x) = a_0/2 + ∑_(n=1)^n (a_n cos n x + b_n sin n x) $

将$x$回代，得

$ cos n x &= cos frac(n π, L) t\
sin n x &= sin frac(n π, L) t $

由

$ ∫_(-π)^π dif x = ∫_(- L)^L d π/L t $

得

$ 1/π ∫_(-π)^π dif x
&= 1/π π/L ∫_(- L)^L dif t\
&= 1/L ∫_(- L)^L dif t $

最终有

$ f(t) = a_0/2 + ∑_(n=1)^∞ (a_n cos frac(n π, L) t + b_n sin frac(n π, L) t) $

其中，

$ a_0 &= 1/L ∫_(- L)^L f(t) dif t\
a_n &= 1/L ∫_(- L)^L f(t) cos frac(n π, L) t dif t\
b_n &= 1/L ∫_(- L)^L f(t) sin frac(n π, L) t dif t $

== 工程调整
<工程调整>

工程中，因为时间总为正数，故令$t_0 = 0$，周期为$2 T$，则有

$ ω = π/L = frac(2π, T) $

同时

$ ∫_(- L)^L dif t → ∫_0^(2L) dif t → ∫_0^T dif t $

此时，有

$ & a_0 = 2/T ∫_0^T f(t) dif t\
& a_n = 2/T ∫_0^T f(t) cos n ω t\
& b_n = 2/T ∫_0^T f(t) sin n ω t $

= Fourier 级数
<fourier-级数>

== 复数形式
<复数形式>

由 Euler 公式，可知

$ cos θ &= 1/2(e^(i θ) + e^(- j θ))\
sin θ &= -1/2(e^(i θ) - e^(- i θ)) $

回代入之前的周期函数公式，得

$ f(t)
&= a_0/2 + ∑_(n=1)^∞ (
  a_n cos frac(n π, L) t +
  b_n sin frac(n π, L) t)\
&= a_0/2 +
  ∑_(n=1)^∞ (a_n 1/2(e^(i n ω t) + e^(-i n ω t))) -
  1/2 i b_n (e^(i n ω t) - e^(-i n ω t))\
&= a_0/2 +
  ∑_(n=1)^∞ frac(a_n - i b_n, 2) e^(i n ω t) +
  ∑_(n=1)^∞ frac(a_n + i b_n, 2) e^(-i n ω t) $

令第二项中的$n ≡ - n$，则

$ f(t)
&= ∑_(n = 0)^0 a_0/2 e^(i n ω t) +
  ∑_(n=1)^∞ frac(a_n - i b_n, 2) e^(i n ω t) +
  ∑_(n = -∞)^(-1) frac(a_(- n) +
  i b_(- n), 2) e^(i n ω t)\
&= ∑_(-∞)^∞ C_n e^(i n ω t) $

对$C_n$，有

$ C_n = cases(delim: "{",
a_0/2 & n = 0,
frac(a_n - i b_n, 2) & n = 1\, 2\, 3\, 4\, …,
frac(a_(- n) + i b_(- n), 2) quad & n = -1\, -2\, -3\, -4\, …) $

分别展开，整理得

$ C_n = 1/T ∫_0^T f(t) e^(-i n ω t) dif t $

== 汇总
<汇总>

综上猜想，任意周期函数都可写成三角函数之和

对周期函数分解

$ f(x) =
frac(f(x) + f(-x), 2) +
frac(f(x) - f(-x), 2) =
f_("even") + f_("odd") $

可得

$ f(x) = a_0/2 + ∑_(n=1)^∞ (
  a_n cos (frac(2π n, T) x) +
  b_n sin (frac(2π n, T) x)
), C ∈ ℝ $

其中

$ a_n = 2/T ∫_(- T \ 2)^(T \ 2) f(x) cos frac(2 n π, T) x dif x\
b_n = 2/T ∫_(- T \ 2)^(T \ 2) f(x) sin frac(2 n π, T) x dif x $

= 常用变换
<常用变换>

== 一般形式
<一般形式>

由 Fourier 级数的复数形式（频域形式）

$ f_T(t) = ∑_(n = -∞)^∞ C_n e^(i n ω_0 t) $

其中，

$ C_n = 1/T ∫_(- T/2)^(T/2) f_T(t) e^(- i n ω_0 t) dif t $

此处，称$ω_0 = frac(2π, T)$为基频率。

当 Fourier 级数中的$T → ∞$，$f(t)$则不再是周期函数，此时需要寻找更一般的形式。

对如下频率

$ Δ ω = (n + 1) ω_0 - n ω_0 = ω_0 = frac(2π, T) $

$T$增大，则$Δ ω$减小。此处，令$1/T = frac(Δ ω, 2π)$，并将$C_n$表达式代入
Fourier 级数的复数表达式，得

$ f_T(t) = ∑_(n = -∞)^∞ frac(Δ ω, 2π) ∫_(- T/2)^(T/2) f_T(t) e^(- i n ω_0 t) dif t e^(i n ω_0 t) $

当$T → ∞$，有

$ ∫_(- T/2)^(T/2) dif t & → ∫_(-∞)^(+∞) dif t\
n ω_0 & → ω\
∑_(n = -∞)^∞ Δ ω & → ∫_(-∞)^(+∞) d ω $

#tip[
  变换 3 用到了黎曼和
]

于是，有

$ f(t) = frac(1, 2π) ∫_(-∞)^(+∞) ∫_(-∞)^(+∞) f(t) e^(- i ω t) dif t e^(i ω t) d ω $

其中，将如下积分称为 Fourier 变换

$ F(ω) = ∫_(-∞)^(+∞) f(t) e^(- i ω t) dif t $

而将如下公式，称为 Fourier 逆变换

$ f(t) = frac(1, 2π) ∫_(-∞)^(+∞) F(ω) e^(i ω t) d ω $

== 与 Laplace 变换
<与-Laplace-变换>

令$s = i ω$，即可得 Laplace 变换

$ F(s) = ∫_(-∞)^(+∞) f(t) e^(- s t) dif t $

由此，Fourier 变换为 Laplace 变换的一个特例，具有 Laplace 变换的所有性质。
