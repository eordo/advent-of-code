using IterTools

function main()
    weights = parse.(Int, eachline(joinpath(@__DIR__, "inputs/day_24.txt")))

    # Part 1.
    target_1 = div(sum(weights), 3)
    optimal_qe_1 = find_optimal_qe(weights, target_1)

    # Part 2.
    target_2 = div(sum(weights), 4)
    optimal_qe_2 = find_optimal_qe(weights, target_2)
    
    println("AoC 2015 Day 24")
    println("Part 1: $optimal_qe_1")
    println("Part 2: $optimal_qe_2")
end

function find_optimal_qe(weights::Vector{Int}, target::Int)
    optimal_groups = find_optimal_groups(weights, target)
    qe = minimum(prod, optimal_groups)
    return qe
end

function find_optimal_groups(weights::Vector{Int}, target::Int)
    optimal_group_size = greedy_group_size(weights, target)
    optimal_groups = Vector{NTuple{optimal_group_size, Int}}()
    for group in subsets(weights, Val{optimal_group_size}())
        if sum(group) == target
            push!(optimal_groups, group)
        end
    end
    return optimal_groups
end

function greedy_group_size(v::Vector{Int}, target::Int)
    group_size = 1
    group_weight = v[end]
    k = length(v) - 1
    while group_weight != target
        if group_weight + v[k] <= target
            group_weight += v[k]
            group_size += 1
        end
        k -= 1
        if k < 1
            return 0
        end
    end
    return group_size
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
