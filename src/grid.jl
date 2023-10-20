mutable struct Box
    x::Array{AbstractFloat}
    y::Array{AbstractFloat}
    z::Array{AbstractFloat}
    vol::AbstractFloat

    function Box()
        new([-0.5, 0.5], [-0.5, 0.5], [-0.5, 0.5], 1.0)
    end

    function Box(xmin, xmax, ymin, ymax, zmin, zmax)
        volume = (xmax - xmin) * (ymax - ymin) * (zmax - zmin)
        new([xmin, xmax], [ymin, ymax], [-zmin, zmax], volume)
    end
end

mutable struct Cell
    box::Box
    root::Bool
    parent::Int
    children::Array{Int}
    particles::Array{Int}
    function Cell()
        new(Box(), true, 0, Array{Int}(undef, 0), Array{Int}(undef, 0))
    end
end

mutable struct Grid
    cells::Array{Cell}
    function Grid()
        new(Array{Cell}(undef, 0))
    end
end

function find_bounding_box(particles)
    box = Box()

    box.x = [Inf, -Inf]
    box.y = [Inf, -Inf]
    box.z = [Inf, -Inf]

    for part in particles
        if part.pos[1] < box.x[1]
            box.x[1] = part.pos[1]
        end
        if part.pos[1] > box.x[2]
            box.x[2] = part.pos[1]
        end

        if part.pos[2] < box.y[1]
            box.y[1] = part.pos[2]
        end
        if part.pos[2] > box.y[2]
            box.y[2] = part.pos[2]
        end

        if part.pos[3] < box.z[1]
            box.z[1] = part.pos[3]
        end
        if part.pos[3] > box.z[2]
            box.z[2] = part.pos[3]
        end
    end

    return box
end

function create_first_Cell(particles)
    cell = Cell()
    cell.box = find_bounding_box(particles)
    return cell
end

function build_grid(particles)
    grid = Grid()
    return grid
end

function create_grid(box, Nx, Ny, Nz)
    grid = Grid()

    dx = (box.x[2] - box.x[1]) / Nx
    dy = (box.y[2] - box.y[1]) / Ny
    dz = (box.z[2] - box.z[1]) / Nz

    for i = 1:Nx, j = 1:Ny, k = 1:Nz
        cell = Cell()

        cell.box.x[1] = box.x[1] + (i - 1) * dx
        cell.box.x[2] = box.x[1] + i * dx

        cell.box.y[1] = box.y[1] + (j - 1) * dy
        cell.box.y[2] = box.y[1] + j * dy

        cell.box.z[1] = box.z[1] + (k - 1) * dz
        cell.box.z[2] = box.z[1] + k * dz

        cell.box.vol = (cell.box.x[2] - cell.box.x[1]) * (cell.box.y[2] - cell.box.y[1]) * (cell.box.z[2] - cell.box.z[1])

        push!(grid.cells, cell)
    end

    return grid
end

function is_inside(cell, position)
    in_x = position[1] >= cell.box.x[1] && position[1] <= cell.box.x[2]
    in_y = position[2] >= cell.box.y[1] && position[2] <= cell.box.y[2]
    in_z = position[3] >= cell.box.z[1] && position[3] <= cell.box.z[2]
    return in_x && in_y && in_z
end

function sort_particles!(grid, particles)
    for i in eachindex(particles)
        for cell in grid.cells
            if is_inside(cell, particles[i].pos)
                push!(particles.particles, i)
                break
            end
        end
    end
end