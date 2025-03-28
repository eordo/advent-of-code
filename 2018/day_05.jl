function main()
    units = readline(joinpath(@__DIR__, "inputs/day_05.txt"))
    
    # Part 1.
    polymer = collect(units)
    react!(polymer)
    final_length = length(polymer)

    # Part 2.
    shortest_length = length(units)
    for ch in 'A':'Z'
        new_polymer = collect(replace(units, ch => "", (ch + 32) => ""))
        react!(new_polymer)
        shortest_length = min(length(new_polymer), shortest_length)
    end

    # Answers.
    println("AoC 2018 Day 5")
    println("Part 1: $final_length")
    println("Part 2: $shortest_length")
end

function react!(polymer::Vector{Char})
    i = 1
    while i < length(polymer)
        if is_match(polymer[i], polymer[i + 1])
            deleteat!(polymer, i)
            deleteat!(polymer, i)
            if i > 1
                i -= 1
            end
        else
            i += 1
        end
    end
    return nothing
end

is_match(a::Char, b::Char) = abs(a - b) == 32

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
