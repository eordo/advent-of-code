using DataStructures

function main()
    input_file = joinpath(@__DIR__, "inputs/day_06.txt")
    message = stack(collect.(eachline(input_file)); dims = 1)

    most_common_chars = Char[]
    least_common_chars = Char[]
    for col in eachcol(message)
        char_counts = counter(col)

        # Part 1.
        _, most_common_char = findmax(char_counts)
        push!(most_common_chars, most_common_char)

        # Part 2.
        _, least_common_char = findmin(char_counts)
        push!(least_common_chars, least_common_char)
    end
    corrected_message_1 = String(most_common_chars)
    corrected_message_2 = String(least_common_chars)

    println("AoC 2016 Day 6")
    println("Part 1: $corrected_message_1")
    println("Part 2: $corrected_message_2")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
