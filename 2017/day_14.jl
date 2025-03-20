using Images

include("day_10.jl")

function main()
    key = readline(joinpath(@__DIR__, "inputs/day_14.txt"))
    grid = BitMatrix(undef, 128, 128)

    # Part 1.
    for i = 1:128
        hashed = knot_hash("$key-$(i - 1)")
        j = 1
        for hex_digit in hashed
            bits = reverse(digits(parse(Int, hex_digit, base = 16), base = 2, pad = 4))
            for bit in bits
                grid[i, j] = bit
                j += 1
            end
        end
    end
    num_used_squares = sum(grid)

    # Part 2.
    num_regions = maximum(label_components(grid))

    # Answers.
    println("AoC 2017 Day 14")
    println("Part 1: $num_used_squares")
    println("Part 2: $num_regions")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
