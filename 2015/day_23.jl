mutable struct Computer
    registers::Dict{Char, Int}
    index::Int
end

function main()
    lines = readlines(joinpath(@__DIR__, "inputs/day_23.txt"))

    # Part 1.
    cpu = Computer(Dict('a' => 0, 'b' => 0), 1)   
    run_instructions!(cpu, lines)
    b_value_1 = cpu.registers['b']

    # Part 2.
    cpu = Computer(Dict('a' => 1, 'b' => 0), 1)
    run_instructions!(cpu, lines)
    b_value_2 = cpu.registers['b']    

    println("AoC 2015 Day 23")
    println("Part 1: $b_value_1")
    println("Part 2: $b_value_2")
end

function run_instructions!(cpu::Computer, lines::Vector{String})
    instructions = Dict(
        "hlf" => half!,
        "tpl" => triple!,
        "inc" => increment!,
        "jmp" => jump!,
        "jie" => jump_even!,
        "jio" => jump_one!
    )
    while 1 <= cpu.index <= length(lines)
        code, args = parse_instruction(lines[cpu.index])
        instructions[code](cpu, args...)
    end
    return nothing
end

function parse_instruction(line::String)
    split_line = split(line)
    code = first(split_line)
    if length(split_line) == 2
        arg = split_line[2]
        arg = length(arg) == 1 ? first(arg) : parse(Int, arg)
        args = [arg]
    elseif length(split_line) == 3
        arg_1 = first(split_line[2])
        arg_2 = parse(Int, split_line[3])
        args = [arg_1, arg_2]
    end
    return code, args
end

function half!(cpu::Computer, r::Char)
    cpu.registers[r] /= 2
    cpu.index += 1
    return nothing
end

function triple!(cpu::Computer, r::Char)
    cpu.registers[r] *= 3
    cpu.index += 1
    return nothing
end

function increment!(cpu::Computer, r::Char)
    cpu.registers[r] += 1
    cpu.index += 1
    return nothing
end

function jump!(cpu::Computer, offset::Int)
    cpu.index += offset
    return nothing
end

function jump_even!(cpu::Computer, r::Char, offset::Int)
    if iseven(cpu.registers[r])
        cpu.index += offset
    else
        cpu.index += 1
    end
    return nothing
end

function jump_one!(cpu::Computer, r::Char, offset::Int)
    if cpu.registers[r] == 1
        cpu.index += offset
    else
        cpu.index += 1
    end
    return nothing
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
