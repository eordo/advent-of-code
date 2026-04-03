function parse_input(path)
    readline(joinpath(@__DIR__, path))
end

function part_1(data)
    count(==('('), data) - count(==(')'), data)
end

function part_2(data)
    floor = 0
    for (position, instruction) in enumerate(data)
        floor += instruction == '(' ? 1 : -1
        floor == -1 && return position
    end
    return nothing
end

function main()
    data = parse_input("inputs/day_01.txt")
    println("Advent of Code 2015 Day 1")
    println("=========================")
    println("Part 1: ", part_1(data))
    println("Part 2: ", part_2(data))
end

main()
