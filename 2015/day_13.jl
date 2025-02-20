using Combinatorics

function main()
    input_file = joinpath(@__DIR__, "inputs/day_13.txt")
    guest_ids = Dict{String, Int}()
    happiness_changes = parse_line.(eachline(input_file), Ref(guest_ids))

    # Part 1.
    n = length(guest_ids)
    M1 = zeros(Int, n, n)
    for (i, j, net_happiness) in happiness_changes
        M1[i, j] = net_happiness
    end
    max_change_1 = maximum_happiness(M1)

    # Part 2.
    M2 = zeros(Int, n + 1, n + 1)
    M2[1:n, 1:n] .= M1
    max_change_2 = maximum_happiness(M2)

    println("AoC 2015 Day 13")
    println("Part 1: $max_change_1")
    println("Part 2: $max_change_2")
end

function maximum_happiness(M::Matrix{Int})
    n = size(M, 1)
    max_happiness = -Inf
    for perm in permutations(1:n)
        happiness = sum(M[perm[k - 1], perm[k]] + M[perm[k], perm[k - 1]] for k in 2:n)
        happiness += M[perm[begin], perm[end]] + M[perm[end], perm[begin]]
        max_happiness = max(happiness, max_happiness)
    end
    return Int(max_happiness)
end

function parse_line(line::String, guest_ids::Dict{String, Int})
    split_line = split(line[1:(end - 1)])
        
    guest_i, guest_j = split_line[begin], split_line[end]
    if !haskey(guest_ids, guest_i)
        i = length(guest_ids) + 1
        guest_ids[guest_i] = i
    end
    if !haskey(guest_ids, guest_j)
        j = length(guest_ids) + 1
        guest_ids[guest_j] = j
    end
    i, j = guest_ids[guest_i], guest_ids[guest_j]

    is_gain = split_line[3] == "gain" ? 1 : -1
    net_happiness = is_gain * parse(Int, split_line[4])

    return i, j, net_happiness
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
