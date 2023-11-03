module WebappExample

greet() = print("Hello World!")

function myhello()
    print("Hello from WebappExample！")
end

function julia_main()::Cint
    println("Hello from Julia EXE!")
    WebappExample.greet()
    WebappExample.myhello()
    return 0
end

end # module WebappExample
