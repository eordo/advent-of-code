struct DanceMove
    move::Function
    args::Vector{Union{Char, Int}}
end

function main()
    input_file = joinpath(@__DIR__, "inputs/day_16.txt")
    moves_sequence = readline(input_file)
    moves = parse_move.(eachsplit(moves_sequence, ','))
    positions = collect('a':'p')
    initial_positions = copy(positions)
    
    # Part 1.
    dance!.(moves, Ref(positions))
    final_order_1 = join(positions)
    
    # Part 2.
    cycle_length = 1
    while positions != initial_positions
        dance!.(moves, Ref(positions))
        cycle_length += 1
    end
    n_moves = mod(1_000_000_000, cycle_length)
    positions = initial_positions
    for _ = 1:n_moves
        dance!.(moves, Ref(positions))
    end
    final_order_2 = join(positions)

    # Answers.
    println("AoC 2017 Day 16")
    println("Part 1: $final_order_1")
    println("Part 2: $final_order_2")
end

function dance!(move::DanceMove, positions::Vector{Char})
    move.move(positions, move.args...)
    return nothing
end

function spin!(positions::Vector{Char}, X::Int)
    circshift!(positions, X)
    return nothing
end

function exchange!(positions::Vector{Char}, A::Int, B::Int)
    positions[A + 1], positions[B + 1] = positions[B + 1], positions[A + 1]
    return nothing
end

function partner!(positions::Vector{Char}, A::Char, B::Char)
    index_A = findfirst(==(A), positions)
    index_B = findfirst(==(B), positions)
    positions[index_A], positions[index_B] = positions[index_B], positions[index_A]
    return nothing
end

function parse_move(s::AbstractString)
    if first(s) == 's'
        move = spin!
    elseif first(s) == 'x'
        move = exchange!
    elseif first(s) == 'p'
        move = partner!
    end
    args_strings = split(s[2:end], '/')
    if length(args_strings) == 1
        args = [parse(Int, only(args_strings))]
    elseif isnothing(tryparse(Int, first(args_strings)))
        args = first.(args_strings)
    else
        args = parse.(Int, args_strings)
    end
    return DanceMove(move, args)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
