#import "@preview/qooklet:0.2.0": *
#show: qooklet.with(
  title: "动态系统",
  author: "ivaquero",
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  lang: "zh",
)
#import "images/control-blocks.typ": *

= 系统建模

#definition[
  系统是形成更大更复杂的整体的互连部分的集合。
]

工程项目通常很复杂。将复杂的项目分为较小的部分从而简化问题，是一贯做法。这允许人们专门从事某个功能领域，而不必在所有领域成为通才。

== 系统框图

通常，我们将以图形方式表示任何系统。进入框中的箭头表示作用于系统的外部输入。然后，系统会随着时间的推移响应这些输入以产生输出，也就是箭头离开框的箭头。

#figure(
  sys-block(
    transfer: ctext("系统"),
    input: ctext("输入"),
    output: ctext("输出"),
  ),
  caption: "系统框图",
  supplement: "图",
)

框图中的三个必需部分，引出相应的三个问题

- 如何建模要控制的系统？
- 系统的相关动力是什么？
- 将已知的输入转换为测量输出的数学方程是什么？

== 系统识别

至少有两种方法可以回答这些问题。

- 黑盒方法：将包装框中的内容对其进行各种已知输入，测量结果输出，然后根据两者之间的关系来推断框中的内容。
- 白盒方法：在了解系统的组件后，直接编写动力学的数学方程式。

通常，我们会同时使用这两种方法。

== 仿真测试

仿真问题是在考虑到已知的输入集和系统的数学模型的情况下，预测输出如何变化。我们可能会在此阶段花费大量设计时间。这里的诀窍是弄清一组有意义的输入及其范围，以便对系统的行为有一个完整的了解。这里我们需要提出以下问题

- 我的系统模型与测试数据匹配吗？
- 我的系统在所有操作环境中都可以工作吗？
- 若使用带有潜在破坏性的指令，我的系统将如何反应？

== 控制问题

最后，若我们知道系统的模型，并且知道如何希望系统有怎样的输出，则我们可以通过各种控制方法确定适当的输入。这是控制问题，即如何生成所需输出的适当系统输入？此时，我们可能需要设计控制系统：

- 如何获取系统以满足我的性能要求？
- 如何自动化当前有人参与的循环过程？
- 如何使我的系统在动态和充满噪音的环境中运行？

= 反馈控制系统
<反馈控制系统>

控制系统由受控系统（controlled system）、执行器（actuator）和控制器（controller）组成，其中，受控系统在建模通常被抽象为某一过程（process），执行器通常指负责控制系统的设备或电机，其与过程的集合被称为动态系统（dynamical system），有时也被称为工厂（plant）。

#figure(
  sys-open(
    controler: ctext("控制器"),
    actuator: ctext("执行器"),
    process: ctext("过程"),
    input: ctext("指令变量"),
    output: ctext("执行信号"),
    output2: ctext("受操纵变量"),
    output3: ctext("受控信号"),
    subunit: ctext("工厂"),
  ),
  caption: "简单控制系统",
  supplement: "图",
)

== 线性时不变系统

#definition[
  当函数$f(x)$满足以下条件时，称其是线性的：

  - 可加性：$f(x_1 + x_2) = f(x_1) + f(x_2)$
  - 齐次性：$f(a x) = a f(x)$
]

自变量和自变量的导数均为线性的系统，称为线性系统。其中，不显含时间$t$的线性系统，称线性自治（linear autonomous）系统，也称为线性时不变（linear time invariant，LTI）系统，其系数不随时间变化，即

$ dot(x) = f(x) $

LTI 是最常用的动态系统，其在具有线性性质的同时，还服从自治（时不变）原理，即

$ O{f(t)} = x(t) ⇒ O{f(t - τ)} = x(t - τ) $

与之相对，显含时间$t$的系统，称线性非自治（non-autonomous）系统或线性时变（time varying）系统，其系数不随时间变化，即

$ dot(x) = f(t, x) $

== 控制器

从控制模式上，控制器分为开环控制和闭环控制。开环控制系统通常保留给对输出行为的简单过程的简单过程。其常见示例是洗碗机，用户设置洗涤计时后，洗碗机将在该设定的时间内运行。无论是否洗涤干净，计时器都不会增加或减少洗涤时间。而在更多的情况下，我们需要得到反馈（feedback），从而调整我们的输出

- 开环控制：根据参考值（reference）决定控制量，即系统输入
- 闭环控制：通过测量系统输出与参考值之间的误差，反馈至输入端，决定控制量

#figure(
  sys-closed(
    controler: ctext("控制器"),
    actuator: ctext("执行器"),
    sensor: ctext("传感器"),
    input: ctext("指令信号"),
    output: ctext("执行信号"),
    output2: ctext("传感信号"),
    error: ctext("误差表"),
    reference: ctext("参考函数"),
  ),
  caption: "闭环控制器",
  supplement: "图",
)

简单说，控制系统是改变系统的行为（或未来状态）的机制。听起来几乎可以将任何东西视为控制系统。好吧，控制系统的定义特征之一是，系统的未来必须趋向于所需的状态。这意味着，作
为设计师，我们必须知道要系统的操作，然后设计控制系统以生成所需的结果。

= 流体力学基础
<流体力学基础>

