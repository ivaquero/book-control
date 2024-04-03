#import "lib/sci-book.typ": *
#show: doc => conf(
  title: "比例微分控制",
  author: ("ivaquero"),
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)
#show: thmrules

= 根轨迹
<根轨迹>

== 图像绘制
<图像绘制>
对如下闭环系统

#figure(
  image("./images/block/closed-1.drawio.png", width: 40%),
  caption: [闭环控制],
  supplement: "图"
)

$ frac(Y(s), R(s)) = frac(K G(s), 1 + K G(s)) $

分子为$0$时得到的极点，即为根。

#tip[
  对根的分析，就是对分子中变量函数的分析。
]

对传递函数

$ G(s) = frac(N(s), D(s)) = frac(∑_(i=1)^m (s - z_i), ∑_(j=1)^n (s - p_j)) $

- $N(s) = 0$时，$s_1 = z_1, z_2 = z_2, …$，称零点（zeros），$N(s)$为$m$阶
- $D(s) = 0$时，$s_1 = p_1, s_2 = p_2, …$，称极点（poles），$D(s)$为$n$阶

此时有如下规则

- 当$m ≠ n$，根轨迹（root locus）共有$max(m, n)$条
- 当$m = n$，随着$K → ∞$，根轨迹从$G(s)$的零点向极点移动
- 复平面实轴上的根轨迹存在于由右至左的第$2n + 1$个零点或极点左边
  - 当$m < n$，则有$n - m$条根轨迹从极点指向$∞$
  - 当$m > n$，则有$m - n$条根轨迹从$∞$指向零点
- 若存在复数根，其必共轭，其更轨迹关于复平面实轴对称
- 根轨迹沿渐近线移动
  - 渐近线与实轴的交点为$δ = frac(∑ p - ∑ z, n - m)$
  - 渐近线与实轴的夹角为$θ = frac(2 q + 1, n - m) π, q = 0, 1, …, |m - n| - 1$
- 根轨迹上的点满足$∠K G(s) = -π$

== 汇合点 & 分离点
<汇合点-分离点>
对弹簧阻尼系统

#figure(
  image("./images/model/vibration.drawio.png", width: 40%),
  caption: [弹簧阻尼系统],
  supplement: "图"
)

有

$ dot.double(x) + 2 ζ ω_n dot(x) + ω_n^2 x = u $

其中，$ζ$为阻尼比，$ω_n$为固有频率。

此时，传递函数为

$ G(s) = frac(1, s^2 + 2 ζ ω_n s + ω_n^2) $

令$ζ = K$，化为一般形式，得

$ frac(1, s^2 + ω_n^2) dot.double(x) + 2 K ω_n dot(x) + ω_n^2 x = 0 $

整理得

$ 1 + K frac(2 ω_n s, s^2 + ω_n^2) = 0 $

此时，新的传递函数为

$ G_("new")(s) = frac(2 ω_n s, s^2 + ω_n^2) $

- 该函数的极点：$p_1 = j ω_n$和$p_2 = -j ω_n$
- 该函数的零点：$z = 0$

由

$ K frac(2 ω_n s, s^2 + ω_n^2) = -1 $

得

$ K = -frac(s^2 + ω_n^2, 2 ω_n s) $

其中，$s = σ + j ω$，于是

$ K(σ) = -frac(σ^2 + ω_n^2, 2 ω_n σ) $

求导得$σ = ±ω_n$，由上$σ$只能在实轴的左边，故$σ = -ω_n$，此时

$ K(σ) = 1 = ζ $

== 几何性质
<几何性质>

对复数

- $z_1 = σ_1 + j ω_1 = r_1 e^(i θ_1)$
- $z_2 = σ_2 + j ω_2 = r_2 e^(i θ_2)$

有

- $z_1⋅z_2 = r_1 r_2 e^(i (θ_1 + θ_2))$
- $z_1/z_2 = r_1/r_2 e^(i (θ_1 - θ_2))$

对

$ G(s) = frac(N(s), D(s)) $

令$s = σ + j ω$，则

- $r = frac(∏|z_i - σ|, ∏|p_j - σ|)$
- $θ = ∑ θ_(z_i) - ∑ θ_(p_j)$

= 补偿器
<补偿器>

== 超前补偿器
<超前补偿器>

对如下系统

#figure(
  image("./images/block/closed-2.drawio.png", width: 40%),
  caption: [闭环系统],
  supplement: "图"
)

- 极点：$p_1 = 0$和$p_2 = -2$
- 零点：无
- 渐近线：$σ_a = (-2 + 0 - 0)/(2 - 0) = -1$
- 夹角：$θ_a = π/2$

绘制出图像，对$K$分析

- 当$K$较小时，$p_1, p_2 < 0$，函数收敛，收敛速度由$p_1$和$p_2$中较小者决定

$ X(t) = C_1 e^(p_1 t) + C_2 e^(p_2 t) $

- 当$K$增加，根移动至复平面，实部落在渐近线，收敛速度由$e^(-σ_a t)$决定

