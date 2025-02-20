function main()
    input_file = joinpath(@__DIR__, "inputs/day_10.txt")
    seed = parse.(Int, readline(input_file))
    seq = reverse(digits(seed))
    
    # Part 1.
    for _ in 1:40
        seq = look_and_say(seq)
    end
    length_1 = length(seq)

    # Part 2.
    for _ in 41:50
        seq = look_and_say(seq)
    end
    length_2 = length(seq)
    
    println("AoC 2015 Day 10")
    println("Part 1: $length_1")
    println("Part 2: $length_2")
end

function look_and_say(seq::Vector{Int})
    current_digit = first(seq)
    current_count = 0
    next_seq = Vector{Int}()
    for (i, digit) in enumerate(seq)
        if digit == current_digit
            current_count += 1
        else
            push!(next_seq, current_count)
            push!(next_seq, current_digit)
            current_digit = digit
            current_count = 1
        end
        if i == lastindex(seq)
            push!(next_seq, current_count)
            push!(next_seq, current_digit)
        end
    end
    return next_seq
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
