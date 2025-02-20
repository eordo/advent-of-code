function main()
    input_file = joinpath(@__DIR__, "inputs/day_06.txt")
    
    N = 1000
    lights = falses(N, N)
    brightness = zeros(Int, N, N)
    @views for line in eachline(input_file)
        x_range, y_range, light_change = parse_instruction(line)
        xy_range = (x_range, y_range)
        if light_change == "on"
            lights[xy_range...] .= true
            brightness[xy_range...] .+= 1
        elseif light_change == "off"
            lights[xy_range...] .= false
            brightness[xy_range...] .= max.(0, brightness[xy_range...] .- 1)
        elseif light_change == "toggle"
            lights[xy_range...] .= .!lights[xy_range...]
            brightness[xy_range...] .+= 2
        end
    end
    total_lights_on = sum(lights)
    total_brightness = sum(brightness)

    println("AoC 2015 Day 6")
    println("Part 1: $total_lights_on")
    println("Part 2: $total_brightness")
end

function parse_instruction(line::String)
    split_line = split(line)
        
    start_coords, end_coords = split_line[end - 2], split_line[end]
    start_coords = parse.(Int, split(start_coords, ',')) .+ 1
    end_coords = parse.(Int, split(end_coords, ',')) .+ 1
    
    x_range = UnitRange(start_coords[1], end_coords[1])
    y_range = UnitRange(start_coords[2], end_coords[2])
    light_change = split_line[end - 3]

    return (x_range, y_range, light_change)
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
