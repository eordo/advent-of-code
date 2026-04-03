function parse_input(path)
    input_file = joinpath(@__DIR__, path)
    map(eachline(input_file)) do line
        parse.(Int, split(line, 'x'))
    end
end

function part_1(data)
    total_wrapping_paper = 0
    for (l, w, h) in data
        areas = (l * w, w * h, h * l)
        total_wrapping_paper += 2 * sum(areas) + minimum(areas)
    end
    total_wrapping_paper
end

function part_2(data)
    total_ribbon = 0
    for (l, w, h) in data
        perimeters = (2 * (l + w), 2 * (w + h), 2 * (h + l))
        total_ribbon += minimum(perimeters) + l * w * h
    end
    total_ribbon
end

function main()
    data = parse_input("inputs/day_02.txt")
    println("Advent of Code 2015 Day 2")
    println("=========================")
    println("Part 1: ", part_1(data))
    println("Part 2: ", part_2(data))
end

main()
