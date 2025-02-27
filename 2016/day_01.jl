function main()
    input = readline(joinpath(@__DIR__, "inputs/day_01.txt"))
    instructions = parse_instruction.(split(input, ", "))

    # Part 1.
    coords = (0, 0)
    orientation = 1
    for instruction in instructions
        direction, distance = instruction
        orientation = reorient(orientation, direction)
        coords = move(coords, orientation, distance)
    end
    num_blocks_1 = taxicab_distance(coords)
    
    # Part 2.
    coords = (0, 0)
    orientation = 1
    visited = Dict(coords => true)
    hq_coords = (0, 0)
    hq_found = false
    for instruction in instructions
        direction, distance = instruction
        orientation = reorient(orientation, direction)
        for i = 1:distance
            next_coords = move(coords, orientation, i)
            if haskey(visited, next_coords)
                hq_coords = next_coords
                hq_found = true
                break
            else
                visited[next_coords] = true
            end
            if i == distance
                coords = next_coords
            end
        end
        if hq_found
            break
        end
    end
    num_blocks_2 = taxicab_distance(hq_coords)

    println("AoC 2016 Day 1")
    println("Part 1: $num_blocks_1")
    println("Part 2: $num_blocks_2")
end

function move(coords::NTuple{2, Int}, orientation::Int, distance::Int)
    x, y = coords
    dx = (-1)^(orientation == 4) * iseven(orientation) * distance
    dy = (-1)^(orientation == 3) * isodd(orientation) * distance
    return x + dx, y + dy
end

function reorient(orientation::Int, direction::Char)
    if direction == 'R'
        orientation = mod1(orientation + 1, 4)
    elseif direction == 'L'
        orientation = mod1(orientation - 1, 4)
    end    
    return orientation
end

taxicab_distance(coords) = sum(abs.(coords))

parse_instruction(s) = (s[begin], parse(Int, s[2:end]))

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
