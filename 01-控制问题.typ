#import "lib/lib.typ": *
#show: chapter-style.with(title: "控制问题", info: info)

= 系统建模

#definition[
  系统是形成更大更复杂的整体的互连部分的集合。
]

工程项目通常很复杂。将复杂的项目分为较小的部分从而简化问题，是一贯做法。这允许人们专门从事某个功能领域，而不必在所有领域成为通才。

== 系统框图

通常，我们将以图形方式表示任何系统。进入框中的箭头表示作用于系统的外部输入。然后，系统会随着时间的推移响应这些输入以产生输出，也就是箭头离开框的箭头。

#figure(
  sys-block(transfer: ctext("系统"), input: ctext("输入"), output: ctext(
    "输出",
  )),
  caption: "系统框图",
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
)

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
    loss: ctext("损失函数"),
    reference: ctext("参考函数"),
  ),
  caption: "闭环控制器",
)

简单说，控制系统是改变系统的行为（或未来状态）的机制。听起来几乎可以将任何东西视为控制系统。好吧，控制系统的定义特征之一是，系统的未来必须趋向于所需的状态。这意味着，作
为设计师，我们必须知道要系统的操作，然后设计控制系统以生成所需的结果。
