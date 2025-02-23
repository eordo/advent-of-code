using Primes

function main()
    min_presents = parse(Int, readline(joinpath(@__DIR__, "inputs/day_20.txt")))

    # Part 1.
    house_num = 1
    presents = 10
    while presents < min_presents
        house_num += 1
        presents = sum(10 .* divisors(house_num))
    end

    # Part 2.
    new_house_num = 1
    elf_counts = Dict(1 => 1)
    presents = 11
    while presents < min_presents
        new_house_num += 1
        presents = 0
        for elf_num in divisors(new_house_num)
            elf_counts[elf_num] = get(elf_counts, elf_num, 0) + 1
            if elf_counts[elf_num] <= 50
                presents += 11 * elf_num
            end
        end
    end

    println("AoC 2015 Day 20")
    println("Part 1: $house_num")
    println("Part 2: $new_house_num")
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
