function main()
    input_file = joinpath(@__DIR__, "inputs/day_10.txt")
    
    # Part 1.
    nums = collect(0:255)
    seq_lengths = parse.(Int, split(readline(input_file), ','))
    hash_round!(nums, seq_lengths)
    result = nums[1] * nums[2]

    # Part 2.
    knot_hashed_input = knot_hash(readline(input_file))

    # Answers.
    println("AoC 2017 Day 10")
    println("Part 1: $result")
    println("Part 2: $knot_hashed_input")
end

function hash_round!(x::Vector{Int}, seq_lengths::Vector{Int};
                        current_position::Int = 1, skip_size::Int = 0)
    n = length(x)
    @views for seq_length in seq_lengths
        if seq_length > n
            continue
        end
        indexes = mod1.(current_position:(current_position + seq_length - 1), n)
        reverse!(x[indexes])
        current_position = mod1(current_position + seq_length + skip_size, n)
        skip_size += 1
    end
    return current_position, skip_size
end

function knot_hash(x::String)
    seq_lengths = map(byte -> Int(codepoint(byte)), collect(x))
    append!(seq_lengths, [17, 31, 73, 47, 23])
    nums = collect(0:255)
    current_position = 1
    skip_size = 0
    for _ in 1:64
        current_position, skip_size = hash_round!(nums, seq_lengths;
                                                    current_position, skip_size)
    end
    dense_hash = [reduce(xor, @view nums[i:(i + 15)]) for i = 1:16:256]
    hashed = join(map(x -> string(x, base = 16, pad = 2), dense_hash))
    return hashed
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
