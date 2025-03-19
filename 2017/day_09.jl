function main()
    stream = readline(joinpath(@__DIR__, "inputs/day_09.txt"))
    group_score, garbage_ch_count = analyze_garbage(stream)

    # Answers.
    println("AoC 2017 Day 9")
    println("Part 1: $group_score")
    println("Part 2: $garbage_ch_count")
end

function analyze_garbage(stream::String)
    group_score, group_depth = 0, 0
    garbage_ch_count = 0
    inside_garbage, negated = false, false
    for ch in stream
        if inside_garbage
            if negated
                negated = false
                continue
            elseif ch == '!'
                negated = true
            elseif ch == '>'
                inside_garbage = false
            else
                garbage_ch_count += 1
            end
        elseif ch == '<'
            inside_garbage = true
        elseif ch == '{'
            group_depth += 1
            group_score += group_depth
        elseif ch == '}'
            group_depth -= 1
        end
    end        
    return group_score, garbage_ch_count
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
