using MD5

function parse_input(path)
    readline(joinpath(@__DIR__, path))
end

function part_1(data)
    find_lowest_number(data, 5)
end

function part_2(data)
    find_lowest_number(data, 6)
end

function find_lowest_number(key, K)
    K_zeros = repeat('0', K)
    num = 1
    while true
        hashed_input = bytes2hex(md5(string(key, num)))
        startswith(hashed_input, K_zeros) && return num
        num += 1
    end
    return num
end

function main()
    data = parse_input("inputs/day_04.txt")
    println("Advent of Code 2015 Day 4")
    println("=========================")
    println("Part 1: ", part_1(data))
    println("Part 2: ", part_2(data))
end

main()
