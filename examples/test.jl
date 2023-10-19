using DSMC

# set up species
species = Species();
species.mass = 1e-26

# create particles
T = 300.0
N = 10000

particles = create_particles(species, T, N);

# build grid
grid = build_grid(particles)

println(grid)

println("done")