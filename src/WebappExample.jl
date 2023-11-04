module WebappExample
using Oxygen, SwaggerMarkdown, HTTP
greet() = print("Hello World!")

function myhello()
    print("Hello from WebappExample！")
end

function start_server(;port::Int=8080, async::Bool = false)
    serve(; port, async)
end

function julia_main()::Cint
    println("Hello from Julia EXE!")
    WebappExample.greet()
    WebappExample.myhello()
    WebappExample.start_server()
    return 0
end

function __init__()
    fname = (@__DIR__) * "/router.jl"
    include(fname)
end

end # module WebappExample
