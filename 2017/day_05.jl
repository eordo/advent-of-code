function main()
    input_file = joinpath(@__DIR__, "inputs/day_05.txt")
    
    # Part 1.
    offsets = parse.(Int, eachline(input_file))
    steps_1 = traverse!(offsets)

    # Part 2.
    offsets = parse.(Int, eachline(input_file))
    steps_2 = traverse!(offsets, weird_jump = true)

    # Answers.
    println("AoC 2017 Day 5")
    println("Part 1: $steps_1")
    println("Part 2: $steps_2")
end

function traverse!(offsets::Vector{Int}; weird_jump::Bool = false)
    current_instruction = 1
    steps = 0
    while 1 <= current_instruction <= length(offsets)
        jump = offsets[current_instruction]
        next_instruction = current_instruction + jump
        if weird_jump
            if jump >= 3
                offsets[current_instruction] -= 1
            else
                offsets[current_instruction] += 1
            end
        else
            offsets[current_instruction] += 1
        end
        current_instruction = next_instruction
        steps += 1
    end
    return steps
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
