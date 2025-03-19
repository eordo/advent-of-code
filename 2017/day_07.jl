using DataStructures

struct ProgramData
    weight::Int
    children::Vector{Symbol}
end

function main()
    input_file = joinpath(@__DIR__, "inputs/day_07.txt")
    
    data = Dict{Symbol, ProgramData}()
    parents = Dict{Symbol, Symbol}()
    for line in eachline(input_file)
        # Parse program data.
        split_line = split(line, " -> ")
        name, weight = extract_name_and_weight(split_line[1])
        children = length(split_line) == 2 ? extract_child_names(split_line[2]) : Symbol[]
        
        # Store program data.
        data[name] = ProgramData(weight, children)
        
        # Identify this program as the parent of its children.
        for child in children
            parents[child] = name
        end
    end

    # Part 1.
    root = only(setdiff(keys(data), keys(parents)))

    # Part 2.
    correct_weight = find_imbalance(data, root)

    # Answers.
    println("AoC 2017 Day 7")
    println("Part 1: $root")
    println("Part 2: $correct_weight")
end

function find_imbalance(data::Dict{Symbol, ProgramData}, root::Symbol)
    # Compute stack weights.
    stack_weights = Dict{Symbol, Int}()
    compute_stack_weight!(stack_weights, data, root)

    # Find weight-unbalanced programs.
    unbalanced_programs = [name for (name, program) in data
        if !allequal(stack_weights[child] for child in program.children)
    ]
    
    # Identify the deepest unbalanced program.
    imbalance = root
    for name in unbalanced_programs
        if !any(child in unbalanced_programs for child in data[name].children)
            imbalance = name
            break
        end
    end
    
    # Identify which stack weight needs to change.
    child_stack_weights = [stack_weights[child] for child in data[imbalance].children]
    unique_weights = counter(child_stack_weights)
    old_weight, target_weight = 0, 0
    for (weight, count) in unique_weights
        if count == 1
            old_weight = weight
        else
            target_weight = weight
        end
    end
    weight_difference = target_weight - old_weight
    
    # Identify the child program causing the imbalance.
    problem_child = Symbol()
    for child in data[imbalance].children
        if stack_weights[child] == old_weight
            problem_child = child
            break
        end
    end
    correct_weight = data[problem_child].weight + weight_difference
    
    return correct_weight
end

function compute_stack_weight!(stack_weights::Dict{Symbol, Int},
                                data::Dict{Symbol, ProgramData},
                                name::Symbol)                                
    # Base case: A leaf program.
    program = data[name]
    if isempty(program.children)
        stack_weights[name] = program.weight
        return program.weight
    end
    
    # Otherwise, recurse on this program's children.
    stack_weight = sum(compute_stack_weight!(stack_weights, data, child)
                    for child in program.children) + program.weight
    stack_weights[name] = stack_weight
    
    return stack_weight
end

function extract_name_and_weight(s::AbstractString)
    name, weight = split(s)
    name = Symbol(name)
    weight = parse(Int, weight[2:(end - 1)])
    return name, weight
end

function extract_child_names(s::AbstractString)
    child_names = Symbol.(split(s, ", "))
    return child_names
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
