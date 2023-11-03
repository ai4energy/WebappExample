bench:
	julia --project=./bench bench/bench.jl

build:
	julia --project=./compile compile/compile.jl

clean:
	rm -rf build/