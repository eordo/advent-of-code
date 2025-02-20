function main()
    input_file = joinpath(@__DIR__, "inputs/day_08.txt")

    # Part 1.
    decoded_difference(s) = 2 + length(s) - length(unescape_string(s))
    total_decoded_difference = sum(decoded_difference, eachline(input_file))
    
    # Part 2.
    encoded_difference(s) = 2 + length(escape_string(s)) - length(s)
    total_encoded_difference = sum(encoded_difference, eachline(input_file))

    println("AoC 2015 Day 8")
    println("Part 1: $total_decoded_difference")
    println("Part 2: $total_encoded_difference")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
