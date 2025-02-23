function main()
    input_file = joinpath(@__DIR__, "inputs/day_18.txt")
    
    # Part 1.
    lights = stack([ch == '#' for ch in line] for line in eachline(input_file); dims = 1)
    for _ in 1:100
        update!(lights)
    end
    num_lights_on_1 = sum(lights)

    # Part 2.
    lights = stack([ch == '#' for ch in line] for line in eachline(input_file); dims = 1)
    for _ in 1:100
        update!(lights)
        lights[1, 1] = true
        lights[1, end] = true
        lights[end, 1] = true
        lights[end, end] = true        
    end
    num_lights_on_2 = sum(lights)

    println("AoC 2015 Day 18")
    println("Part 1: $num_lights_on_1")
    println("Part 2: $num_lights_on_2")
end

function update!(lights::Matrix{Bool})
    current_state = copy(lights)
    for idx in CartesianIndices(lights)
        coords = Tuple(idx)
        is_on = current_state[coords...]
        on_neighbors = count_on_neighbors(coords, current_state)
        if is_on && !(on_neighbors == 2 || on_neighbors == 3)
            lights[coords...] = !is_on
        elseif !is_on && on_neighbors == 3
            lights[coords...] = !is_on
        end
    end
    return nothing
end

function count_on_neighbors(coords::NTuple{2, Int}, lights::Matrix{Bool})
    x, y = coords
    x_max, y_max = size(lights)
    on_count = 0
    for dx = -1:1, dy = -1:1
        if dx == dy == 0
            continue
        elseif (1 <= x + dx <= x_max) && (1 <= y + dy <= y_max)
            on_count += lights[x + dx, y + dy]
        end
    end
    return on_count
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
