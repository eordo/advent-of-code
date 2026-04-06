@enum Op TurnOn TurnOff Toggle

struct Instruction
    op::Op
    x::UnitRange{Int}
    y::UnitRange{Int}
end

function parse_input(path)
    input_file = joinpath(@__DIR__, path)
    map(eachline(input_file)) do line
        tokens = split(line)
        op = if tokens[1] == "toggle"
            Toggle
        elseif tokens[2] == "on"
            TurnOn
        else
            TurnOff
        end
        start_coords = parse.(Int, split(tokens[end-2], ',')) .+ 1
        end_coords = parse.(Int, split(tokens[end], ',')) .+ 1
        Instruction(
            op,
            start_coords[1]:end_coords[1],
            start_coords[2]:end_coords[2]
        )
    end
end

function part_1(data, N = 1000)
    lights = falses(N, N)
    for instruction in data
        apply!(lights, instruction)
    end
    sum(lights)
end

function part_2(data, N = 1000)
    brightness = zeros(Int, N, N)
    for instruction in data
        apply!(brightness, instruction)
    end
    sum(brightness)
end

function apply!(lights::BitMatrix, instruction::Instruction)
    region = view(lights, instruction.x, instruction.y)
    if instruction.op === TurnOn
        region .= true
    elseif instruction.op === TurnOff
        region .= false
    else
        region .= .!region
    end
end

function apply!(brightness::Matrix{Int}, instruction::Instruction)
    region = view(brightness, instruction.x, instruction.y)
    if instruction.op === TurnOn
        region .+= 1
    elseif instruction.op === TurnOff
        clamp!(region .-= 1, 0, typemax(Int))
    else
        region .+= 2
    end
end

function main()
    data = parse_input("inputs/day_06.txt")
    println("Advent of Code 2015 Day 6")
    println("=========================")
    println("Part 1: ", part_1(data))
    println("Part 2: ", part_2(data))
end

main()
