# 《控制之美》笔记

![code size](https://img.shields.io/github/languages/code-size/ivaquero/book-control.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/book-control.svg)

本仓库文本是 DR_CAN（王天威）一系列 [哔站课程](https://space.bilibili.com/230105574/channel/series) 的学习笔记。同时，结合其著作 [控制之美：卷 1](https://book.douban.com/subject/35934779/) 及[控制之美：卷 2](https://book.douban.com/subject/36556895/) （未包含 Kalman 滤波部分），统一规范了公式和代码。

共包括

- Typst 笔记
- MATLAB 代码
- Simulink 程序
- 福利：控制工具箱 API 梳理

笔记原采用 Markdown 格式，但因该格式输出的 PDF 不够稳定，且样式单一，后转向现代文本工具 [Typst](https://github.com/typst/typst)，其安装及使用方法可参考[知乎帖子](https://zhuanlan.zhihu.com/p/642509853)。相信大家会喜欢上 Typst 这个软件。

希望对控制理论感兴趣的朋友，以及 Dr_CAN 的粉丝们，能在这里一起完善和讨论。

## 构建

### 依赖软件

- [Typst](https://github.com/typst/typst)

### 克隆官方仓库

为保证正常编译，请参考 [typst-packages](https://github.com/typst/packages) 上的说明，在如下路径下克隆 `typst-packages` 仓库

- Linux：
  - `$XDG_DATA_HOME/typst`
  - `~/.local/share/typst`
- macOS：`~/Library/Application Support/typst`
- Windows：`%APPDATA%/typst`

### 使用模版

在上述路径下克隆 [scibook](https://github.com/ivaquero/scibook) 和 [cetz-control](https://github.com/ivaquero/cetz-control)，然后在文档中引用

```typst
#import "@local/scibook:0.1.0": *
#import "@local/cetz-control:0.1.0": *
```

## 约定规范

### 公式

- 矩阵
  - `[]` 括号
  - 加粗斜体，大写
- 向量
  - `[]` 括号
  - 加粗斜体，小写

### 图表

目前大部分图表采用 [drawio](https://github.com/jgraph/drawio) 制作，后面会逐步使用 [fletcher](https://github.com/Jollywatt/typst-fletcher) 替换，尤其是控制框图。

## 说明

目前存在的样式问题

- 图表
  - 部分标题缺失
