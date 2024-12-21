#import "@local/scibook:0.1.0": *
#show: doc => conf(
  title: "非线性控制器",
  author: "ivaquero",
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= 自适应控制器
<自适应控制器>

对系统

$ dot(x) = a x^2 + u $

其中，$a$为常量（或一定时间内几乎不变）。

令$e = x_d - x$，则

$ dot(e) = dot(x)_d - dot(x) = dot(x)_d - a x^2 - u $

当$a$已知，可采用反馈线性化，求得 Lyapunov
函数$V(x)$；当$a$未知，则有

$ V(e, tilde(a)) = 1 / 2 e^2 + 1 / 2 a ̃^2 $

其中，

- 测量误差$e = x_d - x$
- 估计误差$tilde(a)= a - a ̂$

求导，得

$
  dot(V)(e, tilde(a)) = e dot(e) + tilde(a)tilde(dot(a)) &= e (x_d - a x^2 - u) - tilde(a)hat(dot(a))\
  &= -k e^2 - tilde(a)(e x^2 + hat(dot(a)))
$

#tip[
  不难得出，$tilde(dot(a)) = dot(a) - hat(dot(a)) = -hat(dot(a))$
]

显然，$-k e^2$半负定，若使$dot(V)(e, tilde(a))$半负定，可以使$e x^2 + hat(dot(a)) = 0$。

由$dot(V)(e, tilde(a)) = -k e^2 ≤ - (k e^2)$，令$g(t) = k e^2$，得

$ dot(V)(e, tilde(a)) ≤ - g(t) $

此时，$dot(g)(t) = 2 k e e ̇$有界，于是

$ lim_(t → ∞) k e^2 = 0 $

由上，可得

$ u = dot(x)_d + x^2 ∫_0^t e x^2 dd(t) + k e $

#theorem("Barbalat 引理")[
  若函数$V$和$g(t)$满足
  - $V ≥ 0$
  - $dot(V)≤ - g(t)$，其中，$g(t) ≥ 0$
  - $dot(g)(t) ∈ L_x$

  则
  $ lim_(t → ∞) g(t) = 0 $
]

#pagebreak()

= 鲁棒控制
<鲁棒控制>

=== 滑模控制
<滑模控制>

对系统

$ dot(x) = f(x) + u $

有

$ dot(e) = dot(x)_d - dot(x) = dot(x)_d - f(x) - u $

令

$ u = dot(x)_d + k e + u_(a u x) = dot(x)_d + k e + ρ|e| / e $

其中，

$ |e| / e = "sign"(e) cases(delim: "{", 1 & e > 0, 0 & e = 0, - 1 & e < 0) $

#tip[
  $e = x_d - x$，则$lim_(t → ∞) e = 0$
]

于是

$ dot(e) = -k e - f(x) - ρ(x) e / |e| $

其中，

- $-k e$为平衡项
- $f(x)$为系统项
- $ρ(x) e/|e|$为控制器项
- $|f(x)| < ρ(x)$

后两项的作用是，使输出回归到第一项上。

对系统

$ dot(x) = a x^2 + u $

其中，$a$为变量。则

- $|a| ≤ |a ̄|$
- $|f(x)| = |a| x^2 ≤ |a ̄| x^2 < |a|(x^2 + 0.1)$

于是，可以设计

$ u = k e + dot(x)_d + |a ̄|(x^2 + 0.1) |e| / e $

=== 高增益鲁棒控制
<高增益鲁棒控制>

对上述问题，采用高增益鲁棒控制，使用足够大的输入来抵消不确定性

令

- $u_(a u x 2) = 1 / ɛ⋅ρ^2 e$
- $V = 1 / 2 e^2$

则

$
  dot(V)= e dot(e) &= e (dot(x)_d - f(x)) - k e - dot(x)_d - 1 / ɛ p^2 e\
  &= -e f(x) - k e^2 - 1 / ɛ ρ^2 e^2
$

于是有

$ dot(V)≤ - k e^2 + p|e|(1 - 1 / ɛ ρ|e|) $

- 当$ρ|e| > ɛ$，$dot(V)≤ - k e^2$
- 当$ρ|e| ≤ ɛ$，$dot(V)≤ 2 k V + ɛ$

最终有

$ lim_(t → ∞) e ≤ sqrt(ɛ/k) $

=== 高频鲁棒控制
<高频鲁棒控制>

对上述问题，采用高频鲁棒控制，平滑滑膜控制

令

- $u_(a u x 3) = frac(ρ^2 e, ρ|e| + ɛ)$
- $V = 1 / 2 e^2$

$
  dot(V)= e dot(e) ≤ - k e^2 + ρ|e| - e frac(ρ^2 e, ρ|e| + ɛ) = -k e^2 + ɛ (frac(ρ|e|, p|e| + ɛ))
$

其中，$0 ≤ frac(ρ|e|, p|e| + ɛ) ≤ 1$，即

$ dot(V)≤ - k e^2 + ɛ $

类似$u_(a u x 2)$，最终有

$ lim_(t → ∞) e ≤ sqrt(ɛ/k) $

#figure(
  table(
    columns: 7,
    align: center + horizon,
    inset: 4pt,
    stroke: frame(rgb("000")),
    [Name], [$u_(a u x)$], [$ɛ$], [稳态误差], [收敛速度], [瞬态输入], [稳态输入],
    [Sliding Mode], [$ρ e\/norm(e)$], [N/A], [5], [4], [2], [1],
    [High Gain], [$1\/ɛ ρ^2 e$], [0.1], [4], [5], [1], [2],
    [High Gain], [$1\/ɛ ρ^2 e$], [1], [2], [3], [3], [4],
    [High Freq], [$(ρ^2 e)\/(ρ norm(e) + ɛ)$], [0.1], [3], [2], [4], [3],
    [High Freq], [$(ρ^2 e)\/(ρ norm(e) + ɛ)$], [1], [1], [1], [5], [5],
  ),
  caption: [高频鲁棒控制],
  supplement: "表",
  kind: table,
)
