using DataStructures

function main()
    input_file = joinpath(@__DIR__, "inputs/day_02.txt")
    ids = readlines(input_file)

    # Part 1.
    two_letter_count, three_letter_count = 0, 0
    for id in eachline(input_file)
        c = counter(id)
        two_letter_count += (2 in values(c))
        three_letter_count += (3 in values(c))
    end
    checksum = two_letter_count * three_letter_count

    # Part 2.
    common_letters = find_common_letters(ids)
    
    # Answers.
    println("AoC 2018 Day 2")
    println("Part 1: $checksum")
    println("Part 2: $common_letters")
end

function find_common_letters(ids::Vector{String})
    for i = 1:length(ids), j = (i + 1):length(ids)
        differences = count(splat(!=), zip(ids[i], ids[j]))
        if differences == 1
            common_letters = join(ch for (k, ch) in enumerate(ids[i]) if ids[i][k] == ids[j][k])
            return common_letters
        end
    end
    return ""
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
