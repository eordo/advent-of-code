function main()
    input_file = joinpath(@__DIR__, "inputs/day_07.txt")

    ip_tls_count = 0
    ip_ssl_count = 0
    for ip in eachline(input_file)
        supernets, hypernets = split_sequences(ip)

        # Part 1.
        supports_tls = any(has_abba.(supernets)) && !any(has_abba.(hypernets))
        if supports_tls
            ip_tls_count += 1
        end
        
        # Part 2.
        aba_set = union(get_triplet_sequences.(supernets)...)
        bab_set = union(get_triplet_sequences.(hypernets)...)
        for aba in aba_set
            a, b, _ = collect(aba)
            bab = b * a * b
            if bab in bab_set
                ip_ssl_count += 1
                break
            end
        end
    end

    println("AoC 2016 Day 7")
    println("Part 1: $ip_tls_count")
    println("Part 2: $ip_ssl_count")
end

function split_sequences(s::AbstractString)
    bracket_text = r"\[[^\]]*\]"
    supernets = split(s, bracket_text)
    hypernets = map(pattern -> pattern.match, eachmatch(bracket_text, s))
    return supernets, hypernets
end

function has_abba(s::AbstractString)
    for i = 1:(length(s) - 3)
        if s[i] == s[i + 3] && s[i + 1] == s[i + 2] && s[i] != s[i + 1]
            return true
        end
    end
    return false
end

function get_triplet_sequences(s::AbstractString)
    aba_set = Set{String}()
    for i in 1:(length(s) - 2)
        if s[i] == s[i + 2] && s[i] != s[i + 1]
            push!(aba_set, s[i:(i + 2)])
        end
    end
    return aba_set
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
