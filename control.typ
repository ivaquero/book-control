// numbering
#import "@preview/i-figured:0.2.4"

#let chapter(filename) = {
  include filename
  context counter(heading).update(0)
}

#chapter("01-动态系统.typ")
#chapter("02-传递函数.typ")
#chapter("03-状态空间方程.typ")
#chapter("04-时域响应分析.typ")
#chapter("05-比例积分控制.typ")
#chapter("06-比例微分控制.typ")
#chapter("07-频域响应分析.typ")
#chapter("08-奈奎斯特稳定性.typ")
#chapter("09-控制器设计.typ")
#chapter("10-状态观测器.typ")
#chapter("11-反馈线性化控制.typ")
#chapter("12-非线性控制器.typ")
#chapter("13-动态规划.typ")
#chapter("14-线性二次型调节器.typ")
#chapter("15-轨迹追踪.typ")
#chapter("16-模型预测控制器.typ")
#chapter("A-傅立叶变换.typ")
#chapter("B-复矩阵.typ")
