import Pkg;
Pkg.instantiate();
include(joinpath(@__DIR__, "../src/WebappExample.jl"))
using .WebappExample
WebappExample.greet()
WebappExample.julia_main()