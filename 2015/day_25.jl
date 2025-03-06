function main()
    # Read explicitly from the puzzle input.
    x, y = 2947, 3029
    index = flatten_index(x, y)

    current_index = 1
    code = 20151125
    while current_index != index
        code = next_code(code)
        current_index += 1
    end
    
    println("AoC 2015 Day 25")
    println("Part 1: $code")
end

function flatten_index(x::Int, y::Int)
    k = x + y - 1
    index = triangular(k - 1) + 1
    i, j = k, 1
    while i != x && j != y
        index += 1
        i -= 1
        j += 1
    end
    return index
end

triangular(n) = div(n * (n + 1), 2)

next_code(code) = mod(code * 252533, 33554393)

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
