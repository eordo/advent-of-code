using JSON

function main()
    json_text = readline(joinpath(@__DIR__, "inputs/day_12.txt"))
    json = JSON.parse(json_text)

    # Part 1.
    doc_sum = nums_sum(json)

    # Part 2.
    dump_reds!(json)
    redless_doc_sum = nums_sum(json)

    println("AoC 2015 Day 12")
    println("Part 1: $doc_sum")
    println("Part 2: $redless_doc_sum")
end

nums_sum(x::Dict{String, Any}) = sum(nums_sum, values(x); init = 0)
nums_sum(x::Vector{Any}) = sum(nums_sum, x; init = 0)
nums_sum(x::Int) = x
nums_sum(x::String) = 0

function dump_reds!(x::Dict{String, Any})
    if any(==("red"), values(x))
        empty!(x)
    else
        dump_reds!.(values(x))
    end
    return nothing
end
dump_reds!(x::Vector{Any}) = dump_reds!.(x)
dump_reds!(x::Int) = nothing
dump_reds!(x::String) = nothing

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
