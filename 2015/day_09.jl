using Combinatorics

function main()
    input_file = joinpath(@__DIR__, "inputs/day_09.txt")
    
    cities = Dict{String, Int}()
    travel_distances = Vector{NTuple{3, Int}}()
    for line in eachline(input_file)
        origin, destination, distance = split(line)[[1, 3, 5]]
        
        if !haskey(cities, origin)
            cities[origin] = length(cities) + 1
        end
        if !haskey(cities, destination)
            cities[destination] = length(cities) + 1
        end

        i = cities[origin]
        j = cities[destination]
        distance = parse(Int, distance)
        push!(travel_distances, (i, j, distance))
    end

    n = length(cities)
    D = Matrix{Int}(undef, n, n)
    for travel_distance in travel_distances
        i, j, distance = travel_distance
        D[i, j] = distance
        D[j, i] = distance
    end

    route_distances = Vector{Int}()
    for route in permutations(1:n)
        route_distance = sum(D[route[i - 1], route[i]] for i = 2:n)
        push!(route_distances, route_distance)
    end

    # Part 1.
    min_dist = minimum(route_distances)

    # Part 2.
    max_dist = maximum(route_distances)

    println("AoC 2015 Day 9")
    println("Part 1: $min_dist")
    println("Part 2: $max_dist")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
