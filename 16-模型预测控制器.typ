#import "lib/sci-book.typ": *
#show: doc => conf(
  title: "模型预测控制器",
  author: ("ivaquero"),
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= 问题提出

对轨迹追踪问题

- 误差 $∫e^2 dif t$越小，追踪越好
- 输入 $∫u^2 dif t$越小，能耗越低

于是，整体代价函数为

$ J = ∫_0^t q e^2 + r u^2 dif t $

拓展至 MIMO 情况
