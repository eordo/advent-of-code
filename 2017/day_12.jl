using Graphs

function main()
    input_file = joinpath(@__DIR__, "inputs/day_12.txt")

    pipes = Dict{Int, Vector{Int}}()
    for line in eachline(input_file)
        program, targets = split(line, " <-> ")
        program = parse(Int, program)
        targets = parse.(Int, split(targets, ", "))
        pipes[program] = targets
    end

    G = Graph(length(pipes))
    for (program, targets) in pipes
        for target in targets
            add_edge!(G, program + 1, target + 1)
        end
    end

    # Part 1.
    group_0_size = 0
    for component in connected_components(G)
        if 1 in component
            group_0_size = length(component)
            break
        end
    end

    # Part 2.
    num_groups = length(connected_components(G))

    # # Answers.
    println("AoC 2017 Day 12")
    println("Part 1: $group_0_size")
    println("Part 2: $num_groups")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
