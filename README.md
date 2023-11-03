# WebappExample
WebappExample， 一个julia (Oxygen.jl)+vue前后端分离的实例

## 创建一个julia包

如果你想在特定目录（例如myrepos目录）中创建Julia包，你可以按照以下步骤进行操作：

1. 打开终端或命令行窗口，并使用`cd`命令进入myrepos目录，例如：

```shell
cd /path/to/myrepos
```

请确保将`/path/to/myrepos`替换为myrepos目录的实际路径。

2. 在myrepos目录中创建一个新的Julia包目录。你可以使用以下命令：

```julia
import Pkg
Pkg.generate("WebappExample")
```

这将在myrepos目录中创建一个名为"WebappExample"的新目录，用于包的代码和文件。

4. 修改WebappExample.jl文件，增加自己的函数和处理逻辑。

5. 此时可以使用如下的代码加载WebappExample包：

```julia
using WebappExample
WebappExample.myhello()
```

我们可以在bench目录建立bench.jl，包含以上内容。

## Pkg添加本地包

使用git提交修改到本地。打开julia，切换到Pkg模式，使用如下的代码可以添加WebappExample到系统环境：
```julia
add "/path/to/WebappExample"
# 比如 add "D:\\gitprojects\\ai4energy\\WebappExample"
```

此时在julia的REPL中就可以`using WebappExample`了。