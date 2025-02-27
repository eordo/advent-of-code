using BenchmarkTools

function main()
    input_file = joinpath(@__DIR__, "inputs/day_03.txt")
    memory = join(eachline(input_file))

    all_patterns = r"mul\(\d+,\d+\)|do\(\)|don't\(\)"
    enabled = true
    all_mul_sum = 0
    enabled_mul_sum = 0
    for pattern in eachmatch(all_patterns, memory)
        if pattern.match == "do()"
            enabled = true
        elseif pattern.match == "don't()"
            enabled = false
        else
            # Part 1.
            evaluation = evaluate(pattern.match)
            all_mul_sum += evaluation
            
            # Part 2.
            if enabled
                enabled_mul_sum += evaluation
            end
        end
    end

    println("AoC 2024 Day 3")
    println("Part 1: $all_mul_sum")
    println("Part 2: $enabled_mul_sum")
end

function evaluate(s::AbstractString)
    s_split = split(s, ',')
    nums = parse.(Int, filter.(isdigit, s_split))
    return prod(nums)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
