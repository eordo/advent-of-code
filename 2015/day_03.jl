function parse_input(path)
    readline(joinpath(@__DIR__, path))
end

function part_1(data)
    # Use complex numbers to represent 2D coordinates.
    move_map = Dict(
        '^' => 0+1im,
        '>' => 1+0im,
        'v' => 0-1im,
        '<' => -1+0im
    )
    coords = 0+0im
    visited_coords = Set(coords)
    for direction in data
        coords += move_map[direction]
        push!(visited_coords, coords)
    end
    length(visited_coords)
end

function part_2(data)
    move_map = Dict(
        '^' => 0+1im,
        '>' => 1+0im,
        'v' => 0-1im,
        '<' => -1+0im
    )
    santa_coords = 0+0im
    robo_coords = 0+0im
    visited_coords = Set(santa_coords)
    for (i, direction) in enumerate(data)
        # 1-indexing means Santa moves on odd-numbered directions.
        if isodd(i)
            santa_coords += move_map[direction]
            push!(visited_coords, santa_coords)
        else
            robo_coords += move_map[direction]
            push!(visited_coords, robo_coords)
        end
    end
    length(visited_coords)
end

function main()
    data = parse_input("inputs/day_03.txt")
    println("Advent of Code 2015 Day 3")
    println("=========================")
    println("Part 1: ", part_1(data))
    println("Part 2: ", part_2(data))
end

main()
