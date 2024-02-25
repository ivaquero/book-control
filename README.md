# 《控制之美》笔记

![code size](https://img.shields.io/github/languages/code-size/ivaquero/book-control.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/book-control.svg)

本仓库文本是 DR_CAN（王天威）一系列 [哔站课程](https://space.bilibili.com/230105574/channel/series) 的学习笔记，同时结合其专著 [控制之美：卷 1](https://book.douban.com/subject/35934779/) 进行了修正。相应的 Simulink 代码也包含在内。

笔记原采用 Markdown 格式，但因该格式输出的 PDF 不够稳定，且样式单一，后转向现代文本工具 [Typst](https://github.com/typst/typst)（相信大家会喜欢上 Typst 这个软件）。

希望对控制理论感兴趣的朋友，以及 Dr_CAN 的粉丝们，能在这里一起完善和讨论。

## 依赖软件

- [Typst](https://github.com/typst/typst): v0.9.0

### 依赖包

- Typst
  - [ctheorems](https://github.com/sahasatvik/typst-theorems): v1.1.1
  - [tablex](https://github.com/PgBiel/typst-tablex): v0.0.8
  - [phyisca](https://github.com/leedehai/typst-physics): v0.9.2
  - [fletcher](https://github.com/Jollywatt/typst-fletcher): v0.4.2

为保证正常编译，请参考 [typst-packages](https://github.com/typst/packages) 上的说明，在如下路径下克隆 `https://github.com/typst/packages` 仓库

- Linux：
  - `$XDG_DATA_HOME/typst`
  - `~/.local/share/typst`
- macOS：`~/Library/Application Support/typst`
- Windows：`%APPDATA%/typst`

### 图表

目前大部分图表采用 [drawio](https://github.com/jgraph/drawio) 制作，后面会逐步使用 `fletcher` 替换，尤其是控制框图。

## 一些说明

目前存在样式的样式问题

- 图表
  - 部分标题缺失
