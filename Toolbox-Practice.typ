#import "@local/scibook:0.1.0": *
#show: doc => conf(
  title: "MATLAB 工具箱最佳实践",
  author: ivaquero,
  header-cap: "现代控制理论",
  footer-cap: "github@ivaquero",
  outline-on: false,
  doc,
)

= 工程结构
<tree>

== 根目录
<root>

根目录即工程目录，通常采用驼峰命名，如 `quickerSimCFD`。其大体结构如下

```markdown
quickerSimCFD/
|   README.md
|   LICENSE
└───images/
        readmeImage.png
```

== 工具箱目录
<toolbox>

工具箱目录即算法代码目录，其应包括如下文件

- 算法接口文件：如`add.m`
- 算法底层文件夹：`internal`
- 交互教程文件：`gettingStarted.mlx`
- 示例文件夹：`examples`
其大体结构如下

```markdown
quickerSimCFD/
:
└───toolbox/
    |   add.m
    |   gettingStarted.mlx
    ├───examples/
    |       usingAdd.mlx
    └───internal/
            intToWord.m
```

== 增强
<enhancing>

MATLAB 提供了各种功能，以使工具箱更直观，更方便使用。推荐实践有：

=== [参数验证]

为增强用户的使用功能时的经验，我们可以添加一个“arguments”块创建定制的选项卡完成建议（R2019a 引入）。此外，MATLAB 将验证类型，大小和值传递给我们的功能，使用户可以调用我们的功能正确。请参阅：#link("https://www.mathworks.com/help/matlab/matlab_prog/function-argument-validation-1.html")[Function-Argument-Validation]。
若我们需要对选项卡完成的更多控制权，请创建一个`functionsignatures.json`，然后将其与相应的函数或类相同的目录中。请参阅：#link("https://www.mathworks.com/help/matlab/matlab_prog/customize-code-suggestions-and-completions.html")[Customize-Code-Suggestions-And-Completions]。

=== 命名空间

名称空间（也称为软件包）提供了一种组织类和功能的方法，并降低了具有相同名称的两个功能的风险。请参阅：#link("https://www.mathworks.com/help/matlab/matlab_oop/scoping-classes-with-packages.html")

=== MATLAB Apps

MATLAB 应用程序是交互式图形应用程序，允许用户在工具箱中执行特定的工作流程。我们将 MATLAB 应用程序包装到一个文件（.mlapp）中，以更轻松地分发。在工具箱文件夹的顶层创建“应用程序”文件夹。打包工具箱时，请确保将我们的应用程序包含在工具箱包装对话框的应用程序部分中。这样，用户可以在安装后轻松访问和运行我们的应用程序。请参阅：#link("https://www.mathworks.com/help/matlab/gui-development.html")[GUI-Development]。

=== 实时任务

实时任务是简单的点击接口，可以在 R2022a 开始的实时脚本中使用。它们为用户提供了一种交互式和直观的方法，可以与我们的工具箱进行交互。将实时任务类放在工具箱文件夹中的“内部”文件夹中，因为用户不直接调用此功能。作为创建的一部分，我们将创建一个 `liveTasks.json` 文件，该文件必须在 `resources` 文件夹中。请参阅：#link("https://www.mathworks.com/help/matlab/develop-live-editor-tasks.html")[Develop-Live-Editor-Tasks]。

== 总结

当使用了以上所有这些推荐功能，则我们的工具箱还应包括：

+ 对功能的选项卡完成和参数验证
+ Apps：`quickerSimCFD.mlapp`
+ 命名空间`describe`中的次级功能：`+describe/describe.add`
+ 实时任务：`internal/liveTasks.json`
此时工程结构为

```markdown
quickerSimCFD/
:
└───toolbox/
    |   add.m
    |   functionSignatures.json
    |   gettingStarted.mlx
    ├───+describe/
    |       add.m
    ├───apps/
    |       quickerSimCFD.mlapp
    ├───examples/
    |       usingAdd.mlx
    └───internal/
        |   addLiveTask.m
        |   intToWord.m
        └───resources/
                liveTasks.json
```

#pagebreak()

= 打包
<packaging>

共享 MATLAB 工具箱通常涉及共享`.m`文件的集合或将它们组合到`.zip`文件中。但是，这里强烈建议一种更好的方法，即将工具箱包装到 MATLAB 工具箱文件中（`.mltbx`）从而获得更增强的用户体验。

我们可以为工具箱添加版本编号和其他信息提供图标。用户可以通过 #link("https://www.mathworks.com/help/matlab/matlab_env/get-add-ons.html")[Add-on Manager] 轻松发现，安装，更新和卸载工具箱。请参阅：#link("https://www.mathworks.com/help/matlab/matlab_prog/create-and-share-custom-matlab-toolboxes.html")[Create-And-Share-Custom-Matlab-Toolboxes]。

