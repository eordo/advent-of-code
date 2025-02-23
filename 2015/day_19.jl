function main()
    lines = readlines(joinpath(@__DIR__, "inputs/day_19.txt"))
    
    replacements = Dict{String, Vector{String}}()
    medicine = last(lines)
    for i = 1:(length(lines) - 3)
        element, replacement = split(lines[i], " => ")
        push!(get!(replacements, element, String[]), replacement)
    end

    # Part 1.
    created_molecules = Set{String}()
    element_patterns = r"[A-Z][a-z]*"
    for pattern in eachmatch(element_patterns, medicine)
        element = pattern.match
        i = pattern.offset
        n = length(element)
        if haskey(replacements, element)
            for replacement in replacements[element]
                created_molecule = join([medicine[begin:(i - 1)], replacement, medicine[(i + n):end]])
                push!(created_molecules, created_molecule)
            end
        end
    end
    num_distinct_molecules = length(created_molecules)

    # Part 2.
    elements = collect(m.match for m in eachmatch(element_patterns, medicine))
    num_steps = (length(elements) 
        - (count(==("Rn"), elements) + count(==("Ar"), elements))
        - 2 * count(==("Y"), elements)
        - 1)
    
    println("AoC 2015 Day 19")
    println("Part 1: $num_distinct_molecules")
    println("Part 2: $num_steps")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
