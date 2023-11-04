@get "/greet" function(req::HTTP.Request)
    return "hello world!"
end

get("/add/{x}/{y}") do request::HTTP.Request, x::Int, y::Int
    x + y
end