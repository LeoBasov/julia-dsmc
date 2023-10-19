using Test
using DSMC
using LinearAlgebra

function calc_T(particles, mass)
    e = 0.0

    for part in particles
        e += 0.5 * mass * dot(part.vel, part.vel) / length(particles)
    end

    return e * 2.0 / (3.0 * DSMC.kb)
end

function test_create_particles()
    species = DSMC.Species()
    T = 300.0
    N = 10000
    species.mass = 1e-26
    particles = create_particles(species, T, N)
    T_new = calc_T(particles, species.mass)
    @test isapprox(T_new, T, atol=5.0)
end

@testset "particles" begin
    test_create_particles();
end;