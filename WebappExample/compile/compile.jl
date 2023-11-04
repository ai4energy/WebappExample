import Pkg;
Pkg.instantiate();

using PackageCompiler

create_app(joinpath(@__DIR__, ".."), "build"; executables = ["webapp" => "julia_main"], incremental=true)