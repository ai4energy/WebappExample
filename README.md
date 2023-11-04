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

## 编译成可执行程序

在WebappExample.jl中加入函数julia_main：
```julia
function julia_main()::Cint
    println("Hello from Julia EXE!")
    WebappExample.greet()
    WebappExample.myhello()
    return 0
end
```

然后在/path/to/WebappExample下建立compile文件夹，并建立compile.jl文件。并且compile文件夹建立相应的环境，添加PackageCompiler包。

接下来在terminal中，使用如下的命令编译成exe文件：
```shell
julia --project=./compile compile/compile.jl
```

现在就可以这样启动exe程序了：

```shell
./build/bin/webapp
```

## 加入Makefile来进行自动化

现在在/path/to/WebappExample下建立Makefile文件，内容如下：
```Makefile
bench:
	julia --project=./bench bench/bench.jl

build:
	julia --project=./compile compile/compile.jl

clean:
	rm -rf build/
```

这样，我们就可以在terminal中，使用如下的命令了：
```shell
make bench
make build
make clean
```

## 使用Oxygen.jl实现web服务
在当前环境下加入Oxygen, SwaggerMarkdown, HTTP包。代码修改情况直接看源码。

在这里我们新建了一个router.jl文件，在WebappExample包的__init__函数中引入了这个router.jl文件。至于为什么要这么做，请参考[Oxygen.jl的issue 115](https://github.com/ndortega/Oxygen.jl/issues/115)。
