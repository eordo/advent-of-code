function main()
    seq = readline(joinpath(@__DIR__, "inputs/day_01.txt"))
    n = length(seq)
    
    # Part 1.
    captcha_1 = sum(parse(Int, seq[i - 1]) for i = 2:n if seq[i] == seq[i - 1])
    captcha_1 += first(seq) == last(seq) ? parse(Int, first(seq)) : 0

    # Part 2.
    captcha_2 = 0
    for i = 1:n
        j = mod1(i + div(n, 2), n)
        if seq[i] == seq[j]
            captcha_2 += parse(Int, seq[i])
        end
    end
    
    # Answers.
    println("AoC 2017 Day 1")
    println("Part 1: $captcha_1")
    println("Part 2: $captcha_2")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
