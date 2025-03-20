function main()
    input_file = joinpath(@__DIR__, "inputs/day_15.txt")
    seed_A, seed_B = parse_starting_value.(eachline(input_file))

    factor_A = 16807
    factor_B = 48271
    divisor = 2147483647

    # Part 1.
    value_A, value_B = seed_A, seed_B
    total_matches_1 = 0
    for _ = 1:40_000_000
        value_A = next_value(value_A, factor_A, divisor)
        value_B = next_value(value_B, factor_B, divisor)
        if (value_A - value_B) & 0xffff == 0
            total_matches_1 += 1
        end
    end

    # Part 2.
    value_A, value_B = seed_A, seed_B
    total_matches_2 = 0
    for _ = 1:5_000_000
        while mod(value_A, 4) != 0
            value_A = next_value(value_A, factor_A, divisor)
        end
        while mod(value_B, 8) != 0
            value_B = next_value(value_B, factor_B, divisor)
        end
        if (value_A - value_B) & 0xffff == 0
            total_matches_2 += 1
        end
        value_A = next_value(value_A, factor_A, divisor)
        value_B = next_value(value_B, factor_B, divisor)
    end

    # Answers.
    println("AoC 2017 Day 15")
    println("Part 1: $total_matches_1")
    println("Part 2: $total_matches_2")
end

next_value(prev_val::Int, factor::Int, divisor::Int) = mod(prev_val * factor, divisor)

parse_starting_value(line::String) = parse(Int, last(split(line)))

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
