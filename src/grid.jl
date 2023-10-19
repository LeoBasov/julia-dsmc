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