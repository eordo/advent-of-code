function main()
    instructions = readline(joinpath(@__DIR__, "inputs/day_01.txt"))

    # Part 1.
    final_floor = count(==('('), instructions) - count(==(')'), instructions)
    
    # Part 2.
    floor = 0
    final_position = 0
    move = Dict(
        '(' => 1,
        ')' => -1
    )
    for (position, instruction) in enumerate(instructions)
        floor += move[instruction]
        if floor == -1
            final_position = position
            break
        end
    end

    println("AoC 2015 Day 1")
    println("Part 1: $final_floor")
    println("Part 2: $final_position")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
