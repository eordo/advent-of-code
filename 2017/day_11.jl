function main()
    steps = readline(joinpath(@__DIR__, "inputs/day_11.txt"))
    moves = Dict(
        :n => (0, 1),
        :ne => (1, 0),
        :se => (1, -1),
        :s => (0, -1),
        :sw => (-1, 0),
        :nw => (-1, 1)   
        )
    coords = (0, 0)
    max_distance = 0
    for step in eachsplit(steps, ',')
        step = Symbol(step)
        coords = coords .+ moves[step]
        # Part 2.
        max_distance = max(hex_distance(coords), max_distance)
    end
    # Part 1.
    shortest_distance = hex_distance(coords)

    # Answers.
    println("AoC 2017 Day 11")
    println("Part 1: $shortest_distance")
    println("Part 2: $max_distance")
end

function hex_distance(point::NTuple{2, Int})
    x, y = point
    if sign(x) == sign(y)
        return abs(x + y)
    else
        return max(abs(x), abs(y))
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
