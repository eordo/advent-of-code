function main()
    input_file = joinpath(@__DIR__, "inputs/day_13.txt")
    
    scanners = Dict{Int, Int}()
    for line in eachline(input_file)
        depth, layer_range = split(line, ": ")
        depth = parse(Int, depth)
        layer_range = parse(Int, layer_range)
        scanners[depth] = layer_range
    end
    
    # Part 1.
    total_severity = sum(severity(depth, layer_range) for (depth, layer_range) in scanners)

    # Part 2.
    time_delayed = 0
    safe_after_delay = is_safe_to_go(scanners, time_delayed)
    while !safe_after_delay
        time_delayed += 1
        safe_after_delay = is_safe_to_go(scanners, time_delayed)
    end

    # Answers.
    println("AoC 2017 Day 13")
    println("Part 1: $total_severity")
    println("Part 2: $time_delayed")
end

function severity(depth::Int, layer_range::Int)
    period = 2 * (layer_range - 1)
    if mod(depth, period) == 0
        return depth * layer_range
    end
    return 0
end

function is_safe_to_go(scanners::Dict{Int, Int}, time_delayed::Int)
    for (depth, layer_range) in scanners
        time_at_arrival = depth + time_delayed
        period = 2 * (layer_range - 1)
        if mod(time_at_arrival, period) == 0
            return false
        end
    end
    return true
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
