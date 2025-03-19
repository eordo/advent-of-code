function main()
    input_file = joinpath(@__DIR__, "inputs/day_08.txt")
    
    cpu = Dict{Symbol, Int}()
    comparisons = Dict(
        ">" => >,
        "<" => <,
        ">=" => >=,
        "<=" => <=,
        "==" => ==,
        "!=" => !=
    )
    changes = Dict(
        "inc" => +,
        "dec" => -
    )
    
    highest_value_held = 0
    for line in eachline(input_file)
        tokens = split(line)
        compare = comparisons[tokens[end - 1]]
        condition_register = Symbol(tokens[end - 2])
        condition_amount = parse(Int, tokens[end])
        if compare(get(cpu, condition_register, 0), condition_amount)
            change = changes[tokens[2]]
            register = Symbol(tokens[1])
            amount = parse(Int, tokens[3])
            cpu[register] = change(get(cpu, register, 0), amount)
            # Part 2.
            highest_value_held = max(cpu[register], highest_value_held)
        end
    end
    # Part 1.
    max_register_value = maximum(values(cpu))

    # Answers.
    println("AoC 2017 Day 8")
    println("Part 1: $max_register_value")
    println("Part 2: $highest_value_held")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
