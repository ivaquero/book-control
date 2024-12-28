#let chapter(filename) = {
  include filename
  context counter(heading).update(0)
}

#chapter("01-动态系统.typ")
#chapter("02-Fourier变换.typ")
#chapter("03-Laplace变换.typ")
#chapter("04-状态空间方程.typ")
#chapter("05-时域响应分析.typ")
#chapter("06-比例积分控制.typ")
#chapter("07-比例微分控制.typ")
#chapter("08-频域响应分析.typ")
#chapter("09-奈奎斯特稳定性.typ")
#chapter("10-控制器设计.typ")
#chapter("11-状态观测器.typ")
#chapter("12-反馈线性化控制.typ")
#chapter("13-非线性控制器.typ")
#chapter("14-动态规划.typ")
#chapter("15-线性二次型调节器.typ")
#chapter("16-轨迹追踪.typ")
#chapter("17-模型预测控制器.typ")
#chapter("A-复矩阵.typ")
