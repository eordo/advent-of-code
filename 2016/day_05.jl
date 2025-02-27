using MD5

@kwdef mutable struct Hasher
    door_id::String
    index::Int = 0
    password_length::Int = 8
end

function main()
    door_id = readline(joinpath(@__DIR__, "inputs/day_05.txt"))
    K = 5
    
    # Part 1.
    hasher = Hasher(door_id = door_id)
    password_chars = Vector{Char}(undef, hasher.password_length)
    for i in eachindex(password_chars)
        password_chars[i] = next_character(hasher, K)
    end
    password_1 = String(password_chars)

    # Part 2.
    hasher = Hasher(door_id = door_id)
    positions_filled = Dict(i => false for i = 1:hasher.password_length)
    password_chars = Vector{Char}(undef, hasher.password_length)
    for _ in 1:hasher.password_length
        character, position = next_character_and_position(hasher, K, positions_filled)
        password_chars[position] = character
    end
    password_2 = String(password_chars)

    println("AoC 2016 Day 5")
    println("Part 1: $password_1")
    println("Part 2: $password_2")
end

function next_character(hasher::Hasher, K::Int)
    K_zeros = repeat('0', K)
    hashed = hash(hasher.door_id, hasher.index)
    while !startswith(hashed, K_zeros)
        hasher.index += 1
        hashed = hash(hasher.door_id, hasher.index)
    end
    hasher.index += 1
    character = hashed[K + 1]
    return character
end

function next_character_and_position(hasher::Hasher, K::Int, positions_filled::Dict{Int, Bool})
    K_zeros = repeat('0', K)
    hashed = hash(hasher.door_id, hasher.index)
    found = false
    while !found
        hasher.index += 1
        hashed = hash(hasher.door_id, hasher.index)
        position_ch = hashed[K + 1]
        if startswith(hashed, K_zeros)
            if !('0' <= position_ch <= only(string(hasher.password_length)))
                continue
            elseif positions_filled[parse(Int, position_ch) + 1]
                continue
            else
                found = true
            end
        end
    end
    hasher.index += 1
    character = hashed[K + 2]
    position = parse(Int, hashed[K + 1]) + 1
    positions_filled[position] = true
    return character, position
end

function hash(door_id::String, index::Int)
    hashed = bytes2hex(md5(door_id * string(index)))
    return hashed
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
