#let chapter(filename) = {
  include filename
  context counter(heading).update(0)
}

#chapter("01-控制问题.typ")
#chapter("02-传递函数.typ")
#chapter("03-物理应用I.typ")
#chapter("04-时域响应分析.typ")
#chapter("05-比例积分控制.typ")
#chapter("06-比例微分控制.typ")
#chapter("07-频域响应分析.typ")
#chapter("08-控制器设计.typ")
#chapter("09-状态观测器.typ")
#chapter("10-反馈线性化控制.typ")
#chapter("11-非线性控制器.typ")
#chapter("12-动态规划.typ")
#chapter("13-线性二次型调节器.typ")
#chapter("14-轨迹追踪.typ")
#chapter("15-模型预测控制器.typ")
#chapter("A-Fourier变换.typ")
#chapter("B-复矩阵.typ")
#chapter("matlab-control.typ")
