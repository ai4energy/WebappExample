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

另外，我们可以使用容器镜像服务，比如阿里云的容器镜像服务。如果我们看到docker-compose中`image: registry.cn-shenzhen.aliyuncs.com/ai4e/webapp:1.0`这样的字样，就是使用了阿里云的容器镜像服务。就是本地build容器镜像，然后推送到了阿里云的容器镜像服务器。用户就只需要拉取这个镜像就可以了。这样我们就可以很方便用户使用。

## 创建前端vue

首先安装绿色版node，设置好环境变量（使得可以在terminal中运行node和npm）。

- 在terminal中，使用如下的命令安装pnpm并创建vue项目
```shell
npm install -g pnpm
pnpm create vite@latest
```

- 进入vue项目目录，安装依赖，启动服务：
```shell
cd ./webapp-vue/
pnpm install
pnpm run dev
```
在浏览器中测试确保vue工作正常。

- 编译前端代码：

```shell
pnpm run build
```

这样会在webapp-vue的目录下建立dist目录，并存放编译好的文件。

## 把前端和后端放在不同的目录
建立WebappExample子目录，把除了前端目录、.gitignore、LICENSE、README.md的文件都移动到WebappExample子目录中。

在当前目录建立新的docker-compose.yml文件。

修改.gitignore，加入nodejs相应的设置。

## 前端docker测试

我们在webapp-vue下建立docker-compose.yml文件，内容如下：

```shell
version: "3.2"

services: 
  webappvue:
    image: nginx:alpine
    container_name: webappvue

    volumes:
      - ./dist:/usr/share/nginx/html
    ports:
      - "8081:80"
```

以下是相应的解释：


这是一个使用Docker Compose编排的服务定义文件（通常称为`docker-compose.yml`），用于部署一个名为"webappvue"的Nginx容器服务。

1. `version: "3.2"`:
   - 这一行指定了Docker Compose文件的版本，指出了使用的Compose文件语法版本。在这种情况下，它是版本3.2。

2. `services`:
   - `services` 是一个键，下面列出了将要运行的不同服务的定义。在这个例子中，只有一个服务，名为"webappvue"。

3. `webappvue` 服务:
   - `webappvue` 是服务的名称，你可以根据需要自定义服务名称。

4. `image: nginx:alpine`:
   - 这行指定了要使用的Docker镜像。在这里，使用了Nginx的Alpine版本，这是一个轻量级的Linux发行版，用于运行Nginx。Docker将从Docker Hub中下载并使用此镜像。

5. `container_name: webappvue`:
   - 这一行定义了容器的名称，即"Nginx"容器的名称将被设置为"webappvue"。

6. `volumes` 部分:
   - 这部分定义了要挂载的数据卷。在这里，`./dist:/usr/share/nginx/html` 将本地目录`./dist`（在Compose文件所在的目录下）挂载到容器内的`/usr/share/nginx/html`路径。这通常用于将应用程序的静态文件（例如网页）提供给Nginx。

7. `ports` 部分:
   - 这部分定义了端口映射。它将容器内的端口80映射到主机上的端口8081。这意味着你可以通过访问主机的8081端口来访问Nginx容器中运行的网页。

总之，这个Docker Compose文件将启动一个Nginx容器服务，将本地的`./dist`目录挂载到Nginx容器的网页根目录，同时将容器内的端口80映射到主机的端口8081，以便通过浏览器访问该网页。这对于部署Vue.js应用程序或其他静态网页非常有用。

我们按照这个docker-compose.yml启动服务，此时从浏览器中访问`http://127.0.0.1:8081`测试。

由于进行了目录迁移，进一步的在WebappExample目录中也进行充分测试，确保工作正常。