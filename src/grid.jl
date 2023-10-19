mutable struct Box
    x::Pair{AbstractFloat, AbstractFloat}
    y::Pair{AbstractFloat, AbstractFloat}
    z::Pair{AbstractFloat, AbstractFloat}
    vol::AbstractFloat
    function Box()
        new(Pair(-0.5, 0.5), Pair(-0.5, 0.5), Pair(-0.5, 0.5), 1.0)
    end
end

mutable struct Cell
    box::Box
    Cell() = new(Box())
end

mutable struct Grid
    cells::Array{Cell}
    function Grid()
        new(Array{Cell}(undef, 0))
    end
end

function find_bounding_box(particles)
    box = Box()

    box.x = Pair(Inf, -Inf)
    box.y = Pair(Inf, -Inf)
    box.z = Pair(Inf, -Inf)

    for part in particles
        if part.pos[1] < box.x[1]
            box.x[1] = part.pos[1]
        if part.pos[1] > box.x[2]
            box.x[2] = part.pos[1]
        end 

        if part.pos[2] < box.y[1]
            box.y[1] = part.pos[2]
        if part.pos[2] > box.y[2]
            box.y[2] = part.pos[2]
        end

        if part.pos[3] < box.z[1]
            box.z[1] = part.pos[3]
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

    cell = create_first_Cell(particles)
    push!(grid.cells, cell)

    return grid
end