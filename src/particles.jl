begin

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

function create_particles(species, T, N)
    particles = Array{Particle}(undef, N)

    for i = 1:N
        particles[i] = Particle()
    end

    return particles
end

end
