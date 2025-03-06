using ProgressBars

struct Effect
    damage::Int
    armor::Int
    restore_hp::Int
    restore_mana::Int
end

struct Spell
    name::String
    cost::Int
    duration::Int
    effect::Effect
end

mutable struct GameState
    player_hp::Int
    player_mana::Int
    spells::Vector{Spell}
    active_effects::Dict{Effect, Int}
    boss_hp::Int
    boss_damage::Int
    total_mana_spent::Int
end

function main()
    input_file = joinpath(@__DIR__, "inputs/day_22.txt")

    PLAYER_HP, PLAYER_MANA = 50, 500
    SPELLS = [
        Spell("Magic Missile", 53, 1, Effect(4, 0, 0, 0)),
        Spell("Drain", 73, 1, Effect(2, 0, 2, 0)),
        Spell("Shield", 113, 6, Effect(0, 7, 0, 0)),
        Spell("Poison", 173, 6, Effect(3, 0, 0, 0)),
        Spell("Recharge", 229, 5, Effect(0, 0, 0, 101))
        ]
    ACTIVE_EFFECTS = Dict(spell.effect => 0 for spell in SPELLS if spell.duration > 1)
    BOSS_HP, BOSS_DAMAGE = parse.(Int, last.(split.(eachline(input_file), ": ")))
    
    state = GameState(
        PLAYER_HP,
        PLAYER_MANA,
        SPELLS,
        ACTIVE_EFFECTS,
        BOSS_HP,
        BOSS_DAMAGE,
        0)
    start_stats = Dict(
        :player_hp => PLAYER_HP,
        :player_mana => PLAYER_MANA,
        :boss_hp => BOSS_HP,
        :total_mana_spent => 0
    )

    min_mana_easy = typemax(Int)
    min_mana_hard = typemax(Int)
    for _ in tqdm(1:150000)
        # Part 1.
        fight!(state; hard_mode = false)
        if player_won(state)
            min_mana_easy = min(state.total_mana_spent, min_mana_easy)
        end
        reset!(state, start_stats)
        
        # Part 2.
        fight!(state; hard_mode = true)
        if player_won(state)
            min_mana_hard = min(state.total_mana_spent, min_mana_hard)
        end
        reset!(state, start_stats)
    end

    println("AoC 2015 Day 22")
    println("Part 1: $min_mana_easy")
    println("Part 2: $min_mana_hard")
end

function fight!(state::GameState; hard_mode::Bool = false)
    is_player_turn = true
    while is_in_play(state)
        if is_player_turn && hard_mode
            state.player_hp -= 1
        end
        apply_effects!(state)
        if is_player_turn
            spell = random_spell(state)
            cast_spell!(state, spell)
        else
            boss_attack!(state)
        end
        is_player_turn = !is_player_turn
    end
    return nothing
end

function apply_effects!(state::GameState)
    for (effect, duration) in state.active_effects
        if duration > 0
            # Damage effects.
            state.boss_hp -= effect.damage
            # Restorative effects.
            state.player_hp -= effect.restore_hp
            state.player_mana += effect.restore_mana
            # Decrement effect timer.
            state.active_effects[effect] -= 1
        end
    end
    return nothing
end

function boss_attack!(state::GameState)
    player_armor = 0
    for (effect, duration) in state.active_effects
        if duration > 0 && effect.armor > 0
            player_armor += effect.armor
        end
    end
    state.player_hp -= max(state.boss_damage - player_armor, 1)
    return nothing
end

function cast_spell!(state::GameState, spell::Spell)
    # Spells that take effect immediately.
    if spell.duration == 1
        state.boss_hp -= spell.effect.damage
        state.player_hp += spell.effect.restore_hp
    # Spells that start a multi-turn active effect.
    else
        state.active_effects[spell.effect] = spell.duration
    end
    state.player_mana -= spell.cost
    state.total_mana_spent += spell.cost
    return nothing
end

function random_spell(state::GameState)
    valid_spells = filter(
        x -> get(state.active_effects, x.effect, 0) == 0 && x.cost <= state.player_mana,
        state.spells)
    spell = rand(valid_spells)
    return spell
end

function is_in_play(state::GameState)
    player_alive = state.player_hp > 0
    boss_alive = state.boss_hp > 0
    has_mana = minimum(getproperty.(state.spells, :cost)) <= state.player_mana
    return player_alive && boss_alive && has_mana
end

player_won(state::GameState) = state.boss_hp <= 0

function reset!(state::GameState, stats::Dict{Symbol, Int})
    for (sym, stat) in stats
        setproperty!(state, sym, stat)
    end
    for effect in keys(state.active_effects)
        state.active_effects[effect] = 0
    end
    return nothing
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
