module WebappExample
using Oxygen, SwaggerMarkdown, HTTP

const CORS_HEADERS = [
    "Access-Control-Allow-Origin" => "*",
    "Access-Control-Allow-Headers" => "*",
    "Access-Control-Allow-Methods" => "POST, GET, OPTIONS"
]


function julia_main()::Cint
    # 跨域解决方案
    function CorsMiddleware(handler)
        return function (req::HTTP.Request)
            # println("CORS middleware")
            # determine if this is a pre-flight request from the browser
            if HTTP.method(req) ∈ ["POST", "GET", "OPTIONS"]
                return HTTP.Response(200, CORS_HEADERS, HTTP.body(handler(req)))
            else
                return handler(req) # passes the request to the AuthMiddleware
            end
        end
    end
    get("/sub/{x}/{y}") do request::HTTP.Request, x::Int, y::Int
        x - y
    end

    serve(host="0.0.0.0", port=8080, async=false, middleware=[CorsMiddleware])
    return 0
end

function __init__()
    fname = (@__DIR__) * "/router.jl"
    include(fname)
end

end # module WebappExample