另外，建议命名包装文件 `toolboxPackaging.prj` 并命名图标文件为`toolboxPackaging.png`，将其放入`images`文件夹中。

使用 `Toolbox Packaging Tool` 创建工具箱包装文件。在 MATLAB，转到 `Home` 选项卡的`Add-Ons`菜单，选择`Toolbox Packaging Tool`。

#figure(
  image("images/matlab-toolbox.png", width: 45%),
  // caption: "",
  // supplement: "图"
)

== 打包文件

`Toolbox Packaging Tool` 创建的 MATLAB 工具箱文件（`.mltbx`）应放在根目录下方的名为 `release` 的文件夹中。从此是一个派生文件，不应在源控制下。此时的工程结构如下：

```markdown
quickerSimCFD/
:
|   toolboxPackaging.prj
├───images/
│       readmeImage.png
│       toolboxPackaging.png
├───release/
│       Arithmetic Toolbox.mltbx
└───toolbox/
        add.m
        :
```

== 发布策略

打包完成后，我们有多个选择发布我们的工具箱

- 创建一个 #link("https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository")[GitHub 仓库]，并链接到 #link("https://www.mathworks.com/matlabcentral/fileexchange/")[MATLAB File Exchange]。工具箱将在 `Add-on Explorer` 中出现，并将安装最新的发布版本。请参阅 #link("https://www.mathworks.com/matlabcentral/discussions/highlights/132204-github-releases-in-file-exchange")[Github-Releases-In-File-Exchange]。
- 将工具箱文件（`.mltbx`）复制到用户共享位置，双击它以安装它。

== 维护
<robust>

=== 测试
<tests>

测试检查工具箱的质量并帮助我们建立信心高质量的发布。#link("https://www.mathworks.com/help/matlab/matlab-unit-test-framework.html")[MATLAB Testing Framework] 提供了用于测试代码的支持。对于熟悉 MATLAB 的用户，应该很熟悉#link("https://www.mathworks.com/help/matlab/function-based-unit-tests.html")[Function-Based Unit Tests]。

将测试放在 `tests` 文件夹中。若在 GitHub 上托管工具箱，则可以使用 #link("https://github.com/matlab-actions/overview")[GitHub Actions] 来通过自动运行测试来限定更改。

现在，我们的工程结构为

```markdown
quickerSimCFD/
:
├───tests/
|       testAdd.m
|       testIntToWord.m
└───toolbox/
        add.m
        :
```

#pagebreak()

== 工程文件
<project>

#link("https://www.mathworks.com/help/matlab/projects.html")[工程文件] 是确保创作团队保持一致环境的好方法。它管理复杂项目中的依赖性，使路径正确，并与源控制系统集成。

使项目文件（带有`.prj`扩展名）与根目录相同的名称。将其放入根目录中。可得

```markdown
quickerSimCFD/
|   README.md
|   quickerSimCFD.prj
|   license.txt
|   toolboxPackaging.prj
:
└───resources/
```

== 持续集成
<cicd>

源控制系统应使用此文件夹作为源存储库的根。包括`.gitatributes`和`.gitignore`。一个典型 MATLAB 工具箱项目的 `.gitignore` 文件可参考 #link("https://github.com/mathworks/gitignore/blob/main/Global/MATLAB.gitignore")。

与打包有关的脚本应放置在根文件夹下方的`buildUtilities`文件夹中。 考虑使用 R2022b 中引入的 #link("https://www.mathworks.com/help/matlab/matlab_prog/overview-of-matlab-build-tool.html")[buildtool]。与 `buildtool` 关联的任务功能在 `buildfile.m` 中。

```markdown
quickerSimCFD/
│   .gitattributes
│   .gitignore
|   README.md
|   quickerSimCFD.prj
|   buildfile.m
|   license.txt
|   toolboxPackaging.prj
├───.git/
:
├───resources/
└───buildUtilities/
```

== 在线运行
<online>

#link("https://www.mathworks.com/products/matlab-online/git.html")[MATLAB Online] 给出了在线运行
MATLAB 的方法。这为访问我们的 GitHub 仓库的用户提供了一种简单的方法，可以在文件交换时跳到我们的代码。设置`File Exchange`条目后，我们的工具箱将出现在页面顶部的工具。请参阅 #link("https://blogs.mathworks.com/community/2019/11/27/a-github-badge-for-the-file-exchange/")[Github-Badge-For-The-File-Exchange]。
