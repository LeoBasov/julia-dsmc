using LinearAlgebra

const kb = 1.380649e-23

mutable struct Particle
    pos
    vel
    spec
    Particle() = new(zeros(3), zeros(3), -one(Int))
end

mutable struct Species
    mass
    Species() = new(1.0)
end

mutable struct Particles
    particles::Array{Particle}
    species::Array{Species}
    Particles() = new(Array{Particle}(undef, 0), Array{Species}(undef, 0))
end

function box_muller(T)
    r1 = rand()
    r2 = rand()
    r3 = rand()

    return T*(-log(r1) - log(r2) * cos((pi/2.0)*r3)^2)
end

function x2velocity(x, mass)
    return sqrt(2.0 * x * kb /mass)
end

function get_vel(T, mass)
    v = rand(3)*2.0 - ones(3)
    return v * x2velocity(box_muller(T), mass) / norm(v)
end

function create_particles(species, T, N)
    particles = Array{Particle}(undef, N)

    for i = 1:N
        particles[i] = Particle()
        particles[i].vel = get_vel(T, species.mass)
    end

    return particles
end
