using Test

include("../src/grid.jl")
include("../src/particles.jl")

function test_find_bounding_box()
    species = DSMC.Species()
    T = 300.0
    N = 4
    species.mass = 1e-26
    particles = create_particles(species, T, N)

    particles[1].pos = [-3.0, 0.0, 0.0]
    particles[2].pos = [9.0, 4.0, 0.0]
    particles[3].pos = [0.0, -12.0, -7.0]

    box = find_bounding_box(particles)

    @test box.x[1] == -3.0
    @test box.x[2] == 9.0

    @test box.y[1] == -12.0
    @test box.y[2] == 4.0

    @test box.z[1] == -7.0
    @test box.z[2] == 0.0
end

@testset "grid" begin
    test_find_bounding_box()
end