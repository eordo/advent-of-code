using DataStructures

function main()
    input_file = joinpath(@__DIR__, "inputs/day_01.txt")
    lists = map(line -> parse.(Int, split(line)), eachline(input_file))
    left_list = first.(lists)
    right_list = last.(lists)
    sort!(left_list)
    sort!(right_list)

    # Part 1.
    total_distance = sum(abs.(left_list - right_list))

    # Part 2.
    right_counts = counter(right_list)
    total_similarity_score = sum(num -> num * get(right_counts, num, 0), left_list)

    println("AoC 2024 Day 1")
    println("Part 1: $total_distance")
    println("Part 2: $total_similarity_score")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
