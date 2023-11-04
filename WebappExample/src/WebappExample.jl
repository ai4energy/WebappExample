module WebappExample
using Oxygen, SwaggerMarkdown, HTTP

const CORS_HEADERS = [
    "Access-Control-Allow-Origin" => "*",
    "Access-Control-Allow-Headers" => "*",
    "Access-Control-Allow-Methods" => "POST, GET, OPTIONS"
]

greet() = print("Hello World!")

function myhello()
    print("Hello from WebappExample！")
end

function start_server(;host="0.0.0.0", port::Int=8080, async::Bool = false)
    serve(; host, port, async)
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
