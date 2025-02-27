function main()
    input_file = joinpath(@__DIR__, "inputs/day_02.txt")

    # Part 1.
    keypad = permutedims(reshape([1:9...], (3, 3)))
    square_code = to_code(parse_square_keypad.(eachline(input_file), Ref(keypad)))

    # Part 2.
    keypad = stack([
        [0, 0, 1, 0, 0],
        [0, 2, 3, 4, 0],
        [5, 6, 7, 8, 9],
        [0, 10, 11, 12, 0],
        [0, 0, 13, 0, 0]
    ]; dims = 1)
    diamond_code = to_hexcode(parse_diamond_keypad.(eachline(input_file), Ref(keypad)))

    println("AoC 2016 Day 2")
    println("Part 1: $square_code")
    println("Part 2: $diamond_code")
end

function parse_square_keypad(directions::String, keypad::Matrix{Int})
    i, j = 2, 2
    m, n = size(keypad)
    for direction in directions
        if direction == 'U'
            i = max(i - 1, 1)
        elseif direction == 'R'
            j = min(j + 1, n)
        elseif direction == 'D'
            i = min(i + 1, m)
        elseif direction == 'L'
            j = max(j - 1, 1)
        end
    end
    return keypad[i, j]
end

function parse_diamond_keypad(directions::String, keypad::Matrix{Int})
    i, j = 3, 1
    m, n = size(keypad)
    for direction in directions
        i_next, j_next = i, j
        if direction == 'U'
            i_next = max(i - 1, 1)
        elseif direction == 'R'
            j_next = min(j + 1, n)
        elseif direction == 'D'
            i_next = min(i + 1, m)
        elseif direction == 'L'
            j_next = max(j - 1, 1)
        end
        if taxicab_distance((i_next - ceil(m / 2), j_next - ceil(n / 2))) <= 2
            i = i_next
            j = j_next
        end
    end
    return keypad[i, j]
end

to_code(nums) = join(nums)

to_hexcode(nums) = join(uppercase.(string.(nums, base = 16)))

taxicab_distance(x) = sum(abs.(x))

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
