def parse_input(filename):
    id_limits = []
    ingredients = []
    reading_ingredients = False
    with open(filename) as f:
        for line in f:
            line = line.strip()
            if not line:
                reading_ingredients = True
            elif reading_ingredients:
                ingredients.append(int(line))
            else:
                start, end = line.split('-')
                id_limits.append([int(start), int(end)])
    return id_limits, ingredients


def part_1(id_limits, ingredients):
    id_ranges = [range(start, end + 1) for (start, end) in id_limits]
    return sum(
        any(ingredient in id_range for id_range in id_ranges)
        for ingredient in ingredients
    )


def part_2(id_limits):
    sorted_limits = sorted(id_limits)
    id_ranges = []
    for start, end in sorted_limits:
        if not id_ranges or start > id_ranges[-1][1]:
            id_ranges.append([start, end])
        else:
            id_ranges[-1][1] = max(id_ranges[-1][1], end)
    fresh_count = 0
    for start, end in id_ranges:
        fresh_count += end - start + 1
    return fresh_count


def solve_puzzle(input_file):
    id_limits, ingredients = parse_input(input_file)
    ans_1 = part_1(id_limits, ingredients)
    ans_2 = part_2(id_limits)
    return ans_1, ans_2


if __name__ == "__main__":
    ans_1, ans_2 = solve_puzzle('inputs/day_05.txt')
    print("2025 Day 5")
    print(f"Part 1: {ans_1}")
    print(f"Part 2: {ans_2}")
