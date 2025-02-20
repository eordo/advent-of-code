using Combinatorics

function main()    
    input_file = joinpath(@__DIR__, "inputs/day_15.txt")
    properties = parse_line.(eachline(input_file))

    A = stack(properties)
    n_ingredients = length(properties)
    max_score_1 = 0
    max_score_2 = 0
    @views for partition in partitions(100, n_ingredients)
        for x in permutations(partition)
            props_totals = A * x
            scored_props_totals = props_totals[1:(end - 1)]
            cookie_score = score(scored_props_totals)
            
            # Part 1.
            max_score_1 = max(cookie_score, max_score_1)
            
            # Part 2.
            if last(props_totals) == 500
                max_score_2 = max(cookie_score, max_score_2)
            end
        end
    end

    println("AoC 2015 Day 15")
    println("Part 1: $max_score_1")
    println("Part 2: $max_score_2")
end

function score(x::AbstractVector{Int})
    if any(x .< 0)
        return 0
    end
    return prod(x)
end

parse_line(s::String) = parse.(Int, last.(split.(split(s, ", "))))

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
