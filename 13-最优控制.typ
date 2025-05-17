#import "lib/lib.typ": *
#show: chapter-style.with(
  title: "最优控制",
  info: info,
)

= 最优控制
<最优控制>

最优控制是为了得到在约束条件下最优系统表现。

== 位置控制
<位置控制>

对独轮车模型

#figure(
  image("images/model/unicycle.drawio.png", width: 40%),
  caption: "独轮车",
)

令

#block(
  height: 5em,
  columns(3)[
    - 位置
      - $x_1(t) = p_x(t)$
      - $x_2(t) = p_y(t)$
    - 速度
      - $x_3(t) = v(t)$
    \
    - 角速度
      - $x_4(t) = θ(t)$
  ],
)

于是有

$ 𝒙(t) = mat(delim: "[", p_x(t); p_y(t); v(t); θ(t)) $

设计输入（控制量）

$ 𝒖(t) = mat(delim: "[", u_1(t); u_2(t)) = mat(delim: "[", α_1(t); ω_2(t)) $

可得

$
  dv(𝒙(t), t) =
  mat(delim: "[", v(t) cos θ(t); v(t) sin θ(t); 0; 0) +
  mat(delim: "[", 1; 0; α(t); ω(t)) = f(𝒙(t)), 𝒖(t)
$

== 离散化
<离散化>

对时间$t$离散化，有

$ 𝒙_([k+1]) = f_d [𝒙_([k]), 𝒖_([k])] $

设目标为

$ 𝒙_d = mat(delim: "[", p_(x d)(t); p_(y d)(t); 0; 0) $

设计代价函数（性能指标）

$
  J &= ∑_(i=1)^4 (x_(i[N]) - x_(i d))^2\
  &= (𝒙_([N]) - 𝒙_d)^⊤(𝒙_([N]) - 𝒙_d)
$

寻找合适的控制策略，使$J$最小

$
  𝒖^* =[𝒖_([0]), 𝒖_([1]), 𝒖_([2]), …, 𝒖_([N-1])] \
  𝒖^* = arg min J
$

考虑实际因素，每个状态变量的重要性不同，于是有

$
  J
  &= 1 / 2 (𝒙_([N]) - 𝒙_(d[N]))^⊤ 𝑺 (𝒙_([N]) - 𝒙_(d[N]))\
  &= 1 / 2 (𝒙_([N]) - 𝒙_(d[N]))^⊤
  dmat(delim: "[", S_1, S_2, S_3, S_4)(𝒙_([N]) - 𝒙_(d[N]))\
  &= 1 / 2 ∑_(i=1)^4 S_i (x_(i[N]) - x_(i d[N]))^2\
  &= 1 / 2 norm(𝒙_([N]) - 𝒙_(d[N]))_𝑺^2
$

其中，$𝑺_n$为半正定对称阵，$1 / 2 norm(𝒙_([N]) - 𝒙_(d[N]))_𝑺^2$称末端代价，$n$为自变量个数。

== 实际约束
<实际约束>

考虑物理约束（硬约束）

- 速度范围
- 控制量

同时，考虑能耗，有

$
  J = 1 / 2 lr(norm(𝒙_([N]) - 𝒙_(d[N])))_𝑺^2 + 1 / 2 ∑_(k=1)^(N - 1) norm(𝒖_([k]))_𝑹^2
$

其中，$𝑹 = mat(delim: "[", r_1, med; med, r_2)$为正定对称阵。由于其通过算法对$J$进行约束，故属于软约束

- 不关注能耗，则$𝑺 ≫ 𝑹$
- 关注能耗，则$𝑹 ≫ 𝑺$

#tip[
  $𝑹_(p × p)$正定时，$J$方有最小值。
]

在硬、软约束的基础上，对轨迹进行约束，有

$
  J = 1 / 2 norm(𝒙_([N]) - 𝒙_(d[N]))_𝑺^2 + 1 / 2 ∑_(k=1)^(N - 1)(norm(𝒙_([k])) - 𝒙_(d[k]))_𝑸^2 + norm(𝒖_([k]))_𝑹^2
$

其中，$𝑸_(n × n)$为半正定对角阵，$1 / 2 norm(𝒙_([k]) - 𝒙_(d[k]))_𝑸^2$称运行代价。

又轨迹中间点，$p_(x[k]), p_(y[k]) in p^*_(x[k]), p^*_(y[k])$，则

$ 𝒙_(1[k]), 𝒙_(2[k]) in X^* $

称为容许轨迹（admissible trajectory）。而控制量约束

$ 𝒖^* ∈ Ω $

称为容许控制域（set of admissible control）。

= 动态规划
<动态规划>

动态规划由 Richard Bellman 于 1966 年在《Science》上发表。

== 高度控制
<高度控制>

对无人机模型，现需要求解，从地面升高至 10m 的最短时间

#figure(
  diagram(
    node-fill: gradient.radial(white, blue, radius: 100%),
    node-stroke: blue,
    node((2, 0), [m], shape: rect),
    node((2, 1), [mg], fill: none, stroke: none),
    node((2, -1), [f(t)], fill: none, stroke: none),
    node((1.2, -.5), [h(t)], fill: none, stroke: none),
    edge((2, 0), "u", "->", snap-to: (<bar>, auto)),
    edge((2, 0), "d", "->", snap-to: (<bar>, auto)),
    edge((2, 0), "l", "-"),
    edge((1.5, 0), "u", "->"),
  ),
  caption: "无人机模型",
)

#block(
  height: 9em,
  columns()[
    初始和最终条件为
    - $h(0) = 0$
    - $dot(h)(0) = 0$
    - $h_f = 10$
    - $dot(h)_f = 0$
    物理约束为
    - $a(t) in[-3, 2]$
    - $v(t) in[0, 3]$
  ],
)

关系式为

$ m dot.double(h)(t) = f(t) - m g $

控制量为

$ u = 1 / m (f(t)) - m g = a $

其中，$f(t) = F(v_("motor"))$

于是有

- $macron(v) = 1 / 2 (v(k)) + v(k + 1)$
- $t = dd(x) / 1 / 2 (v_k + v_(k + 1))$
- $a = (v_k + v_(k + 1)) / t$

== 策略
<策略>

- 以终为始
- 空间换时间
