mutable struct Box
    x::Array{AbstractFloat}
    y::Array{AbstractFloat}
    z::Array{AbstractFloat}
    vol::AbstractFloat
    function Box()
        new([-0.5, 0.5], [-0.5, 0.5], [-0.5, 0.5], 1.0)
    end
end

mutable struct Cell
    box::Box
    root::Bool
    parent::Int
    children::Array{Int}
    function Cell()
        new(Box(), true, 0, Array{Int}(undef, 0))
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