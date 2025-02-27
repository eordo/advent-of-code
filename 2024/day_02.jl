using InvertedIndices

function main()
    input_file = joinpath(@__DIR__, "inputs/day_02.txt")

    safe_report_count = 0
    dampened_report_count = 0
    for line in eachline(input_file)
        report = parse.(Int, split(line))

        # Part 1.
        if is_safe(report)
            safe_report_count += 1
            dampened_report_count += 1
        # Part 2.
        else
            for k in eachindex(report)
                if is_safe(report[Not(k)])
                    dampened_report_count += 1
                    break
                end
            end
        end
    end

    println("AoC 2024 Day 2")
    println("Part 1: $safe_report_count")
    println("Part 2: $dampened_report_count")
end

function is_safe(report::Vector{Int})
    is_in_range(arr) = all(1 <= abs(x) <= 3 for x in arr)
    is_monotonic(arr) = all(x > 0 for x in arr) || all(x < 0 for x in arr)
    diffs = diff(report)
    return is_in_range(diffs) && is_monotonic(diffs)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
