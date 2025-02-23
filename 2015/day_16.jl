function main()
    input_file = joinpath(@__DIR__, "inputs/day_16.txt")
    sue_dicts = parse_sue.(eachline(input_file))
    
    # Part 1.
    TICKER = Dict(
        "children" => 3,
        "cats" => 7,
        "samoyeds" => 2,
        "pomeranians" => 3,
        "akitas" => 0,
        "vizslas" => 0,
        "goldfish" => 5,
        "trees" => 3,
        "cars" => 2,
        "perfumes" => 1
    )
    sue_num_1 = 0
    for (i, sue_dict) in enumerate(sue_dicts)
        if all(sue_dict[item] == TICKER[item] for item in keys(sue_dict))
            sue_num_1 = i
            break
        end
    end

    # Part 2.
    TICKER_RANGES = Dict(
        "children" => ==(3),
        "cats" => >(7),
        "samoyeds" => ==(2),
        "pomeranians" => <(3),
        "akitas" => ==(0),
        "vizslas" => ==(0),
        "goldfish" => <(5),
        "trees" => >(3),
        "cars" => ==(2),
        "perfumes" => ==(1)
    )
    sue_num_2 = 0
    for (i, sue_dict) in enumerate(sue_dicts)
        if all(TICKER_RANGES[item](amount) for (item, amount) in sue_dict)
            sue_num_2 = i
            break
        end
    end

    println("AoC 2015 Day 16")
    println("Part 1: $sue_num_1")
    println("Part 2: $sue_num_2")
end

function parse_sue(line::String)
    sue_dict = Dict{String, Int}()
    for tokens in split.(split(line, ", "), ": ")
        item = tokens[end - 1]
        amount = parse(Int, tokens[end])
        sue_dict[item] = amount
    end
    return sue_dict
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
