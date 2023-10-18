using DSMC
using Test

function eq()
    particles = create_particles(1, 1, 100)
    @test length(particles) == 100
    println(particles[1])
end

@testset "create particles" begin
    eq()
end

@testset "trigonometric identities" begin
    θ = 2/3*π
    @test sin(-θ) ≈ -sin(θ)
    @test cos(-θ) ≈ cos(θ)
    @test sin(2θ) ≈ 2*sin(θ)*cos(θ)
    @test cos(2θ) ≈ cos(θ)^2 - sin(θ)^2
end