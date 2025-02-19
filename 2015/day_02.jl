function main()
    input_file = joinpath(@__DIR__, "inputs/day_02.txt")

    total_wrapping_paper = 0
    total_ribbon = 0
    for line in eachline(input_file)
        l, w, h = parse.(Int, split(line, 'x'))

        # Part 1.
        areas = [l * w, w * h, h * l]
        total_wrapping_paper += 2 * sum(areas) + minimum(areas)

        # Part 2.
        perimeters = 2 * [l + w, w + h, h + l]
        total_ribbon += minimum(perimeters) + l * w * h
    end

    println("AoC 2015 Day 2")
    println("Part 1: $total_wrapping_paper")
    println("Part 2: $total_ribbon")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
