#import "lib/sci-book.typ": *
#show: doc => conf(
  title: "模型预测控制器",
  author: ("ivaquero"),
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= 二维动态系统

对轨迹追踪问题

- 误差 $∫e^2 dd(t)$越小，追踪越好
- 输入 $∫u^2 dd(t)$越小，能耗越低

于是，整体代价函数为

$ J = ∫_0^t q e^2 + r u^2 dd(t) $

拓展至 MIMO 情况，则有

$
  dv(𝑿, t) &= 𝑨 𝑿 + 𝑩 𝑼 \
  𝒀 &= 𝑪 𝑿
$

其代价函数为

$ J = ∫_0^x 𝑬^(⊤) 𝑸 𝑬 + 𝑼^(⊤) 𝑹 𝑼 dd(t) $ <cost>

对某二维系统

$
  dv(, t) vec(delim: "[", x_1, x_2) &= 𝑨 vec(delim: "[", x_1, x_2) + 𝑩 vec(delim: "[", u_1, u_2)\
  vec(delim: "[", y_1, y_2) &= vec(delim: "[", x_1, x_2)
$

又参考值

$ 𝑹 = vec(delim: "[", r_1, r_2) = vec(delim: "[", 0, 0) $

则系统误差为

$
  𝑬 = vec(delim: "[", e_1, e_2) = vec(delim: "[", y_1-r_1, y_2-r_2
) = vec(delim: "[", x_1, x_2)
$

此时，有

$ J = q_1 x_1^2 + q_2 x_2^2 + r_1 u_1^2 + r_2 u_2^2 $

其中，$q_i$和$r_i$为权重系数。

= 模型预测控制器

== 滚动时域优化

模型预测控制器，通过模型预测系统在未来某一时间段内的表现，从而进行优化控制。对离散系统

$ 𝑿_(k+1) = 𝑨 𝑿_k + 𝑩 𝑼_k $

其计算$𝑿_(k+1)$的大致步骤为

1. 估计/测量$k$时刻系统状态；
2. 基于代价函数进行最优化控制。离散化@cost，得

$ J = ∑_k^(N-1) (𝑬^(⊤)_k 𝑸 𝑬_k + 𝑼^(⊤)_k 𝑹 𝑼_k) + 𝑬^(⊤)_N 𝑭 𝑬_N $

3. 以$𝑼_k^*$作为输入，重复第2步，进行继续循环；

== 代价函数推导