== 压强

- 静压（hydrostatic pressure）

即重力产生的压力

$ P = frac(m g, A) $

对均值且不可压缩流体

$
  P_("static") = frac(ρ A h g, A) = ρ g h
$

- 绝对压强（absolute pressure）

$ P_("abs") = P_a + P_("static") $

- 表压（gauge pressure）

$ P_("gauge") = P_("abs") - P_a = ρ g h $

#figure(
  image("images/model/liquid.drawio.png", width: 40%),
  caption: "流体系统",
  supplement: "图",
)

== 阻力

- 理想压源

阻力阀左右两端的压力差

$ P_2 = P_1 + P_(g a u g e) $

- 压头损失

阻力阀左右两端的压力差

$ P_1 - P_2 = ρ q R $

其中，$R$为流阻。

上图中，有

$ P_1 - P_a = ρ q_("out") R $

即

$
  q_("out")
  &= frac(P_1 - P_a, ρ R)\
  &= frac(P_a + ρ g h - P_a, ρ R)\
  &= frac(g h, R)
$

== 守恒

- 质量守恒

$ dv(m, t) = m_("in") - m_("out") $

等式两端除以$ρ$，得

$ dv(V, t) = q_("in") - q_("out") $

两端除以$A$，从而有

$ dv(h, t) = 1 / A (q_("in") - q_("out")) $

- 压力守恒

$ dv(P, t) = dv(P_a + ρ g h, t) $

可得

$ dv(P, t) = ρ g dv(h, t) = frac(ρ g, A)(q_("in") - q_("out")) $

由上，可得

$ dv(h, t) = q_("in") / A - frac(g h, A R) $

= 电学基础
<电学基础>

== 电学单位

#let data = csv("data/electrics.csv")
#figure(
  ktable(data, 5),
  caption: "电学单位",
  supplement: "表",
  kind: table,
)

=== 电压

$
  e_R = I R\
  e_C = Q / C = 1 / C ∫_0^t I dd(t)\
  e_L = L dv(I, t) = L I^′
$

== 电学定律

#law("Ohm 定律")[
  $ I = e_R / R $
]

#law("Kirchhoff 电流定律（KCL）")[

  所有进入某节点的电流的总和等于所有离开这节点的电流的总和。
]

#law("Kirchhoff 电压定律（KVL）")[

  沿着闭合回路所有元件两端的电压的代数和等于零。
]

== RLC 电路

RLC 电路是一种由电阻 R、电感 L、电容 C 组成的电路结构。

#figure(
  image("images/model/circuit-rlc.drawio.png", width: 40%),
  caption: " RLC",
  supplement: "图",
)

定义上图区域 1 和区域 2 的电流方向均为顺时针，则

- 电容 C 上端为电压为正，下端电压为负- 电感 L 左端为电压为正，右端电压为负- 电阻 R 左端为电压为正，右端电压为负

由 KVL

$
  e_L + e_C - e_i = 0\
  e_(R_1) + e_(R_2) - e_C = 0
$

两式相加，得

$ e_L + e_(R_1) + e_(R_2) - e_i = 0 $

即，整体电路的闭环的电压代数和为$0$。分别计算各项，有

- $e_(R_1) = I_2 R_1 = I_2$
- $e_(R_2) = I_2 R_2 = 3 I_2$
- $e_L = L I_1^′ = 2 I_1^′$
- $e_C = 1 / C ∫_0^t (I_1 - I_2) dd(t) = 4 ∫_0^t (I_1 - I_2) dd(t)$

回代入第一个方程组，得

$
  2 I_1^′ + 4 I_2 = e_i\
  I_2 = ∫_0^t (I_1 - I_2) dd(t)
$

对第二个子式连续求导，得

$ I_1^′ = I_2^″ + I_2^′ $

又$e_o = I_2 R_2 = 3 I_2$，则

$ 2 e_o^″ + 2 e_o^′ + 4 e_o = 3 e_i $

#figure(
  image("images/model/circuit-rlc.png", width: 60%),
  caption: "RLC",
  supplement: "图",
)

= 电磁学基础
<电磁学基础>

== 电磁学单位

#let data = csv("data/magnetics.csv")
#figure(
  ktable(data, 3),
  caption: "电磁学单位",
  supplement: "表",
  kind: table,
)

$ ϕ = B S $

其中，$B$为匀强磁场的磁感应强度，$S$是正对磁场的面积（$m^2$）。

== 电磁学定律

#law("Lenz 定律")[
  感应电流产生的磁场总要阻碍引起感应电流的磁通量的变化。

  $ e_L = -n frac(Δ ϕ, Δ t) $

  其中，$n$为循环数或线圈匝数、$ϕ$为磁通量。
]

#tip[
  Lenz 定律（电磁学）和 Newton 第一定律（力学）、Le Chatelier 原理（化学）本质相同，同属惯性定律。
]

= 辅助知识

== 自动化系统

一个典型的自动化系统由 4 部分构成

+ Sense (collect data)
+ Perceive (interpret data)
+ Plan (find path)
+ Act (follow path)

其中，前 2 步的工作并称为传感融合（sensor fusion）。其作用有 3 个

+ 提高数据质量（降低噪声）
+ 估计未量测状态
+ 提高覆盖率
