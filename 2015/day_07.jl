function main()
    input_file = joinpath(@__DIR__, "inputs/day_07.txt")

    ops = Dict(
        "AND" => &,
        "OR" => |,
        "NOT" => ~,
        "RSHIFT" => >>,
        "LSHIFT" => <<
    )
    instructions = Dict{Symbol, Any}()
    for line in eachline(input_file)
        instruction_str, output_str = split(line, " -> ")
        instruction = split(instruction_str)
        if length(instruction) == 3
            op = ops[instruction[2]]
            args = parse_arg.([instruction[1], instruction[3]])
        elseif length(instruction) == 2
            op = ops[instruction[1]]
            args = [parse_arg(instruction[2])]
        elseif length(instruction) == 1
            op = identity
            args = [parse_arg(instruction[1])]
        end
        output = Symbol(output_str)
        instructions[output] = (op, args)
    end
    
    # Part 1.
    circuit = Dict{Symbol, Int}()
    a_signal = evaluate(:a, circuit, instructions)

    # Part 2.
    empty!(circuit)
    circuit[:b] = a_signal
    new_a_signal = evaluate(:a, circuit, instructions)

    println("AoC 2015 Day 7")
    println("Part 1: $a_signal")
    println("Part 2: $new_a_signal")
end

function evaluate(wire::Symbol, circuit::Dict{Symbol, Int}, instructions::Dict{Symbol, Any})
    if !haskey(circuit, wire)
        op, args = instructions[wire]
        evaluated_args = evaluate.(args, Ref(circuit), Ref(instructions))
        circuit[wire] = op(evaluated_args...)
    end
    return circuit[wire]
end
evaluate(signal::Int, circuit::Dict{Symbol, Int}, instructions::Dict{Symbol, Any}) = signal

function parse_arg(s::AbstractString)
    if all(isdigit, s)
        return parse(Int, s)
    end
    return Symbol(s)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
