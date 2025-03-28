using Dates

function main()
    input_file = joinpath(@__DIR__, "inputs/day_04.txt")
    entries = map(line -> lstrip(line, '['), eachline(input_file)) |>
        lines -> map(line -> split(string(line), "] "), lines) |>
        entries -> sort(entries, by = x -> x[1])
    
    minutes_asleep = Dict{Int, Int}()
    sleep_records = Dict{Int, Dict{Int, Int}}()
    guard_id = 0
    start_minute = 0
    for entry in entries
        if startswith(entry[2], "Guard")
            guard_id = parse(Int, split(entry[2])[2][2:end])
            get!(minutes_asleep, guard_id, 0)
            get!(sleep_records, guard_id, Dict(t => 0 for t = 0:59))
        elseif startswith(entry[2], "falls")
            start_time = parse_time(entry[1])
            start_minute = parse_minute(start_time)
        elseif startswith(entry[2], "wakes")
            end_time = parse_time(entry[1])
            end_minute = parse_minute(end_time)
            minutes_asleep[guard_id] += (end_minute - start_minute)
            for t = start_minute:end_minute
                sleep_records[guard_id][t] += 1
            end
        end
    end

    # Part 1.
    _, chosen_guard_1 = findmax(minutes_asleep)
    _, chosen_minute_1 = findmax(sleep_records[chosen_guard_1])
    strategy_1 = chosen_guard_1 * chosen_minute_1

    # Part 2.
    chosen_guard_2, chosen_minute_2 = 0, 0
    max_frequency = 0
    for (guard, record) in sleep_records
        frequency, minute = findmax(record)
        if frequency > max_frequency
            max_frequency = frequency
            chosen_minute_2 = minute
            chosen_guard_2 = guard
        end
    end
    strategy_2 = chosen_guard_2 * chosen_minute_2

    # Answers.
    println("AoC 2018 Day 4")
    println("Part 1: $strategy_1")
    println("Part 2: $strategy_2")
end

parse_time(s) = DateTime(s, dateformat"y-m-d H:M")

parse_minute(dt) = Dates.value(Dates.Minute(dt))

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