$ C(t) = C e^(-σ_a t) sin ω_n t $

此时，改变$K$并不能加快收敛速度。加速需使渐近线左移。

== PD 控制
<pd-控制>

#h(2em) 根轨迹的性质，根轨迹上的点满足$∠K G(s) = -π$。所以，若想使渐近线左移，可以在极点左边补充零点和极点，使夹角和满足上述条件。

在增益前，加入新的控制模块$H = s + 8$，其中

- $s$为微分（derivative）
- $8$为比例（proportion）

#figure(
  image("./images/block/compens-lead-1.drawio.png", width: 40%),
  caption: [PD 控制],
  supplement: "图"
)

这就是比例微分控制（PD control），这种控制器有两个明显的缺点

- 需要外来能量源
- 对高频信号敏感

此时，需要引入超前补偿器（lead compensator）

$ H(s) = frac(s - z, s - p) $

其中，$|z| < |p|$。

#tip[
  这里的“超前”指相位提前。
]

== 滞后补偿器
<滞后补偿器>

对闭环系统，其误差为

$ 𝔼[s] = R(s) - X(s) = R(s) - 𝔼[s] K G(s) $

整理得

$ 𝔼[s] = R(s) frac(1, 1 + K G(s)) = R(s) frac(N(s), 1 + K N(s))/D(s) $

假设$R(s)$为单位阶跃函数$1/s$，此时的稳态误差为

$ e_(s s) &= lim_(t → ∞) e(t) = lim_(s → 0) s 𝔼[s]\
 &= lim_(s → 0) s 1/s frac(1, 1 + frac(N(s), D(s)))\
 &= frac(1, 1 + K N(0))/D(0)\
 &= frac(D(0), D(0)) + K N(0) $

#figure(
  image("./images/block/compens-lag.drawio.png", width: 40%),
  caption: [
    closed-lag
  ],
  supplement: "图"
)

加入滞后补偿器（lag compensator）后，$𝔼[s]$变为

$ 𝔼[s] = R(s) - X(s) = R(s) - 𝔼[s] K G(s) frac(s + z, s + p) $

整理得

$ 𝔼[s] = R(s) frac(1, 1 + K G(s)) = R(s) frac(N(s), 1 + K N(s))/D(s) * (s + z)/(s + p) $

稳态误差为

$ e_(s s) = frac(D(0), D(0)) + K N(0) * z/p $

若$z > p$，则可减小$e_(s s)$，即通过调整$z/p$可以减少$e_(s s)$。

#tip[
  当$p = 0$，$e_(s s) → 0$，$H(s) = 1 + z/s$，此为比例积分控制。
]

= PID 控制器
<PID-控制器>

== 控制途径
<控制途径>

当$r(t) - x(t) ≠ 0$，有如下 3 种手段减小误差

- 比例控制：基于当前误差，调节$k_p⋅e$，其中，$k_p$为比例增益
- 积分控制：基于过去误差，调节$k_I ∫e dd(t)$，其中，$k_I$为积分增益
- 微分控制：基于误差变化，调节$k_D dv(e, t)$，其中，$k_D$为微分增益

将三者整合，得

$ u = k_p e + k_I ∫e dd(t) + k_D dv(e, t) $

两端同时 Laplace 变换，得

$ U(s) = (k_p + k_I 1/s + k_D s) 𝔼[s] $

由此得到的 PID 控制兼具了以下两种控制的优点

- PD 控制：提高稳定性，改善瞬态响应
- PI 控制：降低稳态误差

== Cauchy 幅角原理
<Cauchy-幅角原理>

对复数$q = a + b j$，将其通过映射$F(s)$，可得新的复数$F(q) = a′ + b′ j$。

假设两个复数分别位于的平面称为平面$A$和平面$B$，则映射$F(s)$将平面$A$中的零点/极点平移至平面$B$的原点，此时

#figure(
  table(
    columns: 5,
    align: center + horizon,
    inset: 4pt,
    stroke: frame(rgb("000")),
    [], [幅角], [新幅角], [模], [新模],
    [零点], [$ϕ_1$], [$ϕ_1$], [$v_1$], [$v_1$],
    [极点], [$ϕ_2$], [$-ϕ_2$], [$v_2$], [$1/v_2$],
    [零点 + 极点], [$ϕ_1, ϕ_2$], [$ϕ_1 - ϕ_2$], [$v_1, v_2$], [$v_1/v_2$],
 ),
  caption: [幅角],
  supplement: "表",
  kind: table
)

#tip[
  幅角：零点/极点与平面内的任一点连线与横轴的夹角
]

#theorem("幅角原理（Argument Principle）")[
  在$S$平面内画一条闭环曲线$A$，曲线$B$由曲线$A$通过映射$F(s)$得到，则

  - 曲线$A$每包含1个$F(s)$的零点，曲线$B$就绕原点顺时针一圈
  - 曲线$A$每包含1个$F(s)$的极点，曲线$B$就绕原点逆时针一圈
]
