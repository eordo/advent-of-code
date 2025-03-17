function main()
    input_file = joinpath(@__DIR__, "inputs/day_04.txt")
    passphrases = split.(eachline(input_file))

    # Part 1.
    valid_count = count(allunique, passphrases)
    
    # Part 2.
    also_valid_count = count(
        allunique(map(word -> sort!(collect(word)), passphrase))
        for passphrase in passphrases)

    # Answers.
    println("AoC 2017 Day 4")
    println("Part 1: $valid_count")
    println("Part 2: $also_valid_count")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
