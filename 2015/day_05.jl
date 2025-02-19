function main()
    str_list = readlines(joinpath(@__DIR__, "inputs/day_05.txt"))

    # Part 1.
    nice_str_count = sum(is_nice.(str_list))

    # Part 2.
    also_nice_str_count = sum(is_also_nice.(str_list))

    println("AoC 2015 Day 5")
    println("Part 1: $nice_str_count")
    println("Part 2: $also_nice_str_count")
end

function is_nice(str::String)
    has_three_vowels(s) = count(letter -> letter in "aeoiu", s) >= 3
    has_special_characters(s) = any(occursin(s).(["ab", "cd", "pq", "xy"]))
    has_pair(s) = begin
        for i = 1:(length(s) - 1)
            if s[i] == s[i + 1]
                return true
            end
        end
        return false
    end
    return (has_three_vowels(str) && has_pair(str) && !has_special_characters(str))
end

function is_also_nice(str::String)
    has_doublet_pair(s) = begin
        n = length(s)
        for i = 2:n, j = (i + 2):n
            if s[i - 1] == s[j - 1] && s[i] == s[j]
                return true
            end
        end        
        return false
    end
    has_sandwich(s) = begin
        for i = 1:(length(s) - 2)
            if s[i] == s[i + 2]
                return true
            end
        end
        return false
    end
    return (has_doublet_pair(str) && has_sandwich(str))
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
