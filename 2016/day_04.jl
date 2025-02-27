using DataStructures

function main()
    input_file = joinpath(@__DIR__, "inputs/day_04.txt")

    real_ids_sum = 0
    room_id = 0
    found_room = false
    @views for line in eachline(input_file)
        split_line = split(line, '-')
        
        name = join(split_line[1:(end - 1)])
        sector_id = parse(Int, filter(isdigit, split_line[end]))
        checksum = filter(isletter, split_line[end])
        
        # Part 1.
        letter_counts = counter(name)
        sorted_letter_counts = sort(collect(letter_counts), by = x -> (-x.second, x.first))
        five_most_common_letters = join(first.(sorted_letter_counts[1:5]))
        if checksum == five_most_common_letters
            real_ids_sum += sector_id
        end

        # Part 2.
        if !found_room
            decrypted_name = decrypt(name, sector_id)
            if all(occursin.(["north", "pole", "object"], decrypted_name))
                room_id = sector_id
                found_room = true
            end
        end
    end

    println("AoC 2016 Day 4")
    println("Part 1: $real_ids_sum")
    println("Part 2: $room_id")
end

function decrypt(word::AbstractString, shift::Int)
    decrypted = join(mod(ch + shift - 'a', 26) + 'a' for ch in word)
    return decrypted
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
