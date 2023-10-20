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

function test_create_grid()
    box = Box(-1.0, 3.0, -4.0, 5.0, -7.0, 9.0)
    Nx = 11
    Ny = 13
    Nz = 15

    grid = create_grid(box, Nx, Ny, Nz)

    @test length(grid.cells) == Nx * Ny * Nz

    @test last(grid.cells).box.x[2] == box.x[2]
    @test last(grid.cells).box.y[2] == box.y[2]
    @test last(grid.cells).box.z[2] == box.z[2]
end

function test_sort_particles()
    box = Box(-1.0, 3.0, -4.0, 5.0, -7.0, 9.0)
    Nx = 11
    Ny = 13
    Nz = 15
    species = DSMC.Species()
    T = 300.0
    N = 4
    species.mass = 1e-26
    particles = create_particles(species, T, N)

    grid = create_grid(box, Nx, Ny, Nz)
    sort_particles!(grid, particles)
end

@testset "grid" begin
    test_find_bounding_box()
    test_create_grid()
    test_sort_particles()
end