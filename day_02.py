def is_doubled_sequence(x):
    s = str(x)
    n_digits = len(s)
    if n_digits % 2 == 0 and s[:(n_digits // 2)] * 2 == s:
        return True
    return False


def is_repeated_sequence(x):
    s = str(x)
    n_digits = len(s)
    for k in range(1, n_digits // 2 + 1):
        if n_digits % k == 0 and s[:k] * (n_digits // k) == s:
            return True
    return False


def parse_input(filename):
    id_ranges = []
    with open(filename) as f:
        data = f.readline()
        for id_range in data.split(','):
            start, end = id_range.split('-')
            id_ranges.append(range(int(start), int(end) + 1))
    return id_ranges


def part_1(id_ranges):
    return sum(
        x
        for id_range in id_ranges
        for x in id_range
        if is_doubled_sequence(x)
    )


def part_2(id_ranges, invalid_dict={}):
    return sum(
        x
        for id_range in id_ranges
        for x in id_range
        if is_repeated_sequence(x)
    )


def solve_puzzle(input_file):
    id_ranges = parse_input(input_file)
    ans_1 = part_1(id_ranges)
    ans_2 = part_2(id_ranges)
    return ans_1, ans_2


if __name__ == "__main__":
    ans_1, ans_2 = solve_puzzle('inputs/day_02.txt')
    print("Advent of Code 2025")
    print(f"Part 1: {ans_1}")
    print(f"Part 2: {ans_2}")
