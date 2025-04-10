# 简明控制理论教程

![code size](https://img.shields.io/github/languages/code-size/ivaquero/book-control.svg)
![repo size](https://img.shields.io/github/repo-size/ivaquero/book-control.svg)

本仓库致力于编写一部易于上手的简明控制理论教程，内容上参考了 DR_CAN [哔站课程](https://space.bilibili.com/230105574/channel/series)，及其著作 [控制之美：卷 1](https://book.douban.com/subject/35934779/) 及[控制之美：卷 2](https://book.douban.com/subject/36556895/) （未包含 Kalman 滤波部分），同时使用其他教材和教程对诸多内容进行了细化，统一规范了公式和代码。

共包括

- Typst 笔记
- MATLAB 代码
- Simulink 程序
- 福利：控制工具箱 API 梳理

笔记原采用 Markdown 格式，但因该格式输出的 PDF 不够稳定，且样式单一，后转向现代排版软件[Typst](https://github.com/typst/typst)，其安装可参考[知乎帖子](https://zhuanlan.zhihu.com/p/642509853)。相信大家会喜欢上 Typst 这个软件。

## 构建

### 依赖软件

- [Typst](https://github.com/typst/typst)

### 克隆官方仓库

为保证正常编译，请参考 [typst-packages](https://github.com/typst/packages) 上的说明，在如下路径下克隆 `typst-packages` 仓库

- Linux：
  - `$XDG_DATA_HOME`
  - `~/.local/share`
- macOS：`~/Library/Application Support`
- Windows：`%APPDATA%`

```bash
cd [above-path]
git clone --depth 1 --branch main https://github.com/typst/packages typst
```

### 使用模版

```typst
#import "@preview/qooklet:0.1.1": *
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
