function main()
    input_file = joinpath(@__DIR__, "inputs/day_08.txt")
    screen = falses(6, 50)

    # Part 1.
    for line in eachline(input_file)
        operation, args = parse_instruction(line)
        operation(screen, args...)
    end
    num_lit_pixels = sum(screen)

    println("AoC 2016 Day 8")
    println("Part 1: $num_lit_pixels")
    println("Part 2: ")
    pretty_print(screen)
end

function rect!(screen::BitMatrix, A::Int, B::Int)
    screen[1:B, 1:A] .= true
    return nothing
end

function rotate_col!(screen::BitMatrix, A::Int, B::Int)
    m, _ = size(screen)
    new_col = falses(m)
    for i = 1:m
        new_i = mod1(i + B, m)
        new_col[new_i] = screen[i, A]
    end
    screen[:, A] = new_col
    return nothing
end

function rotate_row!(screen::BitMatrix, A::Int, B::Int)
    _, n = size(screen)
    new_row = falses(n)
    for j = 1:n
        new_j = mod1(j + B, n)
        new_row[new_j] = screen[A, j]
    end
    screen[A, :] = new_row
    return nothing
end

function parse_instruction(s::String)
    s_split = split(s)
    if length(s_split) == 2
        operation = rect!
        args = parse.(Int, split(s_split[2], 'x'))
    else
        operation = s_split[2] == "row" ? rotate_row! : rotate_col!
        A = parse(Int, split(s_split[3], '=')[end])
        B = parse(Int, s_split[end])
        args = [A + 1, B]
    end
    return operation, args
end

function pretty_print(screen::BitMatrix)
    for row in eachrow(screen)
        for pixel in row
            if pixel
                print('#')
            else
                print(' ')
            end
        end
        println()
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
