function parse_input(path)
    readlines(joinpath(@__DIR__, path))
end

function part_1(data)
    sum(is_nice.(data))
end

function part_2(data)
    sum(is_also_nice.(data))
end

function is_nice(str)
    has_three_vowels = s -> count(letter -> letter in "aeiou", s) >= 3
    has_special_chars = s -> any(occursin(s).(["ab", "cd", "pq", "xy"]))
    has_pair = s -> begin
        for i in 1:(length(s) - 1)
            s[i] == s[i + 1] && return true
        end
        return false
    end
    return has_three_vowels(str) && has_pair(str) && !has_special_chars(str)
end

function is_also_nice(str)
    has_doublet_pair = s -> begin
        n = length(s)
        for i in 2:n, j in (i + 2):n
            s[i - 1] == s[j - 1] && s[i] == s[j] && return true
        end
        return false
    end
    has_sandwich = s -> begin
        for i in 1:(length(s) - 2)
            s[i] == s[i + 2] && return true
        end
        return false
    end
    has_doublet_pair(str) && has_sandwich(str)
end

function main()
    data = parse_input("inputs/day_05.txt")
    println("Advent of Code 2015 Day 5")
    println("=========================")
    println("Part 1: ", part_1(data))
    println("Part 2: ", part_2(data))
end

main()
