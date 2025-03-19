function main()
    input_file = joinpath(@__DIR__, "inputs/day_06.txt")
    banks = parse.(Int, split(readline(input_file)))
    
    seen_states = Dict(hash(banks) => 0)
    num_cycles = 0
    cycle_length = typemax(Int)
    while true
        reallocate!(banks)
        banks_hashed = hash(banks)
        num_cycles += 1
        # Parts 1 and 2.
        if haskey(seen_states, banks_hashed)
            cycle_length = num_cycles - seen_states[banks_hashed]
            break
        end
        seen_states[banks_hashed] = num_cycles
    end
    
    # Answers.
    println("AoC 2017 Day 6")
    println("Part 1: $num_cycles")
    println("Part 2: $cycle_length")
end

function reallocate!(banks::Vector{Int})
    n_banks = length(banks)
    blocks_to_distribute, source = findmax(banks)
    banks[source] = 0
    target = mod1(source + 1, n_banks)
    while blocks_to_distribute != 0
        blocks_to_distribute -= 1
        banks[target] += 1
        target = mod1(target + 1, n_banks)
    end
    return nothing
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
