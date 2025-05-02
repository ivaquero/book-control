#import "lib/lib.typ": *
#show: qooklet.with(
  title: "状态观测器",
  author: "ivaquero",
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  lang: "zh",
)

= Luenberger 观测器
<Luenberger-观测器>

观测器：根据系统输入和输出，估计系统的状态。

== 推导
<推导>

对系统

$
  dot(x) = 𝑨 x + 𝑩 u\
  y = 𝑪 x + 𝑫 u
$

其中，$u$为输入，$y$为输出。

引入 Luenberger 观测器，有

$
  hat(dot(x)) = 𝑨 hat(x) + 𝑩 u + 𝑳 (y - hat(y))\
  hat(y) = 𝑪 hat(x) + 𝑫 u
$

$(3), (4)$两式联立，得

$ hat(dot(x)) = (𝑨 - 𝑳 𝑪) hat(x) + (𝑩 - 𝑳 𝑫) u + 𝑳 y $

$(1) - (5)$，得

$ dot(x)- hat(dot(x)) = 𝑨 x + 𝑩 u - (𝑨 - 𝑳 𝑪) hat(x) - (𝑩 - 𝑳 𝑫) y - 𝑳 y $

代入$(2)$，得

$ dot(x)- hat(dot(x)) = (𝑨 - 𝑳 𝑪)(x - hat(x)) $

令$e_x = x - x ̂$，得

$ dot(e)_x = (𝑨 - 𝑳 𝑪) e_x $

若像使$e_x → 0$，则需

$ "Re"["Eig"(𝑨 - 𝑳 𝑪)] < 0 $

即当$|λ 𝑰 - (𝑨 - 𝑳 𝑪)| = 0$的解$λ < 0$，则系统稳定。

#tip[
  通过矩阵的迹的性质，可以确定系统稳定性。
]

== 弹簧阻尼系统
<弹簧阻尼系统>

对弹簧阻尼系统

- $m = 1$
- $K = 1$
- $B = 0.5$

#figure(
  image("images/model/vibration.drawio.png", width: 40%),
  caption: "弹簧阻尼系统",
  supplement: "图",
)

令

- $z_1 = x$
- $z_2 = dot(x)$（不可测）
- $u = F$

则

$
  mat(delim: "[", dot(z)_1; dot(z)_2) =
  mat(delim: "[", 0, 1; - 1, - 0.5)
  mat(delim: "[", z_1; z_2) +
  mat(delim: "[", 0; 1) u
$

同时

$ y = mat(delim: "[", 1, 0) mat(delim: "[", z_1; z_2) $

引入观测器，有

$
  mat(delim: "[", hat(dot(z))_1; hat(dot(z))_2) =
  mat(delim: "[", - 2.5, 1; 0.25, - 0.5)
  mat(delim: "[", hat(z)_1; hat(z)_2) +
  mat(delim: "[", 0; 1) u +
  mat(delim: "[", 2.5; - 1.25) y
$

= 可观测性
<可观测性>

== 分离原理
<分离原理>

对系统

$
  dot(x) &= 𝑨 x + 𝑩 u\
  y &= 𝑪 x
$

引入观测器

$ dot(e)_x = (𝑨 - 𝑳 𝑪) e_x $

引入控制器

$
  u &= -k hat(x) \
  dot(x) &= 𝑨 x - 𝑩 k hat(x) = (𝑨 - 𝑩 k) x + 𝑩 k e
$

联立，得

$
  mat(delim: "[", dot(e_λ); x ̇) = mat(delim: "[", 𝑨 - 𝑳 𝑪, 0; 𝑩 k, 𝑨 - 𝑩 k) mat(delim: "[", e_x; x ̇) = 𝑴 mat(delim: "[", e_x; x ̇)
$

为使$e_x → 0$，则需

$ "Re"["Eig"(𝑴)] < 0 $

由于$𝑴$的特征值即是$(𝑨 - 𝑳 𝑪)$和$(𝑨 - 𝑩 k)$的特征值，则系统稳定需同时满足以下条件

- $"Re"["Eig"(𝑨 - 𝑳 𝑪)] < 0$
- $"Re"["Eig"(𝑨 - 𝑩 k)] < 0$

#tip[
  同一系统的观测器的收敛速度远大于控制器的。
]

#theorem("可观测性")[
  若一个系统可观测，则其观测矩阵
  $ 𝑫 = mat(delim: "[", 𝑪; 𝑪 𝑨; ⋮; 𝑪 𝑨^(n-1)) $
  满秩。
]
