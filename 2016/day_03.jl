function main()
    input_file = joinpath(@__DIR__, "inputs/day_03.txt")
    sides_list = parse_sides.(eachline(input_file))

    # Part 1.
    num_triangles_1 = count(is_valid_triangle.(sides_list))

    # Part 2.
    M = stack(sides_list, dims = 1)
    num_triangles_2 = count(is_valid_triangle(M[i:(i + 2)]) for i in 1:3:length(M))

    println("AoC 2016 Day 3")
    println("Part 1: $num_triangles_1")
    println("Part 2: $num_triangles_2")
end

function is_valid_triangle(sides::Vector{Int})
    a, b, c = sort(sides)
    return a + b > c
end

parse_sides(line::String) = parse.(Int, split(line))

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
