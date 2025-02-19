using MD5

function main()
    key = readline(joinpath(@__DIR__, "inputs/day_04.txt"))
    
    # Part 1.
    answer_1 = find_lowest_number(key, 5)

    # Part 2.
    answer_2 = find_lowest_number(key, 6, answer_1)

    println("AoC 2015 Day 4")
    println("Part 1: $answer_1")
    println("Part 2: $answer_2")
end

function find_lowest_number(key::String, K::Int, num::Int = 1)
    hashed_input = bytes2hex(md5(key * string(num)))
    first_K = hashed_input[1:K]
    K_zeros = repeat('0', K)
    while first_K != K_zeros
        num += 1
        hashed_input = bytes2hex(md5(key * string(num)))
        first_K = hashed_input[1:K]
    end
    return num
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
