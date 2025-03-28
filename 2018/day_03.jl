struct Claim
    x_range::UnitRange{Int}
    y_range::UnitRange{Int}
end

struct Fabric
    claims::Dict{Int, Claim}
    squares::Matrix{Int}
end

function main()
    input_file = joinpath(@__DIR__, "inputs/day_03.txt")
    N = 1000
    fabric = Fabric(Dict{Int, Claim}(), fill(0, N, N))
    parse_claim!.(Ref(fabric), eachline(input_file))

    # Part 1.
    for claim in values(fabric.claims)
        fabric.squares[claim.x_range, claim.y_range] .+= 1
    end
    num_overlaps = sum(fabric.squares .> 1)

    # Part 2.
    claim_id = -1
    for (id, claim) in fabric.claims
        if all(fabric.squares[claim.x_range, claim.y_range] .== 1)
            claim_id = id
            break
        end
    end

    # Answers.
    println("AoC 2018 Day 3")
    println("Part 1: $num_overlaps")
    println("Part 2: $claim_id")
end

function parse_claim!(fabric::Fabric, line::String)
    split_line = split(line)
    # Claim ID.
    id = parse(Int, lstrip(split_line[1], '#'))
    # Claim start.
    coords = split(rstrip(split_line[end - 1], ':'), ',')
    x, y = parse.(Int, coords) .+ 1
    # Claim size.
    dims = split(split_line[end], 'x')
    dx, dy = parse.(Int, dims)
    # Claim ranges.
    x_range, y_range = x:(x + dx - 1), y:(y + dy - 1)
    fabric.claims[id] = Claim(x_range, y_range)
    return nothing
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
