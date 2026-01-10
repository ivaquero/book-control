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
- [drawio](https://github.com/jgraph/drawio)

### 克隆官方仓库

为保证正常编译，请参考 [typst-packages](https://github.com/typst/packages) 上的说明，在如下路径下克隆 `typst-packages` 仓库

- Linux：
  - `$XDG_DATA_HOME`
  - `~/.local/share`
- macOS：`~/Library/Application Support`
- Windows：`%APPDATA%`

```sh
cd [above-path]
git clone --depth 1 --branch main https://github.com/typst/packages typst
```

### 使用模版

本仓库除了辅助教学外，还用于测试我的一个模板 [qooklet](https://github.com/ivaquero/typst-qooklet)，这是一个用于笔记 + 教材的双模式模板，可以在两种模式间丝滑切换，标题、公式和目录都会重新自动计数。

使用如下语句导入模版

```typst
#import "@preview/qooklet:0.6.1": *
#show: chapter-style.with(
  title: "Bellman Eqation",
  // the following are optional arguments
  // info: none
  // outline-on: false,
)
```

这里参数 `info` 让你可以使用一个 TOML 文件传入你的文档信息（使用默认值，意味着下列信息为空）。TOML 文件格式如下

```toml
[key-you-like]
    title = "your book name"
    author = "your name"
    footer = "something you like"
    header = "something you like"
    lang = "zh"
```

使用如下语句读取你的 TOML 文件

```typst
#let info = toml("your path").key-you-like
```

对 qooklet 模板感兴趣的同学可以克隆本仓库，使用仓库内的 `control.typ` 文件探索。

### 使用绘图包

```typst
#import "@preview/consketcher:0.1.0": *
```

详情见 [consketcher](https://github.com/ivaquero/typst-consketcher)

## 约定规范

### 公式

- 矩阵
  - `[]` 括号
  - 加粗斜体，大写
- 向量
  - `[]` 括号
  - 加粗斜体，小写

### 图表

目前大部分图表采用 drawio 制作，后面会使用如下 typst 包重新绘制，力争实现全书代码 typst 占比100%。

- 数据图：[lilaq](https://github.com/lilaq-project/lilaq)
- 示意图：
  - [consketcher](https://github.com/ivaquero/typst-consketcher)
  - [zap](https://github.com/l0uisgrange/zap)
  - [patatrac](https://github.com/ZaninDavide/patatrac)
  - [cetz](https://github.com/cetz-package/cetz)

## 说明

目前存在的样式问题

- 图表
  - 部分标题缺失
