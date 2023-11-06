import Pkg;
Pkg.instantiate();
include(joinpath(@__DIR__, "../src/WebappExample.jl"))
using .WebappExample
WebappExample.julia_main()