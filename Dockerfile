FROM julia:1.9.3

## Install Julia packages
ENV JULIA_NUM_THREADS=2
WORKDIR /opt/julia/
COPY . .
RUN julia --project="." -e 'import Pkg; Pkg.instantiate();'
RUN julia --project="." compile/precompile.jl

EXPOSE 8080

CMD ["bash"]