function main()
    file = readline(joinpath(@__DIR__, "inputs/day_09.txt"))
    
    # Part 1.
    decompressed_length_1 = decompressed_length(file)

    # Part 2.
    decompressed_length_2 = decompressed_length(file; v2 = true)

    println("AoC 2016 Day 9")
    println("Part 1: $decompressed_length_1")
    println("Part 2: $decompressed_length_2")
end

function decompressed_length(file::AbstractString; v2::Bool = false)
    num_chars = 0
    reading_marker = false
    marker_start = 0
    marker_end = 0
    i = 1
    while i <= length(file)
        if !reading_marker && file[i] == '('
            reading_marker = true
            marker_start = i
        elseif reading_marker
            while file[i] != ')'
                i += 1
            end
            reading_marker = false
            marker_end = i
            a, b = parse_marker(file[marker_start:marker_end])
            # Part 2.
            if v2
                num_chars += b * decompressed_length(
                    file[(marker_end + 1):(marker_end + a)];
                    v2 = true)
            # Part 1.
            else
                num_chars += a * b
            end
            i += a
        else
            num_chars += 1
        end
        i += 1
    end
    return num_chars
end

parse_marker(s::String) = parse.(Int, filter.(isdigit, split(s, 'x')))

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
