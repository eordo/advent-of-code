function main()
    input_file = joinpath(@__DIR__, "inputs/day_01.txt")
    changes = parse.(Int, eachline(input_file))

    # Part 1.
    final_frequency = sum(changes)

    # Part 2.
    frequency = 0
    seen_frequencies = Set(frequency)
    found_duplicate = false
    while !found_duplicate
        for change in changes
            frequency += change
            if frequency in seen_frequencies
                found_duplicate = true
                break
            else
                push!(seen_frequencies, frequency)
            end
        end
    end
    repeated_frequency = frequency

    # Answers.
    println("AoC 2018 Day 1")
    println("Part 1: $final_frequency")
    println("Part 2: $repeated_frequency")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
