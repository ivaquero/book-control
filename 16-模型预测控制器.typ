#import "@local/scibook:0.1.0": *
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

$ J = ∫_0^(⊤) q e^2 + r u^2 dd(t) $

拓展至 MIMO 情况，则有

$
  dv(𝒙, t) &= 𝑨 𝒙 + 𝑩 𝒖 \
  𝒀 &= 𝑪 𝒙
$

其代价函数中的变量，只有$𝒛$

$ min J = underbrace(𝒛^(⊤) 𝑸 𝒛, "二次型") + underbrace(𝑪^(⊤) 𝒛, "线性") $ <cost-quad>

对某二维系统

$
  dv(, t) vec(delim: "[", 𝒙_1, 𝒙_2) &= 𝑨 vec(delim: "[", 𝒙_1, 𝒙_2) + 𝑩 vec(delim: "[", 𝒖_1, 𝒖_2)\
  vec(delim: "[", y_1, y_2) &= vec(delim: "[", 𝒙_1, 𝒙_2)
$

又参考值

$ 𝑹 = vec(delim: "[", r_1, r_2) = vec(delim: "[", 0, 0) $

则系统误差为

$
  𝑬 = vec(delim: "[", e_1, e_2) = vec(delim: "[", y_1-r_1, y_2-r_2
) = vec(delim: "[", 𝒙_1, 𝒙_2)
$

此时，有

$
  J &= ∫_0^x 𝑬^(⊤) 𝑸 𝑬 + 𝒖^(⊤) 𝑹 𝒖 dd(t) \
  &= q_1 𝒙_1^2 + q_2 𝒙_2^2 + r_1 𝒖_1^2 + r_2 𝒖_2^2
$ <cost-quad2>

其中，$q_i$和$r_i$为权重系数。

= 模型预测控制器

== 滚动时域优化

模型预测控制器，通过模型预测系统在未来某一时间段内的表现，进行优化控制。

对离散系统

$ 𝒙_(k+1) = 𝑨 𝒙_k + 𝑩 𝒖_k $

其计算$𝒙_(k+1)$的大致步骤为

1. 估计/测量$k$时刻系统状态；
2. 基于代价函数进行最优化控制。离散化@eqt:cost-quad2，得

$ J = ∑_k^(N-1) (𝒆^(⊤)_k 𝑸 𝒆_k + 𝒖^(⊤)_k 𝑹 𝒖_k) + 𝒆^(⊤)_N 𝑭 𝒆_N $ <cost-mpc>

3. 以$𝒖_k^*$作为输入，重复第2步，进行继续循环；

== 代价函数推导

MPC 问题的一个难点就是最小化代价函数的计算。目前的思路是将@eqt:cost-mpc 转化为二次型，这里令

$
  𝑿_k = [𝒙_((k|k)), 𝒙_((k+1|k)), …, 𝒙_((k+N|k))]^(⊤) \
  𝑼_k = [𝒖_((k|k)), 𝒖_((k+1|k)), …, 𝒖_((k+N-1|k))]^(⊤)
$

于是，@eqt:cost-mpc 变为条件式

$
  min J = ∑_(i=k)^(N-1) (
    underbrace(𝒙^(⊤)_(k+i|k) 𝑸 𝒙_(k+i|k), "误差的加权和") + underbrace(𝒖^(⊤)_(k+i|k) 𝑹 𝒖_(k+i|k), "输入的加权和")
  ) + underbrace(𝒙^(⊤)_(k+N) 𝑭 𝒙_(k+N), "终端误差")
$ <cost-mpc2>

为将@eqt:cost-mpc2 化为@eqt:cost-quad 形式，即只有一个变量的形式，做如下代换

$
  cases(
  𝒙_((k|k)) = 𝒙_k,
  𝒙_((k+1|k)) = 𝑨 𝒙_k + 𝑩 𝒖_(k|k),
  …,
  𝒙_((k+N|k)) = 𝑨^N 𝒙_k + 𝑨^(N-1) 𝑩 𝒖_(k|k) + … + 𝑩 𝒖_(k+N-1|k))
$

其简写如下。其中，$𝑪$的零行向量个数为$n$，取决于初始状态。

$
  𝑿_(k+1) = 𝑴 𝑿_k + 𝑪 𝑼_k
$ <mc>

其中

$
  𝑴 = mat(delim: "[", 𝑰; 𝑨; 𝑨^2; ⋮; 𝑨^N),
  𝑪 =
  mat(delim: "[", 0, 0, …, 0; ⋮, ⋮, ⋮, ⋮; 0, 0, …, 0; 𝑩, 0, ⋯, ⋮; 𝑨 𝑩, 𝑩, ⋯, ⋮; ⋮, ⋮, ⋮, ⋮; 𝑨^(N-1) 𝑩, 𝑨^(N-2) 𝑩, ⋯, 𝑩)
$

将@eqt:cost-mpc2 展开，得

$ J = 𝒙_k^(⊤) macron(𝑸) 𝒙_k + 𝑼_k^(⊤) macron(𝑹) 𝑼_k $

其中

$ macron(𝑸) = dmat(delim: "[", Q, Q, ⋱, F), space macron(𝑹) = dmat(delim: "[", R, R, ⋱, R) $

代入@eqt:mc，得

$
  J &= 𝒙_k^(⊤) underbrace(𝑴^(⊤) macron(𝑸) 𝑴, "𝑮") 𝒙_K + 𝒙_k^(⊤) underbrace(𝑴^(⊤) macron(𝑸) 𝑪, "𝑬") 𝑼_k + 𝑼_k^(⊤) underbrace(𝑪^(⊤) macron(𝑸) 𝑴, "𝑬") 𝒙_k + 𝑼_k^(⊤) (
    underbrace(𝑪^(⊤) macron(𝑸) 𝑪 + macron(𝑹), "𝑯")
  ) 𝑼_k \
  &= 𝒙_k^(⊤) 𝑮 𝒙_k + 2 𝒙_k^(⊤) 𝑬 𝑼_k + 𝑼_k^(⊤) 𝑯 𝑼_k
$
