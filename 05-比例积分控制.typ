#import "lib/sci-book.typ": *
#show: doc => conf(
  title: "比例积分控制",
  author: ("ivaquero"),
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= 比例控制
<比例控制>

== 体重变化
<体重变化>

已知，7000 kcal ∼ 1 kg

于是，有

$ dv(m, t) = frac(E_i - E_e, 7000) $

其中，$m$为体重，$E_i$为饮食摄入热量，$E_e$为消耗（expenditure）热量，$E_e$的计算方法为

$ E_e = E_a + α P $

其中，$E_a$为客观运动消耗热量，$α$为正常消耗系数，$P$为基础代谢率（base metabolic rate，BMR）。

对$α$有

- 轻体力劳动：$α = 1.3$
- 中体力劳动：$α = 1.5$
- 重体力劳动：$α = 1.9$

对 BMR，有 Mifflin Jeor 公式

$ P = 10 m + 6.25 h - 5 a + s $

其中，$h$为身高，$a$为年龄，s 为代谢常数（男：5，女：-161）。

== 控制器与稳定性
<控制器与稳定性>
上，不难得出

$ dot(m) &= frac(E_i - E_a - α (10 m + 6.25 h - 5 a + s), 7000)\
 &= frac(E_i - E_a - 10 α m - α C, 7000) $

其中，$C = 6.25 h - 5 a + s$

令

- 输入：$u = E_i - E_a$
- 扰动：$d = -α C$
- 输出：$m$

于是，有

$ 7000 dot(m) + 10 m = u + d $

等号两边同时进行 Laplace 变换，得

$ frac(M(s), U(s) + D(s)) = frac(1, 7000 s + 100) $

#figure(
  image("./images/block/prop.drawio.png", width: 40%),
  caption: [比例控制],
  supplement: "图"
)

对控制器

$ u = k_p e $

其中，$e = r - m$，即参考值与实际体重的误差。

== 引入比例
<引入比例>

这里，有

$ [k_p(R - M) + D] frac(1, 7000 s + 10 α) = M $

整理，得

$ M = frac(k_p R + D, 7000 s + 10 α + k_p) $

当$M$的极点小于$0$，系统稳定。一种常见情况是，$R$和$D$是稳定的，即

- $R = ℒ[r] = r/s$
- $D = ℒ[d] = d/s$

此时

$ M = frac(k_p r/s + d/s, 7000 s + 10 α + k_p) $

令分子为$0$，求出$P_1$和$P_2$

$ m(t) = C_1 e^(0 t) + C_2 e^(frac(-10 α - k_p, 1000)t) $

由于第一项为常数，系统稳定性由$k_p + 10 α$确定。

= 稳态误差
<稳态误差>

== 终值定理
<终值定理>

稳态误差，指系统稳定时的输出值和参考值之间的差值，即

$ e_(s s) = r - lim_(t → ∞) x(t) $

要对稳态误差实现有效控制，需要终值定理（final value theorem，FVT），即

当$∃ lim_(t → ∞) x(t)$ 时

$ lim_(t → ∞) x(t) = lim_(s → 0) s X(s) $

#tip[
  终值定理可以省去 Laplace 逆变换，得到时域上的最终结果，常用于系统稳态判断。
]

== 弹簧阻尼系统
<弹簧阻尼系统>

#figure(
  image("./images/model/vibration.drawio.png", width: 40%),
  caption: [弹簧阻尼系统],
  supplement: "图"
)

对弹簧阻尼系统

$ m dot.double(x) + k x + B dot(x) = F $

使输出$u = F$，两边同时进行 Laplace 变换，整理得

$ frac(X(s), U(s)) = frac(1, m s^2 + B s + k) $

这里仅讨论欠阻尼状态，考虑

- 对冲击响应$δ(t)$

$u(s) = ℒ[δ(t)] = 1$，于是

$ X(s) = frac(1, m s^2 + B s + k) $

使用 FVT，有

$ lim_(t → ∞) x(t) = lim_(s → 0) frac(s, m s^2 + B s + k) = 0 $

- 对阶跃响应$c$

$u(s) = ℒ[c] = c/s$，于是

$ X(s) = c/s frac(1, m s^2 + B s + k) $

使用 FVT，有

$ lim_(t → ∞) x(t) = lim_(s → 0) c/s frac(s, m s^2 + B s + k) = c/k $

#tip[
  无阻尼状态，即$B = 0$时，$lim_(t → ∞) x(t)$ 不存在，无法使用 FVT。
]

= 积分控制
<积分控制>

== 比例控制器
<比例控制器>

#figure(
  image("./images/block/prop-simple.drawio.png", width: 40%),
  caption: [弹簧阻尼系统框图],
  supplement: "图"
)

对上图系统，有

$ k_p(R(s) - X(s)) frac(1, "as" + 1) = X(s) $

整理得

$ X(s) = frac(k_p R(s), "as" + 1 + k_p) $

为使$X(s)$稳定，则其极点$s$需要小于$0$，即

$ s = frac(-1 - k_p, a) < 0 $

可知$k_p$应大于$-1$。此时，可使用 FVT。

当$r(t) = r$，有

$ X(s) = frac(k_p r/s, "as" + 1 + k_p) $

使用 FVT，有

$ lim_(t → ∞) x(t) = lim_(s → 0) s frac(k_p r/s, "as" + 1 + k_p) = frac(k_p, 1 + k_p) r $

此时

$ e_(s s) = r - frac(k_p, 1 + k_p) r = frac(1, 1 + k_p) r $

由上，要消除稳态误差，需要$k_p → ∞$，这显然不可能，所以比例控制的效果有限。

== 比例积分控制
<比例积分控制>

将上述系统中的$k_p$替换为$c(s)$，使

$ lim_(s → 0) c(s) → ∞ $

则可消除$e_(s s)$。由 Laplace 变换，只需要因子$1/s$即可达到目的，显然此处需要引入积分运算。

令$c(s) = k_I/s$，有

$ X(s) = frac(r/s⋅k_I/s, "as" + 1 + k_I/s) = r/s frac(k_I, a s^2 + s + k_I) $

整理并进行 Laplace 逆变换，得

$ a x ̈(t) + x ̇(t) + k_I = r k_I $

这即是二阶系统的阶跃响应。即，通过引入积分，系统被升阶为了一个二阶系统。
