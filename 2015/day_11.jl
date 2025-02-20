function main()
    password = [Char(ch) for ch in readline(joinpath(@__DIR__, "inputs/day_11.txt"))]

    # Part 1.
    while !is_valid(password)
        increment!(password)
    end
    new_password_1 = join(password)

    # Part 2.
    increment!(password)
    while !is_valid(password)
        increment!(password)
    end
    new_password_2 = join(password)

    println("AoC 2015 Day 11")
    println("Part 1: $new_password_1")
    println("Part 2: $new_password_2")
end

function increment!(password::Vector{Char})
    i = lastindex(password)
    password[i] += 1
    while password[i] > 'z'
        password[i] = 'a'
        password[i - 1] += 1
        i -= 1
    end
    return nothing
end

function is_valid(password::Vector{Char})
    contains_iol(s) = any(ch -> ch in "iol", s)
    has_straight(s) = begin
        for i = 1:(length(s) - 2)
            if s[i] == s[i + 1] - 1 == s[i + 2] - 2
                return true
            end
        end
        return false
    end
    has_pairs(s) = begin
        i = 1
        pairs = 0
        while i <= length(s) - 1
            if s[i] == s[i + 1]
                pairs += 1
                i += 2
            else
                i += 1
            end
        end
        return pairs >= 2
    end
    return (!contains_iol(password) && has_straight(password) && has_pairs(password))
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
