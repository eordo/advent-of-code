def max_joltage(bank, n_on):
    current_idx = 0
    batteries = []
    while len(batteries) < n_on:
        n_remaining = n_on - len(batteries)
        current_window = bank[current_idx:(len(bank) - (n_remaining - 1))]
        battery = max(current_window)
        idx = current_idx + current_window.index(battery)
        current_idx = idx + 1
        batteries.append(battery)
    return int(''.join(batteries))


def part_1(banks):
    return sum(max_joltage(bank, n_on=2) for bank in banks)


def part_2(banks):
    return sum(max_joltage(bank, n_on=12) for bank in banks)


def parse_input(filename):
    with open(filename) as f:
        banks = [line.strip() for line in f]
    return banks


def solve_puzzle(input_file):
    banks = parse_input(input_file)
    ans_1 = part_1(banks)
    ans_2 = part_2(banks)
    return ans_1, ans_2


if __name__ == "__main__":
    ans_1, ans_2 = solve_puzzle('inputs/day_03.txt')
    print("2025 Day 3")
    print(f"Part 1: {ans_1}")
    print(f"Part 2: {ans_2}")
