function main()
    directions = readline(joinpath(@__DIR__, "inputs/day_03.txt"))
    
    move_map = Dict(
        '^' => (0, 1),
        '>' => (1, 0),
        'v' => (0, -1),
        '<' => (-1, 0)
    )
    move(coords, direction) = coords .+ move_map[direction]

    # Part 1.
    coords = (0, 0)
    visited_houses = Set([coords])
    for direction in directions
        coords = move(coords, direction)
        push!(visited_houses, coords)
    end
    houses_part_1 = length(visited_houses)

    # Part 2.
    santa_coords = (0, 0)
    robot_coords = (0, 0)
    empty!(visited_houses)
    push!(visited_houses, santa_coords)
    for (i, direction) in enumerate(directions)
        if isodd(i)
            santa_coords = move(santa_coords, direction)
            push!(visited_houses, santa_coords)
        else
            robot_coords = move(robot_coords, direction)
            push!(visited_houses, robot_coords)
        end
    end
    houses_part_2 = length(visited_houses)

    println("AoC 2015 Day 3")
    println("Part 1: $houses_part_1")
    println("Part 2: $houses_part_2")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
