function main()
    input_file = joinpath(@__DIR__, "inputs/day_02.txt")
    rows = map(line -> parse.(Int, line), split.(eachline(input_file)))
    
    # Part 1.
    checksum = sum(row -> maximum(row) - minimum(row), rows)
    
    # Part 2.
    row_results_sum = sum(row_result.(rows))

    # Answers.
    println("AoC 2017 Day 2")
    println("Part 1: $checksum")
    println("Part 2: $row_results_sum")
end

function row_result(row::Vector{Int})
    sort!(row)
    n = length(row)
    for i = 1:n, j = (i + 1):n
        if row[j] % row[i] == 0
            return div(row[j], row[i])
        end
    end
    return 0
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
