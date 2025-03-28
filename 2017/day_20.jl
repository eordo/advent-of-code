using Unzip

function main()
    input_file = joinpath(@__DIR__, "inputs/day_20.txt")
    p_list, v_list, a_list = unzip(get_pva.(eachline(input_file)))
    
    collided = falses(length(p_list))
    T = 500
    for _ in 1:T
        update!.(p_list, v_list, a_list)
        check_collisions!(collided, p_list)
    end
    # Part 1.
    closest_particle = argmin(map(p -> sum(abs.(p)), p_list)) - 1
    # Part 2.
    num_particles_left = length(collided) - sum(collided)

    # Answers.
    println("AoC 2017 Day 20")
    println("Part 1: $closest_particle")
    println("Part 2: $num_particles_left")
end

function update!(p::Vector{Int}, v::Vector{Int}, a::Vector{Int})
    v .+= a
    p .+= v
    return nothing
end

function check_collisions!(collided::BitVector, positions::Vector{Vector{Int}})
    n_particles = length(positions)
    for i = 1:n_particles
        collided[i] && continue
        for j = (i + 1):n_particles
            collided[j] && continue
            if positions[i] == positions[j]
                collided[i] = true
                collided[j] = true
            end
        end
    end
    return nothing
end

function get_pva(line::String)
    p_str, v_str, a_str = split(line, ", ")
    p, v, a = map(str -> parse.(Int, split(str[4:(end - 1)], ',')), (p_str, v_str, a_str))
    return p, v, a
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
