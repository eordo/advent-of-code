function main()
    steps = parse(Int, readline(joinpath(@__DIR__, "inputs/day_17.txt")))
    
    # Part 1.
    buffer = [0]
    current_position = 1
    for num = 1:2017
        current_position = mod1(current_position + steps, num) + 1
        insert!(buffer, current_position, num)
    end
    k = findfirst(==(2017), buffer)
    num_after_2017 = buffer[k + 1]

    # Part 2.
    current_position = 1
    num_after_0 = -1
    for num = 1:50_000_000
        current_position = mod1(current_position + steps, num) + 1
        if current_position == 2
            num_after_0 = num
        end
    end

    # Answers.
    println("AoC 2017 Day 17")
    println("Part 1: $num_after_2017")
    println("Part 2: $num_after_0")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
