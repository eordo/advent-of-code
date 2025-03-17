function main()
    input_file = joinpath(@__DIR__, "inputs/day_03.txt")
    x = parse(Int, readline(input_file))
    
    # Part 1.
    steps = sum(abs.(coordinates(x)))

    # Part 2.
    current_val = 1
    values = Dict(coordinates(1) => current_val)
    n = 2
    while current_val <= x
        coords = coordinates(n)
        neighbors = get_neighbors(coords)
        next_val = sum(get(values, neighbor, 0) for neighbor in neighbors)
        values[coords] = next_val
        current_val = next_val
        n += 1
    end
    
    # Answers.
    println("AoC 2017 Day 3")
    println("Part 1: $steps")
    println("Part 2: $current_val")
end

function coordinates(x::Int)
    if x == 1
        return (0, 0)
    end
    
    is_out_of_bounds(coords, k) = any(coord -> abs(coord) > k, coords)

    k = ceil(Int, isqrt(x - 1) / 2)
    remainder = x - (1 + sum(8 * i for i = 1:(k - 1); init = 0))
    coords = (k, -k)
    direction = 1
    move = Dict(
        1 => (0, 1),
        2 => (-1, 0),
        3 => (0, -1),
        4 => (1, 0)
    )
    while remainder > 0
        if is_out_of_bounds(coords .+ move[direction], k)
            direction += 1
        end
        coords = coords .+ move[direction]
        remainder -= 1
    end
    return coords
end

function get_neighbors(coords::NTuple{2, Int})
    x, y = coords
    neighbors = [(x + dx, y + dy) for dx in -1:1 for dy in -1:1]
    return neighbors
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
