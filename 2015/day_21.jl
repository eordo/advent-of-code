mutable struct Character
    hit_points::Int
    damage::Int
    armor::Int
end

function main()
    input_file = joinpath(@__DIR__, "inputs/day_21.txt")
    
    PLAYER_HP = 100
    player = Character(PLAYER_HP, 0, 0)
    
    boss_stats = parse.(Int, last.(split.(eachline(input_file), ": ")))
    BOSS_HP, BOSS_DAMAGE, BOSS_ARMOR = boss_stats
    boss = Character(BOSS_HP, BOSS_DAMAGE, BOSS_ARMOR)

    # All items are represented by a tuple of (Cost, Damage, Armor) values.
    # The (0, 0, 0) items for armor and rings represent wearing no armor or rings.
    weapons = [
        (8, 4, 0),
        (10, 5, 0),
        (25, 6, 0),
        (40, 7, 0),
        (74, 8, 0)
    ]
    armors = [
        (0, 0, 0),
        (13, 0, 1),
        (31, 0, 2),
        (53, 0, 3),
        (75, 0, 4),
        (102, 0, 5)
    ]
    rings = [
        (0, 0, 0),
        (25, 1, 0),
        (50, 2, 0),
        (100, 3, 0),
        (20, 0, 1),
        (40, 0, 2),
        (80, 0, 3)
    ]

    least_amount_spent = typemax(Int)
    most_amount_spent = typemin(Int)
    for (weapon, armor, ring_1, ring_2) in Iterators.product(weapons, armors, rings, rings)
        # Unpack this item combination.
        amount_spent = sum(first.([weapon, armor, ring_1, ring_2]))
        player_damage = weapon[2] + ring_1[2] + ring_2[2]
        player_armor = armor[3] + ring_1[3] + ring_2[3]

        # Reset Player and Boss stats.
        reset_hit_points!(player, PLAYER_HP)
        reset_hit_points!(boss, BOSS_HP)
        set_damage!(player, player_damage)
        set_armor!(player, player_armor)

        # Simulate the fight.
        fight!(player, boss)
        # Part 1.
        if is_alive(player)
            least_amount_spent = min(amount_spent, least_amount_spent)
        # Part 2.
        else
            most_amount_spent = max(amount_spent, most_amount_spent)
        end
    end

    # println("AoC 2015 Day 21")
    # println("Part 1: $least_amount_spent")
    # println("Part 2: $most_amount_spent")
end

function fight!(player::Character, boss::Character)
    is_player_turn = true
    while player.hit_points > 0 && boss.hit_points > 0
        if is_player_turn
            attack!(player, boss)
        else
            attack!(boss, player)
        end
        is_player_turn = !is_player_turn
    end
end

function attack!(attacker::Character, defender::Character)
    defender.hit_points -= max(attacker.damage - defender.armor, 1)
    return nothing
end

function reset_hit_points!(character::Character, hit_points::Int)
    character.hit_points = hit_points
    return nothing
end

function set_damage!(character::Character, damage::Int)
    character.damage = damage
    return nothing
end

function set_armor!(character::Character, armor::Int)
    character.armor = armor
    return nothing
end

is_alive(player::Character) = player.hit_points > 0

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
