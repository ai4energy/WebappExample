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

在这里我们新建了一个router.jl文件，在WebappExample包的__init__函数中引入了这个router.jl文件。至于为什么要这么做，请参考[Oxygen.jl的issue 115](https://github.com/ndortega/Oxygen.jl/issues/115)以及[OxygenExample.jl的测试文件](https://github.com/Sukhoverkhaya/OxygenExample.jl/blob/master/test/runtests.jl)。

## 使用docker封装成服务

在当前目录中增加Dockerfile，内容直接看文件。Dockerfile是用来创建docker的镜像的。可以使用如下的命令创建镜像。
```shell
docker build -t webappexample:1.0 .
```

我们也可以直接在docker-compose中创建镜像。参加本目录中的使用 Docker Compose 编排工具定义的 Docker 服务的示例配置文件，即docker-compose.yml文件。内容如下：
```shell
version: "3.2"

services: 
  webappexample:
    container_name: webappexample
    build:
      context: .
    command: julia --project="/opt/julia" serve/webappexample.jl
    ports:
      - "8080:8080"
```

Docker Compose 允许您定义和管理多个 Docker 容器，以便在复杂的应用程序中协调它们的运行。在这个配置文件中，定义了一个名为 "webappexample" 的 Docker 服务，以下是对配置文件中各个部分的解释：

1. `version: "3.2"`：这是 Docker Compose 文件的版本。该文件采用 "3.2" 版本的 Docker Compose 格式，它定义了支持的配置选项和语法。

2. `services`：在这个部分中，您可以定义一个或多个 Docker 服务。每个服务都代表一个独立的容器应用。

3. `webappexample` 服务：

   - `container_name: webappexample`：为容器指定一个名称，这里将容器命名为 "webappexample"。

   - `build` 部分：这里定义了构建镜像的方式。
     - `context: .`：构建上下文，这里使用了当前目录作为构建上下文。构建上下文是包含构建镜像所需文件和目录的位置。

   - `command: julia --project="/opt/julia" serve/webappexample.jl`：容器启动时要执行的命令。这里启动了一个 Julia 应用程序，指定了项目目录，并执行了名为 "webappexample.jl" 的 Julia 脚本。

   - `ports` 部分：定义了容器端口映射。
     - `"8080:8080"`：将容器内的端口 8080 映射到主机的端口 8080。这意味着从主机上访问端口 8080 将被转发到容器内的端口 8080，以便访问容器中的应用程序。

通过这个 Docker Compose 配置文件，您可以使用 `docker-compose` 命令来轻松地启动和管理 "webappexample" 服务。只需在包含此文件的目录中运行 `docker-compose up`，Docker Compose 将自动构建镜像、创建容器，并启动应用程序。

当然，如果我们编译成独立可执行文件，那在docker-compose.yml文件中的启动命令就应该不一样。也就是说要修改`command: julia --project="/opt/julia" serve/webappexample.jl`这一行。