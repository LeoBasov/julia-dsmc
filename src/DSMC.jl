module DSMC

include("particles.jl")
include("grid.jl")

export create_particles
export Species
export build_grid

greet() = print("Hello World!")

end # module DSMC
