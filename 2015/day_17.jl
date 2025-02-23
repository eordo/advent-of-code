using Combinatorics

function main()
    input_file = joinpath(@__DIR__, "inputs/day_17.txt")
    capacities = parse.(Int, eachline(input_file))
    volume = 150

    # Part 1.
    num_combinations = count(sum(subset) == volume for subset in powerset(capacities))

    # Part 2.
    subset_sizes = Dict{Int, Int}()
    for subset in powerset(capacities)
        if sum(subset) == volume
            subset_size = length(subset)
            subset_sizes[subset_size] = get!(subset_sizes, subset_size, 0) + 1
        end
    end
    num_smallest_combinations = subset_sizes[minimum(keys(subset_sizes))]

    println("AoC 2015 Day 17")
    println("Part 1: $num_combinations")
    println("Part 2: $num_smallest_combinations")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
