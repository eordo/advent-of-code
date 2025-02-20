struct Reindeer
    name::String
    speed::Int
    flight_time::Int
    rest_time::Int
end

function main()
    input_file = joinpath(@__DIR__, "inputs/day_14.txt")
    reindeers = parse_reindeer.(eachline(input_file))    

    # Part 1.
    T = 2503
    positions = stack(simulate_flight(reindeer, T) for reindeer in reindeers; dims = 1)
    winning_distance = @views maximum(positions[:, end])

    # Part 2.
    points = zeros(Int, length(reindeers))
    @views for position in eachcol(positions)
        ids = findall(position .== maximum(position))
        points[ids] .+= 1
    end
    winning_points = maximum(points)

    println("AoC 2015 Day 14")
    println("Part 1: $winning_distance")
    println("Part 2: $winning_points")
end

function simulate_flight(reindeer::Reindeer, T::Int)
    x = zeros(Int, T)
    t = 1
    time_remaining = reindeer.flight_time
    is_moving = true
    current_position = 0
    while t <= T
        while time_remaining > 0 && t <= T
            if is_moving
                current_position += reindeer.speed
            end
            x[t] = current_position
            t += 1
            time_remaining -= 1
        end
        if is_moving
            time_remaining = reindeer.rest_time
        else
            time_remaining = reindeer.flight_time
        end
        is_moving = !is_moving
    end
    return x
end

function parse_reindeer(line::String)
    split_line = split(line)
    name = split_line[1]
    speed = parse(Int, split_line[4])
    flight_time = parse(Int, split_line[7])
    rest_time = parse(Int, split_line[end - 1])
    reindeer = Reindeer(name, speed, flight_time, rest_time)
    return reindeer
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
