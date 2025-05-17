#import "lib/lib.typ": *

#cover(info)
#preface(info: info)[
  This is an example to test the template
]
#contents(depth: 1, info: info)

#let chapter(filename) = {
  include filename
  counter(heading).update(0)
}

#chapter("01-控制问题.typ")
#chapter("02-进入频域.typ")
#chapter("03-传递函数.typ")
#chapter("04-物理应用一.typ")
#chapter("05-时域响应分析.typ")
#chapter("06-比例积分控制.typ")
#chapter("07-比例微分控制.typ")
#chapter("08-频域响应分析.typ")
#chapter("09-控制器设计.typ")
#chapter("10-状态观测器.typ")
#chapter("11-反馈线性化控制.typ")
#chapter("12-非线性控制器.typ")
#chapter("13-最优控制.typ")
#chapter("14-线性二次型调节器.typ")
#chapter("15-轨迹追踪.typ")
#chapter("16-模型预测控制器.typ")
#chapter("A-复矩阵.typ")
#chapter("matlab-control.typ")
